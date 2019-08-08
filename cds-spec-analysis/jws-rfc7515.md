# JWT Web Signature (RFC7515) Comparison

The following provides a clause by clause breakdown comparing [JSON Web Signature (JWS)](https://tools.ietf.org/html/rfc7515) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  **https://tools.ietf.org/html/rfc7515** | **CDS Guidance** | **Modifies Upstream Standard?** | **Summary** |
| --- | --- | --- | --- |
|  [1. Introduction](https://tools.ietf.org/html/rfc7515#section-1) | Reference | N/A | The CDS Standards appear to use JWS for OpenID Connect Core ID Token Responses (Signed & Encrypted). There are no other references which include it. |
|  [1.1. Notational Conventions](https://tools.ietf.org/html/rfc7515#section-1.1) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
|  [2. Terminology](https://tools.ietf.org/html/rfc7515#section-2) | No | N/A |  |
|  [3. JSON Web Signature (JWS) Overview](https://tools.ietf.org/html/rfc7515#section-3) | Yes | No | Within [Client Authentication](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) the CDS specifies that the `private_key_jwt` object is conducted *through the delivery of an encoded [JWT] signed using the Data Recipients private key*. This appears to imply use of JWT Web Signatures. |
|  [3.1. JWS Compact Serialization Overview](https://tools.ietf.org/html/rfc7515#section-3.1) | Implicit | N/A | CDS [Client Authentication](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) appears to use this method of serialisation |
|  [3.2. JWS JSON Serialization Overview](https://tools.ietf.org/html/rfc7515#section-3.2) | Implicit | No | This serialisation method appears to be DISABLED within the [OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#rnc) |
|  [3.3. Example JWS](https://tools.ietf.org/html/rfc7515#section-3.3) | No | N/A |  |
|  [4. JOSE Header](https://tools.ietf.org/html/rfc7515#section-4) | No | N/A | Based on [Client Authentication](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) example |
|  [4.1. Registered Header Parameter Names](https://tools.ietf.org/html/rfc7515#section-4.1) | No | N/A | Aligned to Standards Client Authentication example |
|  [4.1.1. "alg" (Algorithm) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.1) | Yes | No | FAPI Specifies that `PS256` replaces `RS256` |
|  [4.1.2. "jku" (JWK Set URL) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.2) | No | N/A | Does not appear to be used |
|  [4.1.3. "jwk" (JSON Web Key) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.3) | No | N/A | Does not appear to be used |
|  [4.1.4. "kid" (Key ID) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.4) | No | No | ~~The CDS [appears](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) to make this **MANDATORY** and sets it to the `client-id` parameter~~ Update 07/08/19: This was inferred from example, assuming it is not the case. |
|  [4.1.5. "x5u" (X.509 URL) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.5) | No | N/A | Does not appear to be used |
|  [4.1.6. "x5c" (X.509 Certificate Chain) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.6) | No | N/A | Does not appear to be used |
|  [4.1.7. "x5t" (X.509 Certificate SHA-1 Thumbprint) Header Parameter](https://tools.ietf.org/html/rfc7515#page-12) | No | N/A | Does not appear to be used |
|  [4.1.8. "x5t#S256" (X.509 Certificate SHA-256 Thumbprint) Header Parameter](https://tools.ietf.org/html/rfc7515#page-12) | No | N/A | Does not appear to be used |
|  [4.1.9. "typ" (Type) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.9) | Yes | Yes :stop_sign: | The [example](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) specifies this as ***JWT*** but it appears to be ***JOSE***. The CDS appears to make this **MANDATORY** |
|  [4.1.10. "cty" (Content Type) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.10) | No | N/A | Does not appear to be used |
|  [4.1.11. "crit" (Critical) Header Parameter](https://tools.ietf.org/html/rfc7515#section-4.1.11) | No | N/A | Does not appear to be used |
|  [4.2. Public Header Parameter Names](https://tools.ietf.org/html/rfc7515#section-4.2) | No | N/A | No known additions to parameter names |
|  [4.3. Private Header Parameter Names](https://tools.ietf.org/html/rfc7515#section-4.3) | No | N/A | No known additions to parameter names |
|  [5. Producing and Consuming JWSs](https://tools.ietf.org/html/rfc7515#section-5) | No | N/A |  |
|  [5.1. Message Signature or MAC Computation](https://tools.ietf.org/html/rfc7515#section-5.1) | Reference | N/A |  |
|  [5.2. Message Signature or MAC Validation](https://tools.ietf.org/html/rfc7515#section-5.2) | Reference | N/A |  |
|  [5.3. String Comparison Rules](https://tools.ietf.org/html/rfc7515#section-5.3) | No | N/A |  |
|  [6. Key Identification](https://tools.ietf.org/html/rfc7515#section-6) | No | Unknown :question:| |
|  [7. Serializations](https://tools.ietf.org/html/rfc7515#section-7) | No | N/A |  |
|  [7.1. JWS Compact Serialization](https://tools.ietf.org/html/rfc7515#section-7.1) | Yes | No | The CDS appears to use this serialisation method which is aligned with [OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#rnc) |
|  [7.2. JWS JSON Serialization](https://tools.ietf.org/html/rfc7515#section-7.2) | Yes | No | This serialisation method is DISABLED within the [OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#rnc) |
|  [7.2.1. General JWS JSON Serialization Syntax](https://tools.ietf.org/html/rfc7515#section-7.2.1) | Yes | No | This serialisation method is DISABLED within the [OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#rnc) |
|  [7.2.2. Flattened JWS JSON Serialization Syntax](https://tools.ietf.org/html/rfc7515#section-7.2.2) | Yes | No | This serialisation method is DISABLED within the [OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#rnc) |
|  [8. TLS Requirements](https://tools.ietf.org/html/rfc7515#section-8) | Yes | No | Use of TLS and MTLS [is mandated](https://consumerdatastandardsaustralia.github.io/standards/#transaction-security) |
|  [9. IANA Considerations](https://tools.ietf.org/html/rfc7515#section-9) | No | N/A |  |
|  [9.1. JSON Web Signature and Encryption Header Parameters Registry](https://tools.ietf.org/html/rfc7515#section-9.1) | No | N/A |  |
|  [9.1.1. Registration Template](https://tools.ietf.org/html/rfc7515#section-9.1.1) | No | N/A |  |
|  [9.1.2. Initial Registry Contents](https://tools.ietf.org/html/rfc7515#section-9.1.2) | Yes | No | FAPI Specifies that `PS256` replaces `RS256` |
|  [9.2. Media Type Registration](https://tools.ietf.org/html/rfc7515#section-9.2) | No | N/A |  |
|  [9.2.1. Registry Contents](https://tools.ietf.org/html/rfc7515#section-9.2.1) | No | N/A |  |
|  [10. Security Considerations](https://tools.ietf.org/html/rfc7515#section-10) | No | N/A |  |
|  [10.1. Key Entropy and Random Values](https://tools.ietf.org/html/rfc7515#section-10.1) | No | N/A |  |
|  [10.2. Key Protection](https://tools.ietf.org/html/rfc7515#section-10.2) | No | N/A |  |
|  [10.3. Key Origin Authentication](https://tools.ietf.org/html/rfc7515#section-10.3) | Yes | Yes :stop_sign: | Key Origin Authentication is currently determined by ACCC Register publishing. This content is unsigned and relies entirely on TLS and non-tampered payloads |
|  [10.4. Cryptographic Agility](https://tools.ietf.org/html/rfc7515#section-10.4) | No | N/A | [Reference JWA Review](jwa-rfc7518.md) |
|  [10.5. Differences between Digital Signatures and MACs](https://tools.ietf.org/html/rfc7515#section-10.5) | No | N/A | Digital Signatures appear to be in use |
|  [10.6. Algorithm Validation](https://tools.ietf.org/html/rfc7515#section-10.6) | Yes | Unknown :question: |  |
|  [10.7. Algorithm Protection](https://tools.ietf.org/html/rfc7515#section-10.7) | No | N/A |  |
|  [10.8. Chosen Plaintext Attacks](https://tools.ietf.org/html/rfc7515#section-10.8) | No | N/A |  |
|  [10.9. Timing Attacks](https://tools.ietf.org/html/rfc7515#section-10.9) | No | N/A |  |
|  [10.10. Replay Protection](https://tools.ietf.org/html/rfc7515#section-10.10) | Implicit | N/A | OpenID Connect Core implements replay protection with the `jti` claim |
|  [10.11. SHA-1 Certificate Thumbprints](https://tools.ietf.org/html/rfc7515#section-10.11) | No | N/A | SHA-1 Certificates are not in use |
|  [10.12. JSON Security Considerations](https://tools.ietf.org/html/rfc7515#section-10.12) | Reference | N/A | Strict JSON is not explicitly specified |
|  [10.13. Unicode Comparison Security Considerations](https://tools.ietf.org/html/rfc7515#section-10.13) | No | N/A |  |

