# Financial-grade API: Implementation and Deployment Advice

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
* Financial-grade API: Pushed Request Object
* Financial-grade API: Implementation and Deployment Advice

Future parts may follow.

This part is intended to provide practical guidance around how to use the Financial-grade API.

##Introduction

The Financial-grade API Standard provides a profile for OAuth 2.0 suitable for use in financial services. When an ecosystem adopts Financial-grade API, there are many decisions to be made and it is not always obvious what is the correct way to apply the standard to maximise the benefits.

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

# **Financial-grade API: Implementation and Deployment Advice**

[TOC]

## 1. Scope

This document gives general guidance on the implementation and successful deployment of the FAPI specifications, primarily based on lessons learnt from previous deployments of Financial-grade APIs.

## 2. Normative references

The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[ISODIR2] - ISO/IEC Directives Part 2
[ISODIR2]: http://www.iso.org/sites/directives/2016/part2/index.xhtml

[FAPICIBA] - FAPI: Client Initiated Backchannel Authentication Profile
[FAPICIBA]: https://openid.net/specs/openid-financial-api-ciba.html

[FAPI1] - FAPI Read Only API Security Profile
[FAPI1]: https://openid.net/specs/openid-financial-api-part-1.html

[FAPI2] - FAPI Read Write API Security Profile
[FAPI2]: https://openid.net/specs/openid-financial-api-part-2.html

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

## 5 Implementation and Deployment Advice

### 5.1 Public clients

#### 5.1.1 Introduction 

[FAPI2] and [FAPICIBA] do not permit public clients. This is because there are no widely adopted standards that would allow a sufficiently secure public client. In cases where a public client was desired, we recommend the use of one of the below alternatives.

#### 5.1.2 Confidential client in the backend

Single-page apps or mobile apps can communicate with a backend system that is itself a confidential client and is able securely hold the necessary secrets.

The protocol used for this communication is outside of the scope of the FAPI specifications.

#### 5.1.3 Per-installation confidential client

On platforms where sufficiently secure storage of secrets is available, each instance of an application can register it's own secrets with the server. For example:

 - iOS Secure Enclave accessed via the kSecAttrTokenIDSecureEnclave flag
 - Android's hardware-back keystore accessed via the android.security.keystore API

The method used to protect the registration endpoint at the authorization server is outside of the scope of the FAPI specification.

### 5.2 Replacing screen scraping with APIs

### 5.2.1 Introduction

In many cases, the desire to roll out Financial-grade APIs is driven by a wish to stop the usage of screen scraping.

Screen scraping is undesirable for many reasons, including:

1. the entity doing the scraping often is not identifiable to the scraped side, which can make it hard to enforce legal or privacy obligations onto the scraper, or to distinguish if an action is being invoked directly by the resource owner
2. users should not be encouraged to share their credentials with other parties
3. sharing of credentials grants full access to the user's account, when other solutions allow the user to grant granular permission to third parties

However if it is desired to replace screenscraping, the replacement system must be as capable as screen scraping is or market adoption and user experience will be poor. The below sections enumerate some of the factors that need to be considered.

### 5.2.2 Ease of user authentication

The user must be able to easily authenticate and grant access to the third party application. The process for doing so should be quick and simple, and should not involve the user providing more credentials/information than they would need to in order to access the same data in the first-party website.

For example, if the user is able to access information using a biometric to a mobile application, a similar mechanism should be available to approve ongoing third party access to the same data.

This can be accomplished using a standard OAuth2-style redirect flow but enhanced to support 'app2app' redirections, or via decoupled flows like [FAPICIBA].

### 5.2.3 Re-authentication

When screenscraping it used, it is usually a 'one time' setup for the user. The third party is generally able to access the user's account in perpetuity, which is often desireable to the user.

Systems aiming to replace screenscraping should:
 
1. ensure that the user is able to grant long lived access (including any time period up to and including access that is permanent until explicitly revoked by the user);
2. ensure that the user is able to grant sufficient privilege, for example the ability to make an unlimited number of payments of any amount to any recipient on any date

### 5.2.4 Identity of users

When screenscraping, third parties are often able to obtain some information about the identity of the user. They usually have access to the user's username, and websites may display some of the user's personal details.

Systems aiming to replace screenscraping should:

1. ensure that there is a mechanism that third parties can assure that has authenticated at the authorization server is the same user that has previously authenticated, for example providing a `sub` value in the `id_token` that is persistant for that third party and allowing an essential: true claim for that `sub` value to be made

2. provide available attributes of the user to the third party (with the user's consent)

### 5.2.5 Completeness of API

Any API provided to replace screenscraping must be sufficiently rich to provide all the information that was available to screen scrapers.

For example, some ecosystems have limited the scope of APIs to 'accounts capable of making payments', resulting in a confusing user experience where some types of 'savings accounts' are accessible via API and others only by screen scraping.

In many cases, it is possible to ensure APIs are complete by having first-party products use the same APIs that are made available to third-parties.

## 6. Security Considerations

There are no additional security considerations beyond those in [FAPI1], [FAPI2], [FAPILI], [FAPICIBA].

## 7. Privacy Considerations

There are no additional privacy considerations beyond those in [FAPI1], [FAPI2], [FAPILI], [FAPICIBA].

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
