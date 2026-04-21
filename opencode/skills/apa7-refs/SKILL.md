---
name: apa7-refs
description: Format reference lists in APA 7th edition style. Use when drafting or revising reference sections, or when formatting in-text citations.
license: MIT
---

# Skill: apa7-refs

#style-core

## Reference List: General Rules

1. **Hanging indent**: All references use a hanging indent (first line flush left, subsequent lines indented 0.5"). In markdown, use `<p style="text-indent: -0.5in; padding-left: 0.5in;">` or rely on the conversion tool to apply it.
2. **Alphabetical order**: Sort by first author's last name, then initials. Use letter-by-letter for names without dates. Multiple works by the same author: order by year (earliest first).
3. **Italicization**: Only italicize titles of standalone works (books, journals, websites). Do NOT italicize article titles, chapter titles, or DOIs.
4. **Sentence case for article titles**: Capitalize only the first word, proper nouns, and words after colons. Journal names use title case and are always italicized.
5. **Author name format**: Last name, Initials with periods. Use comma between last name and initials. Separate multiple authors with commas (not &).
6. **Year**: Place immediately after last author name in parentheses.
7. **DOI format**: Always use `https://doi.org/...` — never "Retrieved from" URLs for DOIs. No period after DOI.
8. **URL format**: Only for works without a DOI. Include "Retrieved from" before the URL. Do not include access dates unless the source is a wiki or archival document with no publication date.

## Reference Types

### Journal Article

```
Author, A. A., & Author, B. B. (Year). Title of article. Title of Periodical, volume(issue), pages. https://doi.org/xxxxx
```

- Italicize: Periodical title (journal name) and volume number
- Do NOT italicize: Article title, issue number, page numbers, DOI
- Include issue number only if the journal does not use continuous pagination
- Example:
  ```
  Smith, J. A., & Jones, B. C. (2023). Cognitive effects of sleep deprivation. Journal of Sleep Research, 42(3), 215–230. https://doi.org/10.1234/jsr.2023.0421
  ```

### Book

```
Author, A. A. (Year). Title of work: Capital letter also for subtitle (Edition ed.). Publisher.
```

- Italicize: Title of work
- Include "(X ed.)" only for editions other than the first
- Example:
  ```
  Brown, L. S. (2018). Critical thinking in psychology (3rd ed.). Wiley.
  ```

### Chapter in an Edited Volume

```
Author, A. A. (Year). Title of chapter. In E. E. Editor & F. F. Editor (Eds.), Title of book (pp. xx–xx). Publisher. https://doi.org/xxxxx
```

- Italicize: Book title only
- Do NOT italicize: Chapter title
- Example:
  ```
  Garcia, M. E. (2019). Statistical power in ANOVA designs. In R. S. Kaplan & S. P. Ellis (Eds.), Handbook of research methods (pp. 145–178). Oxford University Press. https://doi.org/10.1234/hrp.2019.0012
  ```

### Preprint / Open Access Server

```
Author, A. A. (Year, Month Day). Title of preprint. Name of Server. https://doi.org/xxxxx
```

- For PsyArXiv, OSF preprints, and similar servers
- Include the server name
- Example:
  ```
  Nguyen, T. H., & Patel, R. S. (2024, March 15). Replication failures in social priming studies. PsyArXiv. https://doi.org/10.1234/psyarxiv.abcde
  ```

### Dissertation / Thesis

```
Author, A. A. (Year). Title of dissertation/ thesis [Doctoral dissertation/Master's thesis, University Name].
```

- Italicize: Title
- Include the institution and bracketed descriptor
- Example:
  ```
  Kim, S. J. (2021). Neural correlates of decision-making under uncertainty [Doctoral dissertation, Harvard University]. ProQuest Information and Learning.
  ```

### Web Page

```
Author, A. A. (Year, Month Day). Title of page. Site Name. https://url
```

- Include date only if available
- Use "Retrieved from" only if no author or date
- Example:
  ```
  American Psychological Association. (2023, January 15). Guidelines for psychological practice. https://www.apa.org/practice/guidelines
  ```

### Conference Proceedings

```
Author, A. A. (Year). Title of paper. In Proceedings of the Conference Name (pp. xx–xx). Publisher. https://doi.org/xxxxx
```

### Software / Data / Model

```
Author, A. A. (Year). Title of software/data/model (Version X.X) [Description]. Site. https://doi.org/xxxxx
```

- Include version number in parentheses after title
- Example:
  ```
  R Core Team. (2023). R: A language and environment for statistical computing (Version 4.3.1) [Computer software]. R Foundation. https://www.R-project.org/
  ```

### Authored Edited Volume (Full Book as Editor)

```
Editor, A. A., & Editor, B. B. (Eds.). (Year). Title of edited volume. Publisher.
```

## In-Text Citations

### Narrative citation
```
Smith (2023) argued that...
```

### Parenthetical citation
```
(Smith, 2023)
```

### Multiple authors
- 2 authors: Always cite both names
- 3+ authors: Use first author et al. on first citation, then just first author et al. on subsequent citations (APA 7 changed this from "always use et al." for 3+)

### Multiple works in one citation
```
(Smith, 2020; Jones, 2022; Brown & White, 2021)
```
Order alphabetically, then by year within author.

### Secondary sources
Use sparingly. Format: "as cited in Original Author, Year". Only list the source you actually read in the reference list.

## Common Mistakes to Avoid

1. **Italicizing article titles** — Only journal names and volume numbers are italicized
2. **Using "Retrieved from" with DOIs** — DOIs always take the form `https://doi.org/...` with no "Retrieved from"
3. **Missing issue numbers** — Include issue number unless the journal uses continuous pagination throughout the volume
4. **Wrong capitalization** — Article titles use sentence case; journal names use title case
5. **Author name formatting** — Use `Smith, J. A.` not `Smith J.A.` or `Smith JA`
6. **Missing "X ed." for reprints** — Only include edition if it is not the original
7. **DOI formatting** — Always include DOI if available; no period after DOI URL
8. **Inconsistent author lists** — Match exact author names as they appear on the source, including middle initials

## Note on Examples

The examples above demonstrate form, style, and structure. Their content and topics are for illustration only—do not copy substance into your writing.
