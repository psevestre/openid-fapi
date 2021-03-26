# Changes between FAPI Second Implementer's draft and Final

## Copyright notice & license

## Introduction

This document is a non-normative list of the changes between the second implementors draft of FAPI1 part 1 (read only / baseline) and part 2 (read-write / advanced) and the final versions.

Changes are listed as major if they may require alterations to implementations.

Changes are listed as minor if they are generally clarifications and are unlikely to require alterations to existing implementations that were already applying best current practice.

Most changes have both client and server clauses that reflect the same change to the protocol; such a change is only listed once below in the interests of brevity.

## Document name changes

The two documents have been renamed as many ecosystems are using the "read-write" spec for read-only operations.

   * "Financial-grade API - Part 1: Read-Only API Security Profile" is now "Financial-grade API Security Profile 1.0 - Part 1: Baseline"
   * "Financial-grade API - Part 2: Read and Write API Security Profile" is now "Financial-grade API Security Profile 1.0 - Part 2: Advanced"

The often used abbrevation for part 2, "FAPI-RW-ID2", would now be "FAPI1-Advanced-Final".

## FAPI Baseline

This section compares:

https://openid.net/specs/openid-financial-api-part-1-ID2.html

to:

https://openid.net/specs/openid-financial-api-part-1-1_0.html

### Major changes

5.2.2-13 must now reject authorization codes that have already been used (previously was a 'should')

5.2.2-14 scopes granted in the token endpoint response can now be omitted except in the case where the authorization request was passed in the front channel (via a web browser) and was not integrity protected. This means requests using a signed request object or PAR can adopt the standard OAuth2 behaviour of only returning the granted scopes if they're different from the requested scopes.

5.2.2-21 should issue access tokens with a lifetime of under 10 minutes unless the tokens are sender-constrained (does not affect 'Advanced' where access tokens are always sender-constrained)

5.2.2-22 must support OpenID Discovery, may optionally support OAuth Server Metadata and shall not distribute discovery metadata (such as the authorization endpoint) by any other means.

5.2.3-1 Clients must use PKCE in all cases now (except when adopting 'Advanced' and not using PAR - for backwards compatibility with existing ecosystems)

5.2.3-10 clients are now required to verify that the scope received in the token response is either an exact match, or contains a subset of the scope sent in the authorization request

5.2.3-11 clients must only use Authorization Server metadata obtained from the metadata document (this makes it clear that, for example, clients should never be configured to use an authorization or token endpoint not published in metadata - due to the risk of phishing attacks against relying parties)

6.2.1-9 The requirement to send ';charset=UTF-8' in the Content-type HTTP header for JSON has been removed (it has no meaning as utf-8 is the default charset for the application/json mimetype), meaning the header should now be `Content-Type: application/json`

7.1 Authorization endpoint should prevent TLS stripping attacks, e.g. by using a preloaded HTTP Strict Transport Security policy

7.1 All endpoints should use DNSSEC (OV/EV TLS certificates are not by themselves an alternative)

### Minor changes

5.2.2-4 clarify that requirements on client authentication apply to all endpoints that the client authenticates to

5.2.2-5, 5.2.2-6 clarify minimum key sizes apply to both client and server keys

5.2.2-11 the requirement to authenticate to LoA2 has been changed to require an appropriate level of authentication for the operation.

5.2.2-16 clarify that the non-guessable requirement also applies to the authorization code and any refresh tokens (the underlying specs already required these to be non-guessable)

5.2.2-note The use of refresh tokens instead of long-lived access tokens is recommended.

5.2.2.2-1 clarify servers must reject requests where nonce is missing when using scope=openid

5.2.2.2-1 clarify servers must reject requests where state is missing when using not scope=openid

5.2.3-5 Reference to BCP212 (OAuth2 for Native Apps) removed, it duplicated the contents of section 7.5 but was less detailed

6.2.1-13 A x-fapi-customer-ip-address containing a valid IPv4 or IPv6 address must be accepted

6.2.1-13 has been renumbered to 6.2.1-14.

7.7 An authorization server hosting different branded authorization endpoints that clients will directly send users to must use a separate issuer for each brand

8.1 Privacy consideration section has been rewritten

## FAPI Advanced

This section compares:

https://openid.net/specs/openid-financial-api-part-2-ID2.html

to:

https://openid.net/specs/openid-financial-api-part-2-1_0.html


### Major changes

These changes may require alterations to implementations.

5.2.2-11 The optional (and not widely implemented) pushed request object endpoint has been replaced with optional support of https://tools.ietf.org/html/draft-ietf-oauth-par

5.2.2-13 must reject request objects where the `exp` gives a lifetime of longer than 60 minutes

5.2.2-17 must reject request objects where the `nbf` claim in request object is missing or is more than 60 minutes in the past

5.2.2-18 requests that use PAR (if supported) must be rejected if they do not use PKCE (the PKCE requirement is an important security upgrade added as a result of analysing various production FAPI clients - the requirement is not applied to non-PAR requests purely for backwards compatibility)

8.9-3 recommends that all keys in jwks have unique `kid`s

### Minor changes

These changes are generally clarifications that are unlikely to require alterations to existing implementations that were already applying best current practice.

5.1 Public clients are now explicitly not allowed (previously they were nominally allowed but in practice impossible to implement compliantly)

5.1 JARM is now an alternative to OIDC (previously it was allowed to be offered in addition to OIDC)

5.2.2-2 The response type `code id_token token`  is no longer permitted (previously it was nominally permitted but in practice impossible to implement compliantly)

5.2.2-2 When using JARM, only the response type `code` is permitted

5.2.2-6 MTLS is now the only listed method for sender-constraining tokens (OAuth Token Binding has not achieved the hoped for level of adoption) 

5.2.2-7 the requirement to authenticate to LoA3 has been removed (the FAPI1 Baseline clause 5.2.2-11 effectively replaces it)

5.2.2-10 the wording around the requirement for signed requests has been aligned with https://tools.ietf.org/html/draft-ietf-oauth-jwsreq

5.2.2.1-6 If the id_token returned from the authorization endpoint unavoidably contains sensitive PII, it should be encrypted

5.2.3-3 the requirement for clients to send an `acr` claim has been removed (though some ecosystems or client implementors may choose to continue to do so)

5.2.3-10 the 'aud' claim sent in the request object must be the OP's issuer

5.2.3-16 It is not required to send duplicate parameters outside the request object when using PAR.

5.2.3.1-5 clients must supported sign+encrypted id tokens

8.5-1 Clarify that any TLS 1.3 cipher can be used

8.5-3 For DHE ciphers a minimum key size of 2048 bits is required

8.6.1 Encryption algorithm `RSA1_5` must not be used 

9 Privacy consideration section has been rewritten

## Acknowledgements

The following people contributed to this document:

* Joseph Heenan (Authlete) -- Author, Editor
