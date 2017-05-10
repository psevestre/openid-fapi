#Financial Services – Financial API - Part 5: Protected Data API and Schema - Read and Write

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice
The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.



##Foreword

OIDF (OpenID Foundation) is an international standardizing body comprised by over 160 participating entities (work group participants). The work of preparing international standards is carried out through OIDF work groups according to OpenID Process. Each participants interested in a subject for which a work group has been established has the right to be represented on that work group. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

OpenID Foundation standards are drafted in accordance with the rules given in the OpenID Process.

The main task of work group is to prepare Implementers Draft and Final Draft. Final Draft adopted by the Work Group through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote.

Attention is drawn to the possibility that some of the elements of this document may be the subject of patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

Financial API - Part 5: Protected Data API and Schema - Read and Write was prepared by OpenID Foundation Financial API Work Group.

Financial API consists of the following parts, under the general title Financial Services — Financial API:

* Part 1: Read Only API Security Profile
* Part 2: Read and Write API Security Profile
* Part 3: Open Data API
* Part 4: Protected Data API and Schema - Read only
* Part 5: Protected Data API and Schema - Read and Write

This part is intended to be used with [RFC6749], [RFC6750], [RFC6736], and [OIDC].

##Introduction

In many cases, Fintech services such as aggregation services uses screen scraping and stores user passwords. This model is both brittle and insecure. To cope with the brittleness, it should utilize an API model with structured data and to cope with insecurity, it should utilize a token model such as OAuth [RFC6749, RFC6750].

This working group aims to rectify the situation by developing a REST/JSON model protected by OAuth. Specifically, the FAPI WG aims to provide JSON data schemas, security and privacy recommendations and protocols to:

* enable applications to utilize the data stored in the financial account,
* enable applications to interact with the financial account, and
* enable users to control the security and privacy settings.

Both commercial and investment banking accounts as well as insurance, and credit card accounts are to be considered.



#**Financial Services – Financial API - Part 5: Protected Data API and Schema - Read and Write **

[TOC]

## 1. Scope

This document specifies the method of

* applications to obtain the OAuth tokens in an appropriately secure manner for the financial data access;
* application to utilize OpenID Connect to identify the customer;
* representing financial data in JSON format;
* using the tokens to interact with the REST endpoints that provides financial data; and
* enabling users to control the security and privacy settings.

This document is applicable to both commercial and investment banking accounts as well as insurance, and credit card accounts are to be considered.

## 2. Normative references
The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[RFC7230] -  Hypertext Transfer Protocol -- HTTP/1.1
[RFC7230]: https://tools.ietf.org/html/rfc7230

[RFC6749] - The OAuth 2.0 Authorization Framework
[RFC6749]: https://tools.ietf.org/html/rfc6749

[RFC6750] - The OAuth 2.0 Authorization Framework: Bearer Token Usage
[RFC6750]: https://tools.ietf.org/html/rfc6750

[RFC7636] - Proof Key for Code Exchange by OAuth Public Clients
[RFC7636]: https://tools.ietf.org/html/rfc7636

[RFC5246] - The Transport Layer Security (TLS) Protocol Version 1.2
[RFC5246]: https://tools.ietf.org/html/rfc5246

[RFC7525] - Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)
[RFC7525]: https://tools.ietf.org/html/rfc7525

[RFC6125] - Representation and Verification of Domain-Based Application Service Identity within Internet Public Key Infrastructure Using X.509 (PKIX) Certificates in the Context of Transport Layer Security (TLS)
[RFC6125]: https://tools.ietf.org/html/rfc6125

BCP NAPPS - [OAuth 2.0 for Native Apps](https://tools.ietf.org/html/draft-ietf-oauth-native-apps-03)

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

[OIDD] -  OpenID Connect Discovery 1.0 incorporating errata set 1
[OIDD]: http://openid.net/specs/openid-connect-discovery-1_0.html

[OIDM] -  OAuth 2.0 Multiple Response Type Encoding Practices
[OIDM]: http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html

[X.1254] - Entity authentication assurance framework
[X.1254]: https://www.itu.int/rec/T-REC-X.1254

## 3. Terms and definitions
For the purpose of this standard, the terms defined in [RFC6749], [RFC6750], [RFC7636], [OpenID Connect Core][OIDC] apply.


## 4. Symbols and Abbreviated terms

**API** – Application Programming Interface

**CSRF** - Cross Site Request Forgery

**FAPI** - Financial API

**FI** – Financial Institution

**HTTP** – Hyper Text Transfer Protocol

**REST** – Representational State Transfer

**TLS** – Transport Layer Security

## 5. Resource APIs

### 5.1 Introduction

Financial API specifies resources in two categories:

* open access resources;
* protected resources;

Open access resources does not require authorization to read them out.

Protected resources require an access token as to read them out. Protected resources are further divided into Read Only access and Read and Write access.

This document defines the resources and data schema for Read and Write access.

The following protected Read and Write resources are defined:
* transfer

### 5.2 OAuth Scope

To request read and write authorization to access the protected resource in question, the client uses the OAuth scope values defined in clause 5.2 of Financial API - Part 4: Protected Data API and Schema - Read only. Additional scopes in Table 1 are defined.

| Resource       | Allowed Actions                                              | Scope value  |
|----------------|--------------------------------------------------------------|--------------|
| Transfer        | Transfer of money between accounts              | wTransfer     |


Table 1 - Financial API Write Scopes


### 5.3 Protected resources


#### 5.3.1 Transfer

A **transfer** represents a transfer of assets from one account to another.

Following is a non-normative example of the transfer request.

```
POST /transfer HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/json

{
  "Transfer" : {
    "TransferId" : "111222333444555",
    "FromAccountId" : "1357902468",
    "ToAccountId" : "3216540987",
    "Amount" : 50.00,
    "Memo" : "For Check #1234",
  }
}
```

Following is a non-normative example of the transfer response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/transfer" },
       "fapi.transferstatus": {
          "href": "/transfer/status{?transferId}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true}
  },
  "TransferStatus": {
    "TransferId" : "111222333444555",
    "ReferenceId" : "8453935582",
    "Status" : "PENDING",
    "TransferDate" : "2015-02-01Z",
  }
}
```


## 6. API-ID's

### 6.1 Introduction
This document uses API-IDs as specified in clause 6 of Financial API - Part 4: Protected Data API and Schema - Read only.

### 6.2 List of API-ID's

This document specifies the following additional API-IDs:


| api                        | api-id | description                               |
|----------------------------|--------|-------------------------------------------|
| /transfer                  |  40000 | 400XXX indicates transfer related API's   |


## 7. API Errors

### 7.1 Introduction
This API specified by this document uses error responses as specified in clause 7 of Financial API - Part 4: Protected Data API and Schema - Read only.


### 7.2 List of errors



## 8. Security Considerations


## 9. Privacy Considerations


## 10. Acknowledgement

(Fill in the names)

## 11. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC

## Annex A Financial Data API Level 1 (Normative)

* [fapi.yml]



