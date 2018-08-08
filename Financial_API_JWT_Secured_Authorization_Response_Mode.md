#Financial Services – Financial API - Part 2: JWT Secured Authorization Response Mode for OAuth 2.0

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
 
This document defines the new mode "jwt" for responses from the authorization endpoint of an authorization server. The response mode "jwt" enables clients to request the transmission of the credentials issued by the authorization server along with additional data in JWT format. This mechanims enhances the security of the authorization response since it provides sender authentication, audience restriction as well as protection from replay, credential leakage, and mix-up attacks.  

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial Services – Financial API - Part 2: JWT Secured Authorization Response Mode for OAuth 2.0 **

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

This draft defines the additional value "jwt" for the authorization request parameter "response_mode" as defined in [OIDM]. 

The response mode "jwt" causes the authorization server to encode the authorization response as a JWT. 

### 4.1. The JWT Response Document 

The JWT contains the credentials issued for a particular response type along with the following additional data utilized to secure the transmission:

* iss - the issuer URL of the authorization server that created the response
* aud - this claim contains the client_id of the client the response is intended for
* exp - experation of the JWT
* s_hash - the hash of the state value as defined in FAPI Part 2

The "state" parameter value is not included in the JWT because it functions as trust anchor to identify and check the authenticity of the response _before_ the JWT is processed by the client. 

When used in conjunction with the response type "code", the code is conveyed as additional field "code" of the JWT. The following is an example JWT response.

```
{  
   "iss":"https://accounts.example.com",
   "aud":"s6BhdRkqt3",
   "exp":1311281970,
   "s_hash":"44D41668D199FF3D525FA357A25525D738AADF2A7B1E2C819A39E38500ABAED9",
   "code":"PyyFaux2o7Q0YfXBU32jhw.5FXSQpvr8akv9CeRDSd0QA"  
}
```

Note: The response mode "jwt" can be combined with other response types, the respective syntax and behavior is out of scope of this draft.

The JWT may be signed or signed & encrypted. If the JWT is both signed and encrypted, the JSON document will be signed then encrypted, with the result being a Nested JWT, as defined in [RFC7519].

### 4.1 The JWT Secured Response

The response mode "jwt" causes the authorization server to add two parameters to the redirect to the client:

* state - the state value as specified in [RFC6749]
* response - the JSON Web Token containing the code and additional response data

This is an example response: 

```
GET /cb?state=S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw&
response=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmV4YW1wbGUuY29tIiwiYXVkIjoiczZCaGRSa3F0MyIsImp0aSI6IjI3MzBkYzJmLWM5YzYtNGJlNC05N2M5LTYyMjNkMThmMmIxMyIsIm5vbmNlIjoibi0wUzZfV3pBMk1qIiwiZXhwIjoxMzExMjgxOTcwLCJjX2hhc2giOiI0NDIyRTBFMDk0RjM0RTk3Qzg1MkVCNUY5QjI4MzlEODEyMDA2NkMyN0VGNjZBQTI4QzNEREM3Q0U3QTc5ODE1Iiwic19oYXNoIjoiNDRENDE2NjhEMTk5RkYzRDUyNUZBMzU3QTI1NTI1RDczOEFBREYyQTdCMUUyQzgxOUEzOUUzODUwMEFCQUVEOSJ9.ldPh3w3QAkkbz3voa3F2pvruWQwNBv3AYV9xpcuVLZi5Da4tjep-xayjO4_flznYuu9EZbyYA1lb9uzu0rSSSiwEJ5Ms9ZEvB4l1xXNLT5TRV00erXb6Y1JsvxHjanB0I8-FUHdP-HMA0Zhg9UVohAc2qiO6wDcEfi5y_1fST4Y
Host: client.example.com
```
### 4.2 Processing rules

The client is obliged to process the JWT secured response as follows:

1. The "state" parameter MUST be checked to be linked to the user agent's local state in order to prevent XSRF. Note: The state value is treated as a one-time-use XSRF token. It MUST be invalidated after the check was performed.
1. (OPTIONAL) The client decrypts the JWT using the key material registered with the expected issuer of the response. 
1. Check the signature of the JWT signature using the jwk set of the expected issuer. Note: the client MUST obtain the JWK set from local data and MUST NOT follow the iss claim of the JWT to obtain key material. This is done to prevent DoS (see Security Considerations) 
1. Check whether the JWT's "iss" claim matches the expected "iss" value of the local state (set before the authorization request was sent). 

## 6. Security considerations

### 6.1 DoS using specially crafted JWTs
This strategy will also work, but it's vulnerable to DoS attacks - JWTs
could be crafted to have an issuer that resolves to a JWK set URL with
huge content, or is delivered very slowly, consuming server networking
bandwidth /  a thread. The resolved JWK set URL could also be used to
DDoS targets on the web.

Use local data

### 6.2 Code Replay
Signature binds code to state (and transitively with user agent state)

### 6.3 Mix-Up
iss and aud

### 6.4 XSRF
state validation

### 6.5 Code Leakage
Encryption

## 7. Privacy considerations
TBD

## 10. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (YES), Editor
* Nat Sakimura (Nomura Research Institute) -- Chair
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Joseph Heenan (Authlete)
* Tom Jones (Independent)
* Ralph Bragg (Raidiam)
* Brian Campbell (Ping Identity)
* Vladimir Dzhuvinov (Connect2ID)

## 11. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC
* [SoK] Mainka, C., Mladenov, V., Schwenk, J., and T. Wich: SoK: Single Sign-On Security – An Evaluation of OpenID Connect
