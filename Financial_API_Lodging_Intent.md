# Financial-grade API: Lodging Intent Pattern

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice & license
The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

##Foreword

The OpenID Foundation (OIDF) promotes, protects and nurtures the OpenID community and technologies. As a non-profit international standardizing body, it is comprised by over 160 participating entities (workgroup participants). The work of preparing implementer drafts and final international standards is carried out through OIDF workgroups in accordance with the OpenID Process. Participants interested in a subject for which a workgroup has been established has the right to be represented in that workgroup. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

Final drafts adopted by the Workgroup through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote. There is a possibility that some of the elements of this document may be the subject to patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial-grade API consists of the following parts:

* Part 1: Read-Only API Security Profile
* Part 2: Read and Write API Security Profile
* Part 3: Client Initiated Backchannel Authentication Profile
* JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)
* Lodging Intent Pattern

Future parts may follow.

These parts are intended to be used with [RFC6749], [RFC6750], [RFC7636], and [OIDC].

##Introduction

Fintech is an area of future economic growth around the world and Fintech organizations need to improve the security of their operations and protect customer data. It is common practice of aggregation services to use screen scraping as a method to capture data by storing users' passwords. This brittle, inefficient, and insecure practice creates security vulnerabilities which require financial institutions to allow what appears to be an automated attack against their applications and to maintain a whitelist of aggregators. A new draft standard, proposed by this workgroup would instead utilize an API model with structured data and a token model, such as OAuth [RFC6749, RFC6750].

The Financial-grade API aims to provide specific implementation guidelines for online financial services to adopt by developing a REST/JSON data model protected by a highly secured OAuth profile.
 
This document describes the "lodging intent" pattern, which is used to parameterize complex OAuth authorization requests in a reliable and secure way.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial-grade API: Lodging Intent Pattern**

[TOC]

## 1. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[RFC7230] - Hypertext Transfer Protocol -- HTTP/1.1
[RFC7230]: https://tools.ietf.org/html/rfc7230

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[RFC7662] - OAuth 2.0 Token Introspection
[RFC7662]: https://tools.ietf.org/html/rfc7662

## 2. Terms and definitions
For the purpose of this document, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.

## 3. Symbols and Abbreviated terms

**API** – Application Programming Interface

**FAPI** - Financial-grade API

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 4. Introduction
OAuth is well equipped to authorize simple actions on behalf of resource owners, such as read access to one‘s contact list. When it comes to more complex authorization decisions, such as access to certain features of a number of bank accounts, or the authorization of transactions, such as the initiation of a payment, the built-in support does not suffice. The „scope“ parameter, which ought to be used to determine the requested scope of an access token, is just defined as a space delimited list of flat string values. This is not sufficient to, for example, list resources and corresponding actions on those resources or to define amount, currency and other details of a payment transaction. Moreover, the length of the scope value is restricted by the maximum length of the authorization request URL, and the scope value is not protected from modifications by the user, which might cause security issues.

The use cases mentioned above require a more expressive and secure way to parameterize authorization transactions.

Different patterns to solve that challenge can be observed in the wild. They basically fall into two categories: either complex data structures are passed in the authorization request or the authorization request refers to authorization data represented in a RESTful HTTP resource. So the solution space boils down to the typical „pass by value“ vs. „pass by reference“ design decision.

This document describes a pattern to pass authorization data by reference designated as „lodging intent“. As the main advantage, this pattern can be used to (1) reliably pass information into the authorization process independent of URL length restrictions while the information is also (2) protected from modification without the need to digitally sign it, reducing implementation costs.

Note: this document only defines a pattern and not the actual interfaces and payload since those are use case and deployment specific.

## 5. Pattern Overview 
Performing an authorization process using the lodging intent pattern and the code flow works as follows:

First, the client creates a resource containing all data required to inform the authorization process at the authorization server. In the case of a payment initiation, the resource might consist of the debtors account number, amount and currency, and further information about the payment. Creating the lodging intent might require an authorization on its own. In this case, the client needs to obtain a suitably scoped access token in advance, typically using the client credentials grant with the AS. The lodging resource service responds to the client with an id and/or a link to the newly created resource.

The client then sends the resource reference with the authorization request to the authorization server. The AS obtains the transaction data from the lodging resource and, after having authenticated the user, utilizes it to render a user consent user interface. For example in the payment case, the AS shows the debtor, the amount, and additional information regarding the payment transaction to the user and asks for her consent.

If the user consents to the requested authorization, the AS associates the authorization data with the newly created (or just upgraded) grant and the respective access tokens issued based on this grant. Ultimately, the AS needs to provide the authorization data to the respective resource server, either embedded in the access token or in the token introspection response.

## 6. Detailed Description
The following sections will describe the recommended process in detail.

## 6.1. Obtain Access Token for Intent Creation (Optional Step)
The AS might require clients to authenticate and get authorized as a prerequisite to create a lodging intent. The recommended approach is to use the OAuth client credentials grant type to authenticate the client and access tokens to convey the authorization towards the lodging intent resource.

This requires the AS to define a certain scope the client needs to specify when asking for an access token.

The following example shows how to obtain an access token using the example of a payment initiation API. The respective scope value is „payments_create“.

```http 
POST /token HTTP/1.1
Host: as.bank.example
Content-Type: application/x-www-form-urlencoded

client_id=3630BF72-E979-477A-A8FF-8A338F07C852&
grant_type=client_credentials&
scope=payments_create
```

Please note the example does not show a particular client authentication method. Any method defined at [token endpoint authentication method iana registry] should be applicable.

## 6.2. Create Lodging Intent
In the next step, the client uses the access token to create a new lodging intent.

The data sent to the resource endpoint depends on the particular transaction and API type. The representation format is at the discretion of the AS, JSON is the recommendation since it allows to represent even complex structures in a simple and robust way.

In our example, the client sends data describing a certain payment initiation transaction in JSON format:


```http
POST /payments HTTP/1.1
Host: api.bank.example
Content-Type:  application/json
Authorization: Bearer eyJraWQiOiJOQnlW...

{
   "creditor":"DE56378485858575858585",
   "instructedAmount": {"currency": "EUR", "amount": "123"},
   "remittanceInformationUnstructured": "Ref Number Merchant: 739466380"
}
```

The lodging intent will respond with an id of and/or link to the newly created resource. This reference is used in the next step to link the resource into the authorization process.


```http
HTTP/1.1 201 Created
Content-Type: application/json
Location: /payments/36fc67776

{
 "consentId": "36fc67776",
}
```

Note: the lodging intent endpoint can be provided by the AS or the respective RS. Both options have up- and downsides, which will be discussed later on.

## 6.3. Authorization Request
The client must send the reference to the lodging intent(s) to the authorization server as part of the authorization request. There are basically the following mechanisms that can be used for that purpose:

## 6.3.1. Parameterized Scope Values
The intent id can be made a part of the scope value used to ask for permission to access certain resources or perform a transaction. For example, the base scope value could be „payment“ and the resource could be added in the concrete authorization request separated by colons, resulting in an effective scope value „payment:36fc67776“. This is shown in the following example (with URI encoding):


```http
GET /authorise?responseType=code&
client_id=3630BF72-E979-477A-A8FF-8A338F07C852&
redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb&
scope=payment%3A36fc67776&
state=S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw&
code_challenge_method=S256&
code_challenge=5c305578f8f19b2dcdb6c3c955c0aa709782590b4642eb890b97e
43917cd0f36 HTTP/1.1
Host: as.bank.example
```

This way the lodging intent adds further details regarding the authorization the client asks for, which fits the purpose of the scope parameter. It also allows the AS to determine whether a user already consented to a certain request by just comparing scope values.

Note: most products nowadays only support scope values out of a discrete, pre-configured list of fixed string values. Supporting parameterized scope values will require modifications of such products. In particular, major changes are required to support dynamic rendering of the user consent dialog based on the transaction authorization data (which is the same for all representations).

## 6.3.2. Additional Request Parameter
Instead of enriching the scope value, one could also refer to the additional data using a new custom URI request parameter, as shown in the following example:


```http
GET /authorise?responseType=code&
client_id=3630BF72-E979-477A-A8FF-8A338F07C852&
redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb&
scope=payment&
payment_intent=3A36fc67776&
state=S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw&
code_challenge_method=S256&
code_challenge=5c305578f8f19b2dcdb6c3c955c0aa709782590b4642eb890b97e
43917cd0f36 HTTP/1.1
Host: as.bank.example
```

This approach requires the introduction of an additional request parameter, which is  related to the particular scope value. Most likely this means there needs to be a distinct URI query parameter per scope value type (e.g. API type). This approach might be easy to implement but the coupling between scope value and corresponding intent is not as clear as in the method described above.

## 6.3.3. Claim

Deployments using OpenID Connect might also consider to use distinct claim values to convey the intent id. The binding between scope values and intent Id is comparable to the additional request parameter approach and always requires OpenID connect to request API authorization.

## 6.4 Authorization Process
The authorization server obtains the lodging intent data and incorporates it into the process of rendering the user consent. In case of the payment initiation, the AS will need to ask the user to confirm the transfer of certain money to the creditor defined in the authorization data.

The way the AS obtains the data depends on the party that provides the lodging intent implementation. Both AS or RS can provide this implementation with different advantages and drawbacks as described in the following.

## 6.4.1. AS Provides Intent Implementation 

On first sight, implementing the lodging intent at the AS might be the obvious choice, since it just serves as an extension to a certain scope value. In such a case, the AS determines how and where the intent data is stored and how it can be accessed in user consent and, later on, when the data needs to be transferred to the RS. The RS will be provided with the authorization data either (1) encoded in the access token or (2) as part of the token introspection response.

## 6.4.2. RS Provides Intent Implementation

There are some advantages to implement the intent with the RS. First of all, the client can directly setup a resource or transaction with the RS in the first step and the RS may than dynamically decide whether there is a need for a user authorization. If so, the RS will be providing the relevant data to the AS to conduct the authorization process, which requires a well-defined interface between AS and RS. If the interface exists, the AS may also inform the RS about the context of the authorization (e.g. the respective user account), so the RS can dynamically adapt the user consent data. As one example, the RS could determine whether the respective user already consented to the RS‘s terms of service and just ask new users for a consent. Or the RS informs the AS of the available debit accounts of the particular user and the AS could directly ask the user to select the account to be used for the transaction in authorization. This pattern benefits from the domain specific knowledge in the RS and keeps the AS very clean and generic. As a consequence, there must be a properly protected interface between AS and RS.

## 6.5. Convey Authorization Data to RS 
When the client sends a request to the RS, it includes the access token issued in the previous step. The access token either directly (token data) or indirectly (token introspection response) refers to the authorization data contained in the lodging intent. If immutability of the lodging intent data cannot be ensured by the AS, this data should be included in order to ensure its integrity and authenticity between authorization process and service usage.

The following example shows an introspection response containing the payment transaction data as confirmed by the user.


```http
HTTP/1.1 200 Ok
Content-Type: application/json

{  
   "active":true,
   "iat":1532452084,
   "iss":"https://as.bank.example",
   "aud":"6a256bca-1e0b-4b0c-84fe-c9f78e0cb4a3",
   "scope":"payment:36fc67776",
   "creditor":"DE56378485858575858585",
   "instructedAmount": {"currency": "EUR", "amount": "123"},
   "remittanceInformationUnstructured": "Ref Number Merchant: 739466380"
}
```

## 7. Security Considerations

## 7.1. Guessing/Enumeration of Lodging Intents

Malicious clients or users might try to guess identifiers of lodging intents that were not created for them. In order to prevent this, lodging intent identifiers must contain sufficient entropy that makes guessing infeasible. Enumeration of lodging intents must be prevented.

## 7.2. Swapping of the Lodging Intents

An attacker could try to swap lodging intents among different clients and authorization transactions. The lodging intent MUST therefore be bound to the respective client which created it in order to detect swapping attempts. Additionally, the token response MUST return the scope value (or the respective request value) as received in the authorization request and the client MUST compare both values for equivalence or the authorization request MUST be signed.

## 7.3. Reuse of Lodging Intent Identifiers

Lodging intent ids must not be reused. Otherwise, a user who has consented to a transaction tied to a specific lodging intent id might inadvertently consent to a different transaction reusing the same lodging intent id.


## 8. Privacy Considerations
Depending on the data used to inform the user consent, the client might be required to obtain user consent prior passing user data to the lodging intent.

The party implementing the lodging intent must ensure that lodging intent data is sufficiently protected, for example by restricting access to the lodging intent resource to the client and AS/RS.

## 9. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (yes.com), Editor
* Daniel Fett (yes.com)

## 11. Bibliography

TBD
