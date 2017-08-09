# How to create XML and HTML #
These instructions only work on a Linux OS.
They apply to all FAPI Markdown specs and not just the **Financial\_API\_WD\_001.md** as indicated. Replace **Financial\_API\_WD\_001.md** with the appropriate filename.


1. Install **xsltproc** package from Linux distribution

2. Install **pandoc2rfc** from [https://github.com/miekg/pandoc2rfc](https://github.com/miekg/pandoc2rfc)

3. In the pandoc2rfc directory, put attached **fapi_template.xml** template file. This file contains the authors, date, and some boilerplate text (Warning, Copyright, Foreword, Introduction sections as XML Note elements) from the markdown file. Edit as necessary.

4. Put **Financial_AP\_WD\_001.md** in pandoc2rfc directory

5. Manually, edit **Financial\_API\_WD_001.md** with the following :
	1. Delete **everything** above the **Scope** section (Warning, Copyright, Foreword, Introduction). These sections have been added to the **fapi\_template.xml** file already.
	2. Delete the section numbers and move the section up 1 level.  The markdown is manually numbered and the "##" is a subsection but we want the XML to start as a main section.

```
#!text

## 1. Scope == > # Scope
## 2. Normative references ==> # Normative references
...
## 5. Read Only API Security Profile ==> # Read Only API Security Profile
### 5.1 Introduction ==> ## Introduction
```
6.Run the following command to generate the XML using pandoc2rfc:

```
#!text

./pandoc2rfc -X -t fapi_template.xml -x transform.xsl Financial_API_WD_001.md
```
7.A **draft.xml** file is generated. This file can be used as input into **xml2rfc** to generate the HTML version.



# fapi_template.xml #
The **fapi_template.xml** contains
```
#!xml
<?xml version="1.0" ?>
<!DOCTYPE rfc SYSTEM 'rfc2629.dtd' [
<!ENTITY pandocMiddle PUBLIC '' 'Financial_API_WD_001.xml'>


]>

<rfc ipr="trust200902" category="info" docName="opend-fapi-financial_api_wd_001">
    <?rfc toc="yes" ?>
    <?rfc tocdepth="4" ?>
    <?rfc symrefs="yes" ?>
    <?rfc sortrefs="yes"?>
    <?rfc strict="yes" ?>
    <?rfc iprnotified="no" ?>
    <?rfc private="Draft" ?>

    <front>
        <title abbrev="FAPI - Part 1">Financial Services – Financial API - Part 1: Read Only API Security Profile</title>

        <author fullname="Nat Sakimura" initials="N." surname="Sakimura">
            <organization abbrev="NRI">Nomura Research Institute, Ltd.</organization>
            <address>
                <email>n-sakimura@nri.co.jp</email>
                <uri>http://nat.sakimura.org/</uri>
            </address>
        </author>
        <author fullname="John Bradley" initials="J." surname="Bradley">
            <organization abbrev="Ping Identity">Ping Identity</organization>
            <address>
                <email>ve7jtb@ve7jtb.com</email>
                <uri>http://www.thread-safe.com/</uri>
            </address>
        </author>
        <author fullname="Edmund Jay" initials="E." surname="Jay">
            <organization abbrev="Illumila">Illumila</organization>
            <address>
                <email>ejay@mgi1.com</email>
                <uri>http://illumi.la/</uri>
            </address>
        </author>
        <date day="24" month="January" year="2017"/>

        <note title="Warning"><t>This document is not an OIDF International Standard. It is distributed for review and comment. It is subject to change without notice and may not be referred to as an International Standard.  </t><t>Recipients of this draft are invited to submit, with their comments, notification of any relevant patent rights of which they are aware and to provide supporting documentation.  </t></note>
        <note title="Copyright notice"><t>The OpenID Foundation (OIDF) grants to any Contributor, developer, implementer, or other interested party a non-exclusive, royalty free, worldwide copyright license to reproduce, prepare derivative works from, distribute, perform and display, this Implementers Draft or Final Specification solely for the purposes of (i) developing specifications, and (ii) implementing Implementers Drafts and Final Specifications based on such documents, provided that attribution be made to the OIDF as the source of the material, but that such attribution does not indicate an endorsement by the OIDF.  </t><t>The technology described in this specification was made available from contributions from various sources, including members of the OpenID Foundation and others. Although the OpenID Foundation has taken steps to help ensure that the technology is available for distribution, it takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this specification or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any independent effort to identify any such rights. The OpenID Foundation and the contributors to this specification make no (and hereby expressly disclaim any) warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to this specification, and the entire risk as to implementing this specification is assumed by the implementer. The OpenID Intellectual Property Rights policy requires contributors to offer a patent promise not to assert certain patent claims against other contributors and against implementers. The OpenID Foundation invites any interested party to bring to its attention any copyrights, patents, patent applications, or other proprietary rights that may cover technology that may be required to practice this specification.  </t></note>
        <note title="Foreword"><t>OIDF (OpenID Foundation) is an international standardizing body comprised by over 160 participating entities (work group participants). The work of preparing international standards is carried out through OIDF work groups according to OpenID Process.  Each participants interested in a subject for which a work group has been established has the right to be represented on that work group. International organizations, governmental and non-governmental, in liaison with OIDF, also take part in the work. OIDF collaborates closely with other standardizing bodies in the related fields.  </t><t>OpenID Foundation standards are drafted in accordance with the rules given in the OpenID Process.  </t><t>The main task of work group is to prepare Implementers Draft and Final Draft. Final Draft adopted by the Work Group through consensus are circulated publicly for the public review for 60 days and for the OIDF members for voting. Publication as an OIDF Standard requires approval by at least 50 % of the members casting a vote.  </t><t>Attention is drawn to the possibility that some of the elements of this document may be the subject of patent rights. OIDF shall not be held responsible for identifying any or all such patent rights.  </t><t>Financial API - Part 1: Read Only API Security Profile was prepared by OpenID Foundation Financial API Work Group.  </t><t>Financial API consists of the following parts, under the general title Financial Services &#8212; Financial API: </t><t><list style="symbols"><t>Part 1: Read Only API Security Profile </t><t>Part 2: Read and Write API Security Profile </t><t>Part 3: Open Data API </t><t>Part 4: Protected Data API and Schema - Read only </t><t>Part 5: Protected Data API and Schema - Read and Write </t></list></t><t>This part is intended to be used with [RFC6749], [RFC6750], [RFC6736], and [OIDC].  </t></note>
        <note title="Introduction"><t>In many cases, Fintech services such as aggregation services use screen scraping and store user passwords. This model is both brittle and insecure. To cope with the brittleness, it should utilize an API model with structured data and to cope with insecurity, it should utilize a token model such as OAuth [RFC6749, RFC6750].  </t><t>Financial API aims to rectify the situation by developing a REST/JSON model protected by OAuth. However, just asking to use OAuth is too vague as there are many implementation choices. OAuth is a framework which can cover wide range of use-cases thus some implementation choices are easy to implement but less secure and some implementation choices are harder to implement but more secure.  Financial services on the internet is a use-case that requires more secure implementation choices. That is, OAuth needs to be profiled to be used in the financial use-cases.  </t><t>This document is a Part 1 of a set of document that specifies Financial API. It provides a profile of OAuth that is suitable to be used in the access of Read Only financial data. An even more secure profile that is suitable for a transactional (i.e., Read/Write) APIs are given in Part 2. Part 3 onwards provides the data schema for specific use-cases.  </t></note>

</front>

<middle>
&pandocMiddle;
</middle>

<back>

</back>
</rfc>


```
