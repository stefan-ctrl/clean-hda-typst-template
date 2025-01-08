#import "@preview/codelst:2.0.1": *
#import "@preview/hydra:0.5.1": hydra
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl
#import "glossary-lib.typ": init-glossary, print-glossary, gls
#import "locale.typ": TABLE_OF_CONTENTS, APPENDIX, REFERENCES
#import "titlepage.typ": *
#import "confidentiality-statement.typ": *
#import "declaration-of-authorship.typ": *
#import "check-attributes.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let page-numbering-symbols = (
  "1",
  "a",
  "A",
  "i",
  "I",
  "α",
  "Α",
  "*",
  "א",
  "一",
  "壹",
  "あ",
  "い",
  "ア",
  "イ",
  "ㄱ",
  "가",
  "\u{0661}",
  "\u{06F1}",
  "\u{0967}",
  "\u{09E7}",
  "\u{0995}",
  "①",
  "⓵",
)

#let supercharged-dhbw(
  title: none,
  authors: (:),
  language: none,
  at-university: none,
  confidentiality-marker: (display: false),
  type-of-thesis: none,
  type-of-degree: none,
  show-confidentiality-statement: true,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-acronyms: true,
  show-abstract: true,
  numbering-alignment: center,
  toc-depth: 3,
  acronym-spacing: 5em,
  glossary-spacing: 1.5em,
  abstract: none,
  appendix: none,
  acronyms: none,
  glossary: none,
  header: none,
  confidentiality-statement-content: none,
  declaration-of-authorship-content: none,
  titlepage-content: none,
  university: none,
  university-location: none,
  university-short: none,
  city: none,
  supervisor: (:),
  date: none,
  date-format: "[day].[month].[year]",
  bibliography: none,
  bib-style: "ieee",
  heading-numbering: "1.1",
  math-numbering: "(1)",
  page-numbering: (preface: "I", main: "1 / 1", appendix: "a"),
  logo-left: image("dhbw.svg"),
  logo-right: none,
  logo-size-ratio: "1:1",
  ignored-link-label-keys-for-highlighting: (),
  body,
) = {
  // check required attributes
  check-attributes(
    title,
    authors,
    language,
    at-university,
    confidentiality-marker,
    type-of-thesis,
    type-of-degree,
    show-confidentiality-statement,
    show-declaration-of-authorship,
    show-table-of-contents,
    show-acronyms,
    show-abstract,
    header,
    numbering-alignment,
    toc-depth,
    acronym-spacing,
    glossary-spacing,
    abstract,
    appendix,
    acronyms,
    university,
    university-location,
    supervisor,
    date,
    city,
    bibliography,
    bib-style,
    logo-left,
    logo-right,
    logo-size-ratio,
    university-short,
    heading-numbering,
    math-numbering,
    ignored-link-label-keys-for-highlighting,
    page-numbering,
  )

  // ---------- Fonts & Related Measures ---------------------------------------

  let body-font = "Source Serif 4"
  let body-size = 11pt
  let heading-font = "Source Sans 3"
  let h1-size = 40pt
  let h2-size = 16pt
  let h3-size = 11pt
  let h4-size = 11pt
  let page-grid = 16pt  // vertical spacing on all pages

  
  // ---------- Basic Document Settings ---------------------------------------

  set document(title: title, author: authors.map(author => author.name))
  let many-authors = authors.len() > 3
  let in-frontmatter = state("in-frontmatter", true)    // to control page number format in frontmatter

  // define logo size with given ration
  // let left-logo-height = 2.4cm // left logo is always 2.4cm high
  // let right-logo-height = 2.4cm // right logo defaults to 1.2cm but is adjusted below
  // let logo-ratio = logo-size-ratio.split(":")
  // if (logo-ratio.len() == 2) {
  //   right-logo-height = right-logo-height * (float(logo-ratio.at(1)) / float(logo-ratio.at(0)))
  // }

  init-acronyms(acronyms)
  init-glossary(glossary)

  // customize look of figure
  set figure.caption(separator: [ --- ], position: bottom)

  // math numbering
  set math.equation(numbering: math-numbering)

  // set link style for links that are not acronyms
  let acronym-keys = if (acronyms != none) {
    acronyms.keys().map(acr => ("acronyms-" + acr))
  } else {
    ()
  }
  let glossary-keys = if (glossary != none) {
    glossary.keys().map(gls => ("glossary-" + gls))
  } else {
    ()
  }
  show link: it => if (str(it.dest) not in (acronym-keys + glossary-keys + ignored-link-label-keys-for-highlighting)) {
    text(fill: blue, it)
  } else {
    it
  }

  // ========== TITLEPAGE ========================================

  if (titlepage-content != none) {
    titlepage-content
  } else {
    titlepage(
      authors,
      date,
      heading-font,
      language,
      logo-left,
      logo-right,
      many-authors,
      supervisor,
      title,
      type-of-degree,
      type-of-thesis,
      university,
      university-location,
      at-university,
      date-format,
      show-confidentiality-statement,
      confidentiality-marker,
      university-short,
      page-grid,
    )
  }
  counter(page).update(1)  

  // ---------- Page Setup ---------------------------------------

  // adapt body text layout to basic measures
  set text(
    font: body-font, 
    lang: language, 
    size: body-size - 0.5pt,      // 0.5pt adjustment because of large x-hight
    top-edge: 0.75 * body-size, 
    bottom-edge: -0.25 * body-size,
  )
  set par(
    spacing: page-grid,
    leading: page-grid - body-size, 
    justify: true,
  )

  set page(
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
    header:
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        row-gutter: 0.5em,
        smallcaps(text(font: heading-font, size: body-size, 
          context {
            hydra(1, display: (_, it) => it.body, use-last: true, skip-starting: false)
          },
        )),
        text(font: heading-font, size: body-size, 
          number-type: "lining",
          context {if in-frontmatter.get() {
              counter(page).display("i")      // roman page numbers for the frontmatter
            } else {
              counter(page).display("1")      // arabic page numbers for the rest of the document
            }
          }
        ),
        grid.cell(colspan: 2, line(length: 100%, stroke: 0.5pt)),
      ),
      header-ascent: page-grid,
  )


  // ========== FRONTMATTER ========================================
  
  // ---------- Heading Format (Part I) ---------------------------------------

  show heading: set text(weight: "bold", fill: luma(80), font: heading-font)
  show heading.where(level: 1): it => {v(2 * page-grid) + text(size: 2 * page-grid, it)}   // only frontmatter

  // ---------- Abstract ---------------------------------------

  if (show-abstract and abstract != none) {
    heading(level: 1, numbering: none, outlined: false, ABSTRACT.at(language))
    text(abstract)
    pagebreak()
  }

  // ---------- Outline ---------------------------------------

  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    v(page-grid, weak: true)
    set text(font: heading-font, weight: "semibold", size: body-size)
    it.body
    box(width: 1fr,)
    text(weight: "semibold", it.page)
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set text(font: heading-font, size: body-size)
    it.body + "  "
    box(width: 1fr, repeat([.], gap: 2pt), baseline: 30%, height: body-size + 1pt)
    "  " + it.page
  }

  if (show-table-of-contents) {
    outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: toc-depth,
    )
  }

  in-frontmatter.update(false)  // end of frontmatter
  counter(page).update(0)       // so the first chapter starts at page 1 (now in arabic numbers)


  // ========== DOCUMENT BODY ========================================

 // ---------- Heading Format (Part II: H1-H4) ---------------------------------------

  set heading(numbering: heading-numbering)

  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(it, top-edge: 0.75em, bottom-edge: -0.25em)
    v(page-grid, weak: true)
  }

  show heading.where(level: 1): it => {
    set par(leading: 0pt, justify: false)
    pagebreak()
    v(page-grid * 10)
    place(              // place heading number prominently at the upper right corner
      top + right,
      dx: 9pt,          // slight adjustment for optimal alignment with right margin
      text(counter(heading).display(), 
        top-edge: "bounds",
        size: page-grid * 10, weight: 900, luma(235), 
      )
    )
    text(               // heading text on separate line
      it.body, size: h1-size,
      top-edge: 0.75em, 
      bottom-edge: -0.25em,
    )
  }

  show heading.where(level: 2): it => {v(16pt) + text(size: h2-size, it)}
  show heading.where(level: 3): it => {v(16pt) + text(size: h3-size, it)}
  show heading.where(level: 4): it => {v(16pt) + smallcaps(text(size: h4-size, weight: "semibold", it.body))}

 // ---------- Body Text ---------------------------------------

  body


  // ========== APPENDIX ========================================

  // ---------- Bibliography ---------------------------------------

  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
    bibliography
  }

  if (appendix != none) {
    heading(level: 1, numbering: none)[#APPENDIX.at(language)]
    appendix
  }

  // ---------- Acronyms & Glossary ---------------------------------------

  if (show-acronyms and acronyms != none and acronyms.len() > 0) {
    print-acronyms(language, acronym-spacing)
  }

  if (glossary != none and glossary.len() > 0) {
    print-glossary(language, glossary-spacing)
  }

  // ---------- Confidentiality Statement ---------------------------------------

  if (not at-university and show-confidentiality-statement) {
    pagebreak()
    confidentiality-statement(
      authors,
      title,
      confidentiality-statement-content,
      university,
      university-location,
      date,
      language,
      many-authors,
      date-format,
    )
  }

  // ---------- Declaration Of Authorship ---------------------------------------

  if (show-declaration-of-authorship) {
    pagebreak()
    declaration-of-authorship(
      authors,
      title,
      declaration-of-authorship-content,
      date,
      language,
      many-authors,
      at-university,
      city,
      date-format,
    )
  }

}
