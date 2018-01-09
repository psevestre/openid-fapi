#Financial Services – Financial API: Client Initiated Backchannel Authentication Profile

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice

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

This part is intended to be used with [RFC6749], [RFC6750], [RFC7636], [OIDC] and [CIBA].

##Introduction

The Financial API Standard provides a profile for OAuth 2.0 suitable for use in financial services. The standard OAuth method for the client to send the resource owner to the authorization server is to use an HTTP redirect. Parts 1 and 2 of this specification support this interaction model and are suitable for use cases where the resource owner is interacting with the client on a device they control that has a web browser. There are however many use-cases for initiating payments where the resource owner is not interacting with the client in such a manner. For example, the resource owner may want to authorize a payment at a "point of sale" terminal at a shop or fuel station.

This document is a profile of the MODRNA Client initiated Backchannel Authentication Flow [CIBA] that supports this decoupled interaction method. The CIBA spec allows a client that has knowledge of the user's identifier to obtain tokens from the authorization server. The user consent is given at the user's Authentication Device mediated by the authorization server. This document profiles the CIBA spec to bring it in line with the rest of the FAPI spec and provide security recommendations for its use in a financial services setting.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

#**Financial Services – Financial API: Client Initiated Backchannel Authentication Profile **

[TOC]

## 1. Scope

This part of the document specifies the method of

* applications to obtain the OAuth tokens via a backchannel authentication flow in an appropriately secure manner for financial data access;
* using the tokens to interact with the REST endpoints that provides financial data;

This document is applicable to higher risk use cases which includes commercial and investment banking.

## 2. Normative references

The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[ISODIR2] - ISO/IEC Directives Part 2
[ISODIR2]: http://www.iso.org/sites/directives/2016/part2/index.xhtml

[RFC7230] - Hypertext Transfer Protocol -- HTTP/1.1
[RFC7230]: https://tools.ietf.org/html/rfc7230

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC5246] - The Transport Layer Security (TLS) Protocol Version 1.2
[RFC5246]: https://tools.ietf.org/html/rfc5246

[RFC6125] - Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)
[RFC6125]: https://tools.ietf.org/html/rfc6125

[RFC6819] - OAuth 2.0 Threat Model and Security Considerations
[RFC6819]: https://tools.ietf.org/html/rfc6819

[RFC7519] - JSON Web Token (JWT)
[RFC7519]:https://tools.ietf.org/html/rfc7519

[BCP195] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[BCP195]: https://tools.ietf.org/html/bcp195

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDM] - OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[X.1254] - Entity authentication assurance framework
[X.1254]: https://www.itu.int/rec/T-REC-X.1254

[OAUTB] - OAuth 2.0 Token Binding
[OAUTB]: https://tools.ietf.org/html/draft-ietf-oauth-token-binding-01

[MTLS] - Mutual TLS Profiles for OAuth Clients
[MTLS]: https://tools.ietf.org/html/draft-ietf-oauth-mtls-00

[CIBA] - MODRNA Client initiated Backchannel Authentication Flow 1.0
[CIBA]: http://openid.net/specs/openid-connect-modrna-client-initiated-backchannel-authentication-1_0.html

## 3. Terms and definitions

For the purpose of this standard, the terms defined in RFC6749, RFC6750, RFC7636, OpenID Connect Core and OpenID Connect MODRNA Client initiated Backchannel Authentication Flow apply.

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

The OIDF Financial API (FAPI) is a REST API that provides JSON data representing
accounts and transactional data. These APIs are protected by the
OAuth 2.0 Authorization Framework that consists of [RFC6749], [RFC6750],
[RFC7636], and other specifications.

The Client Initiated Backchannel Authentication Flow [CIBA] specifies an alternate method of users granting access to their resources whereby the flow is started from a consumption device, but authorized on an authentication device.

The following sections specify a profile of CIBA that is suited for financial APIs.

### 5.2 Read and Write API Security Provisions

#### 5.2.1 Introduction

As it is anticipated the this specification will primary be used for write operations there is no separate read-only profile.

This spec should be ready in conjunction with OpenID Connect MODRNA Client initiated Backchannel Authentication Flow 1.0 and with parts 1 and 2 of the Financial API specification.

#### 5.2.2 Authorization Server

The Authorization Server shall support the provisions specified in clause 5.2.2 of Financial API - Part 1 and clause 5.2.2 of Financial API - Part 2.

In addition the Authorization server, for all operations,

1. shall only support confidential clients for client initiated backchannel authentication flows;
1. shall authenticate the confidential client at the backchannel authentication endpoint using a Signed Request Object
1. shall require the request object to contain a `jti` claim and shall use the `jti` claim to prevent replay attacks;
1. shall ensure that the `auth_req_id` is based on a cryptographic random value so that it is difficult to predict for an attacker;
1. when interacting with a client in polling mode shall ensure that a successful token polling response can only be sent once for a given `auth_req_id`;
1. shall require a binding_message in the authentication request;
1. shall only issue access tokens and refresh tokens that are holder of key bound;
1. shall support [OAUTB] or [MTLS] as a holder of key mechanism;
1. when sending a successful token notification shall include the access token hash, `at_hash`, in the ID Token;
1. when sending a successful token notification, with a refresh token, shall include the refresh token hash, `rt_hash`, in the ID Token;
1. when sending a successful token notification shall include the `auth_req_id`, in the ID Token;

The following is a non-normative example of a base64url decoded ID Token sent to the client notification endpoint:

```
 {
   "iss": "http://server.example.com",
   "sub": "248289761001",
   "aud": "s6BhdRkqt3",
   "nonce": "n-0S6_WzA2Mj",
   "exp": 1311281970,
   "iat": 1311280970,
   "at_hash": "rXH7QWVTZnXYCou_6Vdpfg",
   "rt_hash": "njCczNMR6mTQQTPa93YPcQ",
   "auth_req_id": "1c266114-a1be-4252-8ad1-04986c5b9ac1"
  }
```

**NOTE**: When the authorization server receives an authentication request from a client that is configured in notification mode, the authorization server must associate the attributes required to issue holder of key bound tokens with the `auth_req_id`. When issuing [MTLS] sender constrained tokens this will be the certificate hash or some other representation of the client certificate used at the backchannel authentication endpoint. When issuing [OAUTB] bound tokens this will be the Token Binding ID provided at the backchannel authentication endpoint.

**NOTE:** The binding message is required to protect the user by binding the session on the consumption device with the session on the authentication device. An example use case is when a user is paying at POS terminal. The user will enter their user identifier to start the [CIBA] flow, the terminal will then display a code, the user will receive a notification on their phone (the authentication device) to ask them to authenticate and authorise the transaction, as part of the authorisation process the user will be shown a code and will be asked to check that it is the same as the one shown on the terminal.

**NOTE:** When the client is configured in polling mode, it will be interacting with the token endpoint in order to retrieve access tokens. The same security requirements for this endpoint detailed in Parts 1 and 2 of the Financial API apply.

#### 5.2.3 Confidential Client

A Confidential Client shall support the provisions specified in clause 5.2.4 of Financial API - Part 1 and clause 5.2.4 of Financial API - Part 2.

In addition, the Confidential Client

1. shall authenticate against the Backchannel Authentication Endpoint using a Signed Request Object;

**NOTE**: Where [MTLS] is used to provide proof of possession semantics for tokens, the signed request object used to authenticate the confidential client shall be sent over a mutual TLS connection. This is not for the purpose of authenticating the client, but for the purpose of giving the AS the attributes it needs to issue sender-constrained tokens.

1. shall ensure that the `client_notification_token` is based on a cryptographic random value so that it is difficult to predict for an attacker;
1. shall include a binding message in the authentication request;

When the confidential client is in notification mode:

1. it shall associate the `client_notification_token` sent in the authentication request with the `auth_req_id` received in the successful authentication request acknowledgement;
1. it shall verify that the `client_notification_token` received in a successful token notification is valid;
1. it shall verify that the `auth_req_id` received in a successful token notification matches the `client_notification_token` used to authenticate the notification;
1. it shall authenticate the source of successful token notifications using the ID Token as the detached signature;
1. it shall ensure that that the `auth_req_id` in the ID Token matches the `auth_req_id` in the response;
1. it shall validate the access token received in a successful token notification using the `at_hash` as as per Section 3.2.2.9 of [OIDC].
1. it shall validate the refresh token received in a successful token notification using the `rt_hash` in a similar manner as above.

**NOTE:** The client notification endpoint is only protected by a bearer token. This profile requires that the authorization server send an ID Token as a detached signature. This allows the client to authenticate the source and verify the integrity of the notification payload. Furthermore, the tokens issued to the client notification endpoint are holder of key tokens and if intercepted cannot be used without the associated key.

# 6. Accessing Protected Resources

### 6.1 Introduction

The provisions detailed in Parts 1 and 2 of the Financial API specification apply fully. The benefit of the CIBA specification is that once tokens are issued they can be in the same manner as token issued via authorization code flows.

### 6.2 Client Provisions

In situations where the client does not control the consumption device, the client

1. shall not send `x-fapi-customer-ip-address` or `x-fapi-customer-last-logged-time` headers;
1. should send metadata about the consumption device, for example geolocation and device type.

   **NOTE:** It may be useful for an FI’s fraud systems to know the location and type of the consumption device. The format and schema for such metadata is outside the scope of this profile.

# 7. Security Considerations

### 7.1 Introduction

The [CIBA] specification introduces some new attack vectors not present in OAuth 2 redirect based flows. This profile aims to help implementers of [CIBA] for financial APIs to reduce or eliminate these attack vectors. There are however further security considerations that should be taken into account when implementing this specification.

### 7.2 Authentication sessions started without a users knowledge or consent

Because this specification allows the client to initiate an authentication request it is impossible for the authorization server to know whether the user is aware and has consented to the authentication process. If widely known user identifiers (e.g. phone numbers) are used as the `login_hint` in the authentication request then this risk is worsened. An attacker could start unsolicited authentication sessions on large numbers of authentication devices, causing distress and potentially enabling fraud.

Because of this risk the authorization server should have strict rate limits per client and should start blocking clients if a certain percentage of authentication sessions are dismissed or denied by users.

### 7.3 Reliance on user to confirm binding messages

In a payments scenario it is possible for a fraudster to start a [CIBA] flow at the same time as a genuine flow, but using the genuine user’s identifier. If the amount and the client are the same then the only way to ensure that a user is authorising the correct transaction is for the user to compare the binding messages. If this risk is deemed unacceptable then implementers should consider alternative mechanisms to verify binding messages.

## 8. Privacy Considerations

* TODO

## 9. Acknowledgement

Following people contributed heavily towards this document.

* Nat Sakimura (Nomura Research Institute) -- Chair, Editor
* Anoop Saxana (Intuit) -- Co-chair, FS-ISAC Liaison
* Anthony Nadalin (Microsoft) -- Co-chair, SC 27 Liaison
* Edmund Jay (Illumila) -- Co-editor
* Dave Tonge (Momentum Financial Technology) -- UK Implementation Entity Liaison
* John Bradley (Yubico)
* Henrik Biering (Peercraft)
* Axel Nennker (Deutsche Telekom)

## 11. Bibliography

TODO
