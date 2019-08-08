# How the CDS differs from International Standards and Specifications

This document summarises the differences of the proposed [Consumer Data Standards](https://consumerdatastandardsaustralia.github.io/standards/) and [ACCC Register](https://cdr-register.github.io/register/) when compared against the international standards and specifications they seek to adopt. The Consumer Data Standards are the underlying technical standards currently being developed to deliver on the Australian Government's Consumer Data Right legislation, which was passed 1 August 2019. The ACCC is the lead regulator of the [Consumer Data Right](https://www.accc.gov.au/focus-areas/consumer-data-right-cdr-0).

This document has been put together to summarise and provide reporting back to the [OpenID FAPI Working Group](https://openid.net/wg/fapi/).

## Summary of Observations

The CDS makes a number of changes to globally adopted specifications. In addition observations which may compromise the overall security of the ecosystem are also summarised.

### Financial-grade API - Part 1 & Part 2

The following changes have been made to the FAPI-R & FAPI-RW profiles:

* Public Client support is REMOVED
* Mutual TLS for OAuth Client is REMOVED
* `client_secret_jwt` support is REMOVED
* MISSING explicit charset header
* MISSING explicit HTTP Date header
* CORS headers are NOT SPECIFIED
* `x-fapi-auth-date` is altered to MANDATORY
* `x-fapi-customer-ip-address` is altered to MANDATORY when a business rule of customer presence (versus unattended) is true
* `x-fapi-interaction-id` is altered to MANDATORY
* Request Object Endpoint (`request_uri`) support is REMOVED
* Response type of `code id_token token` is REMOVED
* OAUTB support is REMOVED
* Signed only token support is REMOVED (`Sign`+`Verify` only)
* JWT Secured Authorization Response Mode is NOT SUPPORTED
* Request Object REMOVES `iss` value EXPOSING participants to Identity Provider (IdP) mix-up attack as described in 8.3.3

### JSON Web Key (JWK), Web Signature (JWS), Web Token (JWT)

The following observations have been made that impact JWK, JWS and/or JWT specifications:

* JSON Web Key's are intended to be shipped by the ACCC Register as an unvalidated text field containing JSON data intended to be in JWKS format
* No tamper protection is intended over the custom metadata API from the ACCC Register (see JWK 9.1. Key Provenance and Trust and JWS 10.3 Key Origin Authentication)
* ~~`kid` is MANDATORY and specified to be the SAME as the `client-id` parameter~~ 07/08/19: Incorrect statement 
* `typ` header is MANDATORY and expected to ALWAYS be *JOSE*
* Unregistered (but common) `refresh_token_expires_at` claim is MANDATORY for ongoing consent (ie. not once off)
* Unregistered and New `sharing_expires_at` claim is ADDED and is MANDATORY for ongoing consent (ie. not once off)

### OAuth 2.0 Authorization Framework, JWT Profile, Token Introspection

The following observations have been made that introduce altered behaviour of the OAuth2 suite of specifications:

* `client_id` is REMOVED in token response examples (disabling Substitution Attack protections)
* `scope` is NOT A REQUIRED parameter in token requests with no guidance on the default value
* `expires_in` claim changed to MANDATORY
* `refresh_token_expires_in` claim changed to MANDATORY
* `sharing_expires_in` claim is CREATED, is unregistered and does not comply with collision avoidance rules (See RFC6749 *8.2 Defining New Endpoint Parameters*)
* `iss` is specified as analgous with `client-id` which will cause *JWT Format and Processing Requirements* to fail
* JWT Client Authorization Grants are DISABLED
* Token introspection is NOT ALLOWED on ID Token or Access Token
* Only `active` and `exp` claims are permitted within Introspection responses. ALL other claims are explicitly REMOVED

### OpenID Connect Core, Registration, VoT

The following observations of changes to the OpenID Connect specifications (and OpenID provisions within the VoT specification) have been observed:

* `s_hash` is MANDATORY which means `state` in the Request Object is MANDATORY
* `nonce` is MANDATORY which means `nonce` in the Request Object is MANDATORY
* `acr` is MANDATORY unless LoA `vot` and `vtm` claims are provided
* `acr` claim format is a CUSTOM URN of `urn:cds.au:cdr:#`
* ID Token's must be `Sign`+`Encrypt` ONLY
* Request Object explicitly REMOVES `iss` claim indicating that substitution with `client-id` is sufficient
* `iss` removal breaks third-party login support (See OIDC Core 3.3.2.2 and OIDC Core 4)
* `prompt` is OPTIONAL but Consent is always expected
* Standard Claims are ALTERED because the ID Token MUST NOT provide Personally Identifiable claims
* `updated_at` claim within ID Token is MANDATORY
* `sharing_expires_at` claim has been ADDED for CDS consent management and is MANDATORY
* The scope of `profile` MUST be supported
* `iss` claim is SPECIFIED as being equal to `client-id` which potentially affects Claim Stability and Uniqueness (see OIDC Core 5.7)
* `request_uri` has been EXPLICITLY REMOVED from the Request Object disabling Passing a Request Object by Reference (see OIDC Core 6.2)
* `iss` alteration disables support for Self-Issued OP (see OIDC Core 7)
* `jwks_uri` based key rotation is not possible as ACCC is Static Registration only
* MTI Parameter's for OP not implemented: `prompt`, `display` and `max_age`
* MTI of Locale Support is not implemented
* MTI for Dynamic OP is not possible to achieve as CDS removes `request_uri` claim from Request Object
* The `vot` claim value has been MODIFIED from a String[] to a String

### OpenID Connect Discovery

The following observations of changes/impacts to the OpenID Connect Discovery specification have been observed. The CDS does NOT explicitly support OIDC Discovery but does require publishing of the `.well-known/openid-configuration` endpoint. Changes on this endpoint and other components are as follows:

* `request_uri` claim support is DISABLED and is required for Dynamic OP
* The `/.well-known/openid-configuration` endpoint is modified as follows:
  *  `userinfo_endpoint` is MANDATORY
  *  `scopes_supported` is MANDATORY
  *  `acr_values_supported` is MANDATORY
  *  `vot_values_supported` is MANDATORY
  *  `claims_supported` is MANDATORY
  *  `response_types_supported` is OPTIONAL
  *  `subject_types_supported` is OPTIONAL
  *  `id_token_signing_alg_values_supported` is OPTIONAL
  *  `introspection_endpoint` has been CREATED and is MANDATORY
  *  `revocation_endpoint` has been CREATED and is MANDATORY
  *  `request_uri_parameter_supported` has it's default value IMPLICITLY changed to `false` because `request_uri` is globally DISABLED
*  `issuer` may not pass validation (or validation may need to be DISABLED) because of the removal of the `iss` claim from the Request Object

## Corrections

The author(s) welcome corrections to the above statements either via a Pull Request or by opening an issue on this repository.

## Detailed Reviews

The following table provides a summary of the specifications and standards reviewed as part of this summary:

|  Specification Name | Specification Source | Review Document |
| --- | --- | --- |
| Financial-grade API - Part 1: Read-Only API Security Profile | [https://openid.net/specs/openid-financial-api-part-1.html](https://openid.net/specs/openid-financial-api-part-1.html) | [fapi-part1.md](fapi-part1.md) |
| Financial-grade API - Part 2: Read and Write API Security Profile | [https://openid.net/specs/openid-financial-api-part-2.html](https://openid.net/specs/openid-financial-api-part-2.html) | [fapi-part2.md](fapi-part2.md) |
| JSON Web Key (JWK) | [https://tools.ietf.org/html/rfc7517](https://tools.ietf.org/html/rfc7517) | [json-web-key-rfc7517.md](json-web-key-rfc7517.md) |
| JSON Web Algorithms (JWA) | [https://tools.ietf.org/html/rfc7518](https://tools.ietf.org/html/rfc7518) | [jwa-rfc7518.md](jwa-rfc7518.md) |
| JSON Web Signature (JWS) | [https://tools.ietf.org/html/rfc7515](https://tools.ietf.org/html/rfc7515) | [jws-rfc7515.md](jws-rfc7515.md) |
| JSON Web Token (JWT) | [https://tools.ietf.org/html/rfc7519](https://tools.ietf.org/html/rfc7519) | [jwt-rfc7519.md](jwt-rfc7519.md) |
| The OAuth 2.0 Authorization Framework | [https://tools.ietf.org/html/rfc6749](https://tools.ietf.org/html/rfc6749) | [oauth2-framework-rfc6749.md](oauth2-framework-rfc6749.md) |
| JSON Web Token (JWT) Profile for OAuth 2.0 Client Authentication and Authorization Grants | [https://tools.ietf.org/html/rfc7523](https://tools.ietf.org/html/rfc7523) | [oauth2-jwt-profile-rfc7523.md](oauth2-jwt-profile-rfc7523.md) |
| OAuth 2.0 Token Introspection | [https://tools.ietf.org/html/rfc7662](https://tools.ietf.org/html/rfc7662) | [oauth2-token-introspection-rfc7662.md](oauth2-token-introspection-rfc7662.md) |
| OpenID Connect Core 1.0 incorporating errata set 1 | [https://openid.net/specs/openid-connect-core-1_0.html](https://openid.net/specs/openid-connect-core-1_0.html) | [oidc-core-1.0.md](oidc-core-1.0.md) |
| OpenID Connect Discovery 1.0 incorporating errata set 1 | [https://openid.net/specs/openid-connect-discovery-1_0.html](https://openid.net/specs/openid-connect-discovery-1_0.html) | [oidc-discovery-1.0.md](oidc-discovery-1.0.md) |
| OpenID Connect Dynamic Client Registration 1.0 incorporating errata set 1 | [https://openid.net/specs/openid-connect-registration-1_0.html](https://openid.net/specs/openid-connect-registration-1_0.html) | [oidc-registration-1.0.md](oidc-registration-1.0.md) |
| Vectors of Trust | [https://tools.ietf.org/html/rfc8485](https://tools.ietf.org/html/rfc8485) | [vot-rfc8485.md](vot-rfc8485.md) |

