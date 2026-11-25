<!--
  docs/adr/NNNN-kebab-title.md template, for app repos, derived from
  slug-pages and product-catalog. One file per significant, hard-to-reverse
  decision.

  Filename: four-digit zero-padded sequence number + kebab-case title,
  e.g. 0001-no-authentication.md. Numbers never get reused, even if an
  earlier ADR is later superseded; add a new one instead of rewriting
  history.

  Shape: a title, one or two prose paragraphs, and a closing
  "**Consequences**:" line. No other headings, no status field, no
  alternatives-considered table; keep it to the size these repos'
  existing ADRs actually use (roughly 60-120 words total).
-->

# [Decision, stated as a fact, not a question]

[Paragraph 1: what was chosen and, briefly, what the realistic alternative(s)
were. Name the actual option(s) considered, not a strawman, e.g. "Clean
Architecture" or "a decorated single-pane editor," not "we thought about
other ways to do it."]

[Optional paragraph 2: a technical detail worth recording: a specific
mechanism, a library choice and why it beat a named alternative, a
constraint from the project's actual scope (team size, timeline, what this
product intentionally isn't).]

**Consequences**: [What is now true because of this: a limitation to
accept, a cost paid, or a condition under which this should be revisited.
This line is mandatory; it's what stops a future reread from re-litigating
a decision that already accounted for its downside.]
