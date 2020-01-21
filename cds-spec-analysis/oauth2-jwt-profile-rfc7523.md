# JWT Profile for Oauth2 (RFC7523) Comparison

The following provides a clause by clause breakdown comparing [JSON Web Token (JWT) Profile for OAuth 2.0 Client Authentication and Authorization Grants (RFC7523)](https://tools.ietf.org/html/rfc7523) to the published [Consumer Data Standards v1.1.1](https://consumerdatastandardsaustralia.github.io/standards).

|  **https://tools.ietf.org/html/rfc7523** | **CDS Guidance** | **Modifies Upstream Standard?** | **Summary** |
| --- | :---: | :---: | --- |
|  [1 Introduction](https://tools.ietf.org/html/rfc7523#section-1) | No | N/A | _"The process by which the client obtains the JWT, prior to exchanging it with the authorization server or using it for client authentication, is out of scope."_ |
| | | | The proposed model obtains the public key from the ACCC Register |
|  [1.1 Notational Conventions](https://tools.ietf.org/html/rfc7523#section-1.1) | Implicit :warning: | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
|  [1.2 Terminology](https://tools.ietf.org/html/rfc7523#section-1.2) | No | N/A |  |
|  [2 HTTP Parameter Bindings for Transporting Assertions](https://tools.ietf.org/html/rfc7523#section-2) | Implicit :warning: | No |  |
|  [2.1 Using JWTs as Authorization Grants](https://tools.ietf.org/html/rfc7523#section-2.1) | Yes | No | The CDS supports only the `private_key_jwt` client authentication method and therefore the `urn:ietf:params:oauth:grant-type:jwt-bearer` grant type is **REMOVED** |
|  [2.2 Using JWTs for Client Authentication](https://tools.ietf.org/html/rfc7523#section-2.2) | Yes | No | OpenID Connect Core Specification specifies the `client_id` is **MANDATORY** |
|  [3 JWT Format and Processing Requirements](https://tools.ietf.org/html/rfc7523#section-3) | Yes | No | 
|  [3.1 Authorization Grant Processing](https://tools.ietf.org/html/rfc7523#section-3.1) | Yes | Yes :octagonal_sign: | JWT Authorization Grants are **DISABLED** as part of [Client Authentication](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication). Continuation of *2.1* 
| [3.2 Client Authentication Processing](https://tools.ietf.org/html/rfc7523#section-3.2) | Implicit :warning: | N/A | CDS does not explicitly document error states |
|  [4 Authorization Grant Example](https://tools.ietf.org/html/rfc7523#section-4) | Implicit :warning: | N/A | Keys different due to above changes |
|  [5 Interoperability Considerations](https://tools.ietf.org/html/rfc7523#section-5) | Implicit :warning: | No | FAPI Specifies that `PS256` replaces `RS256` |
|  [6 Security Considerations](https://tools.ietf.org/html/rfc7523#section-6) | Yes | No | OpenID Connect Core implements replay protection with `jti` |
|  [7 Privacy Considerations](https://tools.ietf.org/html/rfc7523#section-7) | No | N/A | |
|  [8 IANA Considerations](https://tools.ietf.org/html/rfc7523#section-8) | No | N/A |  |
|  [8.1 Sub-Namespace Registration of urn:ietf:params:oauth:grant-type:jwt-bearer](https://tools.ietf.org/html/rfc7523#page-10) | No | N/A | JWT Authorization Grants are **DISABLED** |
|  [8.2 Sub-Namespace Registration of urn:ietf:params:oauth:client-assertion-type:jwt-bearer](https://tools.ietf.org/html/rfc7523#page-10) | No | N/A | CDS uses this namespace |
