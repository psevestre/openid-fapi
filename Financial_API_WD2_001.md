#Financial Services – Financial API - Part 1: Read Only API Security Profile

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice
The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.



##Foreword

OIDF (OpenID Foundation) is an international standardizing body comprised by over 160 participating entities (work group participants). The work of preparing international standards is carried out through OIDF work groups according to OpenID Process. Each participants interested in a subject for which a work group has been established has the right to be represented on that work group. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

OpenID Foundation standards are drafted in accordance with the rules given in the OpenID Process.

The main task of work group is to prepare Implementers Draft and Final Draft. Final Draft adopted by the Work Group through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote.

Attention is drawn to the possibility that some of the elements of this document may be the subject of patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial API - Part 1: Read Only API Security Profile was prepared by OpenID Foundation Financial API Work Group.

Financial API consists of the following parts, under the general title Financial Services — Financial API:

* Part 1: Read Only API Security Profile
* Part 2: Read and Write API Security Profile
* Part 3: Open Data API
* Part 4: Protected Data API and Schema - Read only
* Part 5: Protected Data API and Schema - Read and Write

This part is intended to be used with [RFC6749], [RFC6750], [RFC6736], and [OIDC].

##Introduction

In many cases, Fintech services such as aggregation services uses screen scraping and stores user passwords. This model is both brittle and insecure. To cope with the brittleness, it should utilize an API model with structured data and to cope with insecurity, it should utilize a token model such as OAuth [RFC6749, RFC6750].

This working group aims to rectify the situation by developing a REST/JSON model protected by OAuth. Specifically, the FAPI WG aims to provide JSON data schemas, security and privacy recommendations and protocols to:

* enable applications to utilize the data stored in the financial account,
* enable applications to interact with the financial account, and
* enable users to control the security and privacy settings.

Both commercial and investment banking accounts as well as insurance, and credit card accounts are to be considered.



#**Financial Services – Financial API - Part 1: Read Only API Security Profile **

[TOC]

## 1. Scope

This document specifies the method of

* applications to obtain the OAuth tokens in an appropriately secure manner for the financial data access;
* application to utilize OpenID Connect to identify the customer;
* representing financial data in JSON format;
* using the tokens to interact with the REST endpoints that provides financial data; and
* enabling users to control the security and privacy settings.

This document is applicable to both commercial and investment banking accounts as well as insurance, and credit card accounts are to be considered.

## 2. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[RFC2616] -  Hypertext Transfer Protocol -- HTTP/1.1
[RFC2616]: https://tools.ietf.org/html/rfc2616

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC7636] - Proof Key for Code Exchange by OAuth Public Clients
[RFC7636]: https://tools.ietf.org/html/rfc7636

[RFC5246] - The Transport Layer Security (TLS) Protocol Version 1.2
[RFC5246]: https://tools.ietf.org/html/rfc5246

[RFC7525] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[RFC7525]: https://tools.ietf.org/html/rfc7525

[RFC6125] - Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)
[RFC6125]: https://tools.ietf.org/html/rfc6125

[O2fNA] - OAuth 2.0 for Native Apps
[O2fNA]: https://tools.ietf.org/html/draft-ietf-oauth-native-apps-05

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[OIDM] -  OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[X.1254] - Entity authentication assurance framework
[X.1254]: https://www.itu.int/rec/T-REC-X.1254

## 3. Terms and definitions
For the purpose of this standard, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.


## 4. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial API

**FI** – Financial Institution

**HTTP** – Hyper Text Transfer Protocol

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 5. Read Only API Security Profile

### 5.1 Introduction

The OIDF Financial API (FAPI) is a REST API that provides JSON data representing accounts and transactions related data. These APIs are protected by the OAuth 2.0 Authorization Framework that consists of [RFC6749], [RFC6750], [RFC7636], and other specifications.

These API accesses have several levels of risks associated to them. Read only access is generally speaking associated with lower financial risk than the write access. As such, the characteristics required to the tokens are also different.

In the following subclauses, the method to obtain tokens are explained separately.


### 5.2 Read Only API Security Provisions

#### 5.2.1 Introduction

Read Only Access typically is the lower risk scenario compared to the Write access, so the protection level can also be lower.
However, since the FAPI would provide potentially sensitive information, it requires more protection level than a basic [RFC6749] requires.

To request the authorization to access the protected resource in question, the client uses the OAuth scope values defined in table 1.

| Resource       | Allowed Actions                                              | Scope value  |
|----------------|--------------------------------------------------------------|--------------|
| Account        | Read only Access to summary account information              | rAccount     |
| Customer       | Read only Access to customer information, including PII      | rCustomer    |
| Image          | Read only Access to transaction images (checks and receipts) | rImage       |
| Statement      | Read only Access to statement image                          | rStatement   |
| Transaction    | Read only Access to transaction information                  | rTransaction |

Table 1 - Financial API Scopes

This document also defines an aggregated scope `FinancialInformation`, which equates to
`rAccount` + `rCustomer` + `rImage` + `rStatement` + `rTransaction`.

As a profile of The OAuth 2.0 Authorization Framework, this document mandates the following to the Read Only API of the FAPI.

#### 5.2.2 Authorization Server

The Authorization Server

* shall support both public and confidential clients;
* shall provide a client secret longer than 12 characters; If the client secret will be used for signing purposes, the client secret shall contain a minimum of 128 bits and with sufficient entropy to generate cryptographically strong keys as defined in section 16.19 of [OIDC];
* shall support [RFC7636] with `S265` as the code challenge method;
* shall require Redirect URIs to be pre-registered;
* shall require the `redirect_uri` parameter in the authorization request;
* shall require the value of `redirect_uri` to exactly match one of the pre-registered Redirect URIs;
* shall require user authentication at LoA 2 as defined in [X.1254] or more;
* shall require explicit consent by the user to authorize the requested scope if it has not been previously authorized;
* shall verify that the Authorization Code has not been previously used if possible;
* shall return the token response as defined in 4.1.4 of [RFC6749]; and
* shall return the list of allowed scopes with the issued access token.
* shall provide opaque, non-monotonically increasing or non-guessable access tokens with a minimum of 128 bits as defined in section 5.1.4.2.2 of [RFC6819]

    **NOTE**: The Financial API server may limit the scopes for the purpose of not implementing certain APIs.

    **NOTE**: Section 4.1.3 of [RFC6749] does not say anything about the `code` reuse, but this document is putting limitation on it as per Section 3.1.3.2 of [OIDC].

    **NOTE**: If replay identification of the authorization code is not possible, it is desirable to set the validity period of the authorization code to one minute or a suitable short period of time. The validity period may act as a cache control indicator of when to clear the authorization code cache if one is used.

Further, if it wishes to provide the authenticated user's identifier to the client in the token response, the authorization server

* shall support the authentication request as in Section 3.1.2.1 of [OIDC];
* shall perform the authentication request verification as in Section 3.1.2.2 of [OIDC];
* shall authenticate the user as in Section 3.1.2.2 and 3.1.2.3 of [OIDC];
* shall provide the authentication response as in Section 3.1.2.4 and 3.1.2.5 of [OIDC] depending on the outcome of the authentication;
* shall perform the token request verification as in Section 3.1.3.2 of [OIDC]; and
* shall issue an ID Token in the token response when `openid` was included in the requested `scope`
  as in Section 3.1.3.3 of [OIDC] with its `sub` value equal to the value of the `CustomerId`
  of the `Customer` object corresponding to the authenticated user
  and optional `acr` value in ID Token.

    **NOTE**: [DDA] returns a parameter called `user_id` in the token response.
    The value of `user_id` is identical to the value of `CustomerId` member of the `Customer` object.

    **Editor's Note**: Requiring similar mechanism to PKCE to the Refresh and Access Token a good idea?

    **Editor's Note 2**: If `user_id` is indeed required in the token response of DDA, then, we should require OIDC.


#### 5.2.3 Public Client

A Public Client

* shall support [RFC7636] or the mechanisms defined in [Financial API - Part 4](Financial_API_WD_004.md);
* shall use `S256` as the code challenge method for the [RFC7636];
* shall use separate and distinct Redirect URI for each Authorization Server that it talks to;
* shall store the Redirect URI value in the User-Agent session and compare it with the Redirect URI that the Authorization Response was received at, where, if the URIs do not match, the Client shall terminate the process with error;
* shall adhere to the best practice stated by [O2fNA]; and
* shall implement an effective CSRF protection.

Further, if it wishes to obtain a persistent identifier of the authenticated user, it

* shall include `openid` in the `scope` value; and
* shall include `nonce` parameter defined in Section 3.1.2.1 of [OIDC] in the authentication request.

    **NOTE**: Adherence to [RFC7636] means that the token request includes `code_verifier` parameter in the request.


#### 5.2.4 Confidential Client

In addition to the provision to the Public Client, the Confidential Client

* shall authenticate the client to the Token Endpoint using one of the following methods:
    1. TLS mutual authentication
    2. JWS Client Assertion using the `client_secret` or a private key as specified in section 9 of [OIDC]
* shall use RSA keys with a minimum 2048 bits if using RSA cryptography
* shall use Elliptic Curve keys with a minimum of 160 bits if using Elliptic Curve cryptography
* shall verify that it's client secret has a minimum of 128 bits if using symmetric key cryptography


## 6. Accessing Protected Resources (Using tokens)

### 6.1 Introduction

The FAPI endpoints are OAuth 2.0 protected resource endpoints that return various financial information for the resource owner associated with the submitted access token.

### 6.2 Read only access provisions

#### 6.2.1 Protected resources provisions

The protected resources supporting this document

* shall mandate TLS 1.2 or later as defined in [RFC5246] with the usage following the best practice in [RFC7525];
* shall support the use of the HTTP GET and HTTP POST methods defined in [RFC2616];
* shall accept access tokens in the HTTP header as in Section 2.1 of OAuth 2.0 Bearer Token Usage [RFC6750];
* shall not accept access tokens in the query parameters stated in Section 2.3 of OAuth 2.0 Bearer Token Usage [RFC6750];
* shall verify that the access token is not expired nor revoked;
* shall verify that the scope associated with the access token authorizes the reading of the resource it is representing;
* shall identify the associated user to the access token;
* shall only return the resource identified by the combination of the user implicit in the access and the granted scope and otherwise return errors as in section 3.1 of [RFC6750];
* shall encode the response in UTF-8; // DDA allows client to ask for charset but restricting may be better for interoperability
* shall send the `Content-type` HTTP header `Content-Type: application/json; charset=UTF-8`;
* shall send the server date in HTTP date header as in section 14.18 of [RFC2616];
* shall send the `DDA-InteractionId` with the value set to the one received from the client in the `DDA-InteractionId` request header or a unique value created by the server if there was no corresponding request header to track the interaction, e.g., `DDA-InteractionId: c770aef3-6784-41f7-8e0e-ff5f97bddb3a`; and
* shall log the value of `DDA-InteractionId` in the log entry.


    **NOTE**: While this document does not specify the exact method to find out the user associated with the
    access token and the granted scope, the protected resource can use OAuth Token Introspection [RFC7662].

Further, it

* should support the use of Cross Origin Resource Sharing (CORS) [CORS] and or other methods as appropriate to enable Java Script Clients to access the endpoint if it decides to provide access to Javascript clients.

    **NOTE**: Providing access to Javascript clients or not has different security properites.;

### 6.2.2 Client provisions

The client supporting this document

* shall use TLS 1.2 or later as defined in [RFC5246] with the usage following the best practice in [RFC7525];
* shall send access tokens in the HTTP header as in Section 2.1 of OAuth 2.0 Bearer Token Usage [RFC6750];
* shall send `User-Agent` header that identifies the client, e.g., `User-Agent: Intuit/1.2.3 Mint/4.3.1`; and
* shall send `DDA-FinancialId` whose value is the unique identifier of the desired financial institution to interact assigned by the service bureau where the API is provided by a service bureau which uses the same endpoint for multiple institutions.

    **NOTE**: Conceptually, the value of the DDA-FinancialID corresponds to `iss` in the ID Token
    but is not required to be an https URI. It often is the routing number of the FI.

    **NOTE**: The use of `User-Agent` and `DDA-FinancialID` is not a security feature.

Further, the client

* can optionally supply the `sub` value associated with the customer with the `DDA-CustomerId` request header, e.g., `DDA-CustomerId: a237cb74-61c9-4319-9fc5-ff5812778d6b`;
* can optionally supply the last time the customer logged into the client in the `DDA-CustomerLastLoggedTime` header where the value is supplied as ** w3c date **, e.g., `DDA-CustomerLastLoggedTime: Tue, 11 Sep 2012 19:43:31 UTC`; and
* can supply the customer’s IP address if this data is available or applicable in the `DDA-CustomerIPAdress` header, e.g., `DDA-CustomerIPAdress: 198.51.100.119`; and
* may send the `DDA-InteractionId` request header to the server to help correlate log entries between client
and server, e.g., `DDA-InteractionId: c770aef3-6784-41f7-8e0e-ff5f97bddb3a`.





## 7. Security Considerations

### 7.1 TLS Considerations

Since confidential information is being exchanged, all interactions shall be encrypted with TLS/SSL (HTTPS) in accordance with the recommendations in [RFC7525]. TLS version 1.2 or later shall be used for all communications.

### 7.2 Message source authentication failure

Authorization request and response are not authenticated.

### 7.3 Message interity protection failure

Authorization request and response tampering and parameter injection

### 7.4 Message containment failure

#### 7.4.1 Authorization request and response

#### 7.4.2 Token request and response

May leak from logs.

#### 7.4.3 Resource request and response

May leak from referrer.

## 8. Privacy Considerations

### 8.1 Privacy by design

* Privacy impact analysis (PIA) should be performed in the initial phase of the system planning.
* For PIA, use of ISO/IEC 29134 Privacy impact analysis - Guidelines is recommended.
* The provider should establish a management system to help respect privacy of the customer.

### 8.2 Adhering to privacy principles

Stakeholders should follow the privacy principles of ISO/IEC 29100. In particular:

1. Consent and Choice
2. Purpose legitimacy and specification
3. Collection limitation
4. Data (access) limitation
5. Use, retention, and data disclosure limitation:
    1. Use limitation:
    1. Retention limitation: Where the data is no longer being used, clients should delete such data from their system within 180 days except for the cases it needs to retain due to the legal restrictions;
    1. Data disclosure limitation:
6. Accuracy and quality
7. Openness, transparency and notice
8. Individual participation and access
9. Accountability
10. Information security
11. Privacy compliance


## 9. Acknowledgement

(Fill in the names)

## 10. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC

## Annex A Financial Data API Level 1 (Normative)

* [fapi.yml]



