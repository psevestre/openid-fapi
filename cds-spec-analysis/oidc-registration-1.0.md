# OpenID Connect Dynamic Client Registration 1.0 (Errata Set 1) Comparison

The following provides a clause by clause breakdown comparing [OpenID Connect Dynamic Client Registration 1.0 incorporating errata set 1](https://openid.net/specs/openid-connect-registration-1_0.html) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

| **[https://openid.net/specs/openid-connect-registration-1_0.html](https://openid.net/specs/openid-connect-registration-1_0.html)** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
| [1. Introduction](https://openid.net/specs/openid-connect-registration-1_0.html#Introduction) | Yes | N/A | While the CDS references the OpenID Connect Dynamic Registration specification, Dynamic Client Registration is **NOT SUPPORTED**. <br /><br />Guidance from the DSB has indicated that Dynamic Client Registration can be **optionally** supported by Data Holders (ie. OPs). <br /><br />This comparison assesses whether this is possible while still being compliant to the CDS and associated ACCC Register |
| [1.1. Requirements Notation and Conventions](https://openid.net/specs/openid-connect-registration-1_0.html#rnc) | Implicit         | N/A                            | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
| [1.2. Terminology](https://openid.net/specs/openid-connect-registration-1_0.html#Terminology) | No | N/A |  |
| [2. Client Metadata](https://openid.net/specs/openid-connect-registration-1_0.html#ClientMetadata) | Implicit | No :interrobang: | The CDR Register API currently [only supports](https://cdr-register.github.io/register/#get-accredited-data-recipients-with-metadata) a single `redirect_uri` per client. |
| [2.1. Metadata Languages and Scripts](https://openid.net/specs/openid-connect-registration-1_0.html#LanguagesAndScripts) | No | No | The CDS only supports `en-GB` at this time |
| [3. Client Registration Endpoint](https://openid.net/specs/openid-connect-registration-1_0.html#ClientRegistration) | No | No :interrobang: | The CDS and Register information do not provide metadata to disclose the Client Registration Endpoint |
| [3.1. Client Registration Request](https://openid.net/specs/openid-connect-registration-1_0.html#RegistrationRequest) | No | N/A |  |
| [3.2. Client Registration Response](https://openid.net/specs/openid-connect-registration-1_0.html#RegistrationResponse) | No | No | The CDS uses `private_key_jwt` auth method exclusively and therefore `client_secret` is **NOT SUPPORTED**. |
| [3.3. Client Registration Error Response](https://openid.net/specs/openid-connect-registration-1_0.html#RegistrationError) | No | N/A |  |
| [4. Client Configuration Endpoint](https://openid.net/specs/openid-connect-registration-1_0.html#ClientConfigurationEndpoint) | No | N/A |  |
| [4.1. Forming the Client Configuration Endpoint URL](https://openid.net/specs/openid-connect-registration-1_0.html#AccessURL) | No | N/A |  |
| [4.2. Client Read Request](https://openid.net/specs/openid-connect-registration-1_0.html#ReadRequest) | No | N/A |  |
| [4.3. Client Read Response](https://openid.net/specs/openid-connect-registration-1_0.html#ReadResponse) | No | N/A |  |
| [4.4. Client Read Error Response](https://openid.net/specs/openid-connect-registration-1_0.html#ReadError) | No | N/A |  |
| [5. "sector\_identifier\_uri" Validation](https://openid.net/specs/openid-connect-registration-1_0.html#SectorIdentifierValidation) | No | No | `sector_identifier_uri` is not currently used anywhere within the CDS but may be useful to allow for `redirect_uri` modifications without rquiring reregistration of CDR Consumers |
| [6. String Operations](https://openid.net/specs/openid-connect-registration-1_0.html#StringOps) | No | N/A |  |
| [7. Validation](https://openid.net/specs/openid-connect-registration-1_0.html#Validation) | No | N/A |  |
| [8. Implementation Considerations](https://openid.net/specs/openid-connect-registration-1_0.html#ImplementationConsiderations) | No | N/A |  |
| [8.1. Pre-Final IETF Specifications](https://openid.net/specs/openid-connect-registration-1_0.html#PreFinalIETFSpecs) | No | N/A |  |
| [8.2. Implementation Notes on Stateless Dynamic Client Registration](https://openid.net/specs/openid-connect-registration-1_0.html#StatelessRegistration) | No | N/A |  |
| [9. Security Considerations](https://openid.net/specs/openid-connect-registration-1_0.html#Security) | Yes | No | MTLS is in use |
| [9.1. Impersonation](https://openid.net/specs/openid-connect-registration-1_0.html#Impersonation) | No | N/A |  |
| [9.2. Native Code Leakage](https://openid.net/specs/openid-connect-registration-1_0.html#NativeCodeLeakage) | No | N/A |  |
| [9.3. TLS Requirements](https://openid.net/specs/openid-connect-registration-1_0.html#TLSRequirements) | Yes | No | MTLS is in use |
| [10. IANA Considerations](https://openid.net/specs/openid-connect-registration-1_0.html#IANA) | No | N/A |  |