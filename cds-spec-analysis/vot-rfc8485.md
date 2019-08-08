# Vectors of Trust (RFC8485) Comparison

The following provides a clause by clause breakdown comparing [Vectors of Trust (RFC8485)](https://tools.ietf.org/html/rfc8485) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  **[https://tools.ietf.org/html/rfc8485](https://tools.ietf.org/html/rfc8485)** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | :---: | :---: | --- |
| [1. Introduction](https://tools.ietf.org/html/rfc8485#section-1) | Yes | No | The CDS Standards declare that a single VoT claim within the acr attribute MAY be provided for non VoT responses. <br /><br />Formalised VoT responses are **OPTIONALLY** supported and are populated within the [FAPI-R](fapi-part1.md) claims of `vot` and `vtm`<br /><br />The purposes of this review relates to whether the optional support in CDS alters this RFC. |
| [1.1 Notational Conventions](https://tools.ietf.org/html/rfc8485#section-1.1)  | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
| [1.2. Terminology](https://tools.ietf.org/html/rfc8485#section-1.2)  | No | N/A |  |
| [1.3 Identity Model](https://tools.ietf.org/html/rfc8485#section-1.3)  | No | N/A | In the context of the CDS the *identity subject* is assumed to be the *CDR Consumer* and the *identity provider* is assumed to be the *CDR Data Holder* |
| [1.4. Component Architecture](https://tools.ietf.org/html/rfc8485#section-1.4)  | Implicit | N/A |  |
| [2. Component Dimension Definitions](https://tools.ietf.org/html/rfc8485#section-2)  | Implicit | No | While no specific guidance is given in the CDS it is assumed the expected `vot` values will align with these dimensions |
| [2.1. Identity Proofing (P)](https://tools.ietf.org/html/rfc8485#section-2.1)  | Yes | Yes |  |
| [2.2. Primary Credential Usage (C)](https://tools.ietf.org/html/rfc8485#section-2.2) | Implicit | No |  |
| [2.3. Primary Credential Management (M)](https://tools.ietf.org/html/rfc8485#section-2.3) | Implicit | No |  |
| [2.4. Assertion Presentation (A)](https://tools.ietf.org/html/rfc8485#section-2.4) | Implicit | No |  |
| [3. Communicating Vector Values to RPs](https://tools.ietf.org/html/rfc8485#section-3) | Implicit | No |  |
| [3.1. On-the-Wire Representation](https://tools.ietf.org/html/rfc8485#section-3.1) | Implicit | Yes |  |
| [3.2. In OpenID Connect](https://tools.ietf.org/html/rfc8485#section-3.2) | Implicit | No | ***NOTE:*** `vot` and `vtm` is only required for optional LoA support, otherwise the `acr` claim is used using the format `urn:cds.au:cdr:#` |
| [4. Requesting Vector Values](https://tools.ietf.org/html/rfc8485#section-4) | Implicit | Yes | No request values specified but format is non compliant |
| [4.1. In OpenID Connect](https://tools.ietf.org/html/rfc8485#section-4.1) | Implicit | Yes :o2: | The CDS specifies that the `vot` value is a single **string** not an **array of strings**. |
| [5. Trustmarks](https://tools.ietf.org/html/rfc8485#section-5) | Implicit | No | Trust Marks are supported in `vtm` response |
| [6. Defining New Vector Values](https://tools.ietf.org/html/rfc8485#section-6) | No | N/A | |
| [7.  IANA Considerations](https://tools.ietf.org/html/rfc8485#section-7) | No | N/A | |
| [7.1.  Vector of Trust Components Registry](https://tools.ietf.org/html/rfc8485#section-7.1) | No | N/A | |
| [7.1.1. Registration Template](https://tools.ietf.org/html/rfc8485#section-7.1.1) | No | N/A | |
| [7.1.2. Initial Registry Contents](https://tools.ietf.org/html/rfc8485#section-7.1.2) | No | N/A | |
| [7.2. Addition to the OAuth Parameters Registry](https://tools.ietf.org/html/rfc8485#section-7.2)  | No | N/A | |
| [7.3. Additions to JWT Claims Registry](https://tools.ietf.org/html/rfc8485#section-7.3)  | No | N/A | |
| [7.4. Additions to OAuth Token Introspection Response](https://tools.ietf.org/html/rfc8485#section-7.4)  | No | N/A | |
| [8. Security Considerations](https://tools.ietf.org/html/rfc8485#section-8)  | No | N/A |  |
| [9. Privacy Considerations](https://tools.ietf.org/html/rfc8485#section-9) | No | N/A |  |
| [10. References](https://tools.ietf.org/html/rfc8485#section-10) | No | N/A |  |
| [10.1. Normative References](https://tools.ietf.org/html/rfc8485#section-10.1) | No | N/A |  |
| [10.2. Informative References](https://tools.ietf.org/html/rfc8485#section-10.2) | No | N/A |  |
