# Security Policy

Thank you for helping keep docker-latex and its users safe.

## Reporting a Vulnerability

Please report security issues privately. Do not open public GitHub issues for
potential vulnerabilities.

Preferred channel: GitHub Security Advisories

- Create a new private advisory:
  <https://github.com/lbenicio/docker-latex/security/advisories/new>

What to include:

- A clear description of the issue and its impact
- Steps to reproduce or a minimal proof-of-concept
- Affected version or commit (tag/sha) and your environment
- Any proposed mitigations or patches (optional)

Response & timelines (best effort):

- Acknowledgement: within 3 business days
- Initial assessment: within 7 days
- Target fix or mitigation: as soon as practical, typically within 30–90 days
- Coordinated disclosure: we’ll work with you on timing; credit will be given
  unless you prefer to remain anonymous

If you cannot use GitHub advisories, you may open a short GitHub Discussion asking
for a private contact method. Please avoid sharing sensitive details publicly.

## Scope

This project’s scope includes the Docker build definition and entrypoint scripts
that ship with this repository. Vulnerabilities in upstream dependencies (Debian,
TeX Live, latexmk, biber, etc.) should be reported to their respective projects.
If you believe an upstream issue critically impacts this image, you can still let
us know via a private advisory so we can track and mitigate (e.g., via package
updates) where possible.

## Supported Versions

We aim to support:

- main (default branch)
- the latest released/tagged image

Older tags may receive best-effort updates but are generally considered out of
active support. If you rely on an older tag and need a fix, please open a private
advisory with details.

## Non-security Issues

For non-sensitive bugs, feature requests, or questions, please use regular GitHub
Issues or Discussions.

## No Bug Bounty

This project does not run a paid bug bounty program. We still very much appreciate
responsible disclosures and will gladly acknowledge contributions.
