# JSON Web Algorithms (RFC7518) Comparison

The following provides a clause by clause breakdown comparing [JSON Web Algorithms (JWA)](https://tools.ietf.org/html/rfc7518) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  [https://tools.ietf.org/html/rfc7518](https://tools.ietf.org/html/rfc7518) | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
| [1. Introduction](https://tools.ietf.org/html/rfc7518#section-1) | No | N/A | The CDS Standards make a reference to this RFC but never explicitly describe it's involvement. Nonetheless this RFC is referenced in multiple upstream RFCs and various clauses in this RFC are scoped in both the CDS, other RFCs (such as [JWS](jws-rfc7515.md) and [JWT](jwt-rfc7519)) and OpenID Connect specifications.  |
| [1.1. Notational Conventions](https://tools.ietf.org/html/rfc7518#section-1.1) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
| [2. Terminology](https://tools.ietf.org/html/rfc7518#section-2) | No | N/A |  |
| [3. Cryptographic Algorithms for Digital Signatures and MACs](https://tools.ietf.org/html/rfc7518#section-3) | Implicit | No | Digital Signatures appears to be in use |
| [3.1. "alg" (Algorithm) Header Parameter Values for JWS](https://tools.ietf.org/html/rfc7518#section-3.1) | Implicit | No | `PS256` is mandated as part of the [FAPI-RW](fapi-part2.md) profile |
| [3.2. HMAC with SHA-2 Functions](https://tools.ietf.org/html/rfc7518#section-3.2) | Implicit | N/A | Not Supported due to `PS256` being mandated as part of the [FAPI-RW](fapi-part2.md) profile |
| [3.3. Digital Signature with RSASSA-PKCS1-v1_5](https://tools.ietf.org/html/rfc7518#section-3.3) | Implicit | N/A | Not Supported due to `PS256` being mandated as part of the [FAPI-RW](fapi-part2.md) profile |
| [3.4. Digital Signature with ECDSA](https://tools.ietf.org/html/rfc7518#section-3.4) | Implicit | N/A | Not Supported due to `PS256` being mandated as part of the [FAPI-RW](fapi-part2.md) profile |
| [3.5. Digital Signature with RSASSA-PSS](https://tools.ietf.org/html/rfc7518#section-3.5) | Implicit | N/A | Supported as `PS256` is mandated as part of the [FAPI-RW](fapi-part2.md) profile |
| [3.6. Using the Algorithm "none"](https://tools.ietf.org/html/rfc7518#section-3.6) | Implicit | N/A | [FAPI-RW](fapi-part2.md) does not support `none` |
| [4. Cryptographic Algorithms for Key Management](https://tools.ietf.org/html/rfc7518#section-4) | No | N/A |  |
| [4.1. "alg" (Algorithm) Header Parameter Values for JWE](https://tools.ietf.org/html/rfc7518#section-4.1) | Implicit | Unknown :question: | Use of `JWE` and therefore the `alg` parameter is constrained to ID Token interactions only |
| [4.2. Key Encryption with RSAES-PKCS1-v1_5](https://tools.ietf.org/html/rfc7518#section-4.2) | No | N/A |  |
| [4.3. Key Encryption with RSAES OAEP](https://tools.ietf.org/html/rfc7518#section-4.3) | No | N/A |  |
| [4.4. Key Wrapping with AES Key Wrap](https://tools.ietf.org/html/rfc7518#section-4.4) | No | N/A |  |
| [4.5. Direct Encryption with a Shared Symmetric Key](https://tools.ietf.org/html/rfc7518#section-4.5) | No | N/A |  |
| [4.6. Key Agreement with Elliptic Curve Diffie-Hellman Ephemeral Static (ECDH-ES)](https://tools.ietf.org/html/rfc7518#section-4.6) | No | N/A |  |
| [4.6.1. Header Parameters Used for ECDH Key Agreement](https://tools.ietf.org/html/rfc7518#section-4.6.1) | No | N/A |  |
| [4.6.1.1. "epk" (Ephemeral Public Key) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.6.1.1) | No | N/A |  |
| [4.6.1.2. "apu" (Agreement PartyUInfo) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.6.1.2) | No | N/A |  |
| [4.6.1.3. "apv" (Agreement PartyVInfo) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.6.1.3) | No | N/A |  |
| [4.6.2. Key Derivation for ECDH Key Agreement](https://tools.ietf.org/html/rfc7518#section-4.6.2) | No | N/A |  |
| [4.7. Key Encryption with AES GCM](https://tools.ietf.org/html/rfc7518#section-4.7) | No | N/A |  |
| [4.7.1. Header Parameters Used for AES GCM Key Encryption](https://tools.ietf.org/html/rfc7518#section-4.7.1) | No | N/A |  |
| [4.7.1.1. "iv" (Initialization Vector) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.7.1.1) | No | N/A |  |
| [4.7.1.2. "tag" (Authentication Tag) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.7.1.2) | No | N/A |  |
| [4.8. Key Encryption with PBES2](https://tools.ietf.org/html/rfc7518#section-4.8) | No | N/A |  |
| [4.8.1. Header Parameters Used for PBES2 Key Encryption](https://tools.ietf.org/html/rfc7518#section-4.8.1) | No | N/A |  |
| [4.8.1.1. "p2s" (PBES2 Salt Input) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.8.1.1) | No | N/A |  |
| [4.8.1.2. "p2c" (PBES2 Count) Header Parameter](https://tools.ietf.org/html/rfc7518#section-4.8.1.2) | No | N/A |  |
| [5. Cryptographic Algorithms for Content Encryption](https://tools.ietf.org/html/rfc7518#section-5) | No | N/A |  |
| [5.1. "enc" (Encryption Algorithm) Header Parameter Values for JWE](https://tools.ietf.org/html/rfc7518#section-5.1) | No | N/A |  |
| [5.2. AES\_CBC\_HMAC\_SHA2 Algorithms](https://tools.ietf.org/html/rfc7518#section-5.2) | No | N/A |  |
| [5.2.1. Conventions Used in Defining AES\_CBC\_HMAC\_SHA2](https://tools.ietf.org/html/rfc7518#section-5.2.1) | No | N/A |  |
| [5.2.2. Generic AES\_CBC\_HMAC_SHA2 Algorithm](https://tools.ietf.org/html/rfc7518#section-5.2.2) | No | N/A |  |
| [5.2.2.1. AES\_CBC\_HMAC\_SHA2 Encryption](https://tools.ietf.org/html/rfc7518#section-5.2.2.1) | No | N/A |  |
| [5.2.2.2. AES\_CBC\_HMAC\_SHA2 Decryption](https://tools.ietf.org/html/rfc7518#section-5.2.2.2) | No | N/A |  |
| [5.2.3. AES\_128\_CBC\_HMAC\_SHA\_256](https://tools.ietf.org/html/rfc7518#section-5.2.3) | No | N/A |  |
| [5.2.4. AES\_192\_CBC\_HMAC\_SHA\_384](https://tools.ietf.org/html/rfc7518#section-5.2.4) | No | N/A |  |
| [5.2.5. AES\_256\_CBC\_HMAC\_SHA\_512](https://tools.ietf.org/html/rfc7518#section-5.2.5) | No | N/A |  |
| [5.2.6. Content Encryption with AES\_CBC\_HMAC\_SHA2](https://tools.ietf.org/html/rfc7518#section-5.2.6) | No | N/A |  |
| [5.3. Content Encryption with AES GCM](https://tools.ietf.org/html/rfc7518#section-5.3) | No | N/A |  |
| [6. Cryptographic Algorithms for Keys](https://tools.ietf.org/html/rfc7518#section-6) | No | N/A |  |
| [6.1. "kty" (Key Type) Parameter Values](https://tools.ietf.org/html/rfc7518#section-6.1) | No | N/A |  |
| [6.2. Parameters for Elliptic Curve Keys](https://tools.ietf.org/html/rfc7518#section-6.2) | No | N/A |  |
| [6.2.1. Parameters for Elliptic Curve Public Keys](https://tools.ietf.org/html/rfc7518#section-6.2.1) | No | N/A |  |
| [6.2.1.1. "crv" (Curve) Parameter](https://tools.ietf.org/html/rfc7518#section-6.2.1.1) | No | N/A |  |
| [6.2.1.2. "x" (X Coordinate) Parameter](https://tools.ietf.org/html/rfc7518#section-6.2.1.2) | No | N/A |  |
| [6.2.1.3. "y" (Y Coordinate) Parameter](https://tools.ietf.org/html/rfc7518#section-6.2.1.3) | No | N/A |  |
| [6.2.2. Parameters for Elliptic Curve Private Keys](https://tools.ietf.org/html/rfc7518#section-6.2.2) | No | N/A |  |
| [6.2.2.1. "d" (ECC Private Key) Parameter](https://tools.ietf.org/html/rfc7518#section-6.2.2.1) | No | N/A |  |
| [6.3. Parameters for RSA Keys](https://tools.ietf.org/html/rfc7518#section-6.3) | No | N/A |  |
| [6.3.1. Parameters for RSA Public Keys](https://tools.ietf.org/html/rfc7518#section-6.3.1) | No | N/A |  |
| [6.3.1.1. "n" (Modulus) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.1.1) | No | N/A |  |
| [6.3.1.2. "e" (Exponent) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.1.2) | No | N/A |  |
| [6.3.2. Parameters for RSA Private Keys](https://tools.ietf.org/html/rfc7518#section-6.3.2) | No | N/A |  |
| [6.3.2.1. "d" (Private Exponent) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.1) | No | N/A |  |
| [6.3.2.2. "p" (First Prime Factor) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.2) | No | N/A |  |
| [6.3.2.3. "q" (Second Prime Factor) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.3) | No | N/A |  |
| [6.3.2.4. "dp" (First Factor CRT Exponent) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.4) | No | N/A |  |
| [6.3.2.5. "dq" (Second Factor CRT Exponent) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.5) | No | N/A |  |
| [6.3.2.6. "qi" (First CRT Coefficient) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.6) | No | N/A |  |
| [6.3.2.7. "oth" (Other Primes Info) Parameter](https://tools.ietf.org/html/rfc7518#section-6.3.2.7) | No | N/A |  |
| [6.4. Parameters for Symmetric Keys](https://tools.ietf.org/html/rfc7518#section-6.4) | No | N/A |  |
| [6.4.1. "k" (Key Value) Parameter](https://tools.ietf.org/html/rfc7518#section-6.4.1) | No | N/A |  |
| [7. IANA Considerations](https://tools.ietf.org/html/rfc7518#section-7) | No | N/A |  |
| [7.1. JSON Web Signature and Encryption Algorithms Registry](https://tools.ietf.org/html/rfc7518#section-7.1) | No | N/A |  |
| [7.3. JSON Web Encryption Compression Algorithms Registry](https://tools.ietf.org/html/rfc7518#section-7.3) | No | N/A | |
| [7.5. JSON Web Key Parameters Registration](https://tools.ietf.org/html/rfc7518#section-7.5) | No | N/A | |
| [8. Security Considerations](https://tools.ietf.org/html/rfc7518#section-8) | No | N/A |  |
| [8.1. Cryptographic Agility](https://tools.ietf.org/html/rfc7518#section-8.1) | No | N/A |  |
| [8.2. Key Lifetimes](https://tools.ietf.org/html/rfc7518#section-8.2) | No | N/A | Due to `PS256`, SHA256 is in use which exceeds key lifetime objectives |
| [8.3. RSAES-PKCS1-v1_5 Security Considerations](https://tools.ietf.org/html/rfc7518#section-8.3) | Implicit | No | RSAES-PKCS1-v1_5 not in use |
| [8.4. AES GCM Security Considerations](https://tools.ietf.org/html/rfc7518#section-8.4) | Implicit | No | AES GCM not in use |
| [8.5. Unsecured JWS Security Considerations](https://tools.ietf.org/html/rfc7518#section-8.5) | Implicit | No | Not in use |
| [8.6. Denial-of-Service Attacks](https://tools.ietf.org/html/rfc7518#section-8.6) | No | N/A | Keysize is statically set by `PS256` adoption within [FAPI-RW](fapi-part2.md) |
| [8.7. Reusing Key Material when Encrypting Keys](https://tools.ietf.org/html/rfc7518#section-8.7) | No | N/A |  |
| [8.8. Password Considerations](https://tools.ietf.org/html/rfc7518#section-8.8) | No | N/A |  |
| [8.9. Key Entropy and Random Values](https://tools.ietf.org/html/rfc7518#section-8.9) | No | N/A |  |
| [8.10. Differences between Digital Signatures and MACs](https://tools.ietf.org/html/rfc7518#section-8.10) | No | N/A | Digital Signatures appear to be what is intended. |
| [8.11. Using Matching Algorithm Strengths](https://tools.ietf.org/html/rfc7518#section-8.11) | No | N/A |  |
| [8.12. Adaptive Chosen-Ciphertext Attacks](https://tools.ietf.org/html/rfc7518#section-8.12) | No | N/A |  |
| [8.13. Timing Attacks](https://tools.ietf.org/html/rfc7518#section-8.13) | No | N/A |  |
| [8.14. RSA Private Key Representations and Blinding](https://tools.ietf.org/html/rfc7518#section-8.14) | No | N/A |  |
| [9. Internationalization Considerations](https://tools.ietf.org/html/rfc7518#section-9) | No | N/A |  |