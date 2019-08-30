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

Due to the use of TLS and the aibility to directly authenticate the client over the TLS connection, this mechanism can support both signed and unsigned JWTs.  

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial-grade API: Pushed Request Object**

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

[RFC7591] - OAuth 2.0 Dynamic Client Registration Protocol
[RFC7591]: https://tools.ietf.org/html/rfc7591

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[draft-ietf-oauth-security-topics] - OAuth 2.0 Security Best Current Practice
[draft-ietf-oauth-security-topics]: https://tools.ietf.org/html/draft-ietf-oauth-security-topics

[IANA.OAuth.Parameters] - OAuth Parameters Registry
[IANA.OAuth.Parameters]: https://www.iana.org/assignments/oauth-parameters

[JAR] - The OAuth 2.0 Authorization Framework: JWT Secured Authorization Request (JAR)
[JAR]: https://tools.ietf.org/html/draft-ietf-oauth-jwsreq

[RFC7231] - Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content
[RFC7231]:https://tools.ietf.org/html/rfc7231

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

This draft allows the client to send the request object via a direct POST request to the AS rather than as a redirect URI query parameter. 

## 5. Request Object Endpoint
This section describes the process of request object creation and its use in the authorization request.

### 5.1 Request Object Request

The request object endpoint shall be a RESTful API at the authorization server that accepts `x-www-form-urlencoded` POST. 

The rules for client authentication as defined in [RFC6749] for token endpoint requests 
apply for the request object endpoint as well. 

Confidential clients are required to authenticate towards the request object endpoint using the authentication method registered for their `client_id`. If applicable, the `token_endpoint_auth_method` client metadata parameter indicates the registered authentication method for the client to use when making direct requests to the authorization server, including requests to the token endpoint and the request object endpoint (and others). Applicable token endpoint authentication methods are registered in the IANA "OAuth Token Endpoint Authentication Methods" registry [IANA.OAuth.Parameters] defined by [RFC7591].

Note that there's some potential ambiguity around the appropriate audience 
value to use when JWT client assertion based authentication is employed. To address that ambiguity the issuer URL of the AS according to [RFC8414] MUST be used as the value of the audience. 

The request object is sent in the parameter `request` as defined in [JAR].

The rules for signing and encryption of the request object as defined in [JAR] apply.  

The following is an example of a request using a signed request object. The client is 
authenticated using its client secret `BASIC` authorization:

```
POST https://as.example.com/ros/ HTTP/1.1
Host: as.example.com
Content-Type: application/x-www-form-urlencoded
Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3

request=eyJraWQiOiJrMmJkYyIsImFsZyI6IlJTMjU2In0.eyJpc3MiOiJzNkJoZ
FJrcXQzIiwiYXVkIjoiaHR0cHM6Ly9zZXJ2ZXIuZXhhbXBsZS5jb20iLCJyZXNwb2
5zZV90eXBlIjoiY29kZSIsImNsaWVudF9pZCI6InM2QmhkUmtxdDMiLCJyZWRpcmV
jdF91cmkiOiJodHRwczovL2NsaWVudC5leGFtcGxlLm9yZy9jYiIsInNjb3BlIjoi
YWlzIiwic3RhdGUiOiJhZjBpZmpzbGRraiIsImNvZGVfY2hhbGxlbmdlIjoiSzItb
HRjODNhY2M0aDBjOXc2RVNDX3JFTVRKM2J3dy11Q0hhb2VLMXQ4VSIsImNvZGVfY2
hhbGxlbmdlX21ldGhvZCI6IlMyNTYifQ.O49ffUxRPdNkN3TRYDvbEYVr1CeAL64u
W4FenV3n9WlaFIRHeFblzv-wlEtMm8-tusGxeE9z3ek6FxkhvvLEqEpjthXnyXqqy
Jfq3k9GSf5ay74ml_0D6lHE1hy-kVWg7SgoPQ-GB1xQ9NRhF3EKS7UZIrUHbFUCF0
MsRLbmtIvaLYbQH_Ef3UkDLOGiU7exhVFTPeyQUTM9FF-u3K-zX-FO05_brYxNGLh
VkO1G8MjqQnn2HpAzlBd5179WTzTYhKmhTiwzH-qlBBI_9GLJmE3KOipko9TfSpa2
6H4JOlMyfZFl0PCJwkByS0xZFJ2sTo3Gkk488RQohhgt1I0onw
```

Since the communication is HTTPS-protected, clients may decide to send an 
unsigned JWT (using the JWS algorithm `none`) as the request object. This 
generally simplifies use of the request object pattern in cases where 
the additional security properties of the application level signature are 
not needed. It also allows public clients to protect the authorization request 
from modifications without the need to establish a secret with the AS.

The following is an example of a public client sending a unsigned request object to the AS:

```
POST https://as.example.com/ros/ HTTP/1.1
Host: as.example.com
Content-Type: application/x-www-form-urlencoded

request=eyJhbGciOiJub25lIn0.eyJpc3MiOiJzNkJoZFJrcXQzIiwiYXVkIjoi
aHR0cHM6Ly9zZXJ2ZXIuZXhhbXBsZS5jb20iLCJyZXNwb25zZV90eXBlIjoiY29k
ZSIsImNsaWVudF9pZCI6InM2QmhkUmtxdDMiLCJyZWRpcmVjdF91cmkiOiJodHRw
czovL2NsaWVudC5leGFtcGxlLm9yZy9jYiIsInNjb3BlIjoiYWlzIiwic3RhdGUi
OiJhZjBpZmpzbGRraiIsImNvZGVfY2hhbGxlbmdlIjoiSzItbHRjODNhY2M0aDBj
OXc2RVNDX3JFTVRKM2J3dy11Q0hhb2VLMXQ4VSIsImNvZGVfY2hhbGxlbmdlX21l
dGhvZCI6IlMyNTYifQ.
```

### 5.2 Sucessful Response

The AS MUST process the request as follows:

1. If the client is a confidential client, the AS first authenticates the client.  
1. If applicable, the AS decrypts the request object (if applicable) as specified in [JAR], section 6.1.
1. If applicable, the AS validates the request object signature as specified in [JAR], section 6.2.
1. In the next step, the authorization server verifies whether the parameters sent are 
valid as specified in [JAR], section 6.3. For example, the authorization server checks, whether the redirect URI matches one of the redirect URIs configured for the server. It may also check whether the client is authorized for the scope for which it requested access. This validation allows the authorization server to refuse unauthorized or fraudulent requests early.  
1. If the verification is successful, the server shall generate a request URI and
return a JSON payload that contains `request_uri`, `aud`, `iss`, and `exp`
claims at the top level with `201 Created` HTTP response code.
1. The `request_uri` value shall be generated using a cryptographically strong pseudorandom algorithm such that it is computationally infeasible to predict or guess a valid value.   (BC QUESTION: should there some more guidance provided on or requirements around the structer of the URI value? For example it could use the RFC6755 subnamespace and registry and be of the form `urn:ietf:params:oauth:request_uri:<<random-part>>`, which gives a clear indication of what it is and would keep people from inventing their own URIs.)
1. The request URI shall be bound to the client identifier of the client that posted the request object.
1. Since the request URI can be replayed, its lifetime should be short and preferably limited to one-time use.
1. The value of these claims in the JSON payload shall be as follows:
    * `request_uri` : The request URI corresponding to the request object posted. 
    * `aud` : A JSON string that represents the client identifier of the client that posted the request object.
    * `iss` : A JSON string that represents the issuer identifier of the authorization server as defined in [RFC7519]. The value MUST be the issuer URL of the AS as defined in [8414].
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

(BC QUESTION/RESPONSE: I suspect Nat will say there's value in explicitly identifying the participants in any exchange. But I'm not so sure myself (they are already identified by HTTPS and client authentication/identification) and worry a little that `iss` and `aud` will only confuse in this context (case in point the definition of `iss` above is rather confusing referring to JWT [RFC7519] for the definition of an authorization server issuer rather than [RFC8414] but also mentioning 'the redirection URI' as the issuer for the AS). I also don't see what value `exp` adds here - is it anything more than a hint to the client about how long the request_uri will be valid? I don't see the use in that. And using something like `expires_in` similar to RFC6749 with a relative value of how long the URI is valid would be more appropriate for that anyway, if it were needed.)  

### 5.3 Error responses

#### 5.3.1 Authentication required
If the signature validation or client authentication fails, the authorization server shall return `401 Unauthorized` HTTP error response.

#### 5.3.2 Authorization required
If the client is not authorized to perform the authorization request it wanted to post, the authorization server shall return `403 Forbidden` HTTP error response.

#### 5.3.3 Invalid request
If the request object received is invalid, the authorization server shall return `400 Bad Request` HTTP error response.

#### 5.3.4 Method not allowed
If the request did not use POST, the authorization server shall return `405 Method Not Allowed` HTTP error response.

#### 5.3.5 Payload Too Large
If the request size was beyond the upper bound that the authorization server allows, the authorization server shall return a `413 Payload Too Large` HTTP error response as defined in [RFC7231].

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

### 7.1. Request URI Guessing
An attacker could attempt to guess and replay a valid request URI value and 
try to impersonat the respective client. The AS MUST consider the considerations
given in [JAR], section 10.2, clause d on request URI entropy.

### 7.2 Request Object Replay
An attacker could replay a request URI captured from a legit authorization request.
In order to cope with such attacks, the AS SHOULD make the request URIs one-time use.

### 7.3 Client Policy Change
The client policy might change between the lodging of the request object and the 
authorization request using a particular request object. It is therefore recommended 
that the AS checks the request parameter against the client policy when processing 
the authorization request.

## 8. Privacy considerations
TBD

## 9. Acknowledgement

The following people contributed to this document:

* Torsten Lodderstedt (yes.com), Editor
* Brian Campbell (Ping Identity), Co-editor
* Nat Sakimura (Nomura Research Institute) -- Chair
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Vladimir Dzhuvinov (Connect2ID)
* Takahiko Kawasaki (Authlete, Inc.)
* Joseph Heenan (Authlete) 
* Filip Skokan

## 10. IANA Considerations

### 10.1 OAuth Authorization Server Metadata Registration

This specification requests registration of the following value in the IANA "OAuth Authorization Server Metadata" registry of [IANA.OAuth.Parameters] established by [RFC8414]. 

* Metadata Name: request_object_endpoint
* Metadata Description: Request Object Endpoint
* Change Controller: OpenID Foundation FAPI Working Group - openid-specs-fapi@lists.openid.net
* Specification Document(s): Section 5 of this document
