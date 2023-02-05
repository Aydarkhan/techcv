
This LaTeX class extends *extarticle* class to provide standard
building blocks for a typical technical CV.

# Quick start

Run *make* to install and generate the example PDF
```
make
```
One can also manually compile the example. Tested with *pdflatex* and *biber*.

# Prerequisistes

The package was tested on Linux with TeX Live installed.

# Install
```
make install
```

# Generate example PDF with make
```
make pdf
```

# Usage
The example contains all available commands.

I suggest to use *paracol* package to organize the layout
of the first page in two columns.

The package defines an option *yearbullet* to toggle between two styles.

Some colors and lengths can be changed:
```
\setlength{\yearfield}{1.5cm}
\definecolor{yearbulletcolor}{rgb}{0,0.2,0.6}
```

Defined colors:

- linkcolor - for hyperlinks
- yearbulletcolor - for the the timeline
- titlecolor   
- titleshade - for title background

Defined lengths:

- \\yearfield

 
## Automatic publication generation
Insert automatically generated bibliography
```
\nocite{*}
\printbibtabular[title=Section title]
```
Set up the bibliography using commands from *biblatex*, e.g.
\\addbibresource{publications.bib}.
