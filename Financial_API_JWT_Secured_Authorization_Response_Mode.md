# Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)

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

Future parts may follow.

These parts are intended to be used with [RFC6749], [RFC6750], [RFC7636], and [OIDC].

##Introduction

Fintech is an area of future economic growth around the world and Fintech organizations need to improve the security of their operations and protect customer data. It is common practice of aggregation services to use screen scraping as a method to capture data by storing users' passwords. This brittle, inefficient, and insecure practice creates security vulnerabilities which require financial institutions to allow what appears to be an automated attack against their applications and to maintain a whitelist of aggregators. A new draft standard, proposed by this workgroup would instead utilize an API model with structured data and a token model, such as OAuth [RFC6749, RFC6750].

The Financial-grade API aims to provide specific implementation guidelines for online financial services to adopt by developing a REST/JSON data model protected by a highly secured OAuth profile.
 
This document defines a new JWT-based mode to encode authorization responses. Clients are enabled to request 
the transmission of the authorization response parameters along with additional data in JWT format. 
This mechanism enhances the security of the standard authorization response since it adds support for signing 
and encryption, sender authentication, audience restriction as well as protection from replay, credential leakage, 
and mix-up attacks. It can be combined with any response type.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)**

[TOC]

## 1. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[RFC7230] - Hypertext Transfer Protocol -- HTTP/1.1
[RFC7230]: https://tools.ietf.org/html/rfc7230

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC7636] - Proof Key for Code Exchange by OAuth Public Clients
[RFC7636]: https://tools.ietf.org/html/rfc7636

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

[RFC7515] - JSON Web Signature (JWS)
[RFC7515]:https://tools.ietf.org/html/rfc7515

[RFC7516] - JSON Web Encryption (JWE)
[RFC7516]:https://tools.ietf.org/html/rfc7516

[RFC7517] - JSON Web Key (JWK)
[RFC7517]:https://tools.ietf.org/html/rfc7517

[RFC7518] - JSON Web Algorithms (JWA)
[RFC7518]:https://tools.ietf.org/html/rfc7518

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[BCP195] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[BCP195]: https://tools.ietf.org/html/bcp195

[RFC7591] - OAuth 2.0 Dynamic Client Registration Protocol
[RFC7591]: https://tools.ietf.org/html/RFC7591

[RFC8414] - OAuth 2.0 Authorization Server Metadata
[RFC8414]: https://tools.ietf.org/html/rfc8414

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[OIDM] -  OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[OIFP] - OAuth 2.0 Form Post Response Mode
[OIFP]: http://openid.net/specs/oauth-v2-form-post-response-mode-1_0.html

[draft-ietf-oauth-security-topics] - OAuth 2.0 Security Best Current Practice
[draft-ietf-oauth-security-topics]: https://tools.ietf.org/html/draft-ietf-oauth-security-topics

[OISM] - OpenID Connect Session Management 1.0
[OISM]: http://openid.net/specs/openid-connect-session-1_0.html

## 2. Terms and definitions
For the purpose of this document, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.

## 3. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial-grade API

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 4. JWT-based Response Mode

This document defines a new JWT-based mode to encode authorization responses parameters. All response parameters defined for a given response type are conveyed in a JWT along with additional fields used to further protect the transmission. Since there are different techniques to encode the JWT itself in the response to the client, namely query URI parameter, fragment component and form post, this draft defines a set of response mode values in accordance with [OIDM] corresponding to this techniques.  

### 4.1. The JWT Response Document 

The JWT always contains the following data utilized to secure the transmission:

* `iss` - the issuer URL of the authorization server that created the response
* `aud` - the client_id of the client the response is intended for
* `exp` - expiration of the JWT. A maximum JWT lifetime of 10 minutes is RECOMMENDED.
 
The JWT MUST furthermore contain the authorization endpoint response parameters as defined for the particular response types, even in case of an error response. Authorization endpoint response parameter names and string values are included as JSON strings and numerical values (e.g., `expires_in` value) are included as JSON numbers. This pattern is applicable to all response types including those defined in [OIDM]. The following subsections illustrate the pattern with the response types "code" and "token".

Note: Additional authorization endpoint response parameters defined by extensions, e.g. `session_state` as defined in [OISM], will also be added to the JWT. 

The JWT response document MAY contain further element, e.g. the claims defined in [RFC7519]. Implementation SHOULD adhere to the respective processing rules and ignore unrecognized elements.

#### 4.1.1 Response Type "code"

For the grant type authorization "code" the JWT contains the response parameters as defined in [RFC6749], sections 4.1.2:

* `code` - the authorization code
* `state` - the state value as sent by the client in the authorization request, if the client included a `state` parameter

The following example shows the JWT claims for a successful "code" authorization response:

```
{  
   "iss":"https://accounts.example.com",
   "aud":"s6BhdRkqt3",
   "exp":1311281970,
   "code":"PyyFaux2o7Q0YfXBU32jhw.5FXSQpvr8akv9CeRDSd0QA",  
   "state":"S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw"
}
```

In case of an error response, the JWT contains the error response parameters as defined in [RFC6749], sections 4.1.2.1:

* `error` - the error code
* `error_description` (OPTIONAL) - a human readable description of the error
* `error_uri` (OPTIONAL) - a URI identifying a human-readable web page with information about the error
* `state` - the state value as sent by the client in the authorization request (if applicable)

The following example shows the JWT payload for such an error response:

```
{
   "iss":"https://accounts.example.com",
   "aud":"s6BhdRkqt3",
   "exp":1311281970,
   "error":"access_denied",
   "state":"S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw"
}
```

#### 4.1.2 Response Type "token"

For the grant type "token" the JWT contains the response parameters as defined in [RFC6749], sections 4.2.2:

* `access_token` - the access token
* `token_type` - the type of the access token
* `expires_in` - when the access token expires
* `scope` - the scope granted with the access token
*  `state` - the state value as sent by the client in the authorization request (if applicable)

The following example shows the claims of the JWT for a successful "token" authorization response:

```
{  
   "iss":"https://accounts.example.com",
   "aud":"s6BhdRkqt3",
   "exp":1311281970,
   "access_token":"2YotnFZFEjr1zCsicMWpAA",
   "state":"S8NJ7uqk5fY4EjNvP_G_FtyJu6pUsvH9jsYni9dMAJw",
   "token_type":"bearer",
   "expires_in":3600,
   "scope":"example"   
}
``` 
In case of an error response, the JWT contains the error response parameters in the same manner as with the response type "code".

### 4.2 Signing and Encryption

The JWT is either signed, or signed and encrypted. If the JWT is both signed and encrypted, the JSON document will be signed then encrypted, with the result being a Nested JWT, as defined in [RFC7519].

The authorization server determines what algorithm to employ to secure the JWT for a particular authorization response. This decision can be based on registered metadata parameters for the client as defined by this draft (see section 5).

For guidance on key management in general and especially on use of symmetric algorithms for signing and encrypting based on client secrets see sections 10.1 and 10.2 of [OIDC].

### 4.3 Response Encoding

This draft defines the following response mode values:

* `query.jwt`
* `fragment.jwt`
* `form_post.jwt`
* `jwt`

#### 4.3.1 Response Mode "query.jwt"

The response mode "query.jwt" causes the authorization server to send the authorization response as HTTP redirect to the redirect URI of the client. The authorization server adds the parameter `response` containing the JWT as defined in section 4.1. to the query component of the redirect URI using the "application/x-www-form-urlencoded" format.

This is an example response (line breaks for display purposes only): 

```
HTTP/1.1 302 Found
Location: https://client.example.com/cb?
response=eyJraWQiOiJsYWViIiwiYWxnIjoiRVMyNTYifQ.eyAgImlzcyI6ICJodHRwczovL2FjY291
bnRzLmV4YW1wbGUuY29tIiwgICJhdWQiOiAiczZCaGRSa3F0MyIsICAiZXhwIjogMTMxMTI4MTk3MCwg
ICJjb2RlIjogIlB5eUZhdXgybzdRMFlmWEJVMzJqaHcuNUZYU1FwdnI4YWt2OUNlUkRTZDBRQSIsICAi
c3RhdGUiOiAiUzhOSjd1cWs1Zlk0RWpOdlBfR19GdHlKdTZwVXN2SDlqc1luaTlkTUFKdyJ9.4VdtknV
Z9zFYDVLagJpVBD436bjPMcSgOaPDPFgTEkNyCs2uIHYJ2XML6d2w1AUsm5GBG77DBisZNhLWfug6dA
```

Note: "query.jwt" MUST NOT be used in conjunction with response types that contain "token" or "id_token" unless the response JWT is encrypted to prevent token leakage in the URL. 

#### 4.3.2 Response Mode "fragment.jwt"

The response mode "fragment.jwt" causes the authorization server to send the authorization response as HTTP redirect to the redirect URI of the client. The authorization server adds the parameter `response` containing the JWT as defined in section 4.1. to the fragment component of the redirect URI using the "application/x-www-form-urlencoded" format.

This is an example response (line breaks for display purposes only): 

```
HTTP/1.1 302 Found
Location: https://client.example.com/cb#
response=eyJraWQiOiJsYWViIiwiYWxnIjoiRVMyNTYifQ.eyAgImlzcyI6ICJodHRwczovL2FjY291
bnRzLmV4YW1wbGUuY29tIiwgICJhdWQiOiAiczZCaGRSa3F0MyIsICAiZXhwIjogMTMxMTI4MTk3MCwg
ICJhY2Nlc3NfdG9rZW4iOiAiMllvdG5GWkZFanIxekNzaWNNV3BBQSIsICAic3RhdGUiOiAiUzhOSjd1
cWs1Zlk0RWpOdlBfR19GdHlKdTZwVXN2SDlqc1luaTlkTUFKdyIsICAidG9rZW5fdHlwZSI6ICJiZWFy
ZXIiLCAgImV4cGlyZXNfaW4iOiAzNjAwLCAgInNjb3BlIjogImV4YW1wbGUifQ.g_96IM2t_6Dazm1Jp
b2gbO2EXe5IKTw2bYS7l9Y1RI8HbNPYN5EdNjxcWeL5LTQaUAZ2PtJoHbTdjMvNa3xbVg
```

#### 4.3.3. Response Mode "form_post.jwt"

The response mode "form_post.jwt" uses the technique described in [OIFP] to convey the JWT to the client. The `response` parameter containing the JWT is encoded as HTML form value that is auto-submitted in the User Agent, and thus is transmitted via the HTTP POST method to the Client, with the result parameters being encoded in the body using the "application/x-www-form-urlencoded" format.

This is an example response from the authorization server to the user agent (line breaks for display purposes only), 

```
HTTP/1.1 200 OK
Content-Type: text/html;charset=UTF-8
Cache-Control: no-cache, no-store
Pragma: no-cache

<html>
 <head><title>Submit This Form</title></head>
 <body onload="javascript:document.forms[0].submit()">
  <form method="post" action="https://client.example.com/cb">
    <input type="hidden" name="response"
     value="eyJraWQiOiJsYWViIiwiYWxnIjoiRVMyNTYifQ.eyAgImlzcyI6ICJodHRw
     czovL2FjY291bnRzLmV4YW1wbGUuY29tIiwgICJhdWQiOiAiczZCaGRSa3F0MyIsIC
     AiZXhwIjogMTMxMTI4MTk3MCwgICJhY2Nlc3NfdG9rZW4iOiAiMllvdG5GWkZFanIx
     ekNzaWNNV3BBQSIsICAic3RhdGUiOiAiUzhOSjd1cWs1Zlk0RWpOdlBfR19GdHlKdT
     ZwVXN2SDlqc1luaTlkTUFKdyIsICAidG9rZW5fdHlwZSI6ICJiZWFyZXIiLCAgImV4
     cGlyZXNfaW4iOiAzNjAwLCAgInNjb3BlIjogImV4YW1wbGUifQ.g_96IM2t_6Dazm1
     Jpb2gbO2EXe5IKTw2bYS7l9Y1RI8HbNPYN5EdNjxcWeL5LTQaUAZ2PtJoHbTdjMvNa
     3xbVg"/>
    </form>
   </body>
  </html>  
```
which results in the following POST request to the client's redirect URI.

```
  POST /cb HTTP/1.1
  Host: client.example.org
  Content-Type: application/x-www-form-urlencoded

   response=eyJraWQiOiJsYWViIiwiYWxnIjoiRVMyNTYifQ.eyAgImlzcyI6ICJodHRw
   czovL2FjY291bnRzLmV4YW1wbGUuY29tIiwgICJhdWQiOiAiczZCaGRSa3F0MyIsICAi
   ZXhwIjogMTMxMTI4MTk3MCwgICJhY2Nlc3NfdG9rZW4iOiAiMllvdG5GWkZFanIxekNz
   aWNNV3BBQSIsICAic3RhdGUiOiAiUzhOSjd1cWs1Zlk0RWpOdlBfR19GdHlKdTZwVXN2
   SDlqc1luaTlkTUFKdyIsICAidG9rZW5fdHlwZSI6ICJiZWFyZXIiLCAgImV4cGlyZXNf
   aW4iOiAzNjAwLCAgInNjb3BlIjogImV4YW1wbGUifQ.g_96IM2t_6Dazm1Jpb2gbO2EX
   e5IKTw2bYS7l9Y1RI8HbNPYN5EdNjxcWeL5LTQaUAZ2PtJoHbTdjMvNa3xbVg
```  
    
#### 4.3.4 Response Mode "jwt"

The response mode "jwt" is a shortcut and indicates the default redirect encoding (query, fragment) for the requested response type. The default for response type "code" is "query.jwt" whereas the default for "token" and the response types defined in [OIDM], except "none", is "fragment.jwt".

### 4.4 Processing rules

Assumption: the client remembers the authorization server to which it sent the authorization request and binds this information to the user agent.

The client is obliged to process the JWT secured response as follows:

1. (OPTIONAL) The client decrypts the JWT using the default key for the respective issuer or, if applicable, determined by the `kid` JWT header parameter. The key might be a private key, where the corresponding public key is registered with the expected issuer of the response ("use":"enc" via the client's metadata `jwks` or `jwks_uri`) or a key derived from its client secret (see section 4.2). 
1. The client obtains the `iss` element from the JWT and checks whether its value is well known and identifies the expected issuer of the authorization process in examination. If the check fails, the client MUST abort processing and refuse the response.
1. The client obtains the `aud` element from the JWT and checks whether it matches the client id the client used to identify itself in the corresponding authorization request. If the check fails, the client MUST abort processing and refuse the response.
1. The client checks the JWT's `exp` element to determine if the JWT is still valid. If the check fails, the client MUST abort processing and refuse the response. 
1. The client obtains the key needed to check the signature based on the JWT's `iss` element and, if present, the `kid` header element and checks its signature. If the check fails, the client MUST abort processing and refuse the response.

The client will perform further checks, e.g. for CSRF detection, which are out of scope of this specification. Please see [draft-ietf-oauth-security-topics] for more security recommendations.

Note: The way the client obtains the keys for verifying the JWT's signature (step 5) is out of scope of this draft. Established mechanism such as [OIDD] or [RFC8414] SHOULD be utilized.

The client MUST NOT process the grant type specific authorization response parameters before all checks succeed. 

## 5. Client Metadata

The parameter names follow the pattern established by OpenID Connect Dynamic Client Registration [OpenID.Registration] for configuring signing and encryption algorithms for JWT responses at the UserInfo endpoint.

The following client metadata parameters are introduced by this specification:

* `authorization_signed_response_alg` JWS [RFC7515] `alg` algorithm JWA [RFC7518] REQUIRED for signing authorization responses. If this is specified, the response will be signed using JWS and the configured algorithm. If unspecified, the default algorithm to use for signing authorization responses is `RS256`. The algorithm `none` is not allowed.
* `authorization_encrypted_response_alg` JWE [RFC7516] `alg` algorithm JWA [RFC7518] REQUIRED for encrypting authorization responses.  If both signing and encryption are requested, the response will be signed then encrypted, with the result being a Nested JWT, as defined in JWT [RFC7519].  The default, if omitted, is that no encryption is performed.
* `authorization_encrypted_response_enc` JWE [RFC7516] `enc` algorithm JWA [RFC7518] REQUIRED for encrypting authorization responses.  If `authorization_encrypted_response_alg` is specified, the default for this value is A128CBC-HS256.  When `authorization_encrypted_response_enc` is included, `authorization_encrypted_response_alg` MUST also be provided.

Clients may register their public encryption keys using the `jwks_uri` or `jwks` metadata parameters.

## 6. Authorization Server Metadata

Authorization servers SHOULD publish the supported algorithms for signing and encrypting the JWT of an authorization response by utilizing OAuth 2.0 Authorization Server Metadata [RFC8414] parameters.

The following parameters are introduced by this specification:

* `authorization_signing_alg_values_supported` OPTIONAL.  JSON array containing a list of the JWS [RFC7515] signing algorithms (`alg` values) JWA [RFC7518] supported by the authorization endpoint to sign the response.
* `authorization_encryption_alg_values_supported`  OPTIONAL.  JSON array containing a list of the JWE [RFC7516] encryption algorithms (`alg` values) JWA [RFC7518] supported by the authorization endpoint to encrypt the response.
* `authorization_encryption_enc_values_supported`  OPTIONAL.  JSON array containing a list of the JWE [RFC7516] encryption algorithms (`enc` values) JWA [RFC7518] supported by the authorization endpoint to encrypt the response.

Authorization servers SHOULD publish the supported response mode values utilizing the parameter `response_modes_supported` as defined in [RFC8414]. This draft introduces the following possible values:

*  `query.jwt`
*  `fragment.jwt`
*  `form_post.jwt`
*  `jwt`

## 7. Security considerations

### 7.1 DoS using specially crafted JWTs
JWTs could be crafted to have an issuer that resolves to a JWK set URL with
huge content, or is delivered very slowly, consuming server networking
bandwidth and compute capacity. The resolved JWK set URL could also be used to
DDoS targets on the web.

The client therefore MUST first check that the issuer of the JWT is well-known 
and expected for the particular authorization response before it uses this data 
to obtain the key needed to check the JWT's signature.  

### 7.2 Code Replay
An authorization code (obtained on a different device with the same client) could be 
injected into an authorization response in order to impersonate the legitimate resource 
owner (see [draft-ietf-oauth-security-topics]). 

The JWT secured response mode enables clients to detect such an attack. The signature binds 
the authorization code to the state value sent by the client and therewith transitively to 
the transaction in the respective user agent.

### 7.3 Mix-Up
Mix-up is an attack on scenarios where an OAuth client interacts with
multiple authorization servers. The goal of the attack is to obtain an
authorization code or an access token by tricking the client into
sending those credentials to the attacker instead of using them at
the respective endpoint at the authorization/resource server.
   
The JWT secured response mode enables clients to detect this attack by providing an identification of the sender (`iss`) and the intended audience of the authorization response (`aud`). 

### 7.5 Code Leakage
Authorization servers MAY encrypt the authorization response therewith providing a means to prevent leakage of authorization codes in the user agent (e.g. during transmission, in browser history or via referrer headers). 

## 8. Privacy considerations
TBD

## 9. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (YES), Editor
* Brian Campbell (Ping Identity), Co-editor
* Nat Sakimura (Nomura Research Institute) -- Chair
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Joseph Heenan (Authlete)
* Ralph Bragg (Raidiam)
* Vladimir Dzhuvinov (Connect2ID)
* Michael Schwartz (Gluu)
* Filip Skokan

## 10. IANA Considerations
### 10.1 OAuth Dynamic Client Registration Metadata Registration
This specification requests registration of the following client metadata definitions in the IANA "OAuth Dynamic Client Registration Metadata" registry established by [RFC7591]:

#### 10.1.1. Registry Contents

* Client Metadata Name: `authorization_signed_response_alg`
* Client Metadata Description: String value indicating the client's desired introspection response signing algorithm.
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]
* Client Metadata Name: `authorization_encrypted_response_alg`
* Client Metadata Description: String value specifying the desired introspection response encryption algorithm (alg value).
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]
* Client Metadata Name: `authorization_encrypted_response_enc`
* Client Metadata Description: String value specifying the desired introspection response encryption algorithm (enc value).
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]

### 10.2 OAuth Authorization Server Metadata Registration
This specification requests registration of the following value in the IANA "OAuth Authorization Server Metadata" registry established by [RFC8414].

#### 10.2.1. Registry Contents

* Metadata Name: `authorization_signing_alg_values_supported`
* Metadata Description: JSON array containing a list of algorithms supported by the authorization server for introspection response signing.
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]
* Metadata Name: `authorization_encryption_alg_values_supported`
* Metadata Description: JSON array containing a list of algorithms supported by the authorization server for introspection response encryption (alg value).
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]
* Metadata Name: `authorization_encryption_enc_values_supported`
* Metadata Description: JSON array containing a list of algorithms supported by the authorization server for introspection response encryption (enc value).
* Change Controller: IESG
* Specification Document(s): Section 5 of [[ this specification ]]
