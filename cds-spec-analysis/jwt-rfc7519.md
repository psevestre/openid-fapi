# JSON Web Token (JWT) (RFC7519) Comparison

The following provides a clause by clause breakdown comparing [JSON Web Token (JWT)](https://tools.ietf.org/html/rfc7519) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  **https://tools.ietf.org/html/rfc7519** | **CDS Guidance** | **Modifies Upstream Standard?** | **Summary** |
| --- | --- | --- | --- |
|  [1. Introduction](https://tools.ietf.org/html/rfc7519#section-1) | No | N/A | The CDS inherits it's use of JWT's from it's implementation of the [Open ID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html#ClientAuthentication) specification, specifically through the use of the `private_key_jwt` method for [Client Authentication](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) |
|  [1.1 Notational Conventions](https://tools.ietf.org/html/rfc7519#section-1.1) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
|  [2. Terminology](https://tools.ietf.org/html/rfc7519#section-2) | No | N/A |  |
|  [3. JSON Web Token (JWT) Overview](https://tools.ietf.org/html/rfc7519#section-3) | No | N/A |  |
|  [3.1. Example JWT](https://tools.ietf.org/html/rfc7519#section-3.1) | No | N/A |  |
|  [4. JWT Claims](https://tools.ietf.org/html/rfc7519#section-4) | Yes | Yes :octagonal_sign:| The [CDS specifies two unregistered](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) private claims: |
| | | | - `refresh_token_expires_at` which is common but undocumented and serves the same purpose [as the FAPI-RW](https://openbanking.atlassian.net/wiki/spaces/DZ/pages/641992418/Read+Write+Data+API+Specification+-+v3.0#Read/WriteDataAPISpecification-v3.0-TokenExpiryTime) `http://openbanking.org.uk/refresh_token_expires_at` claim |
| | | | - `sharing_expires_at` is introduced within the CDS specifically to handle the [proposed Consent model](https://github.com/ConsumerDataStandardsAustralia/standards/issues/77) |
| | | | - Both of these claims are **MANDATORY** |
|  [4.1. Registered Claim Names](https://tools.ietf.org/html/rfc7519#section-4.1) | Yes | Yes :octagonal_sign: | - *"Applications using JWTs should define which specific claims they use and when they are required or optional"*
| | | | The CDS [Request Object](https://consumerdatastandardsaustralia.github.io/standards/#request-object) example appears to make some of these claims **MANDATORY**. | 
|  [4.1.1. "iss" (Issuer) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.1) | Implicit | No | The OpenID Connect Core specification [states that within Request Objects](https://openid.net/specs/openid-connect-core-1_0.html#RequestObject) this claim **SHOULD** be provided. |
|  [4.1.2. "sub" (Subject) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.2) | Yes | No :question: | The CDS [Request Object](https://consumerdatastandardsaustralia.github.io/standards/#request-object) includes this claim in the example. |
| | | | It does not specify if this claim is required, it is assumed it is **OPTIONAL**. |
|  [4.1.3. "aud" (Audience) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.3) | Implicit | No :question: | The OpenID Connect Core specification [states that within Request Objects](https://openid.net/specs/openid-connect-core-1_0.html#RequestObject) this claim **SHOULD** be provided. |
| | | | It is not specified if the CDS specification alters this to required, it is assumed it **OPTIONAL**. |
|  [4.1.4. "exp" (Expiration Time) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.4) | Implicit | No | The FAPI-RW specification designates [this claim](https://openid.net/specs/openid-financial-api-part-2.html#authorization-server) as **REQUIRED** |
|  [4.1.5. "nbf" (Not Before) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.5) | No | N/A |  |
|  [4.1.6. "iat" (Issued At) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.6) | No | N/A |  |
|  [4.1.7."jti" (JWT ID) Claim](https://tools.ietf.org/html/rfc7519#section-4.1.7) | No | N/A  | |
|  [4.2. Public Claim Names](https://tools.ietf.org/html/rfc7519#section-4.2) | No | No |  |
|  [4.3. Private Claim Names](https://tools.ietf.org/html/rfc7519#section-4.3) | Yes | Yes |As outlined previously the [CDS specifies two unregistered](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) private claims: | 
| | | | - `refresh_token_expires_at` which is common but undocumented and serves the same purpose [as the FAPI-RW](https://openbanking.atlassian.net/wiki/spaces/DZ/pages/641992418/Read+Write+Data+API+Specification+-+v3.0#Read/WriteDataAPISpecification-v3.0-TokenExpiryTime) `http://openbanking.org.uk/refresh_token_expires_at` claim |
| | | | - `sharing_expires_at` is introduced within the CDS specifically to handle the [proposed Consent model](https://github.com/ConsumerDataStandardsAustralia/standards/issues/77) |
| | | | Both of these claims are **MANDATORY** |
|  [5. JOSE Header](https://tools.ietf.org/html/rfc7519#section-5) | Implicit | No | The [CDS Standards](https://consumerdatastandardsaustralia.github.io/standards/#request-object) specifies alignment of signing to the [FAPI-RW profile](https://openid.net/specs/openid-financial-api-part-2.html#jws-algorithm-considerations) which dictates JWS signing but the example appears to be malformed including an invalid `typ` value |
|  [5.1. "typ" (Type) Header Parameter](https://tools.ietf.org/html/rfc7519#section-5.1) | Implicit | Unknown :question: | The FAPI-RW profile [states the signing method as JWS](https://openid.net/specs/openid-financial-api-part-2.html#authorization-server) which according to the [accompanying specification](https://tools.ietf.org/html/rfc7515#section-4.1.9) means this field should be set to `JOSE`. The CDS Request Object Example [appears to use a malformed](https://consumerdatastandardsaustralia.github.io/standards/#request-object) value of `JWT`. |
|  [5.2. "cty" (Content Type) Header Parameter](https://tools.ietf.org/html/rfc7519#section-5.2) | Implicit | No | Nested signing and encryption operations are not in use and therefore [this parameter](https://tools.ietf.org/html/rfc7519#section-5.2) should not (and is not) be specified |
|  [5.3. Replicating Claims as Header Parameters](https://tools.ietf.org/html/rfc7519#section-5.3) | Implicit | No | As per [OpenID Core Specification](https://openid.net/specs/openid-connect-core-1_0.html#Signing) the `kid` parameter has been replicated within Header Parameters |
|  [6. Unsecured JWTs](https://tools.ietf.org/html/rfc7519#section-6) | No | N/A | JWTs must always be signed using `PS256` |
|  [6.1. Example Unsecured JWT](https://tools.ietf.org/html/rfc7519#section-6.1) | No | N/A |  |
|  [7. Creating and Validating JWTs](https://tools.ietf.org/html/rfc7519#section-7) | No | N/A | The CDS appears to use `JWS` for JWT creation |
|  [7.1. Creating a JWT](https://tools.ietf.org/html/rfc7519#section-7.1) | No | N/A |  |
|  [7.2. Validating a JWT](https://tools.ietf.org/html/rfc7519#section-7.2) | No | N/A |  |
|  [7.3. String Comparison Rules](https://tools.ietf.org/html/rfc7519#section-7.3) | No | N/A |  |
|  [8. Implementation Requirements](https://tools.ietf.org/html/rfc7519#section-8) | No | N/A |  |
|  [9. URI for Declaring that Content is a JWT](https://tools.ietf.org/html/rfc7519#section-9) | No | N/A |  |
|  [10. IANA Considerations](https://tools.ietf.org/html/rfc7519#section-10) | No | N/A |  |
|  [10.1. JSON Web Token Claims Registry](https://tools.ietf.org/html/rfc7519#section-10.1) | No | N/A |  |
|  [10.1.1. Registration Template](https://tools.ietf.org/html/rfc7519#section-10.1.1) | No | N/A |  |
|  [10.1.2. Initial Registry Contents](https://tools.ietf.org/html/rfc7519#section-10.1.2) | No | N/A |  |
|  [10.2. Sub-Namespace Registration of urn:ietf:params:oauth:token-type:jwt](https://tools.ietf.org/html/rfc7519#section-10.2) | No | N/A |  |
|  [10.2.1. Registry Contents](https://tools.ietf.org/html/rfc7519#section-10.2.1) | No | N/A |  |
|  [10.3. Media Type Registration](https://tools.ietf.org/html/rfc7519#section-10.3) | No | N/A |  |
|  [10.3.1. Registry Contents](https://tools.ietf.org/html/rfc7519#section-10.3.1) | No | N/A |  |
|  [10.4. Header Parameter Names Registration](https://tools.ietf.org/html/rfc7519#section-10.4) | Implicit | No | FAPI-RW and OpenID Core Connect specifications register header parameters |
|  [10.4.1. Registry Contents](https://tools.ietf.org/html/rfc7519#section-10.4.1) | No | N/A |  |
|  [11. Security Considerations](https://tools.ietf.org/html/rfc7519#section-11) | No | N/A |  |
|  [11.1. Trust Decisions](https://tools.ietf.org/html/rfc7519#section-11.1) | Yes | No | *"In particular, the key(s) used to sign and/or encrypt the JWT will typically need to verifiably be under the control of the party identified as the issuer of the JWT."* |
|  [11.2. Signing and Encryption Order](https://tools.ietf.org/html/rfc7519#section-11.2) | No | N/A |  |
|  [12. Privacy Considerations](https://tools.ietf.org/html/rfc7519#section-12) | No | N/A |  |
