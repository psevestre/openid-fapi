#Financial Services – Financial API - Part 2: Read and Write API Security Profile

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice
The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.



##Foreword

OIDF (OpenID Foundation) is an international standardizing body comprised of over 160 participating entities (work group participants). The work of preparing international standards is carried out through OIDF work groups according to OpenID Process. Each participant interested in a subject for which a work group has been established has the right to be represented on that work group. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

OpenID Foundation standards are drafted in accordance with the rules given in the OpenID Process.

The main task of the work group is to prepare Implementers Draft and Final Draft. Final Draft adopted by the Work Group through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote.

Attention is drawn to the possibility that some of the elements of this document may be the subject of patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial API - Part 2: Read and Write API Security Profile was prepared by OpenID Foundation Financial API Work Group.

Financial API consists of the following parts, under the general title Financial Services — Financial API:

* Part 1: Read Only API Security Profile
* Part 2: Read and Write API Security Profile
* Part 3: Open Data API
* Part 4: Protected Data API and Schema - Read only
* Part 5: Protected Data API and Schema - Read and Write

This part is intended to be used with [RFC6749], [RFC6750], [RFC6736], and [OIDC].

##Introduction

In many cases, Fintech services such as aggregation services use screen scraping and stores user passwords. This model is both brittle and insecure. To cope with the brittleness, it should utilize an API model with structured data and to cope with insecurity, it should utilize a token model such as OAuth [RFC6749, RFC6750].

Financial API aims to rectify the situation by developing a REST/JSON model protected by OAuth. However, just asking to use OAuth is too vague as there are many implementation choices. OAuth is a framework which can cover a wide range of use-cases thus some implementation choices are easy to implement but less secure and some implementation choices are harder to implement but more secure. Financial services on the internet is a use-case that requires more secure implementation choices. That is, OAuth needs to be profiled to be used in the financial use-cases.

This document is a Part 2 of a set of document that specifies Financial API. It provides a profile of OAuth that is suitable to be used in the write access to the financial data also known as the transactional access. To achieve it, this part of the document specifies the control against such attacks like authorization request tampering, the authorization response tampering including code injection and the state injection, token request phishing, etc. More details are available in the security consideration section.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial Services – Financial API - Part 2: Read and Write API Security Profile **

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

[ISODIR2] - ISO/IEC Directives Part 2
[ISODIR2]: http://www.iso.org/sites/directives/2016/part2/index.xhtml

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

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

BCP NAPPS - [OAuth 2.0 for Native Apps](https://tools.ietf.org/html/draft-ietf-oauth-native-apps-03)

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[OIDM] -  OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[X.1254] - Entity authentication assurance framework
[X.1254]: https://www.itu.int/rec/T-REC-X.1254

[OAUTB] - OAuth 2.0 Token Binding
[OAUTB]: https://tools.ietf.org/html/draft-ietf-oauth-token-binding-01

[MTLS] - Mutual TLS Profiles for OAuth Clients
[MTLS]: https://tools.ietf.org/html/draft-campbell-oauth-mtls-01


## 3. Terms and definitions
For the purpose of this standard, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.


## 4. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial API

**FI** – Financial Institution

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 5. Read and Write API Security Profile

### 5.1 Introduction

The OIDF Financial API (FAPI) is a REST API that provides JSON data representing accounts and transactions related data. These APIs are protected by the OAuth 2.0 Authorization Framework that consists of [RFC6749], [RFC6750], [RFC7636], and other specifications.

These API accesses have several levels of risks associated with them. Read and write access has a higher financial risk than read-only access. As such, the characteristics required of the tokens are also different. Investigations of OAuth threats have revealed that OAuth clients are susceptible to malicious endpoints and IdP mix-up attacks. Malicious endpoints attack utilizes a mix a honest and rogue endpoints in the discovery metadata to trick the client into passing an authorization code and client credentials to a rogue endpoint. IdP mix-up attacks involve a rogue IdP that returns the same `client_id` as a honest IdP. This specification defines security measures to mitigate these attacks so that the client have confidence in the corresponding authorization server.

In Part 2, security provisions for the server and client that is appropriate for read and write access to the APIs are described.
For this purpose, the following new parameter is defined.

** s_hash **

State hash value. Its value is the base64url encoding of the
left-most half of the hash of the octets of the ASCII representation
of the state value, where the hash algorithm used is the hash algorithm used
in the `alg` Header Parameter of the ID Token's JOSE Header. For instance,
if the alg is HS512, hash the code value with SHA-512, then take the left-most 256 bits and base64url encode them.
The `s_hash` value is a case sensitive string.


### 5.2 Read and Write API Security Provisions

#### 5.2.1 Introduction

Read and Write Access carries high financial risk, so the protection level is higher than Read-Only Access.

As a profile of The OAuth 2.0 Authorization Framework, this document mandates the following to the Read and Write API of the FAPI.

#### 5.2.2 Authorization Server

The Authorization Server shall support the provisions specified in clause 5.2.2 of Financial API - Part 1: Read Only API Security Profile.

In addition, the Authorization server, for the write operation,

1. shall require the `request` or `request_uri` parameter to be passed as a JWS signed JWT as in clause 6 of [OIDC];
1. shall require the `response_type` values `code id_token` or `code id_token token`;
1. shall return ID Token as a detached signature to the authorization response;
1. shall include state hash, `s_hash`, in the ID Token to protect the `state` value;
1. shall only issue holder of key authorization code, access token, and refresh token for write operations;
1. shall support [OAUTB] or [MTLS] as a holder of key mechanism;
1. shall support user authentication at LoA 3 or greater as defined in [X.1254];
1. shall support signed and encrypted ID Tokens

Editors' note: The following was in the pervious edition but was removed as we now require hybrid flow.

    * shall verify that the pre-registered value for the following names are included in the request object;
        * `resources`: array of resources identifiers that the token will be used against;
     * `authz_ep`: the URI to which the authorization request was intended to be sent;
     * `token_ep`: the URI to which the authorization code will be sent to if 'code' or 'hybrid' flow was used;

#### 5.2.3 Public Client

A Public Client shall support the provisions specified in clause 5.2.3 of Financial API - Part 1: Read Only API Security Profile.

In addition, the Public Client

1. shall support [OAUTB];
1. shall include the `request` or `request_uri` parameter as defined in Section 6 of [OIDC] in the authentication request;
1. shall request user authentication at LoA 3 or greater by requesting the `acr` claim as an essential claim as defined in section 5.5.1.1 of [OIDC];
1. shall require JWS signed ID Token be returned from endpoints;
1. shall verify that the `acr` claim in an ID Token indicates that user authentication was performed at LoA3 or greater;
1. shall verify that the `amr` claim in an ID Token contains values appropriate for the LoA indicated by the `acr` claim;
1. shall verify that the authorization response was not tampered using ID Token as the detached signature

for write operations.

To verify that the authorization response was not tampered using ID Token as the detached signature, the client shall verify that `s_hash` value
is equal to the value calculated from the `state` value in the authorization response in addition to
all the requirements in 3.3.2.12 of [OIDC].

Editors' note: The following was in the previous edition but was removed as we now require hybrid flow.

    The `request` object shall include the pre-registered values for the following parameters:
    * `resources`: array of resources identifiers that the token will be used against;
 * `authz_ep`: the URI to which the authorization request was intended to be sent;
 * `token_ep`: the URI to which the authorization code will be sent to, if 'code' or 'hybrid' flow was used;

#### 5.2.4 Confidential Client

In addition to the provision to the Public Client and the provisions of clause 5.2.3, the Confidential Client

1. shall support [OAUTB] or [MTLS];
1. shall require both JWS signed and JWE encrypted ID Tokens to be returned from endpoints

for write operations.


## 6. Accessing Protected Resources (Using tokens)

### 6.1 Introduction

The FAPI endpoints are OAuth 2.0 protected resource endpoints that return various financial information for the resource owner associated with the submitted access token.

### 6.2 Read and write access provisions

#### 6.2.1 Protected resources provisions

The protected resources supporting this document

1. shall support the provisions specified in clause 6.2.1 Financial API - Part 1: Read Only API Security Profile;
1. SHALL adhere to the requirements in [MTLS].

### 6.2.2 Client provisions

The client supporting this document shall support the provisions specified in clause 6.2.2 of Financial API - Part 1: Read Only API Security Profile.

## 7. Request object endpoint

### 7.1 Request

Request object endpoint is a REST API at the authorization server
that accepts a signed request object as HTTPS POST payload.

Following is an example of such request.

```
POST https://as.example.com/ros/
Host: as.example.com
Content-Type: application/jws
Content-Length: 1288
eyJhbGciOiJSUzI1NiIsImtpZCI6ImsyYmRjIn0.ew0KICJpc3MiOiA
(... abbreviated for brevity ...)
zCYIb_NMXvtTIVc1jpspnTSD7xMbpL-2QgwUsAlMGzw
```

### 7.2 Successful response

The authorization server shall verify that the request object
is valid and the signature is correct. If it is fine, the server shall return
the JSON that contains `request_uri`, `aud`, `iss`, and `exp`
claims at the top level with `201 Created` HTTP response code.

The value of these claims shall be as follows:

* `request_uri` : The request uri corresponding to the request object posted. Note that it can be either URL or URN. It shall be based on a cryptographic random so that it is difficult to predict for the attacker.
* `aud` : A JSON string that represents the client identifier of the client that posted the request object.
* `iss` : A JSON string that represents the issuer identifier of the authorization server as defined in [RFC7519]. When a pure OAuth is used, the value is the redirection URI. When OpenID Connect is used, the value is the issuer value of the authorization server.
* `exp` : A JSON number that represents the expiry time of the request URI as defined in [RFC7519].

Following is an example of such a response.

```
HTTP/1.1 201 Created
Date: Tue, 2 May 2017 15:22:31 GMT
Content-Type: application/json
{
    'iss':'https://as.example.com/',
 'aud':'s6BhdRkqt3',
 'request_uri':'urn:example:MTAyODAK',
 'exp':1493738581
}
```

### 7.3 Error responses

#### 7.3.1 Authorization required
If the signature validation fails, the authorization server
shall return `401 Unauthorized` HTTP error response.

#### 7.3.2 Invalid request
If the request object received is invalid, the authorization server
shall return `400 Bad Request` HTTP error response.

#### 7.3.3 Method Not Allowed
If the request did not use POST, the authorization server shall return `405 Method Not Allowed` HTTP error response.

#### 7.3.4 Request entity too large
If the request size was beyond the upper bound that the authorization server allows, the authorization server shall return `413 Request Entity Too Large` HTTP error response.

#### 7.3.5 Too many requests
If the request from the client per a time period goes beyond the number the authorization server allows, the authorization server shall return `429 Too Many Requests` HTTP error response.



## 8. Security Considerations

### 8.1 Introduction
As a profile of The OAuth 2.0 Authorization Framework, this specification references the security considerations defined in section 10 of [RFC6749], as well as [RFC6819] - OAuth 2.0 Threat Model and Security Considerations, which details various threats and mitigations.

### 8.2 Mitigations for threats in RFC6819

#### 8.2.1 Authorization code phishing resistance
When the FAPI client uses [MTLS] or [TOKB], since the authorization code is bound to the TLS channel, it is authorization code phishing resistant as the phished authorization code cannot be used.

#### 8.2.2 Access token phishing
When the FAPI client uses [MTLS] or [TOKB], the access token is bound to the TLS channel, it is access token phishing resistant as the phished access tokens cannot be used.

#### 8.2.3 Client credential and code phishing at token endpoint
When the FAPI client uses [MTLS] or [TOKB], the authorization code is bound to the TLS channel, any phished client credentials and authorization codes submitted to the token endpoint cannot be used since the authorization code is bound to a particular TLS channel.


### 8.3 Uncertainty around the resource server's handling of the access token
There is no way that the client can find out whether the resource access was granted for the Bearer token or holder of key token.
The two differs in the risk profile and the client may want to differentiate them.
To support it, the resource shall not accept a Bearer token if it is supporting MTLS token with Bearer authorization header.

### 8.4 Request object endpoint phishing resistance
An attacker can social engineer and have the administrator of the client to set the request object endpoint to one of the URL under the attacker's control. In this case, sensitive information included in the request object will be revealed to the attacker. To prevent this, the authorization server should communicate to the client developer of the proper change process repeatedly so that the client developers are going to be less susceptible to such a social engineering.

### 8.5 IdP Mix-up attack
In this attack, the client has registered multiple IdPs and one of them is a rogue IdP that returns the same `client_id` that belongs to one of the honest IdPs. When a user clicks on a malicious link or visits a compromised site, an authorization request is sent to the rogue Idp. The rogue Idp then redirects the client to the honest IdP that has the same `client_id`. If the user is already logged on at the honest IdP, then the authentication may be skipped and a code is generated and returned to the client. Since the client was interacting with the rogue IdP, the code is sent to the rogue IdP's token endpoint. At the point, the attacker has a valid code that can be exchanged for an Access Token at the honest IdP.
By registering a unique `redirect_uri`, storing it before each session, and then comparing the current callback `redirect_uri` to that stored in the session, the client can mitigate this attack. At the same time, the honest IdP will be able to detect that the `redirect_uri` in the authorization request does not match any of the registered ones and return an error.
The use of a `request` object or `request_uri` in the authorization request will prevent tampering with the request parameters and the use of a hybrid flow will bind the current session's `state` parameter to ID Token via the ID Token's `s_hash` claim.

### 8.6 Malicious endpoints attack
This attack lures the user to login to a rogue IdP at the client. The client performs discovery for the rogue IdP and receives discovery information that contains an honest IdP's registration and authorization endpoint and the rogue IdP's own token and userinfo endpoints. The client performs registration and then authentication at the honest IdP. After receiving a code, it sends it to the rogue IdP's token endpoint along with the honest IdP's token endpoint authentication credentials(`client_id`/`client_secret`). The attacker now has the code and credentials to exchange for an Access Token.

### 8.7 Response parameter injection attack
This attack occurs when the victim and attacker use the same relying party client. The attacker is somehow able to
capture the authorization code and state from the victim's authorization response code and uses them in his own
authorization response. This can be mitigated by using hybrid flow where the `c_hash`, `at_hash`,
and `s_hash` can be used to verify the validity of the authorization code, access token,
and state parameters and verifying that the state is the same as what was stored for the current session.



## 9. Privacy Considerations

* If the client is to be used by a single user, the client certificate will provide the means for the websites
  that belongs to different administrative domains to collude and correlate the user's access.
  For this reason, public clients that reside on a user's terminal should avoid [MTLS] and use [TOKB] instead.


## 10. Acknowledgement

Following people contributed heavily towards this document.

* Nat Sakimura (Nomura Research Institute) -- Chair, Editor
* Anoop Saxana (Intuit) -- Co-chair, FS-ISAC Liaison
* Anthony Nadalin (Microsoft) -- Co-chair
* Edmund Jay (Illumila) -- Co-editor
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* Joseph Heenan (Authlete)
* Sascha H. Preibisch (CA)
* John Bradley (Ping Identity)
* Henrik Bearing (Peercraft)
(add yourself)

## 11. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC
