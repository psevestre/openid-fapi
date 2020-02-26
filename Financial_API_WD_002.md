# Financial-grade API - Part 2: Read and Write API Security Profile

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
* Financial-grade API: Client Initiated Backchannel Authentication Profile
* Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)
* Financial-grade API: Pushed Request Object

Future parts may follow.

These parts are intended to be used with [RFC6749], [RFC6750], [RFC7636], and [OIDC].

##Introduction

Fintech is an area of future economic growth around the world and Fintech organizations need to improve the security of their operations and protect customer data. It is common practice of aggregation services to use screen scraping as a method to capture data by storing users' passwords. This brittle, inefficient, and insecure practice creates security vulnerabilities which require financial institutions to allow what appears to be an automated attack against their applications and to maintain a whitelist of aggregators. A new draft standard, proposed by this workgroup would instead utilize an API model with structured data and a token model, such as OAuth [RFC6749, RFC6750].

The Financial-grade API aims to provide specific implementation guidelines for online financial services to adopt by developing a REST/JSON data model protected by a highly secured OAuth profile. The Financial-grade API security profile can be applied to online services in any market area that requires a higher level of security than provided by standard OAuth or OpenID Connect.
 
This document is Part 2 of FAPI that specifies the Financial-grade API and it provides a profile of OAuth that is suitable to be used in write access to financial data (also known as transaction access) and other similar higher risk access. This document specifies the controls against attacks such as: authorization request tampering, authorization response tampering including code injection, state injection, and token request phishing. Additional details are available in the security considerations section.

Although it is possible to code an OpenID Provider and Relying Party from first principles using this specification, the main audience for this specification is parties who already have a certified implementation of OpenID Connect and want to achieve a higher level of security. Implementors are encouraged to understand the security considerations contained in section 8.7 before embarking on a 'from scratch' implementation.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial-grade API - Part 2: Read and Write API Security Profile **

[TOC]

## 1. Scope

This part of the document specifies the method of

* applications to obtain the OAuth tokens in an appropriately secure manner for higher risk access to data;
* applications to use OpenID Connect to identify the customer; and
* using tokens to interact with the REST endpoints that provides protected data; 

This document is applicable to higher risk use cases which includes commercial and investment banking and other similar industries.

## 2. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[ISODIR2] - ISO/IEC Directives Part 2
[ISODIR2]: http://www.iso.org/sites/directives/2016/part2/index.xhtml

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC7636] - Proof Key for Code Exchange by OAuth Public Clients
[RFC7636]: https://tools.ietf.org/html/rfc7636

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[MTLS] - OAuth 2.0 Mutual TLS Client Authentication and Certificate Bound Access Tokens
[MTLS]: https://tools.ietf.org/html/draft-ietf-oauth-mtls

[JARM] - Financial Services – Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)
[JARM]: https://bitbucket.org/openid/fapi/src/master/Financial_API_JWT_Secured_Authorization_Response_Mode.md

[PRO] - Financial Services – Financial-grade API: Pushed Request Object
[PRO]:https://bitbucket.org/openid/fapi/src/master/Financial_API_Pushed_Request_Object.md

## 3. Terms and definitions
For the purpose of this document, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.


## 4. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial-grade API

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 5. Read and write API security profile

### 5.1 Introduction

The OIDF Financial-grade API (FAPI) is a REST API that provides JSON data representing
higher risk data. These APIs are protected by the
OAuth 2.0 Authorization Framework that consists of [RFC6749], [RFC6750],
[RFC7636], and other specifications.

There are different levels of risks associated with access to these APIs.
For example, read and write access to a bank API has a higher financial risk than read-only access. As
such, the security profiles of the authorization framework protecting these
APIs are also different. 

This profile describes security provisions for the server and client that are appropriate for Financial-grade APIs by defining the measures to mitigate:

* attacks that leverage the weak binding of endpoints in [RFC6749] (e.g. malicious endpoint attacks, IdP mix-up attacks),
* attacks that modify authorization requests and responses unprotected in [RFC6749] 

The following ways are specified to cope with modifications of authorization responses. Implementation can leverage OpenID Connect's Hybrid Flow that returns an ID Token in the authorization response or they can utilize the JWT Secured Authorization Response Mode for OAuth 2.0 (JARM) that returns and protects all authorization response parameters in a JWT.

#### 5.1.1 ID Token as Detached Signature
While the name ID Token (as used in the OpenID Connect Hybrid Flow) suggests that it is something that provides the identity of the resource owner (subject), it is not necessarily so. While it does identify the authorization server by including the issuer identifier, 
it is perfectly fine to have an ephemeral subject identifier. In this case, the ID Token acts as a detached signature of the issuer to the authorization response and it was an explicit design decision of OpenID Connect Core to make the ID Token act as a detached signature.

This document leverages this fact and protects the authorization response by including the hash of all of the unprotected response parameters, e.g. `code` and `state`, in the ID Token. 

While the hash of the `code` is defined in [OIDC], the hash of the `state` is not defined. 
Thus this document defines it as follows. 

**s_hash**

>State hash value. Its value is the base64url encoding of the left-most half of the hash of the octets of the ASCII representation
of the `state` value, where the hash algorithm used is the hash algorithm used
in the `alg` header parameter of the ID Token's JOSE header. For instance,
if the `alg` is `HS512`, hash the state value with SHA-512, then take the left-most 256 bits and base64url encode them.
The `s_hash` value is a case sensitive string.

#### 5.1.2 JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)

An authorization server may protect authorization responses to clients using the "JWT Secured Authorization Response Mode" [JARM].

The [JARM] allows a client to request that an authorization server encodes the authorization response (of any response type) in a JWT. It is an alternative to utilizing ID Tokens as detached signatures for providing financial-grade security on authorization responses and can be used with plain OAuth.

This specification facilitates use of [JARM] in conjunction with the response type `code`.

Note: [JARM] can be used to protect OpenID Connect authentication responses. In this case, the OpenID RP would use response type `code`, response mode `jwt` and scope `openid`. This means [JARM] protects the authentication response (instead of the ID Token) and the ID Token containing End-User Claims is obtained from the token endpoint. This facilitates privacy since no End-User Claims are sent through the front channel. It also provides decoupling of 
message protection and identity providing since a client (or RP) can basically use [JARM] to protect all 
authorization responses and turn on OpenID if needed (e.g. to log the user in).

### 5.2 Read and write API security provisions

#### 5.2.1 Introduction

Read and write access carries higher risk; therefore the protection level required is higher than read-only access.

As a profile of The OAuth 2.0 Authorization Framework, this document mandates the following for the read and write API of the FAPI.

#### 5.2.2 Authorization server

The authorization server shall support the provisions specified in clause 5.2.2 of Financial-grade API - Part 1: Read-Only API Security Profile.

In addition, the authorization server, for the write operation,

1. shall require the `request` or `request_uri` parameter to be passed as a JWS signed JWT as in clause 6 of [OIDC];
1. shall require 
	1. the `response_type` value `code id_token` or 
	2. the `response_type` value `code` in conjunction with the `response_mode` value `jwt`;
1. (moved to 5.2.2.1)
1. shall only issue authorization code, access token, and refresh token that are holder of key bound;
1. shall support [MTLS] as a holder of key mechanism;
1. (withdrawn);
1. (moved to 5.2.2.1);
1. (moved to 5.2.2.1);
1. shall only use the parameters included in the signed request object passed in the `request` or `request_uri` parameter;
1. may support the request object endpoint as described in [PRO];
1. (withdrawn);
1. shall require the request object to contain an `exp` claim that has a lifetime of no longer than 60 minutes after the `nbf` claim; and
1. shall authenticate the confidential client using one of the following methods (this overrides FAPI part 1 clause 5.2.2.4):
    1. Mutual TLS for OAuth Client Authentication as specified in section 2 of [MTLS];
    2. `private_key_jwt` as specified in section 9 of [OIDC];
1. shall require the aud claim in the request object to be, or to be an array containing, the OP's Issuer Identifier URL;
1. shall not support public clients; and
1. shall require the request object to contain an `nbf` claim that is no longer than 60 minutes in the past.

**NOTE:** MTLS is currently the only holder of key mechanism that has been widely deployed. Future versions of this specification are likely to allow other holder of key mechanisms.

#### 5.2.2.1 ID Token as detached signature

In addition, if the `response_type` value `code id_token` is used, the authorization server

1. shall support [OIDC]
1. shall support signed ID Tokens;
1. should support signed and encrypted ID Tokens;
1. shall return ID Token as a detached signature to the authorization response;
1. shall include state hash, `s_hash`, in the ID Token to protect the `state` value if the client supplied a value for `state`. `s_hash` may be omitted from the ID Token returned from the Token Endpoint when `s_hash` is present in the ID Token returned from the Authorization Endpoint;

#### 5.2.2.2 JARM

In addition, if the `response_type` value `code` is used in conjunction with the `response_mode` value `jwt`, the authorization server

1. shall create JWT-secured authorization responses as specified in [JARM], section 4.3;

#### 5.2.3 Confidential client

A confidential client shall support the provisions specified in clause 5.2.3 and 5.2.4 of Financial-grade API - Part 1: Read-Only API Security Profile, except for [RFC7636] support.

In addition, the confidential client for write operations

1. shall support [MTLS] as a holder of key mechanism;
1. shall include the `request` or `request_uri` parameter as defined in Section 6 of [OIDC] in the authentication request;
1. shall ensure the Authorization Server has authenticated the user to an appropriate Level of Assurance for the client's intended purpose;
1. (moved to 5.2.3.1);
1. (withdrawn);
1. (withdrawn);
1. (moved 5.2.3.1);
1. shall send all parameters inside the authorization request's signed request object
1. shall additionally send duplicates of the `response_type`, `client_id`, and `scope` parameters/values using the OAuth 2.0 request syntax as required by the OAuth and OpenID Connect specifications
1. shall send the `aud` claim in the request object as the OP's Issuer Identifier URL
1. shall send an `exp` claim in the request object that has a lifetime of no longer than 60 minutes
1. (moved to 5.2.3.1)
1. (moved to 5.2.3.1).
1. shall send a `nbf' claim in the request object

#### 5.2.3.1 ID Token as detached signature

In addition, if the `response_type` value `code id_token` is used, the client

1. shall include the value `openid` into the `scope` parameter in order to activate [OIDC] support
1. shall require JWS signed ID Token be returned from endpoints;
1. shall verify that the authorization response was not tampered using ID Token as the detached signature
1. shall verify that `s_hash` value is equal to the value calculated from the `state` value in the authorization response in addition to all the requirements in 3.3.2.12 of [OIDC]. Note: this enables the client to to verify that the authorization response was not tampered with, using the ID Token as a detached signature.
1. should require both JWS signed and JWE encrypted ID Tokens to be returned from endpoints to protect any sensitive personally identifiable information (PII) contained in the ID Token provided as a detached signature in the authorization response.

#### 5.2.3.2 JARM

In addition, if the `response_type` value `code` is used in conjunction with the `response_mode` value `jwt`, the client

1. shall verify the authorization responses as specified in [JARM], section 4.4;

#### 5.2.4 (withdrawn)

#### 5.2.5 (withdrawn)

## 6. Accessing protected resources (using tokens)

### 6.1 Introduction

The FAPI endpoints are OAuth 2.0 protected resource endpoints that return protected information for the resource owner associated with the submitted access token.

### 6.2 Read and write access provisions

#### 6.2.1 Protected resources provisions

The protected resources supporting this document

1. shall support the provisions specified in clause 6.2.1 Financial-grade API - Part 1: Read Only API Security Profile;
1. shall adhere to the requirements in [MTLS].

#### 6.2.2 Client provisions

The client supporting this document shall support the provisions specified in clause 6.2.2 of Financial-grade API - Part 1: Read-Only API Security Profile.

## 8. Security considerations

### 8.1 Introduction
As a profile of the OAuth 2.0 Authorization Framework, this specification references the security considerations defined in section 10 of [RFC6749], as well as [RFC6819] - OAuth 2.0 Threat Model and Security Considerations, which details various threats and mitigations.

### 8.2 Uncertainty of resource server handling of access tokens
There is no way that the client can find out whether the resource access was granted for the bearer token or holder of key token.
The two differ in the risk profile and the client may want to differentiate them.
The protected resources that conform to this doc differentiate them.
The protected resources that conform to this docuument shall not accept a plain bearer token.
They shall only support bound access tokens via [MTLS].

### 8.3 Attacks using weak binding of authorization server endpoints

#### 8.3.1 Introduction

In [RFC6749] and [RFC6750], the endpoints that the authorization server offers are not tightly bound together. 
There is no notion of authorization server identifier (issuer identifier) and it is not indicated in 
the authorization response unless the client uses different redirection URI per authorization server. 
While it is assumed in the OAuth model, it is not explicitly spelled out and thus many clients 
use the same redirection URI for different authorization servers exposing an attack surface. 
Several attacks have been identified and the threats are explained in detail in [RFC6819].

#### 8.3.2 Client credential and authorization code phishing at token endpoint

In this attack, the client developer is social engineered into believing that the token endpoint has changed to the URL that is controlled by the attacker. 
As the result, the client sends the `code` and the client secret to the attacker, which will be replayed subsequently. 

When the FAPI client uses [MTLS], the authorization code is bound to the TLS channel, any phished client credentials and authorization codes submitted to the token endpoint cannot be used since the authorization code is bound to a particular TLS channel.

#### 8.3.3 Identity provider (IdP) mix-up attack
In this attack, the client has registered multiple IdPs and one of them is a rogue IdP that returns the same `client_id` 
that belongs to one of the honest IdPs. When a user clicks on a malicious link or visits a compromised site, 
an authorization request is sent to the rogue IdP. 
The rogue IdP then redirects the client to the honest IdP that has the same `client_id`. 
If the user is already logged on at the honest IdP, 
then the authentication may be skipped and a code is generated and returned to the client. 
Since the client was interacting with the rogue IdP, the code is sent to the rogue IdP's token endpoint. 
At the point, the attacker has a valid code that can be exchanged for an access token at the honest IdP.

This is mitigated by the use of OpenID Connect Hybrid Flow in which the honest IdP's issuer identifier is included as the value of `iss` or [JARM] where the `iss` included in the response JWT. 
The client then sends the `code` to the token endpoint that is associated with the issuer identifier thus it will not get to the attacker. 

#### 8.3.4 Request object endpoint phishing resistance
An attacker can use social engineering to have the administrator of the client set 
the request object endpoint to a URL under the attacker's control. In this case, 
sensitive information included in the request object will be revealed to the attacker. 
To prevent this, the authorization server should communicate to the client developer 
the proper change process repeatedly to help client developers to be less susceptible to such social engineering.

#### 8.3.5 Access token phishing
When the FAPI client uses [MTLS], the access token is bound to the TLS channel, it is access token phishing resistant as the phished access tokens cannot be used.

### 8.4 Attacks that modify authorization requests and responses

#### 8.4.1 Introduction
In [RFC6749] the authorization request and responses are not integrity protected. 
Thus, an attacker can modify them. 

#### 8.4.2 Authorization request parameter injection attack

In [RFC6749], the authorization request is sent as query parameter. 
Although [RFC6749] mandates the use of TLS, the TLS is terminated in the browser and thus not protected within the browser; as a result an attacker can tamper the authorization request and insert any parameter values.

The use of a `request` object or `request_uri` in the authorization request will prevent tampering with the request parameters. 

The IdP confusion attack reported in [SoK: Single Sign-On Security – An Evaluation of OpenID Connect](https://www.nds.rub.de/media/ei/veroeffentlichungen/2017/01/30/oidc-security.pdf) is an example of this kind of attack.

#### 8.4.3 Authorization response parameter injection attack
This attack occurs when the victim and attacker use the same relying party client. The attacker is somehow able to
capture the authorization code and state from the victim's authorization response and uses them in his own
authorization response. 

This can be mitigated by using OpenID Connect Hybrid Flow where the `c_hash`, `at_hash`,
and `s_hash` can be used to verify the validity of the authorization code, access token,
and state parameters. It can also be mitgated using [JARM] by verifying the integrity of the authorization response JWT.

The server can verify that the state is the same as what was stored in the browser session at the time of the authorization request.

### 8.5 TLS considerations
As confidential information is being exchanged, all interactions shall be encrypted with TLS (HTTPS).

Section 7.1 of Financial-grade API - Part 1: Read Only API Security Profile shall apply, with the following additional requirements:

1. For TLS versions below 1.3, only the following 4 cipher suites shall be permitted:
    * `TLS_DHE_RSA_WITH_AES_128_GCM_SHA256`
    * `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256`
    * `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384`
    * `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`
1. For the `authorization_endpoint`, the authorization server MAY allow additional cipher suites that are permitted by the latest version of [BCP195], if necessary to allow sufficient interoperability with users' web browsers.
1. When using the `TLS_DHE_RSA_WITH_AES_128_GCM_SHA256` or `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384` cipher suites, key lengths of at least 2048 bits are required.

### 8.6 Algorithm considerations

For JWS, both clients and authorization servers:

1. shall use `PS256` or `ES256` algorithms;
1. should not use algorithms that use RSASSA-PKCS1-v1_5 (e.g. `RS256`);
1. shall not use `none`;

### 8.6.1 Encryption algorithm considerations

For JWE, both clients and authorization servers

1. shall not use the `RSA1_5` algorithm.

### 8.7 Incomplete or incorrect implementations of the specifications

To achieve the full security benefits, it is important the implementation of this specification, and the underlying OpenID Connect and OAuth specifications, are both complete and correct.

The OpenID Foundation provides tools that can be used to confirm that an implementation is correct:

https://openid.net/certification/

The OpenID Foundation maintains a list of certified implementations:

https://openid.net/developers/certified/

Deployments that use this specification should use a certified implementation.

### 8.8 Session Fixation 
An attacker could prepare an authorization request URL and trick a victim 
into authorizing access to the requested resources, e.g. by sending the URL 
via e-Mail or utilizing it on a fake site. 

OAuth 2.0 prevents this kind of attack since the process for obtaining the 
access token (code exchange, CSRF protection etc.) is designed in a way that the 
attacker will be unable to obtain and use the token as long as it does not 
control the victim's browser. 

However, if the API allows execution of any privileged action in the course of 
the authorization process before the access token is issued, these controls are 
rendered ineffective. Implementors of this specification therefore MUST ensure 
any action is executed using the access token issued by the authorization 
process. 

For example, payments MUST NOT be executed in the authorization process but 
after the Client has exchanged the authorization code for a token and sent an 
"execute payment" request with the access token to a protected endpoint. 

## 9. Privacy considerations

* When claims related to the subject are returned in the ID Token in the front channel, 
  implementations should consider encrypting the ID Token to lower the risk of personal information disclosure. 


## 10. Acknowledgement

The following people contributed to this document:

* Nat Sakimura (Nomura Research Institute) -- Chair, Editor
* Anoop Saxana (Intuit) -- Co-chair, FS-ISAC Liaison
* Anthony Nadalin (Microsoft) -- Co-chair, SC 27 Liaison
* Edmund Jay (Illumila) -- Co-editor
* Dave Tonge (Moneyhub) -- Co-chair, UK Implementation Entity Liaison
* Paul A. Grassi (NIST) -- X9 Liaison
* Joseph Heenan (Authlete)
* Sascha H. Preibisch (CA)
* John Bradley (Yubico)
* Henrik Biering (Peercraft)
* Tom Jones (Independent) 
* Axel Nennker (Deutsche Telekom)
* Torsten Lodderstedt (yes.com)
* Ralph Bragg (Raidiam)
* Brian Campbell (Ping Identity) 

## 11. Bibliography

* [ISODIR2] ISO/IEC Directives Part 2
* [RFC6749] The OAuth 2.0 Authorization Framework
* [RFC6750] The OAuth 2.0 Authorization Framework: Bearer Token Usage
* [RFC7636] Proof Key for Code Exchange by OAuth Public Clients
* [RFC6819] OAuth 2.0 Threat Model and Security Considerations
* [RFC7519] JSON Web Token (JWT)
* [OIDC] OpenID Connect Core 1.0 incorporating errata set 1
* [OIDD] OpenID Connect Discovery 1.0 incorporating errata set 1
* [MTLS] OAuth 2.0 Mutual TLS Client Authentication and Certificate Bound Access Tokens
* [JARM] Financial Services – Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0
* [SoK] Mainka, C., Mladenov, V., Schwenk, J., and T. Wich: SoK: Single Sign-On Security – An Evaluation of OpenID Connect
