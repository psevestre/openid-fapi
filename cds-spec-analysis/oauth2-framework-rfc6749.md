# OAuth 2.0 Authorization Framework Comparison

The following provides a clause by clause breakdown comparing [The OAuth 2.0 Authorization Framework Comparison](https://tools.ietf.org/html/rfc6749) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards). 

|  **https://tools.ietf.org/html/rfc6749** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
| [1. Introduction](https://tools.ietf.org/html/rfc6749#section-1) | Yes | Yes :warning: | The CDS relies on OAuth 2.0 as a baseline framework that is then overlaid with a combination of international standards (such as JWT/JWS/JWK), OpenID Connect specifications, an internationally adopted security profile (FAPI), an internationally adopted client flow model (Hybrid Flow) and localised modifications targeted at meeting the Australian requirements. For this reason there are a number of cascading changes to the baseline OAuth 2 Framework and where possible their source has been noted. |
| [1.1. Roles](https://tools.ietf.org/html/rfc6749#section-1.1) | No | N/A |  |
| [1.2. Protocol Flow](https://tools.ietf.org/html/rfc6749#section-1.2) | No | N/A |  |
| [1.3. Authorization Grant](https://tools.ietf.org/html/rfc6749#section-1.3) | Implicit | No | The CDS adopts a [Hybrid Flow model from the OpenID Connect Core specification](https://openid.net/specs/openid-connect-core-1_0.html#HybridFlowSteps) which uses the `authorization_code` grant type. For interactions not involving CDR consumers the CDS uses `client_credentials` authorisation grant. |
| [1.3.1. Authorization Code](https://tools.ietf.org/html/rfc6749#section-1.3.1) | No | N/A | `authorization_code` is used as part of the Hybrid Flow model adopted by the CDS |
| [1.3.2. Implicit](https://tools.ietf.org/html/rfc6749#section-1.3.2) | Yes | No | `implicit` grant type is **NOT SUPPORTED** |
| [1.3.3. Resource Owner Password Credentials](https://tools.ietf.org/html/rfc6749#section-1.3.3) | Yes | No | `password_credentials` grant type is **NOT SUPPORTED** |
| [1.3.4. Client Credentials](https://tools.ietf.org/html/rfc6749#section-1.3.4) | No | N/A | `client_credentials` grant type is used for interactions which are not associated with CDR Consumers. For example interactions with the CDR Registry for monitoring information etc. |
| [1.4. Access Token](https://tools.ietf.org/html/rfc6749#section-1.4) | Implicit | No | Bearer based access tokens are used |
| [1.5. Refresh Token](https://tools.ietf.org/html/rfc6749#section-1.5) | Implicit | No | CDS uses Refresh Token's which are issued with a validity of between 28 days and the maximum consent period of the CDR Consumer (up to 365 days). Key rotation is noted but not specified. |
| [1.6. TLS Version](https://tools.ietf.org/html/rfc6749#section-1.6) | Yes | No | TLS 1.2 has been declared |
| [1.7. HTTP Redirections](https://tools.ietf.org/html/rfc6749#section-1.7) | Implicit | No :warning: | 302 Redirects are used extensively but are [not a documented response code](https://consumerdatastandardsaustralia.github.io/standards/#http-response-codes) within the CDS specification |
| [1.8. Interoperability](https://tools.ietf.org/html/rfc6749#section-1.8) | No | N/A |  |
| [1.9 Notational Conventions](https://tools.ietf.org/html/rfc6749#section-1.9) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
| [2. Client Registration](https://tools.ietf.org/html/rfc6749#section-2) | Implicit | No | Client Registration is handled by ACCC Register |
| [2.1. Client Types](https://tools.ietf.org/html/rfc6749#section-2.1) | Implicit | No | The CDS Standards support only `Confidential` client types. For the purposes of accuracy the use case intended for use by the CDS is a `web application` |
| [2.2. Client Identifier](https://tools.ietf.org/html/rfc6749#section-2.2) | Implicit | Yes | Client Identifiers are expected to be issued by the OP following the presentation of a Register signed SSA by the RP to the OP via the Registration endpoint. |
| [2.3. Client Authentication](https://tools.ietf.org/html/rfc6749#section-2.3) | Implicit | N/A | Confidential client secured by MTLS |
| [2.3.1. Client Password](https://tools.ietf.org/html/rfc6749#section-2.3.1) | Implicit | N/A | Hybrid Flow disables `Client Password` based authentication |
| [2.3.2. Other Authentication Methods](https://tools.ietf.org/html/rfc6749#section-2.3.2) | Implicit | N/A | Hybrid Flow does not support other authentication methods |
| [2.4. Unregistered Clients](https://tools.ietf.org/html/rfc6749#section-2.4) | Yes | No | CDS requires all clients to be registered by proxy of only supporting `Confidential` clients |
| [3. Protocol Endpoints](https://tools.ietf.org/html/rfc6749#section-3) | Yes | N/A | CDS Standards specify authorization and token endpoints |
| [3.1. Authorization Endpoint](https://tools.ietf.org/html/rfc6749#section-3.1) | Yes | N/A |  |
| [3.1.1. Response Type](https://tools.ietf.org/html/rfc6749#section-3.1.1) | Yes | Yes :warning: | CDS uses the Hybrid Flow model defined by the OpenID Connect Core specification. CDS further constrains this model to EXCLUSIVELY support only `code id_token` response types |
| [3.1.2. Redirection Endpoint](https://tools.ietf.org/html/rfc6749#section-3.1.2) | Implicit | No | The `redirect_uri` is required as part of the OpenID Connect Core [authentication request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest). |
| [3.2. Token Endpoint](https://tools.ietf.org/html/rfc6749#section-3.2) | No | N/A |  |
| [3.2.1. Client Authentication](https://tools.ietf.org/html/rfc6749#section-3.2.1) | Yes | No |  |
| [3.3. Access Token Scope](https://tools.ietf.org/html/rfc6749#section-3.3) | Yes | No | |
| [4. Obtaining Authorization](https://tools.ietf.org/html/rfc6749#section-4) | Implicit | N/A |  |
| [4.1. Authorization Code Grant](https://tools.ietf.org/html/rfc6749#section-4.1) | Implicit | No | CDS use `code` + `id_token` as part of the [hybrid flow model](https://openid.net/specs/openid-connect-core-1_0.html#HybridFlowAuth) inherited from the OpenID Connect Core specification. |
| [4.1.1. Authorization Request](https://tools.ietf.org/html/rfc6749#section-4.1.1) | Implicit | No |  |
| [4.1.2. Authorization Response](https://tools.ietf.org/html/rfc6749#section-4.1.2) | Implicit | No |  |
| [4.1.3. Access Token Request](https://tools.ietf.org/html/rfc6749#section-4.1.3) | Implicit | No |  |
| [4.1.4. Access Token Response](https://tools.ietf.org/html/rfc6749#section-4.1.4) | Implicit | No |  |
| [4.2. Implicit Grant](https://tools.ietf.org/html/rfc6749#section-4.2) | Yes | No | `implicit` grant support **IS NOT** supported |
| [4.2.1. Authorization Request](https://tools.ietf.org/html/rfc6749#section-4.2.1) | No | N/A |  |
| [4.2.2. Access Token Response](https://tools.ietf.org/html/rfc6749#section-4.2.2) | No | N/A |  |
| [4.3. Resource Owner Password Credentials Grant](https://tools.ietf.org/html/rfc6749#section-4.3) | Yes | N | `password_credentials` grant support **IS NOT** supported |
| [4.3.1. Authorization Request and Response](https://tools.ietf.org/html/rfc6749#section-4.3.1) | No | N/A |  |
| [4.3.2. Access Token Request](https://tools.ietf.org/html/rfc6749#section-4.3.2) | No | N/A |  |
| [4.3.3. Access Token Response](https://tools.ietf.org/html/rfc6749#section-4.3.3) | No | N/A |  |
| [4.4. Client Credentials Grant](https://tools.ietf.org/html/rfc6749#section-4.4) | Yes | No | `client_credentials` are used for non CDR Consumer grants, such as those from the ACCC Register. |
| [4.4.1. Authorization Request and Response](https://tools.ietf.org/html/rfc6749#section-4.4.1) | No | N/A |  |
| [4.4.2. Access Token Request](https://tools.ietf.org/html/rfc6749#section-4.4.2) | No | N/A |  |
| [4.4.3. Access Token Response](https://tools.ietf.org/html/rfc6749#section-4.4.3) | No | N/A |  |
| [4.5. Extension Grants](https://tools.ietf.org/html/rfc6749#section-4.5) | Implicit | No | `id_token` extension is grant is introduced as part of the OpenID Connect Core hybrid flow process |
| [5. Issuing an Access Token](https://tools.ietf.org/html/rfc6749#section-5) | No | N/A |  |
| [5.1. Successful Response](https://tools.ietf.org/html/rfc6749#section-5.1) | Yes | Yes :octagonal_sign: | CDS introduces additional claim requirements for token responses including: |
| | | | - `expires_in` is **MANDATORY** |
| | | | - `refresh_token_expires_at` is **MANDATORY** for requests intended to be continuous consent requests |
| [5.2. Error Response](https://tools.ietf.org/html/rfc6749#section-5.2) | No | N/A |  |
| [6. Refreshing an Access Token](https://tools.ietf.org/html/rfc6749#section-6) | Implicit | N/A | Default `/token` endpoint behaviour is assumed |
| [7. Accessing Protected Resources](https://tools.ietf.org/html/rfc6749#section-7) | Implicit | N/A |  |
| [7.1. Access Token Types](https://tools.ietf.org/html/rfc6749#section-7.1) | Implicit | No | While not documented it is assumed the CDS uses `bearer` access token types |
| [7.2. Error Response](https://tools.ietf.org/html/rfc6749#section-7.2) | Implicit | No| Error Responses are not documented. Assuming these are to RFC spec |
| [8. Extensibility](https://tools.ietf.org/html/rfc6749#section-8) | Yes | No| OpenID Connect Core introduces Hybrid Flow which in-turn utilises the extensibility methods defined in this standard. Additionally the CDS introduces new endpoint parameters |
| [8.1. Defining Access Token Types](https://tools.ietf.org/html/rfc6749#section-8.1) | Implicit| N/A |  |
| [8.2. Defining New Endpoint Parameters](https://tools.ietf.org/html/rfc6749#section-8.2) | Yes | Yes :octagonal_sign: | `sharing_expires_at` is introduced but is not registered nor does it follow collision avoidance specifications within this clause |
| [8.3. Defining New Authorization Grant Types](https://tools.ietf.org/html/rfc6749#section-8.3) | Implicit | No | Hybrid Flow introduces `id_token` grant type |
| [8.4. Defining New Endpoint Response Types](https://tools.ietf.org/html/rfc6749#section-8.4) | No | N/A |  |
| [8.5. Defining Additional Error Codes](https://tools.ietf.org/html/rfc6749#section-8.5) | No | N/A |  |
| [9. Native Applications](https://tools.ietf.org/html/rfc6749#section-9) | Yes | No | Native clients **ARE NOT** supported by the CDS |
| [10. Security Considerations](https://tools.ietf.org/html/rfc6749#section-10) | Implicit | N/A | It is assumed these are adopted wholesale by the CDS |
| [10.1. Client Authentication](https://tools.ietf.org/html/rfc6749#section-10.1) | Implicit | N/A |  |
| [10.2. Client Impersonation](https://tools.ietf.org/html/rfc6749#section-10.2) | Implicit | N/A |  |
| [10.3. Access Tokens](https://tools.ietf.org/html/rfc6749#section-10.3) | Implicit | N/A |  |
| [10.4. Refresh Tokens](https://tools.ietf.org/html/rfc6749#section-10.4) | Implicit | N/A |  |
| [10.5. Authorization Codes](https://tools.ietf.org/html/rfc6749#section-10.5) | Implicit | N/A |  |
| [10.6. Authorization Code Redirection URI Manipulation](https://tools.ietf.org/html/rfc6749#section-10.6) | Implicit | N/A |  |
| [10.7. Resource Owner Password Credentials](https://tools.ietf.org/html/rfc6749#section-10.7) | Implicit | N/A |  |
| [10.8. Request Confidentiality](https://tools.ietf.org/html/rfc6749#section-10.8) | Implicit | N/A |  |
| [10.9. Ensuring Endpoint Authenticity](https://tools.ietf.org/html/rfc6749#section-10.9) | Yes | Yes :question: | [Discussion is occurring](https://github.com/ConsumerDataStandardsAustralia/standards-maintenance/issues/95) about what the approach for TLS certificate verification should be. |
| [10.10. Credentials-Guessing Attacks](https://tools.ietf.org/html/rfc6749#section-10.10) | No | N/A | It is assumed these risks are managed by OP's (aka Data Holders) |
| [10.11. Phishing Attacks](https://tools.ietf.org/html/rfc6749#section-10.11) | No | N/A |  |
| [10.12. Cross-Site Request Forgery](https://tools.ietf.org/html/rfc6749#section-10.12) | No | N/A | |
| [10.13. Clickjacking](https://tools.ietf.org/html/rfc6749#section-10.13) | No | N/A |  |
| [10.14. Code Injection and Input Validation](https://tools.ietf.org/html/rfc6749#section-10.14) | No | N/A |  |
| [10.15. Open Redirectors](https://tools.ietf.org/html/rfc6749#section-10.15) | No | N/A |  |
| [10.16. Misuse of Access Token to Impersonate Resource Owner in Implicit Flow](https://tools.ietf.org/html/rfc6749#section-10.16) | No | N/A |  |
| [11. IANA Considerations](https://tools.ietf.org/html/rfc6749#section-11) | Yes | Yes :octagonal_sign: | Injected claims should be registered via IANA registries |
| [11.1. OAuth Access Token Types Registry](https://tools.ietf.org/html/rfc6749#section-11.1) | No | N/A |  |
| [11.1.1. Registration Template](https://tools.ietf.org/html/rfc6749#section-11.1.1) | No | N/A |  |
| [11.2. OAuth Parameters Registry](https://tools.ietf.org/html/rfc6749#section-11.2) | No | N/A |  |
| [11.2.1. Registration Template](https://tools.ietf.org/html/rfc6749#section-11.2.1) | No | N/A |  |
| [11.2.2. Initial Registry Contents](https://tools.ietf.org/html/rfc6749#section-11.2.2) | No | N/A |  |
| [11.3. OAuth Authorization Endpoint Response Types Registry](https://tools.ietf.org/html/rfc6749#section-11.3) | No | N/A |  |
| [11.3.1. Registration Template](https://tools.ietf.org/html/rfc6749#section-11.3.1) | No | N/A |  |
| [11.3.2. Initial Registry Contents](https://tools.ietf.org/html/rfc6749#section-11.3.2) | No | N/A |  |
| [11.4. OAuth Extensions Error Registry](https://tools.ietf.org/html/rfc6749#section-11.4) | No | N/A |  |
| [11.4.1. Registration Template](https://tools.ietf.org/html/rfc6749#section-11.4.1) | No | N/A |  |
| [12. References](https://tools.ietf.org/html/rfc6749#section-12) | No | N/A |  |
| [12.1. Normative References](https://tools.ietf.org/html/rfc6749#section-12.1) | No | N/A |  |
| [12.2. Informative References](https://tools.ietf.org/html/rfc6749#section-12.2) | No | N/A |  |
