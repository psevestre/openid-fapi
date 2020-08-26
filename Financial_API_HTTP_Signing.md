# Financial-grade API: HTTP Signing Requirements

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice

The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

##Foreword

The OpenID Foundation (OIDF) promotes, protects and nurtures the OpenID community and technologies. As a non-profit international standardizing body, it is comprised by over 160 participating entities (workgroup participants). The work of preparing implementer drafts and final international standards is carried out through OIDF workgroups in accordance with the OpenID Process. Participants interested in a subject for which a workgroup has been established has the right to be represented in that workgroup. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

Final drafts adopted by the Workgroup through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote. There is a possibility that some of the elements of this document may be the subject to patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial-grade API consists of the following parts:

* Part 1: Read-Only API Security Profile
* Part 2: Read and Write API Security Profile
* Financial-grade API: Client Initiated Backchannel Authentication Profile
* Financial-grade API: JWT Secured Authorization Response Mode for OAuth 2.0 (JARM)
* Financial-grade API: Implementation and Deployment Advice
* Financial-grade API: HTTP Signing Requirements

Future parts may follow.

This part is intended to provide practical guidance on the methods that can be used for HTTP request/response signing in Financial-grade APIs.

##Introduction

The Financial-grade API Standard provides a profile for OAuth 2.0 suitable for use in financial services and other similar higher risk scenarios. Ecosystems that have Financial-grade APIs often also have a requirement for the signing of HTTP requests or responses, this document covers the likely requirements and potential solutions.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

# **Financial-grade API: HTTP Signing Requirements**

[TOC]

## 1. Scope

This document specifies the method for an application to:

* obtain OAuth tokens via a backchannel authentication flow in an appropriately secure manner for financial data access and other similar situations where the risk is higher;
* use tokens to interact with protected data via REST endpoints.

## 2. Normative references

The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[ISODIR2] - ISO/IEC Directives Part 2
[ISODIR2]: https://www.iso.org/sites/directives/current/part2/index.xhtml

[FAPICIBA] - FAPI: Client Initiated Backchannel Authentication Profile
[FAPICIBA]: https://openid.net/specs/openid-financial-api-ciba-ID1.html

[FAPI1-PART1] - FAPI Read Only API Security Profile
[FAPI1-PART1]: https://openid.net/specs/openid-financial-api-part-1.html

[FAPI1-PART2] - FAPI Read Write API Security Profile
[FAPI1-PART2]: https://openid.net/specs/openid-financial-api-part-2.html

[FAPILI] - FAPI Lodging Intent
[FAPILI]: https://bitbucket.org/openid/fapi/src/master/Financial_API_Pushed_Request_Object.md

## 3. Terms and definitions

For the purpose of this standard, the terms defined in RFC6749, RFC6750, RFC7636, OpenID Connect Core and OpenID Connect Client Initiated Backchannel Authentication Core apply.

## 4. Symbols and Abbreviated terms

**API** – Application Programming Interface

**FAPI** - Financial-grade API

**HTTP** – Hyper Text Transfer Protocol

**OIDF** - OpenID Foundation

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 5 Typical requirements

### 5.1 Introduction 

The section lists the likely requirements that influence the choice of HTTP signing method for ecosystems using Financial-grade APIs.

#### 5.1.1 Non-repudiation

Generally ecosystems look to signing as a method for non-repudiation, meaning that the request or response can be retained by the parties and later used as prove that the message came from a party that had possession of the relevant private key.

Although TLS certificates can be used for instantaneous proof of key possesion, it is essentially impractical to retain all the necessary state such that it is possible to later independently verify key possession.

Any signing scheme must support straightforward serialization for later verification.

#### 5.1.2 JSON payloads

As the primary use-case for Financial-grade APIs is with JSON payloads, it is generally possible to make using of signing methods that are specific to JSON.

#### 5.1.3 Interference with payload

As Financial-grade APIs always use end-to-end encrypted TLS, it is generally possible to assume that the message body will not be tampered with (deliberately or accidentally) during transport.

However many middleware systems come with REST clients that will often parse JSON payloads automatically, making it difficult to reconstruct the original message body to verify the signature. It is often possible to workaround this (for example canonicalisation or base64 encoding of payloads), but the workarounds can reduce simplicity or robustness. It is often possible to access the raw payload by avoiding use of the REST client. In time this would be less of an issue, as the hope is that REST clients would implement support for widely used signature schemes.

#### 5.1.4 Signing of entire message

In REST-like systems, the Request-URI, method and some HTTP headers often include important information that must be within the scope of the signature.

#### 5.1.5 Interoperability

HTTP signing methods must be sufficiently well specified and straightforward to implement such that the signing library does not need to be aware of ecosystem specifics.

Systems must not have high rates of false negatives between difference implementations.

## 6. Security Considerations

There are no additional security considerations beyond those in [FAPI1-PART1], [FAPI1-PART2], [FAPILI], [FAPICIBA].

## 7. Privacy Considerations

There are no additional privacy considerations beyond those in [FAPI1-PART1], [FAPI1-PART2], [FAPILI], [FAPICIBA].

## 8. Acknowledgement

The following people contributed heavily towards this document:

* Nat Sakimura (Nomura Research Institute) -- Chair, Editor
* Anoop Saxana (Intuit) -- Co-chair, FS-ISAC Liaison
* Anthony Nadalin (Microsoft) -- Co-chair, SC 27 Liaison
* Dave Tonge (Moneyhub) -- Co-chair, UK Implementation Entity Liaison
* Brian Campbell (Ping Identity)
* John Bradley (Yubico)
* Joseph Heenan (Authlete)

## 11. Bibliography

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html
