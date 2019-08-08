
# FAPI-R Security Profile Comparison

The following provides a clause by clause breakdown comparing [Financial-grade API - Part 1: Read-Only API Security Profile](https://openid.net/specs/openid-financial-api-part-1.html) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  **https://openid.net/specs/openid-financial-api-part-1.html** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
|  [1. Scope](https://openid.net/specs/openid-financial-api-part-1.html#scope) | Yes | N/A | The CDS specify *"This information security profile builds upon the foundations of the Financial-grade API Read Write Profile [FAPI-RW] and other standards relating to Open ID Connect 1.0 [OIDC]."* |
|     |     |     |  It is assumed that without explicit guidance there is adoption of the upstream profile. For the sake of completeness the FAPI-R profile is compared independently of [FAPI-RW](fapi-part2.md). |
|  [2. Normative references](https://openid.net/specs/openid-financial-api-part-1.html#normative-references) | No | N/A |  |
|  [3. Terms and definitions](https://openid.net/specs/openid-financial-api-part-1.html#terms-and-definitions) | No | N/A |  |
|  [4. Symbols and abbreviated terms](https://openid.net/specs/openid-financial-api-part-1.html#symbols-and-abbreviated-terms) | No | N/A |  |
|  [5. Read-only API security profile](https://openid.net/specs/openid-financial-api-part-1.html#read-only-api-security-profile) | No | N/A |  |
|  [5.1. Introduction](https://openid.net/specs/openid-financial-api-part-1.html#introduction) | No | N/A |  |
|  [5.2. Read-only API security provisions](https://openid.net/specs/openid-financial-api-part-1.html#read-only-api-security-provisions) | No | N/A |  |
|  [5.2.1. Introduction](https://openid.net/specs/openid-financial-api-part-1.html#introduction-1) | No | N/A |  |
|  [5.2.2. Authorization server](https://openid.net/specs/openid-financial-api-part-1.html#authorization-server) | Yes | Yes :octagonal_sign: | The CDS modifies the statements in this clause as follows: 
| | | | - *Item 1:* Public Clients are [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#oidc-client-types) |
| | | | - *Item 4 (1)*: Mutual TLS for OAuth Client Authentication is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) |
| | | | - *Item 4 (2):* `client_secret_jwt` is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
| | | | - *Item 4 (2):*  `private_key_jwt` is [**REQUIRED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
|  [5.2.2.1. Returning authenticated user's identifier Authorization server](https://openid.net/specs/openid-financial-api-part-1.html#returning-authenticated-users-identifier-authorization-server) | No | N/A | |
|  [5.2.3. Public client](https://openid.net/specs/openid-financial-api-part-1.html#public-client) | Yes | Yes :octagonal_sign: | Public Clients are [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#oidc-client-types) |
|  [5.2.4. Confidential client](https://openid.net/specs/openid-financial-api-part-1.html#confidential-client) | Yes | Yes :octagonal_sign: |  - Mutual TLS for OAuth Client Authentication is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#client-authentication) |
| | | | - `client_secret_jwt` is [**NOT SUPPORTED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
| | | | - `private_key_jwt` is [**REQUIRED**](https://consumerdatastandardsaustralia.github.io/standards/#authentication-flows) |
|  [6. Accessing Protected Resources](https://openid.net/specs/openid-financial-api-part-1.html#accessing-protected-resources) | No | N/A |  |
|  [6.1. Introduction](https://openid.net/specs/openid-financial-api-part-1.html#introduction-2) | No | N/A |  |
|  [6.2. Read-only access provisions](https://openid.net/specs/openid-financial-api-part-1.html#read-only-access-provisions) | No | N/A |  |
|  [6.2.1. Protected resources provisions](https://openid.net/specs/openid-financial-api-part-1.html#protected-resources-provisions) | Yes | Yes :octagonal_sign: | The following alterations to this clause are made within the [CDS Headers](https://consumerdatastandardsaustralia.github.io/standards/#http-headers) specification: |
| | | | - *Item 9:* Standards **DO NOT** set an explicit charset |
| | | | - *Item 10*: Standards **DO NOT** require the HTTP Date header |
| | | | - *Item 13*: CORS headers **ARE NOT** specified |
|  [6.2.2. Client provisions](https://openid.net/specs/openid-financial-api-part-1.html#client-provisions) | Yes | Yes | The following alterations to this clause are made within the [CDS Headers](https://consumerdatastandardsaustralia.github.io/standards/#http-headers) specification: |
| | | | - 3. `x-fapi-auth-date` is **MANDATORY** for all authenticated calls |
| | | | - 4. `x-fapi-customer-ip-address` is **MANDATORY** for attended callsand is tied to [CDS Performance Requirements](https://consumerdatastandardsaustralia.github.io/standards/#performance-requirements) |
| | | | - 5. `x-fapi-interaction-id` is **MANDATORY** |
|  [7. Security considerations](https://openid.net/specs/openid-financial-api-part-1.html#security-considerations) | No | N/A |  |
|  [7.1. TLS considerations](https://openid.net/specs/openid-financial-api-part-1.html#tls-considerations) | Yes | No | CDS [guidance on TLS](https://consumerdatastandardsaustralia.github.io/standards/#transaction-security) requirements is aligned with this clause |
|  [7.2. Message source authentication failure](https://openid.net/specs/openid-financial-api-part-1.html#message-source-authentication-failure) | Yes | No | CDS [guidance on Request Object](https://consumerdatastandardsaustralia.github.io/standards/#request-object) appears to be aligned with this clause |
|  [7.3. Message integrity protection failure](https://openid.net/specs/openid-financial-api-part-1.html#message-integrity-protection-failure) | Yes | No | CDS [guidance on Request Object](https://consumerdatastandardsaustralia.github.io/standards/#request-object) appears to be aligned with this clause |
|  [7.4. Message containment failure](https://openid.net/specs/openid-financial-api-part-1.html#message-containment-failure) | Yes | No | It is understood that ID Token requests are JOSE encapsulated and encrypted using JWE. CDS guidance on this is provided in the [Tokens section](https://consumerdatastandardsaustralia.github.io/standards/#tokens) specifically *"ID Tokens must be signed and encrypted when returned to a Data Recipient from both the Authorisation End Point and Token End Point."* |
|  [7.4.1. Authorization request and response](https://openid.net/specs/openid-financial-api-part-1.html#authorization-request-and-response) | No | N/A |  |
|  [7.4.2. Token request and response](https://openid.net/specs/openid-financial-api-part-1.html#token-request-and-response) | No | N/A |  |
|  [7.4.3. Resource request and response](https://openid.net/specs/openid-financial-api-part-1.html#resource-request-and-response) | No | N/A |  |
|  [7.5. Native Apps](https://openid.net/specs/openid-financial-api-part-1.html#native-apps) | Implicit | Unknown :question: | Although not explicitly stated it is understood the CDS does not support Native Apps |
|  [7.6. Incomplete or incorrect implementations of the specifications](https://openid.net/specs/openid-financial-api-part-1.html#incomplete-or-incorrect-implementations-of-the-specifications) | Implicit | Yes :octagonal_sign: | The changes outlined result in incomplete implementations of the upstream specification: |
| | | | *"To achieve the full security benefits, it is important the implementation of this specification, and the underlying OpenID Connect and OAuth specifications, are both complete and correct."* |
|  [8. Privacy considerations](https://openid.net/specs/openid-financial-api-part-1.html#privacy-considerations) | No | N/A |  |
|  [8.1. Privacy by design](https://openid.net/specs/openid-financial-api-part-1.html#privacy-by-design) | No | N/A | *"Privacy impact analysis (PIA) should be performed in the initial phase of the system planning."* |
|  [8.2. Adhering to privacy principles](https://openid.net/specs/openid-financial-api-part-1.html#adhering-to-privacy-principles) | No | N/A | Noteworthy: *"Where the data is no longer being used, clients should delete such data from their system within 180 days except for the cases where it needs to be retained due to legal restrictions;"* |
