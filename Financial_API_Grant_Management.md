%%%
title = "Grant Management for OAuth 2.0 "
abbrev = "fapi-grant-management"
ipr = "none"
workgroup = "fapi"
keyword = ["security", "oauth", "grant management", "consent management"]

[seriesInfo]
name = "Internet-Draft"
value = "fapi-grant-management-00"
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

This specification defines an extension of OAuth 2.0 to allow clients to explicitly manage their grants with the authorization server.

{mainmatter}

# Introduction {#Introduction}

OAuth authorization servers issue access and refresh tokens based on privileges granted by a resource owner to a particular client in the course of an authorization process or based on pre-configured policies. The concept representing these privileges and their assignment to a particular client is sometimes referred to a the "underlying grant". 

Although this concept is fundamental to OAuth, there is no explicit representation of the grant in the OAuth protocol. This leads to the situation that clients cannot explicitly manage grants, e.g. query the status or revoke a grant that is no longer needed. The status is implicitly communicated if an access token refresh succeeds or fails or if an API call using an access token fails with HTTP status codes 401 (token is invalid) or 403 (token lacks privileges). 

It also means the client cannot explictely ask the authorization server to update a certain grant that is bound to a certain user. Instead the authorization server, typically, will determine a pre-existing grant using the client id from the authorization request and the user id of the authenticated resource owner. 

If a client wants the authorization server to update a pre-existing grant, it needs to obtain identity data about the user and utilize it in a login hint kind of parameter to refer to the "same user as last time", exposing more identity data to the client than neccessary. 

Another pattern that was proposed is to use refresh tokens to refer to grants. This would require to send the refresh token as part of the authorization request through the front channel, which posses security issues since the refresh token is a credential and could leak and be injected that way. 

There are also use cases in highly regulated sectors, e.g. Open Data, where the client might be forced to maintain concurrent, independent grants to represent the privileges delegated by the resource owner to this client in the context of a distinct service offered by the client to this user. 

In order to support the before mentioned use cases, this specification introduces a `grant_id` clients can use to identify a particular grant along with extensions to the OAuth protocol flow to obtain and pass such grant ids. This specification also defines a new API provided by the authorization server that clients can use to query the status of a grant and to revoke it. 

## Terminology

* Grant: resource managed by the authorization server representing the privileges delegated by a resource owner to a certain client.
* Grant Management API: a HTTP-based API provided by the authorization server that clients can use to query the status of and revoke grants.

# Overview

An authorization server supporting this extension allows a client to explitely manage its grants. The basic design principle is that disclosure, creation and update of grants is always requested using an OAuth authorization request while querying the status of a grant and revoking it is performed using the new Grant Management API. 

The underlying assumption is that creation and updates of grants almost always require interaction with the resource owner. Moreover, the client is supposed to manage the grant ids along with the respective tokens on its own without support from the authorization server. 

# OAuth Protocol Extensions

## Authorization Request

This specification introduces the following new authorization request parameters:

`grant_id`: string value identifying an individual grant managed by a particular authorization server for a certain client and a certain resource owner. The `grant_id` value MUST be unique in the context of the authorization server that issued it. 

`grant_mode`: string value controlling the way the authorization shall handle the grant when processing an authorization request. The defined values of `grant_mode` are:

* `get`: the authorization server determines the grant based on the `client_id` of the authorization request and the user id of the resource owner determined via user authentication and provides the grant id in the corresponding token response. 
* `new`: the authorization server will create a fresh grant irrespective of any pre-existing grant for the client identified by the `client_id` in the autorization request and the resource owner identified by the user authentication (including Single SignOn). The authorization server will provide the client with the `grant_id` of the new grant in the corresponding token response. 
* `set`: this mode requires the client to specify a grant id using the `grant_id` parameter. It requests the authorization server to use a certain grant when processing the authorization request. The authorization server SHOULD attempt to update the privileges associated with this grant as result of the authorization process. This mode can be used to ensure the authorization process is performed by the same user that originally approved a certain grant and results in updated privileges for this grant. 
* `reset`: this mode requires the client to specify a grant id using the `grant_id` parameter. It requests the authorization server to use a certain grant when processing the authorization request, to revoke all privileges associated with this grant but keep the grant itself and add any privileges as requested by the client and approved by the resource owner in the course of the processing of this authorization request. This mode can be used to ensure the authorization process is performed by the same user that originally approved a certain grant while removing all previously assigned privileges. 

The following example 

```http
GET /authorize?response_type=code&
     client_id=s6BhdRkqt3
     &grant_mode=get
     &scope=read
     &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb
     &code_challenge_method=S256
     &code_challenge=K2-ltc83acc4h... HTTP/1.1
Host: as.example.com 
```
    
shows an authorization request asking the authorization server to provide the client with a grant id whereas this example

```http
GET /authorize?response_type=code&
     client_id=s6BhdRkqt3
     &grant_mode=set
     &grant_id=4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25
     &scope=read
     &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb
     &code_challenge_method=S256
     &code_challenge=K2-ltc83acc4h... HTTP/1.1
Host: as.example.com 
```

shows how a client can force the authorization server to use a certain grant id (previously obtained using `get`). 

## Authorization Response

### Error Response

In case the `grant_mode` is `set` or `reset` but the `grant_id` is unknown or invalid, the authorization server will respond with an error code `invalid_grant_id`.

## Token Request 

The `grant_mode` and `grant_id` parameters MAY be added to the token request in case this request is also an authorization request.

## Token Response

This specification introduces the following new token response parameter:

`grant_id`: URL safe string value identifying an individual grant managed by a particular authorization server for a certain client and a certain resource owner. The `grant_id` value MUST be unique in the context of a certain authorization server and SHOULD have enough entropy to make it impractical to guess it.  

It is RECOMMENDED that the output of a suitable random number generator be used to create a 32-octet sequence.  The octet sequence is then base64url-encoded to produce a 43-octet URL safe string to use as the code verifier. 

```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-cache, no-store

{
   "access_token": "2YotnFZFEjr1zCsicMWpAA",
   "token_type": "example",
   "expires_in": 3600,
   "refresh_token": "tGzv3JOkF0XG5Qx2TlKWIA",
   “grant_id”:”4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25”
}
```

OPEN: 

* Should the AS always return the grant_id if the client once asked for it?
* Should the AS rotate grant ids for privacy reasons?

# Grant Management API

The Grant Management API allows clients to query the status of a grant whose `grant_id` the client previously obtained from the authorization server in a token response. The API also allows the client to revoke such a grant. 

The Grant Management API does not provide bulk access to all grants of a certain client for functional and privacy reasons. Every grant is associated with a certain resource owner, so just getting the status is useless for the client as long as there is not indication of the user the client can use this grant for. Adding user identity data to the status data would weaken the privacy protection OAuth offers for users towards a client. 

The Grant Management API will not expose any tokens associated with a certain grant in order to prevent token leakage.   

The client is supposed to manage its grants along with the respective tokens and ensure its usage in the correct user context. 

## Authorization server's metadata

`grant_id_supported`
OPTIONAL. Boolean value specifying whether the authorization server supports grant_id issuance as defined in this specification, with true indicating support. If omitted, the default value is false.

`grant_management_endpoint`
OPTIONAL. URL of the authorization server's Grant Management Endpoint.

`grant_management_supported`
OPTIONAL. Boolean value specifying whether the authorization server supports Grant Management as defined in this specification, with true indicating support. If omitted, the default value is false.

## API authorization

Using the grant management API requires the client to obtain an access token authorized for this API. The grant type the client uses to obtain this access token is out of scope of this specification. 

The token is required to be associated with the following scope value:

`grant_management_query`: scope value the client uses to request an access token to query the status of its grants. 

`grant_management_revoke`: scope value the client uses to request an access token to revoke its grants. 

## Endpoint

The grant management API is provided by a new endpoint provided by the authorization server. The client MAY utilize the server metadata parameter `grant_management_endpoint` to obtain the endpoint URL. 

## Grant Resource URL

The resource URL for a certain grant is built by concatinating the grant management endpoint URL, a shlash, and the the `grant_id`. For example, if the grant management endpoint is defined as 

```
https://as.example.com/grants
``` 

and the `grant_id` is 

```
4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25
```

the resulting resource URL would be

```
https://as.example.com/grants/4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25 
```

## Query Status of a Grant

The status of a grant is queried by sending a HTTP GET request to the grant's resource URL as shown by the following example. 

```http
GET /grants/4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25 
Host: as.example.com
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA
```

The authorization server will respond with a JSON-formated response as shown in the folling example:

```http
HTTP/1.1 200 OK
Cache-Control: no-cache, no-store
Content-Type: application/json

{ 
  "scope": "read"
}
```

The privileges associated with the grant will be provided in a JSON object with the following fields:

* `scope`: String value as defined in [@RFC6749] representing the scope associated with the grant.
* `authorization_details`: JSON Object as defined in [@I-D.ietf-oauth-rar].
* `claims`: JSON object as defined in [@OpenID].

The response structure MAY also include further elements defined by other extensions. 

## Revoke Grant 

To revoke a grant, the client sends a HTTP DELETE request to the grant's resource URL. The authorization server responds with a HTTP status code 204 and an empty response body.

This is illustrated by the following example.

```http
DELETE /grants/4d276a8ab980c436b4ffe0c1ff56c049b27e535b6f1266e734d9bca992509c25 
Host: as.example.com
Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA

HTTP/1.1 204 No Content
```

## Error Responses

If the resource URL is unknown, the authorization server responds with HTTP status code 400.

If the client is not authorized to perform a call, the authorization server responds with HTTP status code 403.

If the request lacks a valid access token, the authorization server responds with HTTP status code 401.


# Privacy Consideration {#Privacy}

grant_id is issued by the authorization server for each established grant between a client and a user. This should prevent correlation between different clients.

grant_id is not be based on PII that can make possible to identify the user.

OPEN: 
* Should grant reference client's policy_uri?
* tracking via grant_id(?). Tracking in what context?

# Security Considerations {#Security}

no credentials

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

# IANA Considerations

grant_id

grant_id_mode

grant_management_endpoint

grant_management_supported

# Acknowledgements {#Acknowledgements}

# Notices

Copyright (c) 2020 The OpenID Foundation.

The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

# Document History

   [[ To be removed from the final specification ]]
      
   -00 

   *  initial revision

