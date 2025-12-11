# Resume

This repository contains my resume as source in [JSON Resume](https://jsonresume.org/) format.
This is used to build HTML and PDF versions of my resume suitable for distribution.

## Organization

This repository is organized as follows:

``` text
.
├── README.md                     # This documentation
├── .github/
│   └── workflows/
│       └── deploy-resume.yml     # GitHub Actions workflow publishing resume to GitHub Pages
├── Makefile                      # Project automation
├── package.json                  # Project toolchain dependencies
├── package-lock.json             # Project toolchain dependencies lockfile
└── src/
    ├── resume.json               # JSON Resume instance file
    └── schema.json               # JSON Resume schema file
```

## Automation

This project contains a [`Makefile`](Makefile) providing convenient automation.
Ensure that [GNU `make`](https://www.gnu.org/software/make/) is found in your `PATH`.

To view a list of the build targets and their usage, run `make help`, simply
omit all arguments.

``` shell
make
```

You should see something like the following:

``` text
Usage:
  make <target>

Info targets
  help             Show this help
  vars             Show environment variables used by this Makefile

GitHub targets
  gh-repo          Open GitHub repository page
  gh-actions       Open GitHub Actions page for resume builds
  gh-pages         Open GitHub Pages page for latest published resume build

Toolchain targets
  tools-init       Initialize resume build toolchain
  tools-update     Update resume build toolchain
  tools-clean      Clean resume build toolchain

Build targets
  lint             Check resume source for issues
  build            Build resume for format (format=)
  preview          Preview resume build for format (format=)
  clean            Clean resume build for format (format=)

```

To list the build variables used by the build targets and their values, run
`make vars`.

``` shell
make vars
```

You should see something like the following:

``` text
ROOT_DIR:             /home/agooch/src/github.com/mojochao/resume
OUTPUT_DIR:           out
SOURCE_DIR:           src
GH_REPO_URL:          https://github.com/mojochao/resume
GH_ACTIONS_URL:       https://github.com/mojochao/resume/actions
GH_PAGES_URL:         https://mojochao.github.io/resume/index.html
PLATFORM_OS:          linux
PLATFORM_OPEN:        xdg-open
NODE_MODULES_DIR:     node_modules
NODE_BIN_DIR:         node_modules/.bin
JSONRESUME_CLI_BIN:   node_modules/.bin/resumed
JSONRESUME_CLI_PKG:   resume-cli
JSONRESUME_THEME_PKG: jsonresume-theme-even
JSONSCHEMA_CLI_BIN:   node_modules/.bin/jsonschema
JSONSCHEMA_CLI_PKG:   @sourcemeta/jsonschema
format:               html
schema_file:          src/schema.json
input_file:           src/resume.json
output_file:          out/agooch.resume.jsonresume-theme-even.html
```

Of all these variables, typically `format` is the one most used, especially
with the `Build` targets, as indicated by the `(format=)` in the `help` output.
If not provided, `format` will default to `html`. The only other valid format
option at the time is `pdf`.

This project also contains a GitHub Actions workflow on commits pushed to `main`
branch to build the HTML resume and publish it to GitHub pages for hosting,
utilizing build targets provided by this [`Makefile`](Makefile).

## Installation

In addition to GNU `make`, a JSON Resume builder is needed for generation of
resume document build artifacts.

The original [jsonresume-cli](https://jsonresume.org/) is no longer maintained,
but [resumed](https://github.com/rbardini/resumed) is a lightweight replacement.
It is a typescript project, so ensure that [nodejs](https://nodejs.org/) is
installed and `node` and `npm` are found in your `PATH`.

In addition, a JSON Resume theme is needed when generating resume build artifacts.
Peruse the [themes gallery](https://jsonresume.org/themes) for samples of build
output.

Once these dependencies are satisfied, the toolchain must be initialized before
resume builds may be performed.

``` shell
make tools-init
```

## Usage


Once initialized, resume builds may be performed.
After edits to the project are complete, first verify that things look good to build.

``` shell
make lint
```

Once verified, build the resume.

``` shell
make build
```

Once built, preview the build output.

``` shell
make preview
```

Once satisifed, commit the changes and push the commit back to origin.

``` shell
git ci -am 'Updated work skills' && git push
```

Once pushed, the build pipeline will kick off.
Review the pipelines in the GitHub Actions page for the repository.

``` shell
make gh-actions
```

Once the pipeline has successfully completed, the resume will have been published.
Review the published resume in the GitHub Pages page for the repository.

``` shell
make gh-pages
```

Note that if you wish to quickly open the GitHub repository for the project, you
can run the `make gh-repo` command.

``` shell
make gh-repo
```

