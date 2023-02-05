
This class extends extarticle class to provide standard
blocks for typical technical CV.
Publications are generate from specified \*.bib file with

# Getting started

Run *make* to install and generate the example PDF
```
make
```
One can also manually compile the example. Tested with *pdflatex* and *biber*.

# Install
```
make install
```

# Generate example PDF with make
```
make pdf
```

# Usage
I suggest to use *paracol* package to organize the layout
of the first page.

The package defines an option *yearbullet* to toggle between two styles.

Provide info with command:

- \\author
- \\position 
- \\email 
- \\linkedin
- \\visa

Insert generators

- \\maketitle
- \\makecontact

List of environments

- summary / item
- joblist / yearitem
- eventlist / yearitem
- skills / item 
- referees / item
- languages / item
- publications / yearitem (manual) or bibtexitem (from \*.bib file)

Defined colors (can be redefined):

- linkcolor   for hyperlinks
- yearbulletcolor   for the the timeline
- titlecolor   
- titleshade   for title background
 
## Automatic publication generation
Insert automatically generated bibliography
```
\nocite{*}
\printbibtabular[title=Section title]
```
Setup bibliography using commands from *biblatex*, e.g.
\\addbibresource{publications.bib} 
