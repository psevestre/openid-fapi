# Financial-grade API: Simple HTTP Message Integrity Protocol

## Warning

This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.

Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.

## Copyright notice

The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.

The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.

## Foreword

The OpenID Foundation (OIDF) promotes, protects and nurtures the OpenID community and technologies. As a non-profit international standardizing body, it is comprised by over 160 participating entities (workgroup participants). The work of preparing implementer drafts and final international standards is carried out through OIDF workgroups in accordance with the OpenID Process. Participants interested in a subject for which a workgroup has been established has the right to be represented in that workgroup. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.

Final drafts adopted by the Workgroup through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote. There is a possibility that some of the elements of this document may be the subject to patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.

## Introduction

There are many applications for HTTP signing, however there are no widely-used standards to support it. This specification is designed to be a thin layer on top of [DPoP] that will support non-repudiation. It enables the recipient of a signed http message to save the payload, uri, http method and a signature from the sender for non-repudiation purposes. Furthermore it enables a signed HTTP response to be cryptographically linked to a signed HTTP request; from a non-repudiation perspective it is expected that a pair of messages will be more useful than just a single request or response. 

### Notational Conventions

The keywords "shall", "shall not",
"should", "should not", "may", and
"can" in this document are to be interpreted as described in
ISO Directive Part 2 [ISODIR2].
These keywords are not used as dictionary terms such that
any occurrence of them shall be interpreted as keywords
and are not to be interpreted with their natural language meanings.

# **Financial-grade API: Simple HTTP Message Integrity Protocol **

[TOC]

## 1. Scope

This document specifies the method for an application to:

* sign HTTP requests
* sign HTTP responses

## 2. Normative references

The following referenced documents are indispensable for the application of this document. For dated references, only the edition cited applied. For undated references, the latest edition of the referenced document (including any amendments) applies.

[DPOP] - OAuth 2.0 Demonstration of Proof-of-Possession at the Application Layer
[DPOP]: https://tools.ietf.org/html/draft-ietf-oauth-dpop-02

[DIGEST] - Digest Headers
[DIGEST]: https://tools.ietf.org/html/draft-ietf-httpbis-digest-headers-04

[RFC7519] - JSON Web Token (JWT)
[RFC7519]: https://tools.ietf.org/html/rfc7519

[RFC7517] - JSON Web Key (JWK)
[RFC7517]: https://tools.ietf.org/html/rfc7517

[OIDC] - OpenID Connect Core 1.0 incorporating errata set 1
[OIDC]: http://openid.net/specs/openid-connect-core-1_0.html

## 3. Terms and definitions

For the purpose of this standard, the terms defined in [DPOP] apply.

## 4. Symbols and Abbreviated terms

**API** - Application Programming Interface

**HTTP** - Hyper Text Transfer Protocol

## 5. Simple HTTP Message Integrity Protocol 

### 5.1 Introduction

There is a requirement (often legislative) for API requests and responses to be signed for non-repudiation purposes. There are no widely used interoperable standards for this currently.

The OAuth working group at the IETF has defined the [DPOP] standard which "enables a client to demonstrate proof-of-possession of a public/private key pair by including a DPoP header in an HTTP request". [DPOP] specifies a way for a client to sign a proof which contains claims for the HTTP method and URI. The specification allows DPoP proofs to be extended to protect additional HTTP data.

This specification is an extension to DPoP that supports the following

1. Signing a digest of the HTTP body data
2. Using DPoP proofs in HTTP responses
3. Allowing a signed HTTP response to be cryptographically linked to a signed HTTP request

The aim of this specification is to provide a simple, interoperable method of signing HTTP requests and responses. By utilizing [DPOP] (which itself utlizes the JOSE suite of standards) and [DIGEST] there is no need for custom canonicalization rules. The DPoP proof is a simple self-contained JWT and is therefore simple to verify.

This specification does not support signing additional HTTP headers, see section 7 for the rationale for this.

This specification does not define the manner in which the recipient of a DPoP proof may verify that the key is valid for the sender, however there is a list of possible approaches in section 6.


### 5.2 Claims

#### 5.2.1 `htd` - The digest of the HTTP request or response body

[DIGEST] defines a mechanism to calculate the digest of HTTP representation-data and convey the value in an HTTP header field. It deals with the differences between the payload body and HTTP representation data, taking into account HTTP semnatics such as content-encoding and range requests. 

[DIGEST] requires digests to be communicated in the `Digest` header field. This specification requires digests to be communicated in the `htd` claim of a DPoP proof, with the following requirements:

1. Only a single "Representation Digest" shall be conveyed in the `htd` claim;
2. The "Representation Digest" shall be calculated according to [DIGEST] section 2;
3. The digest shall be calculated using either the `sha-256`, `sha-512`, `id-sha-256` or `id-sha-512` algorithms;
4. The digest for requests or responses with no payload body shall be calcuated according to [DIGEST] section 10.2.

[DIGEST] allows multiple digests with different algorithms to be sent in the digest header field. This specification opts for simplicity of requiring only a single digest to be sent. In addition this specification limits the algorithms that can be used in order to meet the goal of non-repudiation and increase interoperability.

**NOTE:** 
We recommend that either the `id-sha-256` or `id-sha-512` algorithms be used. For the purposes of non-repudiation, the content-encoding should be irrelevant and these algorithms mean that the representation data is hashed prior to any content encoding.


#### 5.2.2 `dpr` - DPoP request signature hash

This claim can be used to cryptographically link a signed HTTP response to a signed HTTP request. It is the hash of the DPoP proof received in the signed HTTP request. It cannot be used when signing an HTTP request, and is optional when signing an HTTP response.

The value of the `dpr` claim shall be the base64url encoding of the digest of the bytes of the ASCII representation of the DPoP proof received in the HTTP request where the digest algorithm used is the same as the hash function primitive that was used to calculate the value of the `htd` claim.

#### 5.2.3 `htm` and `htu` for HTTP responses

The `htm` and `htu` claims are defined in [DPOP] in the context of an HTTP request. This specification allows these claims to be used when signing an HTTP response with the following semantics:

 - `htm` - the HTTP method of the HTTP request that caused the HTTP response
 - `htu` - the HTTP URI of the HTTP request, without query and fragment parts, that caused the HTTP response


### 5.3 Signing HTTP Requests

To sign an HTTP request, a DPoP proof is created according to [DPOP] but with the additional `htd` claim. This claim is the digest of the HTTP request body as defined in 5.2.

The DPoP proof is sent in the `DPoP` http header as described in [DPOP].

An example request is shown below followed by the decoded content of the DPoP proof showing the JSON of the JOSE header and payload but omitting the signature part. Line breaks and extra whitespace are included for formatting and readability.

Example Singed HTTP Request: 
```
POST /books HTTP/1.1
Host: example.com
Content-Type: application/json
Accept: application/json
Accept-Encoding: identity
DPoP: eyJ0eXAiOiJkcG9wK2p3dCIsImFsZyI6IkVTMjU2IiwiandrIjp7Imt0eSI6Ik
 VDIiwieCI6IlRBSW5NNmZnemp1aGphSXlva3g5dXAyYlFRYW1TVGlaZ2RNYVhqNWtMW
 DQiLCJ5IjoiVGR4d29WU05pYnkwR3pscWx0QjdfTE56R2lFOEFXcGw4TlRPQW5nSFV6
 TSIsImNydiI6IlAtMjU2In19.eyJqdGkiOiI5bHRjNEFDQzNlc2M1QndDLWxjIiwiaH
 RtIjoiUE9TVCIsImh0dSI6Imh0dHBzOi8vZXhhbXBsZS5jb20vYm9va3MiLCJpYXQiO
 jE2MDYzNDM5MDMsImh0ZCI6InNoYS0yNTY9YldvcEdHTmladGJWZ0hzRytJNGtuemZF
 SnBtbW1RSGY3UkhEWEEzbzFoUT0ifQ.6djiCghBCVXAAj3tKKlsWjV2n4otMj0-dSPA
 ki2-OH3DHOz1Fo5qs7lyNLk_Ku-wKw0c8NADrQXSBT1meUFDSg
 
{"title": "New Title"}
```

Decoded Content of the DPoP Proof from the Above Example: 
```
{
  "typ":"dpop+jwt",
  "alg":"ES256",
  "jwk": {
    "kty":"EC",
    "x":"TAInM6fgzjuhjaIyokx9up2bQQamSTiZgdMaXj5kLX4",
    "y":"TdxwoVSNiby0GzlqltB7_LNzGiE8AWpl8NTOAngHUzM",
    "crv":"P-256"
  }
}
.
{
  "jti":"9ltc4ACC3esc5BwC-lc",
  "htm":"POST",
  "htu":"https://example.com/books",
  "iat":1606343903,
  "htd":"sha-256=bWopGGNiZtbVgHsG+I4knzfEJpmmmQHf7RHDXA3o1hQ="
}

```

### 5.4 Verifying Signed HTTP Requests

To verify a signed HTTP request, all the steps listed in "Checking DPoP Proofs" in [DPOP] shall be followed. In addition the verifier shall calculate the representation-data digest of the HTTP message using the algorithm specified in the `htd` claim. The calculated digest shall be compared to ensure that it matches the digest in the `htd` claim. 


### 5.5 Signing HTTP Responses

While [DPOP] defines a mechanism for sending a DPoP proof in the `DPoP` HTTP request header, this specification allows DPoP proofs to be sent in an HTTP response using the same `DPoP` header.

To sign an HTTP response a DPoP proof shall be created according to [DPOP] but with the following differences to the claims:

 - `htu` - the HTTP URI of the received HTTP request (REQUIRED)
 - `htm` - the HTTP method of the received HTTP request (REQUIRED)
 - `htd` - the digest of the HTTP representation-data (the response body) (REQUIRED)
 - `dpr` - the hash of the DPoP proof of the received HTTP request (OPTIONAL)

The following example shows the response to the request in the prior example. It is followed by the decoded content of the DPoP proof showing the JSON of the JOSE header and payload but omitting the signature part. Line breaks and extra whitespace are included for formatting and readability.

Example Singed HTTP Response: 
```
HTTP/1.1 201 Created
Content-Type: application/json
Location: /books/123
DPoP: eyJ0eXAiOiJkcG9wK2p3dCIsImFsZyI6IkVTMjU2IiwiandrIjp7Imt0eSI6Ik
 VDIiwieCI6InpGbG9RMDJRdFZDVTRzVUpsTXhXd1g2NjE1Y3ZNNURNUUZZQllPUmlrW
 WMiLCJ5IjoiV2RRT1lzT0Z4RFh5RldpQ2xoM19qQWQ4UWUydHpOZnlGZ2UyNkpCXzZY
 dyIsImNydiI6IlAtMjU2In19.eyJqdGkiOiJiV0NfN2VTQzhhY0M5TFRDIiwiaHRtIj
 oiUE9TVCIsImh0dSI6Imh0dHBzOi8vZXhhbXBsZS5jb20vYm9va3MiLCJpYXQiOjE2M
 DYzNDM5MDQsImh0ZCI6InNoYS0yNTY9L09RZW9KOXQ5c0VzTlBJYjhsSDJpbTNnMWRV
 ZWNKNEZ3TEVLTmlSNFowWT0iLCJkcHIiOiJmM1JLcURiRVVpSmhZT2w4blBWZG1jRzZ
 FcTQ0M1BnZ1NwWERzb2l1WWZBIn0.umgiQnQTVg0XvlPbDnZL9sHlT_qzaPzrCUmo5w
 nz0t5YWT3Lvldi8F-rwf_Gl5jxe4Ahgh9C4GObDAX3DTO09A

{"status": "created", "id": "123", "instance": "/books/123"}
```

Decoded Content of the DPoP Proof from the Response Example Above:

```
{
  "typ":"dpop+jwt",
  "alg":"ES256",
  "jwk": {
    "kty":"EC",
    "x":"zFloQ02QtVCU4sUJlMxWwX6615cvM5DMQFYBYORikYc",
    "y":"WdQOYsOFxDXyFWiClh3_jAd8Qe2tzNfyFge26JB_6Xw",
    "crv":"P-256"
  }
}
.
{
  "jti":"bWC_7eSC8acC9LTC",
  "htm":"POST",
  "htu":"https://example.com/books",
  "iat":1606343904,
  "htd":"sha-256=/OQeoJ9t9sEsNPIb8lH2im3g1dUecJ4FwLEKNiR4Z0Y=",
  "dpr":"f3RKqDbEUiJhYOl8nPVdmcG6Eq443PggSpXDsoiuYfA"
}


```

### 5.6 Verifying Signed HTTP Responses

To verify a signed HTTP response, all the steps listed in "Checking DPoP Proofs" in [DPOP] shall be followed with the following differences:

1. the `htm` claim matches the HTTP method value of the HTTP request that caused the HTTP response that contained the JWT,
2. the `htu` claim matches the HTTPS URI value of the HTTP request that caused the HTTP response that contained the JWT, ignoring any query and fragment parts,

In addition the verifier shall calculate the digest of the HTTP HTTP representation-data using the algorithm specified in the `htd` claim. The calculated digest shall be compared to ensure that it matches the digest in the `htd` claim. 

If a `dpr` claim is present, the verifier shall calculate the DPoP request signature hash of the DPoP proof that was sent in the HTTP request and ensure it matches the `dpr` claim. 

If a `dpr` claim is present when no `DPoP` proof was sent in the HTTP request the received proof is invalid.

## 6. Key Verification

For the purposes of non-repudiation the receiver of a DPoP proof must determine that the key the sender used to sign the proof is valid for that purpose. This is beyond the scope of this specification as it is likely to be ecosystem and implementation specific. Here are some examples of how such verification could be achieved.

### 6.1 Lookup at `jwks_uri`

The recipient of the proof could lookup the key at a pre-registered `jwks_uri` associated with the sender. The matching key hosted at the `jwks_uri` could have additional metadata such as an `x5c` value that contains a certificate signed by a trusted authority.  

### 6.2 `x5c` embedded certificate

The JWK in the DPoP proof could include the full X509 certificate. The recipient would need to verify that the public key in the JWK matched the certificate (as specified in [RFC7517]) and that the certificate was valid for the sender. While this approach would increase the size of the DPoP proof it has the advantage that a recipient could store the HTTP body and the DPoP proof for non-repudiation purposes without needing any additional data.

### 6.3 `x5u` certificate url

The JWK in the DPoP proof could include a url to the certificate. The recipient would retrieve the certificate, verify it matches the key (as specified in [RFC7517]), and verify that it is valid for the sender.

### 6.4 Certificate thumbprint lookup

The JWK in the DPoP proof could include a thumbprint (e.g. `x5t#S256`) of the certificate. The recipient would be able to compare the thumbprint to a list of pre-registered certificates valid for the sender. 


## 7. Signing HTTP headers

This specification has made the design choice not to sign additional HTTP headers. To do so would bring additional complexity and would likely cause interoperability issues. Furthermore we consider it to be best practice that any data that is required for non-repudiation is sent in the body of a request or a response and not in the headers. 

As an example, if an HTTP request is being used to initiate a payment, any fraud indicators such as the geo-location of the end-user should be sent in the request body and not in a request header.


## 6. Security Considerations

todo


## 7. Privacy Considerations

This specification is designed to support the use-case of non-repudiation. This may involve HTTP requests or responses being stored for many years in case they are needed as evidence in a dispute. 

Such data may well contain personally identifiable information and therefore care must be taken to ensure such information is protected.


## 8. IANA Considerations

### 8.1  JSON Web Token Claims Registration

This specification requests registration of the following Claims in the 
IANA "JSON Web Token Claims" registry established by [RFC7519].

HTTP digest:

 *  Claim Name: `htd`
 *  Claim Description: The digest of the HTTP representation-data 
 *  Change Controller: IESG
 *  Specification Document(s):  [[ 5.2 of this specification ]]
 
DPoP request signature hash:
 
 *  Claim Name: `dpr`
 *  Claim Description: The hash value of a DPoP proof
 *  Change Controller: IESG
 *  Specification Document(s):  [[ 5.2 of this specification ]]


## 9. Acknowledgement

The following people contributed heavily towards this document:

* Dave Tonge (Moneyhub)
* Brian Campbell (Ping Identity)


## 10. Bibliography



## Appendix A - Examples

