# Financial-grade API: Pushed Request Object

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

The Financial-grade API aims to provide specific implementation guidelines for online financial services to adopt by developing a REST/JSON data model protected by a highly secured OAuth profile.
 
This document defines a new mode for handling request objects called "pushed request objects" that allows the client to create the request object at the authorization server. This relieves the client from the burden to maintain request objects and facilitates the stability of the authorization process as the authorization server does not need to call back to the client in order to obtain the authorization request data. 

Due to the use of TLS and the aibility to directly authenticate the client over the TLS connection, this mechanism can support plain JSON request objects in addition to the "classical" JWTs.  

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

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[BCP195] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[BCP195]: https://tools.ietf.org/html/bcp195

[RFC8414] - OAuth 2.0 Authorization Server Metadata
[RFC8414]: https://tools.ietf.org/html/rfc8414

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[draft-ietf-oauth-security-topics] - OAuth 2.0 Security Best Current Practice
[draft-ietf-oauth-security-topics]: https://tools.ietf.org/html/draft-ietf-oauth-security-topics

[IANA.OAuth.Parameters] - OAuth Parameters Registry
[IANA.OAuth.Parameters]: https://www.iana.org/assignments/oauth-parameters

## 2. Terms and definitions
For the purpose of this document, the terms defined in [RFC6749], [RFC6750], [RFC7636], and [OIDC] apply.

## 3. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial-grade API

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 4. Introduction

OpenID Connect and OAuth already support the transfer of authorization request parameters in JSON format in two ways:

* the `request` parameter may carry the request data in a JWT
* the `request_uri` parameter carries a URI referring to a place where the AS may retrieve the request object. 

Both mechanisms contribute to the security of the request by allowing for the signing and encryption of the authorization request data.

The request URI additionally allows the client to just send the URI value in the authorization request as a pointer to the request object, rather than the full content of the request object itself, which allows for the transfer of larger amounts of request data without issues caused by URI length restrictions. 

However, the request URI mechanisms also has some downsides. The client needs to maintain and expose request objects. This might look easy on first sight, but the client needs to be able to handle inbound requests from the authorization server and, potentially, store a large number of objects in its database including the need to properly clean them up.

It also means the availability and latency of the authorization process at the authorization server depends on the availability and latency of the client’s backend.

Moreover, in order to dereference the `request_uri` parameter the authorization has to make outbound HTTP requests, which brings with it all the potential problems of server-side request forgery.

This specification addresses these problems by moving the responsibility for managing request objects from the client to the authorization server. The authorization server offers an additional "request object endpoint". The client calls this endpoint to deliver its request objects and is provided with a unique URI for that particular request object, which in turn is sent into to the AS's authorization endpoint as the value of the `request_uri` parameter.  

There are two modes:

1. The client posts the request object as a JWT, which is equivalent to the existing mechanisms and provides non-repudiation in addition to request integrity and authenticity.
2. The client posts the "raw" request object in JSON format. The request is authenticated using the client’s token endpoint authentication method. This new mode leverages the direct TLS-protected communication channel between client and authorization server in order to simplify the implementation while still providing request authenticity and integrity. 

The mode is determined by the client using the appropriate mime type, `application/jwt` or `application/json`, in the `Content-Type` header of the `POST` request.

## 5. Request Object Endpoint
This section describes the process of request object creation and its use in the authorization request.

### 5.1 Request Object Request

1. The request object endpoint shall be a RESTful API at the authorization server that accepts signed request object as JWTs or plain JSON-formatted request objects as the HTTPS `POST` payload. The client indicates the format using the mime types, `application/jwt` for request objects as JWTs or `application/json` in the case of JSON-formatted request objects. 
2. If the request object is signed, the signature serves as means for client authentication and as evidence of the client submitting the request object, which is referred to as 'non-repudiation'. If the request object is not signed, the client is expected to authenticate itself using its registered token endpoint authentication method.

The following is an example of a JWT-based request:

```
POST https://as.example.com/ros/ HTTP/1.1
Host: as.example.com
Content-Type: application/jwt
Content-Length: 1288

eyJhbGciOiJSUzI1NiIsImtpZCI6ImsyYmRjIn0.ew0KICJpc3MiOiA
(... abbreviated for brevity ...)
zCYIb_NMXvtTIVc1jpspnTSD7xMbpL-2QgwUsAlMGzw
```

The following is an example of a unsigned request object using BASIC authentication with client credentials:

```
POST https://as.example.com/ros/ HTTP/1.1
Host: as.example.com
Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
Content-Type: application/json
Content-Length: 1288

{  
   "response_type":"code",
   "client_id":"s6BhdRkqt3",
   "redirect_uri":"https://client.example.org/cb",
   "scope":"accounts",
   "state":"af0ifjsldkj",
   "code_challenge_method":"S256",
   "code_challenge":"5c305578f8f19b2dcdb6c3c955c0a...97e43917cd"
}
```
Note: I intentionally removed `aud` and `iss` from the request object since they don't seem to be necessary in this case.


### 5.2 Sucessful Response

1.  In case of a JWT, the authorization server shall verify that the request object is valid, the signature algorithm is not `none`, and the signature is correct as in clause 6.3 of [OIDC]. In case of the JSON request object, the authorization checks whether the client was successfully authenticated and the request object is valid. 
1. In the next step, the authorization server verifies whether the parameters sent are valid. For example, the authorization server checks, whether the redirect URI matches one of the redirect URIs configured for the server. It may also check whether the client is authorized for the scope for which it requested access. This validation allows the authorization server to refuse unauthorized or fraudulent requests early. 
1. If the verification is successful, the server shall generate a request URI and
return a JSON payload that contains `request_uri`, `aud`, `iss`, and `exp`
claims at the top level with `201 Created` HTTP response code.
1. The `request_uri` value shall be generated using a cryptographically strong pseudorandom algorithm such that it is computationally infeasible to predict or guess a valid value.   (BC QUESTION: should there some more guidance provided on or requirements around the structer of the URI value? For example it could use the RFC6755 subnamespace and registry and be of the form `urn:ietf:params:oauth:request_uri:<<random-part>>`, which gives a clear indication of what it is and would keep people from inventing their own URIs.)
1. The request URI shall be bound to the client identifier of the client that posted the request object.
1. Since the request URI can be replayed, its lifetime should be short and preferably limited to one-time use.
1. The value of these claims in the JSON payload shall be as follows:
    * `request_uri` : The request URI corresponding to the request object posted. 
    * `aud` : A JSON string that represents the client identifier of the client that posted the request object.
    * `iss` : A JSON string that represents the issuer identifier of the authorization server as defined in [RFC7519]. When a pure OAuth 2.0 is used, the value is the redirection URI. When OpenID Connect is used, the value is the issuer value of the authorization server.
    * `exp` : A JSON number that represents the expiry time of the request URI as defined in [RFC7519].

The following is an example of such a response:

```
HTTP/1.1 201 Created
Date: Tue, 2 May 2017 15:22:31 GMT
Content-Type: application/json

{
    "iss": "https://as.example.com/",
    "aud": "s6BhdRkqt3",
    "request_uri": "urn:example:MTAyODAK",
    "exp": 1493738581
}
```
Question: What is the value of returning `iss` and `aud`? Does the `exp` really add anything given the text encourages one-time use of the request object?

(BC QUESTION/RESPONSE: I suspect Nat will say there's value in explicitly identifying the participants in any exchange. But I'm not so sure myself (they are already identified by HTTPS and client authentication/identification) and worry a little that `iss` and `aud` will only confuse in this context (case in point the definition of `iss` above is rather confusing referring to JWT/RFC7519 for the definition of an authorization server issuer rather than RFC8414 but also mentioning 'the redirection URI' as the issuer for the AS). I also don't see what value `exp` adds here - is it anything more than a hint to the client about how long the request_uri will be valid? I don't see the use in that. And using something like `expires_in` similar to RFC6749 with a relative value of how long the URI is valid would be more appropriate for that anyway, if it were needed.)  

### 5.3 Error responses

#### 5.3.1 Authentication required
If the signature validation or client authentication fails, the authorization server shall return `401 Unauthorized` HTTP error response.

#### 5.3.2 Authorization required
If the client is not authorized to perform the authorization request it wanted to post, the authorization server shall return `403 Forbidden` HTTP error response.

#### 5.3.3 Invalid request
If the request object received is invalid, the authorization server shall return `400 Bad Request` HTTP error response.

#### 5.3.4 Method not allowed
If the request did not use POST, the authorization server shall return `405 Method Not Allowed` HTTP error response.

#### 5.3.5 Request entity too large
If the request size was beyond the upper bound that the authorization server allows, the authorization server shall return a `413 Request Entity Too Large` HTTP error response.

#### 5.3.6 Too many requests
If the request from the client per a time period goes beyond the number the authorization server allows, the authorization server shall return a `429 Too Many Requests` HTTP error response.

### 5.4 Authorization Request

The client uses the `request_uri` value as returned by the authorization server as authorization request parameter `request_uri`.

```
https://server.example.com/authorize?request_uri=urn:example:MTAyODAK
```
Note: we should encourage clients to use the request URI as the only parameter in order to use the integrity and authenticity provided by the pushed request object.

## 6. Authorization Server Metadata

If the authorization server has a request object endpoint, it shall include the following OAuth/OpenID Provider Metadata parameter in discovery responses:

1. `request_object_endpoint` : The url of the request object endpoint at which the client can exchange a request object for a request URI.

## 7. Security considerations
TBD


## 8. Privacy considerations
TBD

## 9. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (yes.com), Editor
* Brian Campbell (Ping Identity), Co-editor
* Nat Sakimura (Nomura Research Institute) -- Chair
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Vladimir Dzhuvinov (Connect2ID)

## 10. IANA Considerations

### 10.1 OAuth Authorization Server Metadata Registration

This specification requests registration of the following value in the IANA "OAuth Authorization Server Metadata" registry of [IANA.OAuth.Parameters] established by [RFC8414]. 

* Metadata Name: request_object_endpoint
* Metadata Description: Request Object Endpoint
* Change Controller: OpenID Foundation FAPI Working Group - openid-specs-fapi@lists.openid.net
* Specification Document(s): Section 5 of this document
