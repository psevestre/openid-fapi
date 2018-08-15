#Financial Services – Financial API: JWT Secured Authorization Response Mode for OAuth 2.0

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice & license
The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

##Foreword

The OpenID Foundation (OIDF) promotes, protects and nurtures the OpenID community and technologies. As a non-profit international standardizing body, it is comprised by over 160 participating entities (workgroup participants). The work of preparing implementer drafts and final international standards is carried out through OIDF workgroups in accordance with the OpenID Process. Participants interested in a subject for which a workgroup has been established has the right to be represented in that workgroup. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

Final drafts adopted by the Workgroup through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote. There is a possibility that some of the elements of this document may be the subject to patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial API consists of the following parts:

* Part 1: Read-Only API Security Profile
* Part 2: Read and Write API Security Profile
* Part 3: Client Initiated Backchannel Authentication Profile

Future parts may follow.

These parts are intended to be used with [RFC6749], [RFC6750], [RFC7636], and [OIDC].

##Introduction

Fintech is an area of future economic growth around the world and Fintech organizations need to improve the security of their operations and protect customer data. It is common practice of aggregation services to use screen scraping as a method to capture data by storing users' passwords. This brittle, inefficient, and insecure practice creates security vulnerabilities which require financial institutions to allow what appears to be an automated attack against their applications and to maintain a whitelist of aggregators. A new draft standard, proposed by this workgroup would instead utilize an API model with structured data and a token model, such as OAuth [RFC6749, RFC6750].

The Financial API aims to provide specific implementation guidelines for online financial services to adopt by developing a REST/JSON data model protected by a highly secured OAuth profile.
 
This document defines the new mode "jwt" for responses from the authorization endpoint of an authorization server. The response mode "jwt" enables clients to request the transmission of the credentials issued by the authorization server along with additional data in JWT format. This mechanism enhances the security of the standard authorization response since it adds sender authentication, audience restriction as well as protection from replay, credential leakage, and mix-up attacks.  

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial Services – Financial API: JWT Secured Authorization Response Mode for OAuth 2.0 **

[TOC]

## 1. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[RFC7230] - Hypertext Transfer Protocol -- HTTP/1.1
[RFC7230]: https://tools.ietf.org/html/rfc7230

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[BCP195] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[BCP195]: https://tools.ietf.org/html/bcp195

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[OIDM] -  OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[draft-ietf-oauth-security-topics] - OAuth 2.0 Security Best Current Practice
[draft-ietf-oauth-security-topics]: https://tools.ietf.org/html/draft-ietf-oauth-security-topics

## 2. Terms and definitions
For the purpose of this document, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.


## 3. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial API

**FI** – Financial Institution

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 4. Response Mode "jwt"

This draft defines the additional response mode "jwt" for OAuth authorization requests in accordance with [OIDM]. The response mode "jwt" causes the authorization server to encode most of the authorization response as a JWT. 

### 4.1. The JWT Response Document 

Depending on the response type, the JWT contains the authorization response parameters as defined in [RFC6749], sections 4.1.2 and 4.2.2, except the `state` response parameter. 

For the grant type authorization code this is:

* `code` - the authorization code

For the grant type "token" these are:

* `access_token` - the access token
* `token_type` - the type of the access token
* `expires_in` - when the access token expires
* `scope` - the scope granted with the access token

The JWT also contains further data utilized to secure the transmission:

* `iss` - the issuer URL of the authorization server that created the response
* `aud` - the client_id of the client the response is intended for
* `exp` - expiration of the JWT
* `s_hash` - the hash of the state value as defined in FAPI Part 2

Note: The `state` parameter value is not included in the JWT because it functions as trust anchor to identify and check the authenticity of the authorization response _before_ the JWT is processed by the client. The `s_hash` claim of the JWT will provide a cryptographically protected binding between the state and the response parameters contained in the JWT. 

The following example shows an JWT for response type "code":

```
{  
   "iss":"https://accounts.example.com",
   "aud":"s6BhdRkqt3",
   "exp":1311281970,
   "s_hash":"44D41668D199FF3D525FA357A25525D738AADF2A7B1E2C819A39E38500ABAED9",
   "code":"PyyFaux2o7Q0YfXBU32jhw.5FXSQpvr8akv9CeRDSd0QA"  
}
```

The JWT is either signed, or signed and encrypted. If the JWT is both signed and encrypted, the JSON document will be signed then encrypted, with the result being a Nested JWT, as defined in [RFC7519].

### 4.2 The JWT Secured Response

The response mode "jwt" causes the authorization server to send an authorization response with the following parameters to the redirect URL of the client:

* state - the state value as specified in [RFC6749]
* response - the JWT as defined in section 4.1

This is an example response: 

```
GET /cb?state=S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw&
response=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FjY291bnR
zLmV4YW1wbGUuY29tIiwiYXVkIjoiczZCaGRSa3F0MyIsImp0aSI6IjI3MzBkYzJmLWM5YzYtNGJl
NC05N2M5LTYyMjNkMThmMmIxMyIsIm5vbmNlIjoibi0wUzZfV3pBMk1qIiwiZXhwIjoxMzExMjgxO
TcwLCJjX2hhc2giOiI0NDIyRTBFMDk0RjM0RTk3Qzg1MkVCNUY5QjI4MzlEODEyMDA2NkMyN0VGNj
ZBQTI4QzNEREM3Q0U3QTc5ODE1Iiwic19oYXNoIjoiNDRENDE2NjhEMTk5RkYzRDUyNUZBMzU3QTI
1NTI1RDczOEFBREYyQTdCMUUyQzgxOUEzOUUzODUwMEFCQUVEOSJ9.ldPh3w3QAkkbz3voa3F2pvr
uWQwNBv3AYV9xpcuVLZi5Da4tjepxayjO4_flznYuu9EZbyYA1lb9uzu0rSSSiwEJ5Ms9ZEvB4l1x
XNLT5TRV00erXb6Y1JsvxHjanB0I8-FUHdP-HMA0Zhg9UVohAc2qiO6wDcEfi5y_1fST4Y
Host: client.example.com
```
### 4.3 Processing rules

Assumption: the client stored the issuer it sent the authorization request to and is also able to obtain the key material to check the JWT's signature and, if needed, to decrypt the JWT independent of the JWT in the authorization response.

The client is obliged to process the JWT secured response as follows:

1. The "state" parameter MUST be checked to be linked to the user agent's local state in order to prevent CSRF. Note: The state value is treated as a one-time-use XSRF token. It MUST be invalidated after the check was performed.
1. (OPTIONAL) The JWT is decrypted using the key material registered with the expected issuer of the response. 
1. The signature of the JWT is validated using the JWK set of the expected issuer. Note: the client MUST obtain the JWK set from local data and MUST NOT follow the `iss` claim of the JWT to obtain key material. This is done to prevent DoS (see Security Considerations) 
1. The JWT's `iss` claim MUST matches the expected `iss` value of the local state (as stored with the client's local state before the authorization request was sent). 
1. The JWT's `aud` claim MUST match the client_id the client used to request the authorization.

The client MUST NOT process the grant type specific authorization response parameters before all checks suceeded. 

## 5. Security considerations

### 5.1 DoS using specially crafted JWTs
JWTs could be crafted to have an issuer that resolves to a JWK set URL with
huge content, or is delivered very slowly, consuming server networking
bandwidth and compute capacity. The resolved JWK set URL could also be used to
DDoS targets on the web.

The client therefore MUST use key material obtained independent of the JWT contained in the authorization response from a secure source to check its signature. 

### 5.2 Code Replay
An authorization code (obtained on a different device with the same client) could be injected into an authorization response in order to impersonate the legitimate resource owner (see [draft-ietf-oauth-security-topics]). 

The JWT secured response mode enables clients to detect such an attack. The signature binds the authorization code to the state value sent by the client and therewith transitively to the transaction in the respective user agent.

### 5.3 Mix-Up
Mix-up is an attack on scenarios where an OAuth client interacts with
   multiple authorization servers. The goal of the attack is to obtain an
   authorization code or an access token by tricking the client into
   sending those credentials to the attacker instead of using them at
   the respective endpoint at the authorization/resource server.
   
The JWT secured response mode enables clients to detect this attack by providing an identification of the sender (`iss`) and the intended audience of the authorization response (`aud`). 

### 5.5 Code Leakage
Authorization servers MAY encrypt the authorization response therewith providing a mechanism to prevent leakage of authorization codes in the user agent (transmission, history, referrer headers). 

## 6. Privacy considerations
TBD

## 7. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (YES), Editor
* Nat Sakimura (Nomura Research Institute) -- Chair
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Joseph Heenan (Authlete)
* Tom Jones (Independent)
* Ralph Bragg (Raidiam)
* Brian Campbell (Ping Identity)
* Vladimir Dzhuvinov (Connect2ID)
* Michael Schwartz (Gluu)

## 8. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC
* [SoK] Mainka, C., Mladenov, V., Schwenk, J., and T. Wich: SoK: Single Sign-On Security – An Evaluation of OpenID Connect
