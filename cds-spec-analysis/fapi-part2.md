
# FAPI-RW Security Profile Comparison

The following provides a clause by clause breakdown comparing [Financial-grade API - Part 2: Read and Write API Security Profile](https://openid.net/specs/openid-financial-api-part-2.html) to the published [Consumer Data Standards v1.1.1](https://consumerdatastandardsaustralia.github.io/standards).

|  **[https://openid.net/specs/openid-financial-api-part-2.html](https://openid.net/specs/openid-financial-api-part-2.html)** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
|  [1. Scope](https://openid.net/specs/openid-financial-api-part-2.html#scope) | No | N/A | The CDS security profile [introduction](https://consumerdatastandardsaustralia.github.io/standards/#security-profile) states that *"this information security profile builds upon the foundations of the Financial-grade API Read Write Profile [FAPI-RW] and other standards relating to Open ID Connect 1.0 [OIDC]"*.<br/><br/>It is assumed that without explicit guidance there is adoption of the upstream profile. 
| | | | **NOTE:** For the sake of completeness the FAPI-RW profile is compared independently of [FAPI-R](fap-part1.md). |
|  [2. Normative references](https://openid.net/specs/openid-financial-api-part-2.html#normative-references) | No | N/A |  |
|  [3. Terms and definitions](https://openid.net/specs/openid-financial-api-part-2.html#terms-and-definitions) | No | N/A |  |
|  [4. Symbols and Abbreviated terms](https://openid.net/specs/openid-financial-api-part-2.html#symbols-and-abbreviated-terms) | No | N/A |  |
|  [5. Read and write API security profile](https://openid.net/specs/openid-financial-api-part-2.html#read-write-api-security-profile) | No | N/A |  |
|  [5.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction) | Yes | No | `s_hash` is defined by the FAPI-RW specification and [adopted by](https://consumerdatastandardsaustralia.github.io/standards/#tokens) the CDS Profile |
|  [5.2. Read and write API security provisions](https://openid.net/specs/openid-financial-api-part-2.html#read-and-write-api-security-provisions) | No | N/A |  |
|  [5.2.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-1) | No | N/A |  |
|  [5.2.2. Authorization server](https://openid.net/specs/openid-financial-api-part-2.html#authorization-server) | Yes | Yes :octagonal_sign: | With respect to inherited clauses from the [FAPI-R](fapi-part1.md) profile, the CDS modifies the statements in [this related clause](https://openid.net/specs/openid-financial-api-part-1.html#authorization-server) as follows: |
| | | | - *Item 2:* Public Clients are [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#oidc-client-types) |
| | | | - *Item 4 (1)*: Mutual TLS for OAuth Client Authentication is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) |
| | | | - *Item 4 (2):* `client_secret_jwt` is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
| | | | - *Item 4 (2):*  `private_key_jwt` is [**REQUIRED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
| | | | - *Item 4 (2):*  `private_key_jwt` is [**REQUIRED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
| | | | In addition the CDS modifies the FAPI-RW provisions included in this clause as follows: |
| | | | - *Item 1:* `request_uri` is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows)** | 
| | | | - *Item 2:* `response_type` of `code id_token token` is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows)** | 
| | | | - *Item 3:* Unclear if detached signatures are in use, CDS example does not appear to be valid.
| | | | - *Item 4:* `s_hash` is **MANDATORY** in CDS
| | | | - *Item 6:* OAUTB is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#transaction-security)** |
| | | | - *Item 8:* Signed only ID Tokens are **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#tokens)** |
| | | | - *Item 9:* Signed & Encrypted tokens are the **MANDATORY** | 
| | | :question: | - *Item 10:* Unsure
| | | | - *Item 11:* `request_uri` and therefore Request Object Endpoint support is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows)** |
| | | | - *Item 12:* Public clients are not supported. PKCE is also not supported.
| | | | - *Item 13:* `exp` is not included in [example CDS payload](https://consumerdatastandardsaustralia.github.io/standards/#request-object) and does not appear to be mandatory
| | | | - *Item 14:* Mutual TLS for OAuth Client Authentication is not supported |
|  [5.2.3. Public client](https://openid.net/specs/openid-financial-api-part-2.html#public-client) | Yes | Yes :octagonal_sign: | Public clients are **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#oidc-client-types)** |
|  [5.2.4. Confidential client](https://openid.net/specs/openid-financial-api-part-2.html#confidential-client) | Yes | Yes :octagonal_sign: | The CDS modifies this statement as follows: |
| | | | - *Item 1:* OAUTB is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#transaction-security)** |
| | | | - *Item 2:* Signed Only Tokens are **NOT SUPPORTED**. The CDS requires tokens to be `Sign`+`Encrypt`. Detached Signatures are not explicitly required and the example payload is not a detached signature. |
|  [5.2.5. JWT Secured Authorization Response Mode](https://openid.net/specs/openid-financial-api-part-2.html#jwt-secured-authorization-response-mode) | Yes | Yes :octagonal_sign: | While JARM was recommended in the [Independent Security Review](https://github.com/ConsumerDataStandardsAustralia/standards/files/3401837/Consumer_Data_Right_Security_Review_Final.pdf) the CDS response [decided](https://github.com/ConsumerDataStandardsAustralia/standards/files/3401842/Decision.078.-.Independent.Information.Security.Review.pdf) has specified it will not be adopted (even optionally) in the first version. |
|  [6. Accessing protected resources (using tokens)](https://openid.net/specs/openid-financial-api-part-2.html#accessing-protected-resources-using-tokens) | No | N/A |  |
|  [6.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-2) | No | N/A |  |
|  [6.2. Read and write access provisions](https://openid.net/specs/openid-financial-api-part-2.html#read-and-write-access-provisions) | No | N/A |  |
|  [6.2.1. Protected resources provisions](https://openid.net/specs/openid-financial-api-part-2.html#protected-resources-provisions) | Yes | Yes :octagonal_sign: | As per [FAPI-R](fapi-part1.md) review, the following alterations to this clause are made within the [CDS Headers](https://consumerdatastandardsaustralia.github.io/standards/#http-headers) specification: |
| | | | - *Item 9:* Standards specify an explicit charset of `application/json` which is not aligned. *NOTE: This clause in FAPI is scheduled to alter to be aligned to CDS*  |
| | | | - *Item 10*: Standards **DO NOT** require the HTTP Date header |
| | | | - *Item 13*: CORS headers are specified for Unauthenticated Endpoints |
|  [6.2.2. Client provisions](https://openid.net/specs/openid-financial-api-part-2.html#client-provisions) | Yes | Yes | As per [FAPI-R](fapi-part1.md) review, the following alterations to this clause are made within the [CDS Headers](https://consumerdatastandardsaustralia.github.io/standards/#http-headers) specification: |
| | | | - *Item 3*: `x-fapi-auth-date` is **MANDATORY** for all authenticated calls |
| | | | - *Item 4*: `x-fapi-customer-ip-address` is **MANDATORY** for attended calls and is tied to [CDS Performance Requirements](https://consumerdatastandardsaustralia.github.io/standards/#performance-requirements) |
|  [7. Request object endpoint](https://openid.net/specs/openid-financial-api-part-2.html#request-object-endpoint) | Yes | Yes :octagonal_sign: | The CDS specifies that `request_uri`  is **[NOT SUPPORTED](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows)** and by definition this means Request Object Endpoint is **NOT SUPPORTED** |
|  [7.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-3) | Implicit | Yes :octagonal_sign: |  |
|  [7.2. Request](https://openid.net/specs/openid-financial-api-part-2.html#request) | Implicit | Yes :octagonal_sign: |  |
|  [7.3. Successful response](https://openid.net/specs/openid-financial-api-part-2.html#successful-response) | Implicit | Yes :octagonal_sign: |  |
|  [7.4. Error responses](https://openid.net/specs/openid-financial-api-part-2.html#error-responses) | Implicit | Yes :octagonal_sign: |  |
|  [7.4.1. Authorization required](https://openid.net/specs/openid-financial-api-part-2.html#authorization-required) | Implicit | Yes :octagonal_sign: |  |
|  [7.4.2. Invalid request](https://openid.net/specs/openid-financial-api-part-2.html#invalid-request) | Implicit | Yes :octagonal_sign: |  |
|  [7.4.3. Method not allowed](https://openid.net/specs/openid-financial-api-part-2.html#method-not-allowed) | Implicit | Yes :octagonal_sign: |  |
|  [7.4.4. Request entity too large](https://openid.net/specs/openid-financial-api-part-2.html#request-entity-too-large) | Implicit | Yes :octagonal_sign: |  |
|  [7.4.5. Too many requests](https://openid.net/specs/openid-financial-api-part-2.html#too-many-requests) | Implicit | Yes :octagonal_sign: |  |
|  [7.5. OpenID Provider Discovery Metadata](https://openid.net/specs/openid-financial-api-part-2.html#openid-provider-discovery-metadata) | Yes | Yes :octagonal_sign: | In the CDS, due to `request_uri` being removed from support, `request_object_endpoint` is **NOT SUPPORTED** |
|  [8. Security considerations](https://openid.net/specs/openid-financial-api-part-2.html#security-considerations) | No | N/A |  |
|  [8.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-4) | No | N/A |  |
|  [8.2. Uncertainty of resource server handling of access tokens](https://openid.net/specs/openid-financial-api-part-2.html#uncertainty-of-resource-server-handling-of-access-tokens) | No | N/A |  |
|  [8.3. Attacks using weak binding of authorization server endpoints](https://openid.net/specs/openid-financial-api-part-2.html#attacks-using-weak-binding-of-authorization-server-endpoints) | No | N/A |  |
|  [8.3.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-5) | No | N/A |  |
|  [8.3.2. Client credential and authorization code phishing at token endpoint](https://openid.net/specs/openid-financial-api-part-2.html#client-credential-and-authorization-code-phishing-at-token-endpoint) | No | N/A |  |
|  [8.3.3. Identity provider (IdP) mix-up attack](https://openid.net/specs/openid-financial-api-part-2.html#identity-provider-idp-mix-up-attack) | Yes | No | |
|  [8.3.4. Request object endpoint phishing resistance](https://openid.net/specs/openid-financial-api-part-2.html#request-object-endpoint-phishing-resistance) | No | N/A |  |
|  [8.3.5. Access token phishing](https://openid.net/specs/openid-financial-api-part-2.html#access-token-phishing) | No | N/A |  |
|  [8.4. Attacks that modify authorization requests and responses](https://openid.net/specs/openid-financial-api-part-2.html#attacks-that-modify-authorization-requests-and-responses) | No | N/A |  |
|  [8.4.1. Introduction](https://openid.net/specs/openid-financial-api-part-2.html#introduction-6) | No | N/A |  |
|  [8.4.2. Authorization request parameter injection attack](https://openid.net/specs/openid-financial-api-part-2.html#authorization-request-parameter-injection-attack) | No | N/A |  |
|  [8.4.3. Authorization response parameter injection attack](https://openid.net/specs/openid-financial-api-part-2.html#authorization-response-parameter-injection-attack) | No | N/A |  |
|  [8.5. TLS considerations](https://openid.net/specs/openid-financial-api-part-2.html#tls-considerations) | No | N/A |  |
|  [8.6. JWS algorithm considerations](https://openid.net/specs/openid-financial-api-part-2.html#jws-algorithm-considerations) | No | N/A :question: | It is understood that only `PS256` is allowed within the CDS. |
|  [8.7. Incomplete or incorrect implementations of the specifications](https://openid.net/specs/openid-financial-api-part-2.html#incomplete-or-incorrect-implementations-of-the-specifications) | Implicit | Yes :octagonal_sign: | The changes outlined result in incomplete implementations of the upstream specification: *"To achieve the full security benefits, it is important the implementation of this specification, and the underlying OpenID Connect and OAuth specifications, are both complete and correct."* |
|  [9. Privacy considerations](https://openid.net/specs/openid-financial-api-part-2.html#privacy-considerations) | No | N/A |  |
