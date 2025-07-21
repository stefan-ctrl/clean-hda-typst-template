# Clean HDA

A [Typst](https://typst.app/) template for h_da thesis and papers in the department of Computer Sciences.


The template recreates
[mbredel/thesis-template](https://github.com/mbredel/thesis-template) by
forking the the existing template of [DHBW](https://github.com/roland-KA/clean-dhbw-typst-template), which looked the most similar to the
original latex implementation for h_da students. 

This is an **unofficial** template for [Hochschule Darmstadt - University of Applied Sciences](https://h-da.de/en/) for the department of Computer Sciences.
Contributions and takeover by h_da affiliated are welcome. 
 
## Getting started

Run the following command in your terminal to create a new project using this template:


Make sure to replace `<version>` with the actual version you want to use, e.g. `0.1.0`.

```console
typst init @preview/clean-hda:<version> MyMasterThesis
```

## Getting started for template development

You may want to follow these steps if you want to contribute to the template itself and make your development easier for fast iteration cycles.

1. Add this as a git submodule
```console
git submodule add https://github.com/stefan-ctrl/clean-hda-typst-template hda_template
```

2. Include as the following in your `main.typst`:

```typst
#import "./hda_template/template/main.typ": *
```

Contributions are welcome.

## Abbreviations

The template includes built-in support for abbreviations using the `abbr` package. You can define your abbreviations in a CSV file and reference them throughout your document.

### Setting up abbreviations

1. Create a CSV file with your abbreviations (e.g., `abbr.csv`):
```csv
PR,Pull Request
MR,Merge Request
K8S,Kubernetes
CI/CD,Continuous Integration/Continuous Deployment
h_da,Hochschule Darmstadt
```

2. Reference the CSV file in your main document:
```typst
#show: clean-hda.with(
  // ... other configuration ...
  abbr-list-csv: "abbr.csv", // path to your abbreviations file
)
```

### Using abbreviations in your text

Once configured, you can use abbreviations in your text with the `@` symbol or
by using `abbr` [package/abbr](https://typst.app/universe/package/abbr/):

```typst
This @PR implements a new feature for @K8S deployment.
The @CI/CD pipeline at @h_da ensures quality.
```

The template will automatically:
- Generate a list of abbreviations in the front matter
- Expand abbreviations on first use
- Use short forms on subsequent references
- Create clickable links between abbreviations and their definitions

## Forked from DHBW Template

Please review the original forked documentation for more information, configuration and usage options :
[roland-KA/clean-dhbw-typst-template](https://github.com/roland-KA/clean-dhbw-typst-template)

To see the direct changes compared to the forked project, consider
taking a look at the [CHANGELOG.MD](./CHANGELOG.md).
