%%%
title = "Grant Management for OAuth 2.0"
abbrev = "fapi-grant-management"
ipr = "none"
workgroup = "fapi"
keyword = ["security", "oauth", "grant management", "consent management"]

[seriesInfo]
name = "Internet-Draft"
value = "fapi-grant-management-01"
status = "standard"

[[author]]
initials="T."
surname="Lodderstedt"
fullname="Torsten Lodderstedt"
organization="yes.com"
    [author.address]
    email = "torsten@lodderstedt.net"
	
[[author]]
initials="S."
surname="Low"
fullname="Stuart Low"
organization="Biza.io"
    [author.address]
    email = "stuart@biza.io"

[[author]]
initials="D."
surname="Postnikov"
fullname="Dima Postnikov"
    [author.address]
    email = "dima@postnikov.net"
    
%%%

.# Abstract

This specification defines an extension of OAuth 2.0 [@!RFC6749] to allow clients to explicitly manage their grants with the authorization server. 

{mainmatter}

# Introduction {#Introduction}

OAuth authorization servers issue access and refresh tokens based on privileges granted by a resource owner to a particular client in the course of an authorization process or based on pre-configured policies. The concept representing these privileges and their assignment to a particular client is sometimes referred to a the "underlying grant". 

Although this concept is fundamental to OAuth, there is no explicit representation of the grant in the OAuth protocol. This leads to the situation that clients cannot explicitly manage grants, e.g. query the status or revoke a grant that is no longer needed. The status is implicitly communicated if an access token refresh succeeds or fails or if an API call using an access token fails with HTTP status codes 401 (token is invalid) or 403 (token lacks privileges). 

It also means the client cannot explicitly ask the authorization server to update a certain grant that is bound to a certain user. Instead the authorization server, typically, will determine a pre-existing grant using the client id from the authorization request and the user id of the authenticated resource owner. 

If a client wants the authorization server to update a pre-existing grant, it needs to obtain identity data about the user and utilize it in a login hint kind of parameter to refer to the "same user as last time", exposing more identity data to the client than neccessary. 

Another pattern that was proposed is to use refresh tokens to refer to grants. This would require to send the refresh token as part of the authorization request through the front channel, which posses security issues since the refresh token is a credential and could leak and be injected that way. 

There are also use cases in highly regulated sectors, e.g. Open Data, where the client might be forced to maintain concurrent, independent grants to represent the privileges delegated by the resource owner to this client in the context of a distinct service offered by the client to this user and using different client_ids is not appropriate. 

In order to support the before mentioned use cases, this specification introduces a `grant_id` clients can use to identify a particular grant along with additional authorization request parameters to request creation and use of such grant ids. This specification also defines a new grant management API provided by the authorization server that clients can use to query the status of a grant and to revoke it. 

## Terminology

* Grant: resource managed by the authorization server representing the privileges delegated by a resource owner to a certain client.
* Grant Management API: a HTTP-based API provided by the authorization server that clients can use to query the status of and revoke grants.

# Overview

An authorization server supporting this extension allows a client to explicitly manage its grants. The basic design principle is that creation and update of grants is always requested using an OAuth authorization request while querying the status of a grant and revoking it is performed using the new Grant Management API. 

The underlying assumption is that creation and updates of grants almost always require interaction with the resource owner. Moreover, the client is supposed to manage the grant ids along with the respective tokens on its own without support from the authorization server. 

# OAuth Protocol Extensions

## Authorization Request

This specification introduces the  authorization request parameter `grant_id`:

`grant_id`: OPTIONAL. String value identifying an individual grant managed by a particular authorization server for a certain client and a certain resource owner. The `grant_id` value MUST have been issued by the respective authorization server and the respective client MUST be authorized to use the particular grant id. If the parameter is present and the AS supports grant updates (see (#server_metadata)), the AS will assign all permissions as consented by the user in the actual request to the respective grant. If the parameter is not present and the AS always issues grant ids or the AS optionally issues grant ids (see (#server_metadata)) and the client requires grant ids (see (#client_metadata)), the AS MUST create a new grant and return the respective grant id in the token response. Otherwise, the AS MUST NOT return a grant id in the token response. The internal grant management behavior is at the discretion of the AS in this case.   

The following example shows how a client may ask the authorization request to use a certain grant id:

```http
GET /authorize?response_type=code&
     client_id=s6BhdRkqt3
     &grant_id=TSdqirmAxDa0_-DB_1bASQ
     &scope=write
     &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb
     &code_challenge_method=S256
     &code_challenge=K2-ltc83acc4h... HTTP/1.1
Host: as.example.com 
```

Note: the parameter `grant_id` can be used with any request serving as authorization request, e.g. it may be used with CIBA requests. 

Note: a client (as logical entity) MAY use multiple client ids to deliver its service across different platforms, e.g. apps for iOS and Android and a Web App. It is RECOMMENDED that the AS supports sharing of grants among client ids belonging to the same client. Sector identifier URIs as defined in [@OpenID.Registration] is one option to group client ids under single administrative control.

## Authorization Response

### Error Response

In case the `grant_id` is unknown or invalid, the authorization server will respond with an error code `invalid_grant_id`.

## Token Response

This specification introduces the token response parameter `grant_id`:

`grant_id`: URL safe string value identifying an individual grant managed by a particular authorization server for a certain client and a certain resource owner. The `grant_id` value MUST be unique in the context of a certain authorization server and SHOULD have enough entropy to make it impractical to guess it.  

```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-cache, no-store

{
   "access_token": "2YotnFZFEjr1zCsicMWpAA",
   "token_type": "example",
   "expires_in": 3600,
   "refresh_token": "tGzv3JOkF0XG5Qx2TlKWIA",
   “grant_id”:”TSdqirmAxDa0_-DB_1bASQ”
}
```

# Grant Management API

The Grant Management API allows clients to perform various actions on a grant whose `grant_id` the client previously obtained from the authorization server.

Currently supported actions are:

  * Query: Retrieve the current status of a specific grant
  * Revoke: Request the revocation of a grant 

The Grant Management API does not provide bulk access to all grants of a certain client for functional and privacy reasons. Every grant is associated with a certain resource owner, so just getting the status is useless for the client as long as there is not indication of the user the client can use this grant for. Adding user identity data to the status data would weaken the privacy protection OAuth offers for users towards a client. 

The Grant Management API will not expose any tokens associated with a certain grant in order to prevent token leakage. The client is supposed to manage its grants along with the respective tokens and ensure its usage in the correct user context. 

## API authorization

Using the grant management API requires the client to obtain an access token authorized for this API. The grant type the client uses to obtain this access token is out of scope of this specification. 

The token is required to be associated with the following scope value:

`grant_management_query`: scope value the client uses to request an access token to query the status of its grants. 

`grant_management_revoke`: scope value the client uses to request an access token to revoke its grants. 

## Endpoint

The grant management API is provided by a new endpoint provided by the authorization server. The client MAY utilize the server metadata parameter `grant_management_endpoint` (see (#server_metadata)) to obtain the endpoint URL. 

## Grant Resource URL

The resource URL for a certain grant is built by concatenating the grant management endpoint URL, a slash, and the the `grant_id`. For example, if the grant management endpoint is defined as 

```
https://as.example.com/grants
``` 

and the `grant_id` is 

```
TSdqirmAxDa0_-DB_1bASQ
```

the resulting resource URL would be

```
https://as.example.com/grants/TSdqirmAxDa0_-DB_1bASQ 
```

## Query Status of a Grant

The status of a grant is queried by sending a HTTP GET request to the grant's resource URL as shown by the following example. 

```http
GET /grants/TSdqirmAxDa0_-DB_1bASQ 
Host: as.example.com
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA
```

The authorization server will respond with a JSON-formated response as shown in the folling example:

```http
HTTP/1.1 200 OK
Cache-Control: no-cache, no-store
Content-Type: application/json

{
   "scopes":[
      {
         "scope":"contacts read write",
         "resources":[
            "https://rs.example.com/api"
         ]
      },
      {
         "scope":"openid"
      }
   ],
   "claims":[
      "given_name",
      "nickname",
      "email",
      "email_verified"
   ],
   "authorization_details":[
      {
         "type":"account_information",
         "actions":[
            "list_accounts",
            "read_balances",
            "read_transactions"
         ],
         "locations":[
            "https://example.com/accounts"
         ]
      }
   ]
}
```

The privileges associated with the grant will be provided as a JSON array containing objects with the following structure:

* `scopes`: JSON array where every entry contains the `scope` parameter value and (optionally) any `resource` parameter value as defined in [@!RFC8707] passed in the same authorization request. The AS MUST maintain the scope and resource values passed in different authorization requests in separate objects of the JSON structure in order to preserve their relationship.
* `claims`: JSON array containing the names of all OpenID Connect claims (see [@!OpenID]) as requested and consented in one or more authorization requests associated with the respective grant. 
* `authorization_details`: JSON Object as defined in [@!I-D.ietf-oauth-rar] containing all authorization details as requested and consented in one or more authorization requests associated with the respective grant.

The response structure MAY also include further elements defined by extensions. 

## Revoke Grant 

To revoke a grant, the client sends a HTTP DELETE request to the grant's resource URL. The authorization server responds with a HTTP status code 204 and an empty response body.

This is illustrated by the following example.

```http
DELETE /grants/TSdqirmAxDa0_-DB_1bASQ 
Host: as.example.com
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA

HTTP/1.1 204 No Content
```

The AS MUST revoke the grant and all refresh tokens issued based on that particular grant, it SHOULD revoke all access tokens issued based on that particular grant. 

Note: Token revocation as defined in [@RFC7009] differentiates from grant revocation as defined in this specification in that token revocation is not required to cause the revocation of the underlying grant. It is at the discretion of the AS to retain a grant in case of token revocation and allow the client to re-connect to this grant through a subsequent authorization request. This decoupling may improve user experience in case the client just wanted to discard the token as a credential.

## Error Responses

If the resource URL is unknown, the authorization server responds with HTTP status code 400.

If the client is not authorized to perform a call, the authorization server responds with HTTP status code 403.

If the request lacks a valid access token, the authorization server responds with HTTP status code 401.

# Metadata

## Authorization server's metadata {#server_metadata}

`grant_id_supported`
OPTIONAL. JSON string indicating support for provision of grant ids in token responses and use of such grant ids in authorization requests. Allowed values are `none`, `optional`, `always`. 

* `none`: the AS does not support grant ids.
* `optional`: the AS supports grant ids, the client determines whether grant ids are issued.
* `always`: the AS will provide grant ids in every token response. 

If omitted, the default value is `none`. 

`grant_update_supported`
OPTIONAL. JSON boolean indicating whether the authorization server supports grant updates. If omitted, the default value is `false`. 

`grant_management_actions_supported`
OPTIONAL. JSON array containing a list of Grant Management actions which are supported. Allowed values are `query` and `revoke`. If omitted, the default value is no supported actions.

`grant_management_endpoint`
OPTIONAL. URL of the authorization server's Grant Management Administration Endpoint.

## Client metadata {#client_metadata}

`grant_id_required`
OPTIONAL. JSON boolean requesting the AS to provide grant ids in the token response. If omitted, the default value is no grant ids required.

# Implementation Considerations {#Implementation}

Implementations may wish to consider solutions to allow for addressibility of individual components within a grant. Trust ecosystems should consider their requirements during implementation and consider either;
- Including a unique identifier within the authorization object (ie. `id` within the RAR) or; 
- Defining a comparison algorithm for the grant to allow for derivation of update and append actions

# Privacy Consideration {#Privacy}

`grant_id` is issued by the authorization server for each established grant between a client and a user. This should prevent correlation between different clients.

`grant_id` MUST NOT be derived from PII that can make possible to identify the user.

`grant_id` potentially could be shared by different client_id belonging to the same entity. 

# Security Considerations {#Security}

A grant id is considered a public identifier, it is not a secret. Implementations MUST assume grant ids leak to attackers, e.g. through authorization requests. For example, access to the sensitive data associated with a certain grant MUST NOT be made accessible without suitable security measures, e.g. an authentication and authorization of the respective client. 

{backmatter}

<reference anchor="OpenID" target="http://openid.net/specs/openid-connect-core-1_0.html">
  <front>
    <title>OpenID Connect Core 1.0 incorporating errata set 1</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
    <author initials="M." surname="Jones" fullname="Mike Jones">
      <organization>Microsoft</organization>
    </author>
    <author initials="B." surname="de Medeiros" fullname="Breno de Medeiros">
      <organization>Google</organization>
    </author>
    <author initials="C." surname="Mortimore" fullname="Chuck Mortimore">
      <organization>Salesforce</organization>
    </author>
   <date day="8" month="Nov" year="2014"/>
  </front>
</reference>

<reference anchor="OpenID.Registration" target="https://openid.net/specs/openid-connect-registration-1_0.html">
        <front>
          <title>OpenID Connect Dynamic Client Registration 1.0 incorporating errata set 1</title>
		  <author fullname="Nat Sakimura">
            <organization>NRI</organization>
          </author>
          <author fullname="John Bradley">
            <organization>Ping Identity</organization>
          </author>
          <author fullname="Mike Jones">
            <organization>Microsoft</organization>
          </author>
          <date day="8" month="Nov" year="2014"/>
        </front>
 </reference>

# IANA Considerations

`grant_id`

`grant_management_mode`

`grant_management_modes_supported`

`grant_management_actions_supported`

`grant_management_endpoint`

`invalid_grant_id`

# Acknowledgements {#Acknowledgements}

We would like to thank Filip Skokan, Dave Tonge, and Brian Campbell for their valuable feedback and contributions that helped to evolve this specification.

# Notices

Copyright (c) 2020 The OpenID Foundation.

The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

# Document History

   [[ To be removed from the final specification ]]
      
   -01 
   
   * simplified authorization requests
   * added metadata control grant management behavior of AS and client
   * extended grant resource data model

   -00 

   *  initial revision

