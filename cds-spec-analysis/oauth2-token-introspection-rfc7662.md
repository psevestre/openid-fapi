# OAuth 2.0 Token Introspection

The following provides a clause by clause breakdown comparing [OAuth 2.0 Token Introspection](https://tools.ietf.org/html/rfc7662) to the published [Consumer Data Standards v0.9.5](https://consumerdatastandardsaustralia.github.io/standards).

|  **https://tools.ietf.org/html/rfc7662** | **CDS Guidance** | **Modifies Upstream Standard** | **Summary** |
| --- | --- | --- | --- |
|  [1.  Introduction](https://tools.ietf.org/html/rfc7662#section-1) | Yes | Yes :stop_sign: | The [CDS specifies that Token Introspection](https://consumerdatastandardsaustralia.github.io/standards/#end-points) is allowed **ONLY** for *Refresh Tokens*. <br /><br />*Access Token* and *ID Token* introspection is **NOT ALLOWED** |
|  [1.1. Notational Conventions](https://tools.ietf.org/html/rfc7662#section-1.1) | Implicit | N/A | [Aligned to Standards](https://consumerdatastandardsaustralia.github.io/standards/#introduction "Aligned to Standards") |
|  [1.2.  Terminology](https://tools.ietf.org/html/rfc7662#section-1.2) | No | N/A |  |
|  [2.  Introspection Endpoint](https://tools.ietf.org/html/rfc7662#section-2) | Yes | No | MTLS in use.  |
|  [2.1.  Introspection Request](https://tools.ietf.org/html/rfc7662#section-2.1) | Yes | Yes :stop_sign: | Only introspection of *Refresh Tokens* is permitted. `token` value of `access_token` is **NOT** permitted |
|  [2.2.  Introspection Response](https://tools.ietf.org/html/rfc7662#section-2.2) | Yes | Yes :stop_sign: | The [CDS](https://consumerdatastandardsaustralia.github.io/standards/#end-points) allows only the `active` and `exp` claims. All other attributes are explicitly **NOT ALLOWED**. |
|  [2.3.  Error Response](https://tools.ietf.org/html/rfc7662#section-2.3) | No | N/A |  |
|  [3.  IANA Considerations](https://tools.ietf.org/html/rfc7662#section-3) | No | N/A |  |
|  [3.1.  OAuth Token Introspection Response Registry](https://tools.ietf.org/html/rfc7662#section-3.1) | No | N/A |  |
|  [3.1.1.  Registration Template](https://tools.ietf.org/html/rfc7662#section-3.1.1) | No | N/A |  |
|  [3.1.2.  Initial Registry Contents](https://tools.ietf.org/html/rfc7662#section-3.1.2) | No | N/A |  |
|  [4.  Security Considerations](https://tools.ietf.org/html/rfc7662#section-4) | No | N/A | MTLS in use |
|  [5.  Privacy Considerations](https://tools.ietf.org/html/rfc7662#section-5) | No | N/A |  |
