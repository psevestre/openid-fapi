# How the CDS differs from International Standards and Specifications

This document summarises the differences of the proposed [Consumer Data Standards](https://consumerdatastandardsaustralia.github.io/standards/) and [ACCC Register](https://cdr-register.github.io/register/) when compared against the international standards and specifications they seek to adopt. The Consumer Data Standards are the underlying technical standards currently being developed to deliver on the Australian Government's Consumer Data Right legislation, which was passed 1 August 2019. The ACCC is the lead regulator of the [Consumer Data Right](https://www.accc.gov.au/focus-areas/consumer-data-right-cdr-0).

This document has been put together to summarise and provide reporting back to the [OpenID FAPI Working Group](https://openid.net/wg/fapi/). It is split between breaking changes, non-spec compliant but believed to be non-breaking and changes which could be seen as Australia's "Profile" related changes.

## Summary of Observations

The CDS makes a number of changes to globally adopted specifications. In addition observations which may compromise the overall security of the ecosystem are also summarised.

### Breaking Changes

#### Consumer Data Standards

The following are the list of modifications made which have known breaking impacts on certified implementations:

* Explicit removal (and *banning*) of `iss` from Request Object specification:
  
  *Genesis of this change appears to be [here](https://bitbucket.org/openid/fapi/issues/190/aud-iss-should-be-mandatory-in-requests). This had a comment first of `aud` and `iss` being mandatory then a comment later discussing the removal of `iss` claim due to `client_id` being same. Potential compatibility issues were asked by WG member but the thread was focused on making aud mandatory.*

  * [FAPI-RW 8.3.3](fapi-part2.md#8.3.3): Removal of `iss` reintroduces mitigation for Identity Provider (IdP) mix-up attack
  * [OAuth2 JWT Profile Section 3](oauth2-jwt-profile-rfc7523.md#3): Use of `client-id` as a substitute for `iss` (as directed) is likely to cause required format validation failures
  * [OIDC Core 5.7 Claim Stability](oidc-core-1.0.md#5.7): Use of `client-id` as a substitute means `client_id`+`sub` which increases chance of collision
  * [OIDC Core 3.3.2.2 Authentication Request Validation](oidc-core-1.0.md#3.3.2.2): With no separation of `client_id` from `iss`, third-party login handling (ie. delegated auth handler) is not possible
  * [OIDC Core 7 Self-Issued OP](oidc-core-1.0.md#7): Self-Issued OP is not possible without `iss`
  * [OIDC Discovery 4.3 OpenID Provider Configuration](oidc-discovery-1.0.md#4.3): Validation of `issuer` element from Discovery document is tied to `iss` and therefore not possible
* `vot` claim has been modified from String[] (array of String) to simply String
    * All `vot` responses will be invalid format
* `request_uri` has been removed from Request Object:
    * This is a *Mandatory to Implement* for [Dynamic OP within OpenID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html#DynamicMTI)
    * This changes the default value at `/.well-known/openid-configuration`
    * [6.2. Passing a Request Object by Reference](https://openid.net/specs/openid-connect-core-1_0.html#RequestUriParameter) is not possible

* `client_id` is missing in example token responses (and not mentioned as required):
  * [OAuth2 Framework 3.2.1 Client Authentication](oauth2-framework-rfc6749.md#3.2.1): This disables substitution attack protections

**Final Note:** The specification is not in a format similar to IETF or OpenID. Identifying what changes from upstream specifications has been very challenging and involved line by line analysis. **Adopting a standardised documentation method similar to these existing formats would be more consistent with a typical Implementors Draft and preferred.**

#### ACCC Register

The current proposed design of the Register is to provide a complete "data dump" of all participants to be loaded statically into participants auth packages. This is expected to be checked for validity based on a "cache refresh time" that is currently being debated but thought to be <4hrs.

The JWKS provided by the register is:

* Intended to be a single text field containing a flattened JSON of the entire JWKS
* Not intended to be signed or encrypted, ie. has no integrity protection beyond layer-3 TLS establishment

### Non-Spec Compliant Changes

The following are a list of modifications which are divergent from their specification and may or may not be breaking but are notable:

* Introspection methods modified:
  * Introspection of Access Tokens is not allowed
  * Introspection of ID Tokens is not allowed
  * Introspection of Refresh Tokens is allowed but may ONLY include `active` and `exp` claims and no others
* `scope` is NOT A REQUIRED parameter in token requests with no guidance on the default value
  * Lack of default value guidance means behaviour is unknown
* `profile` scope MUST be supported (but `scope` isn't required) 
* OAUTB support is REMOVED
* JWT Secured Authorization Response Mode is NOT SUPPORTED

   * JARM was recommended by an Independent Security Review but not adopted on basis of ["Due to the need to understand the impacts of this recommendation it will not be incorporated into the standards at this stage but will be considered for incorporation in the next phase of the regime"](https://github.com/ConsumerDataStandardsAustralia/standards/issues/78)

* `jwks_uri` based key rotation is not possible as ACCC is Static Registration only
* Mandatory to Implement components of OpenID Core have been modified:
  * Parameter's for OP not implemented: `prompt`, `display` and `max_age`
  * Locale Support is not implemented
  * (Repeated) request_uri has been removed from Request Object which breaks [Dynamic OP within OpenID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html#DynamicMTI)
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

### Profile Based Changes

The following is a list of modifications which while different from the upstream specification could be justified as of a "situational" nature and aren't believed to break existing implementations:

* Public Client support is REMOVED
* Mutual TLS for OAuth Client is REMOVED
* `client_secret_jwt` support is REMOVED
* MISSING explicit charset header
* MISSING explicit HTTP Date header
* CORS headers are NOT SPECIFIED
* `x-fapi-auth-date` is altered to MANDATORY
* `x-fapi-customer-ip-address` is altered to MANDATORY when a business rule of customer presence (versus unattended) is true
* `x-fapi-interaction-id` is altered to MANDATORY
* Response type of `code id_token token` is REMOVED
* Signed only token support is REMOVED (`Sign`+`Encrypt` only)
* `typ` header is MANDATORY and expected to ALWAYS be *JOSE*
* Unregistered (but common) `refresh_token_expires_at` claim is MANDATORY for ongoing consent (ie. not once off)
* Unregistered and New `sharing_expires_at` claim is ADDED and is MANDATORY for ongoing consent (ie. not once off)
* `expires_in` claim changed to MANDATORY
* `refresh_token_expires_in` claim changed to MANDATORY
* `sharing_expires_in` claim is CREATED, is unregistered and does not comply with collision avoidance rules (See RFC6749 *8.2 Defining New Endpoint Parameters*)
* JWT Client Authorization Grants are DISABLED
* `s_hash` is MANDATORY which means `state` in the Request Object is MANDATORY
* `nonce` is MANDATORY which means `nonce` in the Request Object is MANDATORY
* `acr` is MANDATORY unless LoA `vot` and `vtm` claims are provided
* `acr` claim format is a CUSTOM URN of `urn:cds.au:cdr:#`
* ID Token's must be `Sign`+`Encrypt` ONLY
* `prompt` is OPTIONAL but Consent is always expected
* `updated_at` claim within ID Token is MANDATORY
* `sharing_expires_at` claim has been ADDED for CDS consent management and is MANDATORY

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

