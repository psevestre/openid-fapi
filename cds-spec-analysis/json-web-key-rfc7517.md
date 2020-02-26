
# JSON Web Key (JWK) (RFC7517) Comparison

The following provides a clause by clause breakdown comparing [JSON Web Key (JWK)](https://tools.ietf.org/html/rfc7517) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards). As the main source of JSON Web Key's is the ACCC Register this also incorporates a review relative to the current [ACCC Register](https://cdr-register.github.io/register) design.

|  **https://tools.ietf.org/html/rfc7517** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
|  [1. Introduction](https://tools.ietf.org/html/rfc7517#section-1) | Yes | No | The CDS Standards reference this RFC without explicitly ever discussing it. |
|  [1.1 Notational Conventions](https://tools.ietf.org/html/rfc7517#section-1.1) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
|  [2. Terminology](https://tools.ietf.org/html/rfc7517#section-2) | No | N/A |  |
|  [3. Example JWK](https://tools.ietf.org/html/rfc7517#section-3) | No | N/A |  |
|  [4. JSON Web Key (JWK) Format](https://tools.ietf.org/html/rfc7517#section-4) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.1. "kty" (Key Type) Parameter](https://tools.ietf.org/html/rfc7517#section-4.1) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.2. "use" (Public Key Use) Parameter](https://tools.ietf.org/html/rfc7517#section-4.2) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.3. "key_ops" (Key Operations) Parameter](https://tools.ietf.org/html/rfc7517#section-4.3) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.4. "alg" (Algorithm) Parameter](https://tools.ietf.org/html/rfc7517#section-4.4) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.5. "kid" (Key ID) Parameter](https://tools.ietf.org/html/rfc7517#section-4.5) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA |
|  [4.6. "x5u" (X.509 URL) Parameter](https://tools.ietf.org/html/rfc7517#section-4.6) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [4.7. "x5c" (X.509 Certificate Chain) Parameter](https://tools.ietf.org/html/rfc7517#section-4.7) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [4.8. "x5t" (X.509 Certificate SHA-1 Thumbprint) Parameter](https://tools.ietf.org/html/rfc7517#section-4.8) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [4.9. "x5t#S256" (X.509 Certificate SHA-256 Thumbprint) Parameter](https://tools.ietf.org/html/rfc7517#section-4.9) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [5. JWK Set Format](https://tools.ietf.org/html/rfc7517#section-5) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [5.1. "keys" Parameter](https://tools.ietf.org/html/rfc7517#section-5.1) | Yes | No | JWKS retrieved using [an attribute](https://cdr-register.github.io/register/#tocSresponseregisterdataholderbrandlist) in ACCC Register combined with an SSA
|  [6. String Comparison Rules](https://tools.ietf.org/html/rfc7517#section-6) | No | N/A |  |
|  [7. Encrypted JWK and Encrypted JWK Set Formats](https://tools.ietf.org/html/rfc7517#section-7) | No | N/A | Non Public Key Material is never intended to be disclosed by OPs to the Register |
|  [8. IANA Considerations](https://tools.ietf.org/html/rfc7517#section-8) | No | N/A |  |
|  [9. Security Considerations](https://tools.ietf.org/html/rfc7517#section-9) | No | N/A |  |
|  [9.1. Key Provenance and Trust](https://tools.ietf.org/html/rfc7517#section-9.1) | Yes | No | *"One should place no more trust in the data cryptographically secured by a key than in the method by which it was obtained and in the trustworthiness of the entity asserting an association with the key."* |
|  [9.2. Preventing Disclosure of Non-public Key Information](https://tools.ietf.org/html/rfc7517#section-9.2) | No | N/A |  |
|  [9.3. RSA Private Key Representations and Blinding](https://tools.ietf.org/html/rfc7517#section-9.3) | No | N/A |  |
|  [9.4. Key Entropy and Random Values](https://tools.ietf.org/html/rfc7517#section-9.4) | No | N/A |  |
