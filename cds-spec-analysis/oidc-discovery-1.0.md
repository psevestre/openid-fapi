
# OpenID Connect Discovery Comparison

The following provides a clause by clause breakdown comparing [OpenID Connect Discovery 1.0 incorporating errata set 1](https://openid.net/specs/openid-connect-discovery-1_0.html) to the published [Consumer Data Standards v1.1.1](https://consumerdatastandardsaustralia.github.io/standards). 

|  **https://openid.net/specs/openid-connect-discovery-1_0.html** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
| [1. Introduction](https://openid.net/specs/openid-connect-discovery-1_0.html#Introduction) | No | N/A | The CDS adopts the OpenID Connect Discovery standard with modifications. The reason stated for these modification is because *"not all fields defined as required in the discovery standard are considered required for CDR"* |
| [1.1. Requirements Notation and Conventions](https://openid.net/specs/openid-connect-discovery-1_0.html#rnc) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
| [1.2. Terminology](https://openid.net/specs/openid-connect-discovery-1_0.html#Terminology) | No | N/A |  |
| [2. OpenID Provider Issuer Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html#IssuerDiscovery) | No | No | Issuer Discovery is **OPTIONAL** within both the CDS and OpenID Connect Discovery specifications |
| [2.1. Identifier Normalization](https://openid.net/specs/openid-connect-discovery-1_0.html#IdentifierNormalization) | Implicit | N/A |  |
| [2.1.1. User Input Identifier Types](https://openid.net/specs/openid-connect-discovery-1_0.html#IdentifierTypes) | Implicit | N/A |  |
| [2.1.2. Normalization Steps](https://openid.net/specs/openid-connect-discovery-1_0.html#NormalizationSteps) | Implicit | N/A |  |
| [2.2. Non-Normative Examples](https://openid.net/specs/openid-connect-discovery-1_0.html#Examples) | Implicit | N/A |  |
| [2.2.1. User Input using E-Mail Address Syntax](https://openid.net/specs/openid-connect-discovery-1_0.html#EmailSyntax) | Implicit | N/A |  |
| [2.2.2. User Input using URL Syntax](https://openid.net/specs/openid-connect-discovery-1_0.html#URLSyntax) | Implicit | N/A |  |
| [2.2.3. User Input using Hostname and Port Syntax](https://openid.net/specs/openid-connect-discovery-1_0.html#HostPortExample) | Implicit | N/A |  |
| [2.2.4. User Input using "acct" URI Syntax](https://openid.net/specs/openid-connect-discovery-1_0.html#AcctURISyntax) | Implicit | N/A |  |
| [3. OpenID Provider Metadata](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata) | Yes | Yes :octagonal_sign: |  The CDS specifies that a [discovery endpoint](https://consumerdatastandardsaustralia.github.io/standards/#end-points) from Data Holders is **MANDATORY**. While the CDS is broadly aligned with this specification the specification modifies mandatory metadata and adds additional  [not documented](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata) and unregistered attributes to the OpenID Connect Discovery document. |
| [4. Obtaining OpenID Provider Configuration Information](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) | Implicit | N/A |  |
| [4.1. OpenID Provider Configuration Request](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationRequest) | Implicit | N/A |  |
| [4.2. OpenID Provider Configuration Response](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse) | Yes | Yes :octagonal_sign: | The CDS [specifies](https://consumerdatastandardsaustralia.github.io/standards/#end-points) a number of changes to the OpenID Discovery metadata response. |
| | | | The following items are altered to **MANDATORY**: |
| | | | - `userinfo_endpoint` |
| | | | - `scopes_supported` |
| | | | - `acr_values_supported` | 
| | | | - `claims_supported` |
| | | | The following items are altered to **OPTIONAL**: |
| | | | - `response_types_supported` |
| | | | - `subject_types_supported` |
| | | | - `id_token_signing_alg_values_supported` |
| | | | The following items have been **ADDED** and are **MANDATORY**: |
| | | | - `introspection_endpoint` |
| | | | - `revocation_endpoint` |
| | | | The following items have had their default value altered but are **OMITTED**: |
| | | |  - `request_uri_parameter_supported`: Default value should be `false` as `request_uri` is explicitly disabled within the CDS |
| [4.3. OpenID Provider Configuration Validation](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationValidation) | Implicit | No | The CDS specifies the `issuer` value is to be set to the *"URL that the Data Holder asserts as its Issuer Identifier"* |
| [5. String Operations](https://openid.net/specs/openid-connect-discovery-1_0.html#StringOps) | No | N/A |  |
| [6. Implementation Considerations](https://openid.net/specs/openid-connect-discovery-1_0.html#ImplementationConsiderations) | No | N/A | *All of these Relying Parties and OpenID Providers MUST implement the features that are listed in this specification as being "REQUIRED" or are described with a "MUST"*  |
| [6.1. Pre-Final IETF Specifications](https://openid.net/specs/openid-connect-discovery-1_0.html#PreFinalIETFSpecs) | No | N/A |  |
| [7. Security Considerations](https://openid.net/specs/openid-connect-discovery-1_0.html#Security) | No | N/A |  |
| [7.1. TLS Requirements](https://openid.net/specs/openid-connect-discovery-1_0.html#TLSRequirements) | Yes | No | TLS is **MANDATORY** within the CDS |
| [7.2. Impersonation Attacks](https://openid.net/specs/openid-connect-discovery-1_0.html#Impersonation) | No | N/A |  |
| [8. IANA Considerations](https://openid.net/specs/openid-connect-discovery-1_0.html#IANA) | No | N/A |  |
| [8.1. Well-Known URI Registry](https://openid.net/specs/openid-connect-discovery-1_0.html#WellKnownRegistry) | No | N/A | |
| [8.1.1. Registry Contents](https://openid.net/specs/openid-connect-discovery-1_0.html#WellKnownContents) | Yes | Yes :octagonal_sign: | The CDS alters the specification of the well-known uri registered endpoint `/.well-known/openid-configuration` |
