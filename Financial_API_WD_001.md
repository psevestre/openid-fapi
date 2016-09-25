#Financial Services – Financial API - Part 1: Read Only APIs

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

Financial API - Part 1: Read Only APIs was prepared by OpenID Foundation Financial API Work Group.

Financial API consists of the following parts, under the general title Financial Services — Financial API:

* Part 1: Read Only APIs
* Part 2: Read and write APIs

This part is intended to be used with [RFC6749], [RFC6750], [RFC6736], and [OIDC]. 

##Introduction

In many cases, Fintech services such as aggregation services uses screen scraping and stores user passwords. This model is both brittle and insecure. To cope with the brittleness, it should utilize an API model with structured data and to cope with insecurity, it should utilize a token model such as OAuth [RFC6749, RFC6750].

This working group aims to rectify the situation by developing a REST/JSON model protected by OAuth. Specifically, the FAPI WG aims to provide JSON data schemas, security and privacy recommendations and protocols to:

* enable applications to utilize the data stored in the financial account,
* enable applications to interact with the financial account, and
* enable users to control the security and privacy settings.

Both commercial and investment banking accounts as well as insurance, and credit card accounts are to be considered.



#**Financial Services – Financial API - Part 1: Read Only APIs **

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

## 5. Getting Tokens

### 5.1 Introduction

The OIDF Financial API (FAPI) is a REST API that provides JSON data representing accounts and transactions related data. These APIs are protected by the OAuth 2.0 Authorization Framework that consists of [RFC6749], [RFC6750], [RFC7636], and other specifications.

These API accesses have several levels of risks associated to them. Read only access is generally speaking associated with lower financial risk than the write access. As such, the characteristics required to the tokens are also different.

In the following subclauses, the method to obtain tokens are explained separately.


### 5.2 Read Only Access Provisions

Read Only Access typically is the lower risk scenario compared to the Write access, so the protection level can also be lower. However, since the FAPI would provide potentially sensitive information, it requires more protection level than a basic [RFC6749] requires. 

To request the authorization to access the protected resource in question, the client uses the OAuth scope values defined in table 1. 

| Resource       | Allowed Actions                                              | Scope value          |
|----------------|--------------------------------------------------------------|----------------------|
| Account        | Read only Access to summary account information              | FinancialInformation |
| Customer       | Read only Access to customer information, including PII      | FinancialInformation |
| Image          | Read only Access to transaction images (checks and receipts) | FinancialInformation |
| Statement      | Read only Access to statement image                          | FinancialInformation |
| Transaction    | Read only Access to transaction information                  | FinancialInformation |

Table 1 - Financial API Scopes

As a profile of The OAuth 2.0 Authorization Framework, this specification mandates the following to the Read Only API of the FAPI.

#### 5.2.1 Authorization Server 

The Authorization Server

* shall support both public and confidential clients; 
* shall provide a client secret longer than 12 characters; 
* shall support [RFC7636] with `S265` as the code challenge method;
* shall require Redirect URIs to be pre-registered; 
* shall require the `redirect_uri` parameter in the authorization request; 
* shall require the value of `redirect_uri` to exactly match one of the pre-registered Redirect URIs;  
* shall require user authentication at LoA 2 as defined in [X.1254] or more; 
* shall require explicit consent by the user to authorize the requested scope if it has not been previously authorized;  
* shall verify that the Authorization Code has not been previously used if possible; 
* shall return the token response as defined in 4.1.4 of [RFC6749]; and 
* shall return the list of allowed scopes with the issued access token.  

    **NOTE**: The Financial API server may limit the scopes for the purpose of not implementing certain APIs.

    **NOTE**: Section 4.1.3 of [RFC6749] does not say anything about the `code` reuse, but this document is putting limitation on it as per Section 3.1.3.2 of [OIDC]. 

    **NOTE**: If replay identification of the authorization code is not possible, it is desirable to make the validity period of the authorization code very short. 

Further, if it wishes to provide the authenticated user's identifier to the client in the token response, the authorization server 

* shall support the authentication request as in Section 3.1.2.1 of [OIDC]; 
* shall perform the authentication request verification as in Section 3.1.2.2 of [OIDC]; 
* shall authenticate the user as in Section 3.1.2.2 and 3.1.2.3 of [OIDC]; 
* shall provide the authentication response as in Section 3.1.2.4 and 3.1.2.5 of [OIDC] depending on the outcome of the authentication; 
* shall perform the token request verification as in Section 3.1.3.2 of [OIDC]; and 
* shall issue an ID Token in the token response when `openid` was included in the requested `scope` 
  as in Section 3.1.3.3 of [OIDC] with its `sub` value equal to the value of the `CustomerId` 
  of the `Customer` object corresponding to the authenticated user
  and optional `acr` value in ID Token. 

    NOTE: [DDA] returns a parameter called `user_id` in the token response. 
    The value of `user_id` is identical to the value of `CustomerId` member of the `Customer` object. 

    Editor's Note: Requiring similar mechanism to PKCE to the Refresh and Access Token a good idea?

    Editor's Note 2: If `user_id` is indeed required in the token response of DDA, then, we should require OIDC. 


#### 5.2.2 Public Client

A Public Client

* shall support [RFC7636];
* shall use the [RFC7636] with `S256` as the code challenge method;
* shall use separate and distinct Redirect URI for each Authorization Server that it talks to;
* shall store the Redirect URI value in the User-Agent session and compare it with the Redirect URI that the Authorization Response was received at, where, if the URIs do not match, the Client shall terminate the process with error;
* shall adhere to the best practice stated by [BCP NAPPS](https://tools.ietf.org/html/draft-ietf-oauth-native-apps-03); and 
* shall implement an effective CSRF protection. 

Further, if it wishes to obtain a persistent identifier of the authenticated user, it 

* shall include `openid` in the `scope` value; and 
* shall include `nonce` parameter defined in Section 3.1.2.1 of [OIDC] in the authentication request.  

    NOTE: Adherence to [RFC7636] means that the token request includes `code_verifier` parameter in the request.


#### 5.2.3 Confidential Client

In addition to the provision to the Public Client, the Confidential Client 

* shall authenticate the client with client secret to access the Token Endpoint as in Section 4.1.3 of [RFC6749]; 


## 6. Accessing Protected Resources (Using tokens)

### 6.1 Introduction

The FAPI endpoints are OAuth 2.0 protected resource endpoints that return various financial information for the resource owner associated with the submitted access token. 

### 6.2 Read only access provisions 

#### 6.2.1 Protected resources provisions

The protected resources supporting this document 

* shall mandate TLS 1.2 as defined in [RFC5246] or later with the usage following the best practice in [RFC7525]; 
* shall support the use of the HTTP GET and HTTP POST methods defined in [RFC2616]; 
* shall accept access tokens in the HTTP header as in Section 2.1 of OAuth 2.0 Bearer Token Usage [RFC6750];
* shall not accept access tokens in the query parameters stated in Section 2.3 of OAuth 2.0 Bearer Token Usage [RFC6750]; 
* shall verify that the access token is not expired nor revoked; 
* shall verify that the scope associated with the access token authorizes the reading of the resource it is representing; 
* shall identify the associated user to the access token;  
* shall only return the resource identified by the combination of the user implicit in the access and the granted scope and otherwise return errors as in section 3.1 of [RFC6750]; 
* shall encode the response in UTF-8; // DDA allows client to ask for charset but restricting may be better for interoperability
* shall send the `Content-type` HTTP header `Content-Type: application/json; charset=UTF-8`;  
* shall send the server date in HTTP date header as in section 14.18 of [RFC2616];  
* shall send the `DDA-InteractionId` with the value set to the one received from the client in the `DDA-InteractionId` request header or a unique value created by the server if there was no corresponding request header to track the interaction, e.g., `DDA-InteractionId: c770aef3-6784-41f7-8e0e-ff5f97bddb3a`; and 
* shall log the value of `DDA-InteractionId` in the log entry. 


    NOTE: While this document does not specify the exact method to find out the user associated with the 
    access token and the granted scope, the protected resource can use OAuth Token Introspection [RFC7662]. 

Further, it 
 
* should support the use of Cross Origin Resource Sharing (CORS) [CORS] and or other methods as appropriate to enable Java Script Clients to access the endpoint; 

### 6.2.2 Client provisions

The client supporting this document 

* shall use TLS 1.2 as defined in [RFC5246] or later with the usage following the best practice in [RFC7525]; 
* shall send access tokens in the HTTP header as in Section 2.1 of OAuth 2.0 Bearer Token Usage [RFC6750];   
* shall send `User-Agent` header that identifies the client, e.g., `User-Agent: Intuit/1.2.3 Mint/4.3.1`; and 
* shall send `DDA-FinancialId` whose value is the unique identifier of the desired financial institution to interact assigned by the service bureau where the API is provided by a service bureau which uses the same endpoint for multiple institutions. 

    **NOTE**: Conceptually, the value of the DDA-FinancialID corresponds to `iss` in the ID Token 
    but is not required to be an https URI. It often is the routing number of the FI. 

Further, the client 

* can optionally supply the `sub` value associated with the customer with the `DDA-CustomerId` request header, e.g., `DDA-CustomerId: a237cb74-61c9-4319-9fc5-ff5812778d6b`; 
* can optionally supply the last time the customer logged into the client in the `DDA-CustomerLastLoggedTime` header where the value is supplied as ** w3c date **, e.g., `DDA-CustomerLastLoggedTime: Tue, 11 Sep 2012 19:43:31 UTC`; and 
* can supply the customer’s IP address if this data is available or applicable in the `DDA-CustomerIPAdress` header, e.g., `DDA-CustomerIPAdress: 198.51.100.119`; and 
* may send the `DDA-InteractionId` request header to the server to help correlate log entries between client
and server, e.g., `DDA-InteractionId: c770aef3-6784-41f7-8e0e-ff5f97bddb3a`. 


### 6.2.3 Open access resource provisions



## 7. Resource APIs

### 7.1 Introduction

This document specifies resources in two categories: 

* open access resources;
* protected resources; 

Open access resources does not require authorization to read them out. 
This document defines the following open access resources:

* Branch location
* ATM location
* Offered products list
* Offered product
* API service availability
* API service capability
* etc. 

Protected resources require the access token as defined above to read them out. 
This document defines the following protected resources: 

* customer; 
* account; 
* transaction; 
* transfer;
* transfer status;
* statement; 
* etc. 

### 7.2 Endpoint Discovery

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

### 7.3 Open access resources

#### 7.3.1 ATM locations

##### 7.3.1.1 Introduction

ATM locations APIs has ... 

##### 7.3.1.2 ATM countries

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


##### 7.3.1.3 ATM provinces

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

##### 7.3.1.4 ATM Locations

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

#### 7.3.2 Offered products 

##### 7.3.2.1 Introduction

##### 7.3.2.2 Offered product list

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

##### 7.3.2.3 Offered product

#### 7.3.4 Availability

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

#### 7.3.5 Capability

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

### 7.4 Protected resources 

#### 7.4.1 Customer  

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

#### 7.4.2. Account Descriptor List 

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

#### 7.4.3 Account 

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

#### 7.4.4 Statements 

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

#### 7.4.5 Statement 

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

#### 7.4.6 Transactions 

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

#### 7.4.7 Transaction Image

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


#### 7.4.8 Transfer

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


#### 7.4.9 Transfer status

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
## 8. API-ID's

### 8.1 Definition

For each resource endpoint an api-id is specified. Api-id’s are unique and are represented as a 5-digit integer value.
Assigning an API-ID to a protected resource endpoint (API) has several advantages:

1. Due to internal regulations within FAPI provider systems FAPI endpoints may have to be implemented with different URL path components
2. Due to overlapping URL's within FAPI provider systems FAPI endpoints may have to be implemented with different URL path components
3. API-ID's identify a FAPI endpoint independently of the actual URL which 

### 8.2 List of API-ID's

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

## 9. API Errors

### 9.1 Introduction

Resource endpoints may respond with an error. In those cases an appropriate HTTP status is returned in conjunction with an error message. HTTP status codes are well defined but do not always indicate the exact cause for an error. Resource endpoints will also include an error message but these have to be parsed by clients to extract the information about the error cause.

Requiring a client to parse the error message has several drawbacks:

1. Clients depend on a text message which may change over time
2. Clients need to be able to parse localized error messages
3. Due to internal regulations within FAPI provider systems error messages may not match the ones specified in this document

### 9.2 Error codes

For each type of error an error code is specified. Error codes are specified as a 3-digit integer value.

### 9.4 Error header

A HTTP header named `x-fapi-err` shall contain a value constructed by concatenating the API-ID value and the error code with "-" (0x2D).
The value shall enable a client to identify the error causing protected resource endpoint and the type of error without parsing the message body.

### 9.5 Error responses

Error responses shall include the HTTP error header and an error message. Providing the error header has several advantages:

1. HTTP headers are accessible without parsing the error message
2. The content type of the error message can be ignored
3. Localized error messages do not require special handling by the client
4. The error causing protected resource can be identified even if client libraries are used that execute multiple requests to different endpoints in an encapsulating manner

### 9.6 List of errors

RFC 6749 (OAuth 2.0) does not specify error responses for protected resource endpoints. It provides an error response framework (Section 8.5) and specifies a pattern for error names and descriptions. Following that pattern FAPI specifies errors for several categories:

1. General server side errors
2. Invalid request parameters
3. General limitations
4. Invalid access_token

#### 9.6.1 General server side errors

It is possible that servers have internal errors that occur unexpected. These types of errors will likely require system administrators attention.

| error code | error   | error description                          | http status | 
|------------|---------|--------------------------------------------|-------------| 
| 000        | invalid | The request failed due some unknown reason | 500         | 

#### 9.6.2 Invalid request parameters

Protected resource endpoints may require parameters and headers and have limitations on how they can be provided. 

| error code | error           | error description               | http status | 
|------------|-----------------|---------------------------------|-------------| 
| 100        | invalid_request | Missing or duplicate parameters | 400         | 
| 101        | invalid_request | Missing or duplicate headers    | 400         | 

#### 9.6.3 General API restrictions

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

### 9.7 Example error response

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

## 10. Security Considerations

### 10.1 TLS Considerations

Since confidential information is being exchanged, all interactions shall be encrypted with TLS/SSL (HTTPS) in accordance with the recommendations in [RFC7525]. TLS version 1.2 or later shall be used for all communications.
 
### 10.2 Message source authentication failure

Authorization request and response are not authenticated. 

### 10.3 Message interity protection failure

Authorization request and response tampering and parameter injection

### 10.4 Message containment failure

#### 10.4.1 Authorization request and response

#### 10.4.2 Token request and response

May leak from logs. 

#### 10.4.3 Resource request and response

May leak from referrer. 

## 11. Privacy Considerations

### 11.1 Privacy by design

* Privacy impact analysis (PIA) should be performed in the initial phase of the system planning. 
* For PIA, use of ISO/IEC 29134 Privacy impact analysis - Guidelines is recommended. 
* The provider should establish a management system to help respect privacy of the customer. 

### 11.2 Adhering to privacy principles

Stakeholders should follow the privacy principles of ISO/IEC 29100. In particular: 

1. Consent and Choice
2. Purpose legitimacy and specification
3. Collection limitation
4. Data (access) limitation
5. Use, retention, and data disclosure limitation:
    1. Use limitation:   
    1. Retention limitation: Where the data is no longer being used, clients should delete such data from their system within 180 days except for the cases it needs to retain due to the legal restrictions; 
    1. Data disclosure limitation: 
6. Accuracy and quality
7. Openness, transparency and notice
8. Individual participation and access
9. Accountability
10. Information security
11. Privacy compliance


## 12. Acknowledgement

(Fill in the names) 

## 13. Bibliography

* [OFX2.2] Open Financial Exchange 2.2
* [HTML4.01] “HTML 4.01 Specification,” World Wide Web Consortium Recommendation REC-html401-19991224, December 1999
* [RFC7662] OAuth 2.0 Token Introspection
* [DDA] Durable Data API, (2015), FS-ISAC

## Annex A Financial Data API Level 1 (Normative)

* [fapi.yml]



