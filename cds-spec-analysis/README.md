# How the CDS differs from International Standards and Specifications

**2019-01-22: Update in progress, please contact the mailing list if you wish to suggest alterations or corrections.**

This document summarises the differences of the proposed [Consumer Data Standards](https://consumerdatastandardsaustralia.github.io/standards/) when compared against the international standards and specifications they seek to adopt. The Consumer Data Standards are the underlying technical standards currently being developed to deliver on the Australian Government's Consumer Data Right legislation, which was passed 1 August 2019. The ACCC is the lead regulator of the [Consumer Data Right](https://www.accc.gov.au/focus-areas/consumer-data-right-cdr-0). The banking sector is the first of multiple industries intended, energy and telco being the next. 

This document has been put together to summarise and provide reporting back to the [OpenID FAPI Working Group](https://openid.net/wg/fapi/). It contains a set of specific comparisons for implementers to understand impacts of the CDS and a summary of changes split between breaking changes, non-spec compliant but believed to be non-breaking and changes which could be seen as Australia's "Profile" related changes.

This is intended to be a living document and as such the authors welcome any recommendations, changes or alterations. If you have alterations we welcome your feedback which can be sent via the FAPI WG Chair contactable at [openid-specs-fapi-owner@lists.openid.net](mailto:openid-specs-fapi-owner@lists.openid.net).

**Final Note:** The specification is not in a format similar to IETF or OpenID. Identifying what changes from upstream specifications has been very challenging and involved line by line analysis. **Adopting a standardised documentation method similar to these existing formats would be more consistent with a typical Implementors Draft and preferred.**

### Outcomes

Breaking changes documented here-in result in a number of outcomes, notably:

* Existing infrastructure cannot be reused requiring new (and therefore duplicated) builds to meet the desired requirements
* Unknown race conditions and/or security vulnerabilities may be introduced due to lack of international adoption, diverse testing and deployment. OpenID Connect is now over 5 years old and has 100s (possibly 1000s) of implementations worldwide. Within software development this is commonly referred to as [Linus's Law](https://en.wikipedia.org/wiki/Linus%27s_Law) whereby *"given enough eyeballs, all bugs are shallow"*
* [Interoperability](https://en.wikipedia.org/wiki/Interoperability) between implementations will, potentially significantly, be impacted. The result of this lack of interoperability has significant flow on effects with respect to software vendor diversity and competition
* [Existing certification processes](https://openid.net/certification/faq/) may be non-functional requiring a separate certification process to be established and maintained by the creating entity

## Scenario Impact Analysis

This section seeks to outline the impacts of implementing the CDS against existing implementations which are certified to OIDC or FAPI specifications. For the purposes of this section "OIDC" includes all relevent specifications in the OpenID Connect suite.

**PLEASE READ**: EACH of these scenarios is to be viewed **IN ISOLATION**. For instance, for `CDS -> OpenID Certification` if an implementer had a CDS conformant implementation an OpenID conformance check would fail because `request_uri_parameter_supported` default value has been changed. Conversely, for `OpenID -> CDS Validation` if an implementer had an OpenID conformant implementation a CDS conformance check would fail because `acr` claim is mandatory.

### CDS -> FAPI Certification

The following items, if implemented, appear likely to result in the failure of FAPI Conformance:

* ~~Signed ID Token's are **NOT SUPPORTED** in CDS which breaks FAPI Part 2 5.2.2 Item 8 which specifies signed only ID Token support as **MANDATORY**~~
    * *Note:* This has been removed following discussions at the FAPI WG meeting on 2020-01-22. The intent of the authors was to require at least signed tokens. Requiring signed+encrypted tokens is an ecosystem choice and while not explicitly required is not discouraged. The implementation of signed+encrypted appears to reduce the number of available libraries supporting JWS (15) to the number of libraries supporting JWE (6). Surprisingly this appears to preclude .NET implementations (ie. there does not appear to be a certified JWE implementation in .NET)
* HTTP Date Header's are **NOT REQUIRED**

### CDS -> OpenID Certification

The following items, if implemented, appear likely to result in the failure of OIDC Conformance:

* `request_uri` support is **removed** but is a Mandatory to Implement for Dynamic OP within OpenID Connect Core
    * *NOTE*: Some WG members have questioned whether the `request_uri` MTI is being enforced in other implementations now?
* Metadata response attribute `request_uri_parameter_supported` has had it's default altered to `false` and omitted from the discovery document
* Metadata response is altered with a number of items converted to **OPTIONAL**:
    * `response_types_supported`
    * `subject_types_supported`
    * `id_token_signing_alg_values_supported`
* Implementations supporting Claims Languages & Scripts. CDS **does not** support any language other than English (likely `en-AU`)

### FAPI -> CDS Validation

The following items are likely to result in existing FAPI certified implementations failing validation to the CDS:

* Public Clients are **NOT SUPPORTED**
* Mutual TLS for OAuth Client Authentication is **NOT SUPPORTED**
* `client_secret_jwt` support is **NOT SUPPORTED**
* `private_key_jwt` support is **MANDATORY**
* `request_uri` support is **NOT SUPPORTED**
* `response_type` of `code id_token token` is **NOT SUPPORTED**
* Detached Signature support is ambiguous as CDS Example does not appear to demonstrate them
* `s_hash` support is **MANDATORY**
* Signed only ID Tokens are **NOT SUPPORTED**
* Signed and Encrypted ID Tokens are **MANDATORY**
* Request Object Endpoint is **NOT SUPPORTED**
* `x-fapi-auth-date` is altered to **MANDATORY**
* `x-fapi-customer-ip-address` is altered to **MANDATORY**

### OpenID -> CDS Validation

The following items are likely to result in existing OIDC certified implementations failing validation to the CDS:

* Metadata response is altered with a number of items converted to **MANDATORY**:
    * `scopes_supported`
    * `acr_values_supported`
    * `claims_supported`
    * `userinfo_endpoint`: *NOTE*: This is aligned with OIDC for Dynamic OP
* Metadata response is altered with a number of items converted to **OPTIONAL**:
    * `response_types_supported`
    * `subject_types_supported`
    * `id_token_signing_alg_values_supported`
* Metadata response is altered with a number of items **ADDED** and made **MANDATORY**:
    * `introspection_endpoint`
    * `revocation_endpoint`
* Metadata response attribute `request_uri_parameter_supported` has had it's default altered to `false` and omitted from the discovery document
* `acr` claim is **MANDATORY** and therefore essential
* `acr` claim format is an explicit and unregistered claim value of `urn:cds.au:cdr:#` where # represents an LoA value of 2 or 3
* `state` and `nonce` claims are **MANDATORY** and therefore essential
* `c_hash` is **REQUIRED** in ID Token responses
* `updated_at` claim is **REQUIRED**
* Signed only ID Tokens are **NOT SUPPORTED**
* Signed and Encrypted ID Tokens are **MANDATORY**
* `response_type` **MUST** only be `code id_token`, no other response types are supported
* Address Claims are **NOT SUPPORTED**
* Introduction of **MANDATORY** unregistered and CDS specific claim of `sharing_expires_at`
* Claim Languages are not supported, all responses are assumed to be `en-AU`
* `profile` scope is **REQUIRED**
* `request_uri` is **NOT SUPPORTED**
* Certain *Mandatory to Implement* requirements are not supported:
    * `prompt` parameter
    * `display` parameter
    * Locale Support
    * `max_age` parameter


## Per Specification Modifications

The following are a list of modifications which are divergent from their specification.

### FAPI Part 1

* Public Clients are **NOT SUPPORTED**
* Mutual TLS for OAuth Client Authentication is **NOT SUPPORTED**
* `client_secret_jwt` support is **NOT SUPPORTED**
* `private_key_jwt` support is **MANDATORY**
* Charset specification in `Content-Type` header is **REMOVED**
* HTTP Date Header's are **NOT REQUIRED**
* `x-fapi-auth-date` is altered to **MANDATORY**
* `x-fapi-customer-ip-address` is altered to **MANDATORY**
* `x-cds-client-headers` has been added and is **OPTIONAL**

### FAPI Part 2

* Public Clients are **NOT SUPPORTED**
* Mutual TLS for OAuth Client Authentication is **NOT SUPPORTED**
* `client_secret_jwt` support is **NOT SUPPORTED**
* `private_key_jwt` support is **MANDATORY**
* `request_uri` support is **NOT SUPPORTED**
* `response_type` of `code id_token token` is **NOT SUPPORTED**
* Detached Signature support is ambiguous as CDS Example does not appear to demonstrate them
* `s_hash` support is **MANDATORY**
* OAUTB is **NOT SUPPORTED**
* Signed only ID Tokens are **NOT SUPPORTED**
* Signed and Encrypted ID Tokens are **MANDATORY**
* Request Object Endpoint is **NOT SUPPORTED**
* HTTP Date Header's are **NOT REQUIRED**
* `x-fapi-auth-date` is altered to **MANDATORY**
* `x-fapi-customer-ip-address` is altered to **MANDATORY**

### OpenID Connect Core 1.0 (Errata Set 1)

* `nonce` claim is **MANDATORY**
* `acr` claim is **MANDATORY** and therefore essential
* `acr` claim format is an explicit and unregistered claim value of `urn:cds.au:cdr:#` where # represents an LoA value of 2 or 3
* Signed only ID Tokens are **NOT SUPPORTED**
* Signed and Encrypted ID Tokens are **MANDATORY**
* `state` and `nonce` are **MANDATORY** within Request Object
* `response_type` **MUST** only be `code id_token`, no other response types are supported
* `prompt` parameter is **NOT REQUIRED**
* **REQUIRED** claim of `redirect_uri` is not documented (but perhaps assumed)
* `c_hash` is **REQUIRED** in ID Token responses
* `updated_at` claim is **REQUIRED**
* Address Claims are **NOT SUPPORTED**
* Introduction of **MANDATORY** unregistered and CDS specific claim of `sharing_expires_at`
* Claim Languages are not supported, all responses are assumed to be `en-AU`
* `profile` scope is **REQUIRED**
* `request_uri` is **NOT SUPPORTED**
* Certain *Mandatory to Implement* requirements are not supported:
    * `prompt` parameter
    * `display` parameter
    * Locale Support
    * `max_age` parameter

### OpenID Connect Discovery Comparison

* Discovery Endpoint is **MANDATORY** under CDS
* Metadata response is altered with a number of items converted to **MANDATORY**:
    * `userinfo_endpoint`
    * `scopes_supported`
    * `acr_values_supported`
    * `claims_supported`
* Metadata response is altered with a number of items converted to **OPTIONAL**:
    * `response_types_supported`
    * `subject_types_supported`
    * `id_token_signing_alg_values_supported`
* Metadata response is altered with a number of items **ADDED** and made **MANDATORY**:
    * `introspection_endpoint`
    * `revocation_endpoint`
* Metadata response attribute `request_uri_parameter_supported` has had it's default altered to `false` and omitted from the discovery document

### OAuth 2.0 Authorization Framework (RFC6749)

* `implicit` grant type is **NOT SUPPORTED**
* `password_credentials` grant type is **NOT SUPPORTED**
* `expires_in` claim is **MANDATORY**
* `refresh_token_expires_at` is **MANDATORY** for requests for continuous consent
* Native clients are **NOT SUPPORTED**
* *Ensuring Endpoint Authenticity* may be impacted by [ongoing discussion](https://github.com/ConsumerDataStandardsAustralia/standards-maintenance/issues/95)

### OAuth 2.0 Token Introspection

* Access Token introspection is **NOT SUPPORTED**
* ID Token introspection is **NOT SUPPORTED**
* Refresh Token introspection is **MANDATORY**
* Only `active` and `exp` claims in introspection responses are **SUPPORTED**
* `exp` claim is **MANDATORY**


## Corrections

This is intended to be a living document and as such the authors welcome any recommendations, changes or alterations. If you have alterations we welcome your feedback which can be sent via the FAPI WG Chair contactable at [openid-specs-fapi-owner@lists.openid.net](mailto:openid-specs-fapi-owner@lists.openid.net).

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

