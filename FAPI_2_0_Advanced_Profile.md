%%%
title = "FAPI 2.0 Advanced Profile"
abbrev = "fapi-2-advanced"
ipr = "trust200902"
workgroup = "connect"
keyword = ["security", "openid"]

[seriesInfo]
name = "Internet-Draft"
value = "fapi-2_0-advanced-00"
status = "standard"

[[author]]
initials="D."
surname="Fett"
fullname="Daniel Fett"
organization="yes.com"
    [author.address]
    email = "mail@danielfett.de"


%%%

.# Abstract 

OIDF FAPI 2.0 is an API security profile based on the OAuth 2.0
Authorization Framework [@!RFC6749].

{mainmatter}

# Introduction

## Warning

This document is not an OIDF International Standard. It is distributed
for review and comment. It is subject to change without notice and may
not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments,
notification of any relevant patent rights of which they are aware and
to provide supporting documentation.

## Copyright notice & license

The OpenID Foundation (OIDF) grants to any Contributor, developer,
implementer, or other interested party a non-exclusive, royalty free,
worldwide copyright license to reproduce, prepare derivative works
from, distribute, perform and display, this Implementers Draft or
Final Specification solely for the purposes of (i) developing
specifications, and (ii) implementing Implementers Drafts and Final
Specifications based on such documents, provided that attribution be
made to the OIDF as the source of the material, but that such
attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from
contributions from various sources, including members of the OpenID
Foundation and others. Although the OpenID Foundation has taken steps
to help ensure that the technology is available for distribution, it
takes no position regarding the validity or scope of any intellectual
property or other rights that might be claimed to pertain to the
implementation or use of the technology described in this
specification or the extent to which any license under such rights
might or might not be available; neither does it represent that it has
made any independent effort to identify any such rights. The OpenID
Foundation and the contributors to this specification make no (and
hereby expressly disclaim any) warranties (express, implied, or
otherwise), including implied warranties of merchantability,
non-infringement, fitness for a particular purpose, or title, related
to this specification, and the entire risk as to implementing this
specification is assumed by the implementer. The OpenID Intellectual
Property Rights policy requires contributors to offer a patent promise
not to assert certain patent claims against other contributors and
against implementers. The OpenID Foundation invites any interested
party to bring to its attention any copyrights, patents, patent
applications, or other proprietary rights that may cover technology
that may be required to practice this specification.


## Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [@!ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.


# Advanced Profile

OIDF FAPI is an API security profile based on the OAuth 2.0
Authorization Framework [@!RFC6749]. This Advanced Profile aims to
reach the security goals and the non-repudiation goals laid out in the
[Attacker Model].

All provisions of the [Baseline Profile] apply to the Advanced Profile
as well, with the extensions described in the following.


## Profile

In addition to the technologies used in the [Baseline Profile], the
following standards are used in the Advanced Profile:

  * OAuth 2.0 JWT Secured Authorization Request (JAR) [@I-D.ietf-oauth-jwsreq]
  * JWT Secured Authorization Response Mode for OAuth 2.0 [JARM]
  * OAuth 2.0 Token Introspection [@!RFC7662] with signed introspection responses [@I-D.draft-ietf-oauth-jwt-introspection-response]

### Requirements for Authorization Servers

Authorization servers

 1. shall support signed request objects according to JAR
    [@I-D.ietf-oauth-jwsreq] at the PAR endpoint
    [@I-D.lodderstedt-oauth-par]
 2. shall support at least one of the following methods to sign the authorization response:
    1. JWT Secured Authorization Response Mode for OAuth 2.0 [JARM]
    2. OpenID Connect [@!OpenID] ID Tokens as detached signatures (for backward compatibility with existing implementations)
 3. when offering token introspection [@!RFC7662], shall sign introspection responses that are issued in JWT format according to [@I-D.draft-ietf-oauth-jwt-introspection-response]
 4. OPEN QUESTION: how to sign resource requests and responses?
 5. OPEN QUESTION: how to handle userinfo response type selection? OIDC core says: depends on client registration

### Requirements for Clients

Clients

 1. shall sign request objects according to JAR [@I-D.ietf-oauth-jwsreq] at the PAR endpoint [@I-D.lodderstedt-oauth-par]
 1. shall ensure that authorization responses are signed using either [JARM] or via an ID Token as a detached signature [@!OpenID]
 2. shall verify the respective signatures
 3. when using token introspection [@!RFC7662], shall request signed token introspection responses according to [@I-D.draft-ietf-oauth-jwt-introspection-response]
 4. 
 
### Requirements for Resource Servers

The FAPI 2.0 endpoints are OAuth 2.0 protected resource endpoints that return protected information for the resource owner associated with the submitted access token.

Resource servers with the FAPI endpoints

1. shall accept access tokens in the HTTP header as in Section 2.1 of OAuth 2.0 Bearer Token Usage [RFC6750]
1. shall not accept access tokens in the query parameters stated in Section 2.3 of OAuth 2.0 Bearer Token Usage [RFC6750]
1. shall verify the validity, integrity, expiration and revocation status of access tokens
1. shall verify that the scope (incl. `authorization_details`) of the access token authorizes the access to the resource it is representing
1. shall verify sender-constraining for access tokens
1. shall identify the associated entity to the access token
1. shall only return the resource identified by the combination of the entity implicit in the access and the granted scope and otherwise return errors as in section 3.1 of [RFC6750]
1. shall set the response header `x-fapi-interaction-id` to the value received from the corresponding fapi client request header or to a [RFC4122] UUID value if the request header was not provided to track the interaction, e.g., `x-fapi-interaction-id: c770aef3-6784-41f7-8e0e-ff5f97bddb3a`
1. shall log the value of `x-fapi-interaction-id` in the log entry


## Cryptography and Secrets

 1. RSA keys shall have a minimum length of 2048 bits.
 1. Elliptic curve keys shall have a minimum length of 160 bits.
 1. authorization servers shall provide a client secret that adheres to the requirements in section 16.19 of [@!OpenID] if a symmetric key is used
 1. Access tokens shall be non-guessable with a minimum of 128 bits of entropy where the probability of an attacker guessing the generated token is less than or equal to 2^(-160) as per [RFC6749] section 10.10.
    


## Differences to FAPI 1.0

| FAPI 1.0 Read/Write                      | FAPI 2.0                            | Reasons                                                                                               |
|:-----------------------------------------|:------------------------------------|:------------------------------------------------------------------------------------------------------|
| JAR, JARM                                | PAR                                 | integrity protection and compatibility improvements for authorization requests; only code in response |
| -                                        | RAR                                 | support complex and structured information about authorizations                                       |
| -                                        | shall adhere to Security BCP         |                                                                                                       |
| `s_hash`                                 | -                                   | state integrity is protected by PAR; protection provided by state is now provided by PKCE             |
| pre-registered redirect URIs             | redirect URIs in PAR                | pre-registration is not required with client authentication and PAR                                   |
| response types `code id_token` or `code` | response type `code`                | improve security: no ID token in front-channel; not needed                                            |
| ID Token as detached signature           | -                                   | ID token does not need to serve as a detached signature                                               |
| signed and encrypted ID Tokens            | signing and encryption not required | ID Tokens only exchanged in back channel                                                              |
| `exp` claim in request object            | -                                   | ?                                                                                                     |


## Open questions:
 * disallow scopes? if yes, use RAR transport for openid claim
 * Response types? ID Token in front channel?
 * lifetime for request objects?
 * (relevance/meaning unclear):
     * shall return token responses that conform to section 4.1.4 of [RFC6749]; 
     * shall return an invalid_client error as defined in 5.2 of [RFC6749] when mis-matched client identifiers were provided through the client authentication methods that permits sending the client identifier in more than one way;
     * The Financial-grade API server may limit the scopes for the purpose of not implementing certain APIs.
     * (RS) shall encode the response in UTF-8 if applicable; 
     * (RS) shall send the `Content-type` HTTP header `Content-Type: application/json; charset=UTF-8` if applicable;
     * (RS) shall send the server date in HTTP Date header as in section 7.1.1.2 of [RFC7231];
     * (RS) should support CORS for JS clients
 * Check Sections 7/8

     

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

<reference anchor="preload" target="https://hstspreload.org/">
<front>
<title>HSTS Preload List Submission</title>
    <author fullname="Anonymous">
      <organization></organization>
    </author>
</front>
</reference>

