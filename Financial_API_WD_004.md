#Financial Services – Financial API - Part 4: Protected Data API and Schema - Read only

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

Financial API - Part 4: Protected Data API and Schema - Read only was prepared by OpenID Foundation Financial API Work Group.

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



#**Financial Services – Financial API - Part 4: Protected Data API and Schema - Read only **

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

Financial API specifies resources in two categories:

* open access resources;
* protected resources;

Open access resources does not require authorization to read them out.

Protected resources require an access token as to read them out. Protected resources are further divided into Read Only access and Read and Write access.

This document defines the resources and data schema for Read Only access.

The following protected Read Only resources are defined:

* customer
* account
* transaction
* transfer
* transfer status
* statement
* etc.

### 5.2 OAuth Scope

As a profile of The OAuth 2.0 Authorization Framework, the authorization request to the Authorization Server requires `scope` values. Finacial API defines the scope values in Table 1 for read only access to Financial API protected resources.


| Resource       | Allowed Actions                                              | Scope value  |
|----------------|--------------------------------------------------------------|--------------|
| Account        | Read only Access to summary account information              | rAccount     |
| Customer       | Read only Access to customer information, including PII      | rCustomer    |
| Image          | Read only Access to transaction images (checks and receipts) | rImage       |
| Statement      | Read only Access to statement image                          | rStatement   |
| Transaction    | Read only Access to transaction information                  | rTransaction |

Table 1 - Financial API Scopes

This document also defines an aggregated scope `FinancialInformation`, which equates to
`rAccount` + `rCustomer` + `rImage` + `rStatement` + `rTransaction`.

### 5.3 Protected resources

#### 5.3.1 Customer

A **customer** is an OAuth protected resource that represents the customer referred to by the access token presented.
It is represented as a URI from which the client can GET the JSON representation.
The client is only allowed to obtain the data within the granted scope.

    Editor's Note: The DDA seems to be quite particular not to use customerId
    but the "surrogate identity (identifier)", which is the access token.
    However, the token endpoint returns customer_id and this is represented in
    the HTTP header all the time. Need to find out what it is trying to achieve.

The detail of this object is defined in Appendix A as a swagger.

Following is a non-normative example of the resource request.

```
GET /customer HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
User-Agent: Intuit/1.2.3 Mint/4.3.1
Accept-Charset: UTF-8
```

Following is a non-normative example of the resource response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/customer" }
  },
  "Customer": {
    "name": {
      "first": "Michael",
      "middle": "J",
      "last": "Smith",
      "company": "Acme"
    },
    "taxId": "144-27-7471",
    "customerID": a237cb74-61c9-4319-9fc5-ff5812778d6b
  }
}
```

  **NOTE**: It is similar to the UserInfo endpoint of [OIDC].

#### 5.3.2. Account Descriptor List

An account descriptor list is an OAuth protected resource that represents the list of account descriptors, the metadata about the account, associated with the provided access token, which is related to the customer in question.

The detail of this object is defined in Appendix A as a swagger.

Following is a non-normative example of the resource request.

```
GET /accountDescriptorList HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
```

Following is a non-normative example of the resource response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accountDescriptorList" },
       "fapi.account": {
          "href": "/accounts{?accountId}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true}
  },
  "AccountDescriptorList" : [
    {
      "AccountId" : "1357902468",
      "AccountType" : "SAVINGS",
      "DisplayName" : "Savings Account",
      "Status" : "OPEN",
      "Description" : "Savings Account",
    },
    {
      "AccountId" : "3216540987",
      "AccountType" : "CHECKING",
      "DisplayName" : "Checking Account",
      "Status" : "OPEN",
      "Description" : "Checking Account",
    }
  ]
}
```

     Editor's Note:  /me/accountDescriptorList might look more REST like.

#### 5.3.3 Account

An **account** is an OAuth protected resource that represents the account of the customer in question.
It is represented as a URI from which the client can obtain the JSON representation.
It may be HAL+ enhanced.
The client is only allowed to obtain the data within the granted scope.
It has an identifier unique to the issuing organization called `accountId`.

Since the access token only identifies the customer and the customer might have multiple accounts, account identifier, `accountId`, which is provided in the account descriptor needs to be provided.

The detail of this object is defined in Appendix A as a swagger.

Following is a non-normative example of the resource request.

```
POST /account HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1357902468
```

Following is a non-normative example of the resource request.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accounts/?accountId=1357902468" },
       "fapi.statements": {
          "href": "/statements{?accountId,startTime,endTime}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true},
       "fapi.transactions": {
          "href": "/account/transactions"},
  },
  "DepositAccount" : {
    "AccountId" : "1357902468",
    "AccountType" : "SAVINGS",
    "DisplayName" : "Savings Account",
    "Status" : "OPEN",
    "Description" : "Savings Account",
    "ParentAccountId" : "2468135790",
    "Nickname" : "My Savings Account A",
    "AccountNumber" : "4561237890",
    "InterestRate" : 3.0,
    "InterestRateType" : "FIXED",
    "MicrNumber" : "9753108642",
    "BalanceAsOf" : "2015-01-01Z",
    "CurrentBalance" : 1000.00,
  }
}
```

While GET is more REST like, in the above example, POST is used
so that the accountId is not exposed as a path / query,
which may expose the accountId through referrer and history.

#### 5.3.4 Account not available

An **account** as described in 5.3.3 may not be available temporarily or does not exist. In that case the API will not 
return account info but a message indicating that it either does not exist or has no available information at the moment.

Following is a non-normative examples of the resource request.

```
POST /account HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1357902468
```

Following is a non-normative example of the resource request with an account being temporarily unavailable.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accounts/?accountId=1357902468" },
       "fapi.statements": {
          "href": "/statements{?accountId,startTime,endTime}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true},
       "fapi.transactions": {
          "href": "/account/transactions"},
  },
  "DepositAccount" : {
    "AccountId" : "1357902468",
    "Error" : {
        "Code":"700",
        "Description":"Account information temporarily not available"
    }
  }
}
```

Following is a non-normative example of the resource request with a non existing account.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accounts/?accountId=1357902468" },
       "fapi.statements": {
          "href": "/statements{?accountId,startTime,endTime}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true},
       "fapi.transactions": {
          "href": "/account/transactions"},
  },
  "DepositAccount" : {
    "AccountId" : "1357902468",
    "Error" : {
        "Code":"701",
        "Description":"Account does not exist"
    }
  }
}
```

#### 5.3.5 Statements

Gets a list of statements for the given account.

```
POST /account/statements HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1357902468&startTime=2015-01-01Z&endTime=2015-02-01Z&page=1
```

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accounts/statements?accountId=1357902468" },
       "fapi.statement": {
          "href": "/statement/{?accountId,statementId}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true}
  },
  "Statements" : {
    "Total" : "1",
    "TotalPages" : "1",
    "Page" : "1",
    "Statement" : [
      {
        "AccountId" : "1357902468",
        "StatementId" : "ST875376081768363584636",
        "StatementDate" : "2015-01-01Z",
        "Description" : "Statement for 2015-01-01",
      },
      {
        "AccountId" : "1357902468",
        "StatementId" : "ST962558772885635484949",
        "StatementDate" : "2015-02-01Z",
        "Description" : "Statement for 2015-02-01",
      }
    ]
  }
}
```

    Editor's Note: Is StatementId unique to the org or to the AccountId?

#### 5.3.6 Statement

A **statement** represents an image of an account statement. It can be one of the following formats:

* application/pdf
* image/gif
* image/jpeg
* image/png
* image/tiff

```
POST /account/statement HTTP/1.1
Host: example.com
Accept: application/pdf
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1&statementId=1
```

```
HTTP/1.1 200 OK
Content-Type: application/pdf

Binary data
```

#### 5.3.7 Transactions

**Transactions** represents a list of transactions for the given account.

```
POST /account/transactions HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1357902468&startTime=2015-01-01Z&endTime=2015-02-01Z&page=1
```

Response example.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/accounts/transactions?accountId=1357902468&startTime=2015-01-01Z&endTime=2015-02-01Z&page=1" },
       "fapi.transaction": {
          "href": "/transaction{?accountId,transactionId}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true},
       "fapi.transactionImages": {
          "href": "/transaction/images/{?accountId,transactionId}",
          "Authorize":"Bearer {access_token}",
          "Method":"POST",
          "templated":true},
  },
  "Transactions" : {
    "Total" : "1",
    "TotalPages" : "1",
    "Page" : "1",
    "DepositTransaction" : [
      {
        "AccountId" : "1357902468",
        "TransactionId" : "111222333444555",
        "TransactionTimestamp" : "2015-02-01Z",
        "Description" : "Transfer",
        "Status" : "POSTED",
        "Amount" : -50.00,
        "TransactionType" : "TRANSFER",
        "Payee" : "3216540987",
      },
      {
        "AccountId" : "1357902468",
        "TransactionId" : "111222333444588",
        "TransactionTimestamp" : "2015-02-01Z",
        "Description" : "Transfer",
        "Status" : "POSTED",
        "Amount" : 150.00,
        "TransactionType" : "TRANSFER",
        "Payee" : "3216540987",
      }
    ]
  }
}
```

#### 5.3.8 Transaction Image

A **transaction image** represents an image of a transaction such as a scanned check or deposit/withdrawal slip. It can be one of the following formats:

* application/pdf
* image/gif
* image/jpeg
* image/png
* image/tiff

```
POST /account/transaction/image HTTP/1.1
Host: example.com
Accept: application/pdf
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/x-www-form-urlencoded

accountId=1&imageId=101&startTime=2015-01-01Z&endTime=2015-02-01Z
```

```
HTTP/1.1 200 OK
Content-Type: application/pdf

Binary data
```


#### 5.3.9 Transfer status

A **transfer status** represents the status of a transfer request.

Following is a non-normative example of the transfer request.

```
POST /transfer/status HTTP/1.1
Host: example.com
Accept: application/json
Authorization: Bearer w0mcJylzCn-AfvuGdqkty2-KP48=
Content-Type: application/json

transferId=111222333444555
```

Following is a non-normative example of the transfer status response.

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
{
  "_links": {
       "self": { "href": "/transfer/status" }
  },
  "TransferStatus": {
    "TransferId" : "111222333444555",
    "ReferenceId" : "8453935582",
    "Status" : "SUCCESS",
    "TransferDate" : "2015-02-01Z",
  }
}
```
## 6. API-ID's

### 6.1 Definition

For each resource endpoint an api-id is specified. Api-id’s are unique and are represented as a 5-digit integer value.
Assigning an API-ID to a protected resource endpoint (API) has several advantages:

1. Due to internal regulations within FAPI provider systems FAPI endpoints may have to be implemented with different URL path components
2. Due to overlapping URL's within FAPI provider systems FAPI endpoints may have to be implemented with different URL path components
3. API-ID's identify a FAPI endpoint independently of the actual URL which

### 6.2 List of API-ID's

All protected resource endpoints in FAPI have an API-ID. The API-ID's shall be assigned as listed below:

| api                        | api-id | description                               |
|----------------------------|--------|-------------------------------------------|
| /account                   |  10000 | 100XX indicates account related API's     |
| /account/statement         |  10010 |                                           |
| /account/statements        |  10011 |                                           |
| /account/transaction       |  10020 |                                           |
| /account/transactions      |  10021 |                                           |
| /account/transaction/image |  10022 |                                           |
| /accountList               |  10030 |                                           |
| /accountDetails            |  10040 |                                           |
| /availability              |  20010 | 200XXX indicates api-health related API's |
| /capability                |  20020 |                                           |
| /customer                  |  30000 | 300XXX indicates customer related API's   |
| /transfer                  |  40000 | 400XXX indicates transfer related API's   |
| /transfer/status           |  40010 |                                           |
| /atm/countries             |  50010 | 500XXX indicates atm related API's        |
| /atm/provinces             |  50020 |                                           |
| /atm/locations             |  50030 |                                           |
| /products                  |  60000 | 600XXX indicates product related API's    |

API-ID's are returned whenever an error on that API occurs. The api-id will be combined with an error code. Clients are able to identify the failing API by reading the api-id which is returned in an HTTP header.

## 7. API Errors

### 7.1 Introduction

Resource endpoints may respond with an error. In those cases an appropriate HTTP status is returned in conjunction with an error message. HTTP status codes are well defined but do not always indicate the exact cause for an error. Resource endpoints will also include an error message but these have to be parsed by clients to extract the information about the error cause.

Requiring a client to parse the error message has several drawbacks:

1. Clients depend on a text message which may change over time
2. Clients need to be able to parse localized error messages
3. Due to internal regulations within FAPI provider systems error messages may not match the ones specified in this document

### 7.2 Error codes

For each type of error an error code is specified. Error codes are specified as a 3-digit integer value.

### 7.4 Error header

A HTTP header named `x-fapi-err` shall contain a value constructed by concatenating the API-ID value and the error code with "-" (0x2D).
The value shall enable a client to identify the error causing protected resource endpoint and the type of error without parsing the message body.

### 7.5 Error responses

Error responses shall include the HTTP error header and an error message. Providing the error header has several advantages:

1. HTTP headers are accessible without parsing the error message
2. The content type of the error message can be ignored
3. Localized error messages do not require special handling by the client
4. The error causing protected resource can be identified even if client libraries are used that execute multiple requests to different endpoints in an encapsulating manner

### 7.6 List of errors

RFC 6749 (OAuth 2.0) does not specify error responses for protected resource endpoints. It provides an error response framework (Section 8.5) and specifies a pattern for error names and descriptions. Following that pattern FAPI specifies errors for several categories:

1. General server side errors
2. Invalid request parameters
3. General limitations
4. Invalid access_token

#### 7.6.1 General server side errors

It is possible that servers have internal errors that occur unexpected. These types of errors will likely require system administrators attention.

| error code | error   | error description                          | http status |
|------------|---------|--------------------------------------------|-------------|
| 000        | invalid | The request failed due some unknown reason | 500         |

#### 7.6.2 Invalid request parameters

Protected resource endpoints may require parameters and headers and have limitations on how they can be provided.

| error code | error           | error description               | http status |
|------------|-----------------|---------------------------------|-------------|
| 100        | invalid_request | Missing or duplicate parameters | 400         |
| 101        | invalid_request | Missing or duplicate headers    | 400         |

#### 7.6.3 General API restrictions

Protected resource endpoints may have restrictions that fail otherwise valid requests.

| error code | error           | error description                                  | http status |
|------------|-----------------|----------------------------------------------------|-------------|
| 200        | invalid_request | The number of permitted requests has been exceeded | 400         |
| 201        | invalid_request | The request messages Content-Type is not supported | 400         |
| 202        | invalid_request | The request message exceeds max. message size      | 400         |

#### 9.6.4 Invalid access_token

Protected resource endpoints always require an access_token but the token may not pass validations.

| error code | error           | error description                                           | http status |
|------------|-----------------|-------------------------------------------------------------|-------------|
| 990        | invalid_request | The token has expired                                       | 401         |
| 991        | invalid_request | The token misses permissions (SCOPE)                        | 401         |
| 992        | invalid_request | The token is missing or it has been provided more than once | 401         |
| 993        | invalid_request | The token is disabled                                       | 401         |
| 994        | invalid_Request | The token was retrieved via an unsupported grant_type       | 401         |
| 995        | invalid_Request | The token was issued to an unsupported client type          | 401         |
| 996        | invalid_Request | The token type is not supported                             | 401         |

### 7.7 Example error response

Assuming a request was send to a protected endpoint such as **/account**. That endpoint has been specified with **api-id=10000**. A request is sent without the required parameter **accountId**. The error type *Missing or duplicate parameters* has been specified with **error-code=100**.
An error response may look as follows:

```
HTTP/1.1 400 Bad Request
Content-Type: application/json; charset=utf-8
x-fapi-err: 10000-100:

{
    "error":"invalid_request",
    "error_description":"Missing or duplicate parameters"
}
```
The client can identify the failing endpoint and the error by processing the error header even if the error message had been localized. Parsing the error message is optional and may be used for display purposes only.



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



