#Financial Services – Financial API - Part 3: Open Data API

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

Financial API - Part 3: Open Data API was prepared by OpenID Foundation Financial API Work Group.

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



#**Financial Services – Financial API - Part 3: Open Data API **

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

[RFC2616] -  Hypertext Transfer Protocol -- HTTP/1.1
[RFC2616]: https://tools.ietf.org/html/rfc2616

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

Financial API document specifies resources in two categories:

* open access resources;
* protected resources;

Open access resources does not require authorization to read them out.

Protected resources require an access token to read them out.

This document defines the open access resources and data schema.

The following open access resources are defined:

* Branch location
* ATM location
* Offered products list
* Offered product
* API service availability
* API service capability
* API endpoint discovery
* etc.

### 5.2 Endpoint Discovery

    Editor's Note: In the following, we are currently citing OpenID Connect Discovery but
    once OAuth Server Metadata is done, it should be changed to it.

This document defines a mechanism for discovering the various resources endpoints for requesting the user's financial data. It defines two ways of doing it i.e.,

* server metadata document;
* Enhanced HAL;

Server metadata document builds upon the discovery mechanism described in OpenID Connect Discovery 1.0. This document defines the parameters defined in Table 2 to the OpenID Discovery response.

In case of using HAL, JSON describing the link is returned as a part of the resource being returned.

| Parameter         | Type  | Description                                                                                |
|-------------------|-------|--------------------------------------------------------------------------------------------|
| `fapi` *optional* | Array | JSON object containing a collection of the API resources endpoints and their URL locations |

The `fapi` parameter contains the following parameters:

|  Rel     | Parameter                              | Type   | Description                                                                        |
|----------|----------------------------------------|--------|------------------------------------------------------------------------------------|
| fapi.account  | account *optional*              | String | URL for getting account information                                                |
| fapi.accountlist | accountlist *optional*         | String | URL for getting list of accounts                                                   |
| fapi.accountdetails | accountdetails *optional*      | String | URL for getting account information (details & transactions) for the current token |
| fapi.statement| statement *optional*            | String | URL for retrieving a statement document                                            |
| fapi.statementlist | statementlist *optional*       | String | URL for getting list of statements                                                 |
| fapi.transaction | transaction *optional* | String | URL for getting a transaction document                                             |
| fapi.transactionlist| transactionlist *optional*     | String | URL for getting list of transactions                                               |
| fapi.availability |  availability *optional*        | String | URL for getting information about this API's availability                          |
| fapi.capability | capability *optional*           | String | URL for getting information about this API's capabilities                           |
| fapi.customer | customer *optional*             | String | URL for getting about the customer within the authorization scope                  |
| fapi.transfer | transfer *optional*             | String | URL for creating a transfer between accounts                                       |
| fapi.transferstatus | transferstatus *optional*      | String | URL for getting the status of a transfer between accounts                          |

Table 2 -- Link relations and the JSON parameters.

    Editor's note:
    An example should be added.

Following is a non-normative example of the discovery request.

```
GET /.well-known/openid-configuration HTTP/1.1
Host: example.com
Accept: application/json
Accept-Charset: UTF-8
```

Following is a non-normative example of the resource response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
 	"issuer": "https://example.com",
 	"authorization_endpoint": "https://example.com/connect/authorize",
 	"token_endpoint": "https://example.com/connect/token",
 	"jwks_uri": "https://example.com/jwks.json",
 	"scopes_supported": ["openid", "profile", "email", "address",
 		"phone", "offline_access"
 	],
 	"response_types_supported": ["code", "code id_token", "id_token", "token id_token"],
 	"subject_types_supported": ["pairwise"],
 	"id_token_signing_alg_values_supported": ["RS256", "ES256", "HS256"],
 	"fapi" : {
 	    "account" : "https://example.com/account",
 	    "statement" : "https://example.com/account/statement",
 	    "statementlist" : "https://example.com/account/statements",
 	    "transaction" : "https://example.com/account/transaction/image",
 	    "transactionlist" : "https://example.com/account/transactions",
 	    "accountlist" : "https://example.com/accountlist",
 	    "accountdetails" : "https://example.com/accountdetail",
 	    "availability" : "https://example.com/availability",
 	    "capability" : "https://example.com/capability",
 	    "customer" : "https://example.com/customer",
 	    "transfer" : "https://example.com/transfer",
 	    "transferstatus" : "https://example.com/transfer/status",
 	}
}
```

### 5.3 Open access resources

#### 5.3.1 ATM locations

##### 5.3.1.1 Introduction

ATM locations APIs has ...

##### 5.3.1.2 ATM countries

ATM countries are the resource that represents the list of countries
that the ATM are located. The API does not take any parameters and
returns the array of country information which has the following
members:

* Name: Country name;
* Code: ISO 3166-1 Alpha-3 code;
* Geocoding: Boolean that represents whether the geocoding is available for the country or not.

Request example:

```
GET /countries HTTP/1.1
Host: example.com
Accept: application/json
```

Response example:

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "_links": {
       "self": { "href": "/countries" }
  },
  "Countries":  [
      {
        "Name": "Japan",
        "Code": "JPN",
        "Geocoding": FALSE
      },
      {
        "Name": "United States of America",
        "Code": "USA",
        "Geocoding": FALSE
      }
   ]
}
```


##### 5.3.1.3 ATM provinces

ATM provinces represents country subdivisions such as states, provinces, prefectures etc. that have ATM locations.

Request example:

```
GET /atms/provinces?country=CAN HTTP/1.1
Host: example.com
Accept: application/json
```

Response example:

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "_links": {
       "self": { "href": "/atms/provinces?country=CAN" }
  },
  "CountrySubdivisions":  [
    {
      "Name": "ALBERTA",
      "Code": "AB"
     },
    {
      "Name": "BRITISH COLUMBIA",
      "Code": "BC"
    }
  ]
}
```

##### 5.3.1.4 ATM Locations

ATM locations represents the Geolocation of the ATMs.
It takes Country, Province, City, latitude, and longitude as parameter.

Details are defined in Swagger format in Appendix A.

Request example:

```
GET /atms?country=CAN&province=BC HTTP/1.1
Host: example.com
Accept: application/json
```

Response example:

```
{
  "atms":[
    {
      "id":"24242-3b13",
      "name":"RMD01",
      "address":{
        "line_1":" 1221 Granville St",
        "line_2":"",
        "line_3":"",
        "city":"Vancouver",
        "province":"BC",
        "postcode":"V6Z 1M6",
        "country":"CAN"
      },
     "location":{
        "latitude":49.2634,
        "longitude":-123.1241
      }
    }
  ]
}
```

#### 5.3.2 Offered products

##### 5.3.2.1 Introduction

##### 5.3.2.2 Offered product list

Offered product list represents the products and services offered by a financial institution.

Details are defined in Swagger format in Appendix A.

Request example:

```
GET /products HTTP/1.1
Host: example.com
Accept: application/json
```

Response example:

```
{
  "Products": [{
    "Code": "BPC05001161",
    "Name": "Premiere Savings Account",
    "Category": "Savings",
    "Family": "Banking",
    "SuperFamily": "Financial",
    "MoreInfUrl": "https:example.com/products/BPC05001161",
    }, {
    "Code": "BCP11118372",
    "Name": "Retirement Account",
    "Category": "Retirement",
    "Family": "Investing",
    "SuperFamily": "Financial",
    "MoreInfoUrl": "https://example.com/products/BCP11118372",
  }]
}
```

##### 5.3.2.3 Offered product

#### 5.3.4 Availability

**Availability** represents the availability of the API service.

Following is a non-normative example of availability request.

```
GET /availability HTTP/1.1
Host: example.com
Accept: application/json
```

Following is a non-normative example of the availability response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/availability" }
  },
  "Availability" : {
    "CurrentStatus" : "Operational",
    "CurrentStatusDesc" : "All systems working with no problems",
    "PlannedAvailability" : [
      {
        "Status" : "Maintenance",
        "StatusShortDesc" : "Monthly Maintenance Downtime",
        "StatusStartDate" : "2015-01-01T03:00:00.000Z",
        "StatusEndDate" : "2015-01-01T04:00:00.000Z",
      },
      {
        "Status" : "Maintenance",
        "StatusShortDesc" : "Monthly Maintenance Downtime",
        "StatusStartDate" : "2015-02-01T03:00:00.000Z",
        "StatusEndDate" : "2015-02-01T04:00:00.000Z",
      },
    ],
  }
}
```

#### 5.3.5 Capability

**Capability** represents the capabilities and supported features of the API service.

Following is a non-normative example of capability request.

```
GET /capability HTTP/1.1
Host: example.com
Accept: application/json
```

Following is a non-normative example of the capability response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/capability" }
  },
  "Capability": {
    "allowedConnections": 10,
    "supportsCustomer": true,
    "supportsAccounts": true,
    "supportsTransactions": true,
    "supportsImage": true,
  }
}
```


## 6. Security Considerations



## 7. Privacy Considerations



## 8. Acknowledgement

(Fill in the names)

## 9. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC

## Annex A Financial Data API Level 1 (Normative)

* [fapi.yml]



