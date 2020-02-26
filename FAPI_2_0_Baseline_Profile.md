%%%
title = "FAPI 2.0"
abbrev = "fapi-evolution"
ipr = "trust200902"
workgroup = "connect"
keyword = ["security", "openid"]

[seriesInfo]
name = "Internet-Draft"
value = "fapi-2_0-00"
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

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in RFC
2119 [RFC2119].


# Baseline Profile

OIDF FAPI is an API security profile based on the OAuth 2.0
Authorization Framework [@!RFC6749]. It aims to reach the security
goals laid out in the [Attacker Model].

## Network Layer

To protect against network attackers, all interactions MUST be
encrypted using TLS version 1.2 or later and follow [@!RFC7525].

## OAuth 2.0 Profile

Main technologies used:

  * OAuth 2.0 Authorization Framework [@!RFC6749]
  * OAuth 2.0 Bearer Tokens [@!RFC6750]
  * OAuth 2.0 PKCE [@!RFC7636]
  * OAuth 2.0 Mutual-TLS Client Authentication [@!RFC8705]
  * OAuth 2.0 Pushed Authorization Requests [@I-D.lodderstedt-oauth-par]
  * OAuth 2.0 Rich Authorization Requests [@I-D.lodderstedt-oauth-rar]
  * OAuth 2.0 Authorization Server Metadata [@!RFC8414]
  
### Requirements for Authorization Servers

Authorization servers

 1. MUST adhere to [@I-D.ietf-oauth-security-topics]
 1. MUST support the authorization code grant described in [@!RFC6749]
 1. MUST support client-authenticated pushed authorization requests
    according to [@I-D.lodderstedt-oauth-par]
 1. MUST NOT support authorization requests sent without
    [@I-D.lodderstedt-oauth-par] or without client authentication
 1. MUST support rich authorization requests according to [@I-D.lodderstedt-oauth-rar]
 1. MUST support confidential clients
 1. MUST support client authentication using Mutual TLS as described in [@!RFC8705]
 1. MUST require PKCE [@!RFC7636] with `S256` as the code challenge method
 1. MUST require the `redirect_uri` parameter in authorization requests and evaluate only this parameter to ensure authenticity and integrity of the redirect URI
 1. MUST require that redirect URIs use the `https` scheme

### Requirements for Clients

Clients

 1. MUST use the authorization code grant described in [@!RFC6749]
 1. MUST use pushed authorization requests according to [@I-D.lodderstedt-oauth-par]
 1. MUST use client authentication using Mutual TLS as described in [@!RFC8705]
 1. MUST use PKCE [@!RFC7636] with `S256` as the code challenge method 


### OpenID Connect




## Cryptography

 1. RSA keys MUST have a minimum length of 2048 bits.
 1. Elliptic curve keys MUST have a minimum length of 160 bits.



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

<reference anchor="RFC8705" target="https://www.rfc-editor.org/info/rfc8705">
<front>
<title>
OAuth 2.0 Mutual-TLS Client Authentication and Certificate-Bound Access Tokens
</title>
<author initials="B." surname="Campbell" fullname="B. Campbell">
<organization/>
</author>
<author initials="J." surname="Bradley" fullname="J. Bradley">
<organization/>
</author>
<author initials="N." surname="Sakimura" fullname="N. Sakimura">
<organization/>
</author>
<author initials="T." surname="Lodderstedt" fullname="T. Lodderstedt">
<organization/>
</author>
<date year="2020" month="February"/>
</front>
<seriesInfo name="RFC" value="8705"/>
</reference>

