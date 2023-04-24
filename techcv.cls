%
% Title     Technical CV
% Author    Ruslan Aydarkhanov
% Version   0.2, 02/04/23
%
% This class extends extarticle class to provide standard
% blocks for typical technical CV.
% Publications are generate from specified *.bib file with
% biblatex package.
%  
%
% Options:
%  yearbullet
%
% Generators:
%  \maketitle  based on \author and \position
%  \makecontact based on \email, \linkedin and \visa
%  \printbibtabular from biblatex-ext-tabular package 
%
% Environments:
%  summary
%  joblist 
%  eventlist 
%  publications
%  skills
%  referees
%  languages
%
% Defined colors (can be redefined):
%  linkcolor   for hyperlinks
%  yearbulletcolor   for the the timeline
%  titlecolor   
%  titleshade   for title background
%  


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{techcv}[2023/02/04 Technical CV]

\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{yearbullet}{\def\@yearlistbullet{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass{extarticle}

\RequirePackage{etoolbox}
\RequirePackage{ragged2e}
\RequirePackage{calc}

\RequirePackage[none]{hyphenat}
\RequirePackage[top=1.5cm, bottom=1.5cm, left=1.5cm, right=1.5cm]{geometry}
\RequirePackage[table,usenames,dvipsnames]{xcolor} % Required for specifying custom colors

\RequirePackage{tikz}

\RequirePackage[explicit]{titlesec}
\definecolor{titleshade}{rgb}{0.8,0.9,1.0}
\definecolor{titlecolor}{rgb}{0,0,0}
\titlespacing*{\section}{0pt}{4pt}{4pt} % Spacing around sections
%\titleformat{\section}
  %[hang]
  %{\Large\bfseries\centering}
  %{}
  %{0pt}{#1}
\titleformat{\section}
  [hang]
  {\Large\bfseries}
  {}
  {0pt}{
  \tikz{
  \node[shade,
        shading=axis, 
        shading angle=135, 
        right color=white,
        left color=white,
        middle color=titleshade,
        %left color=titleshade,
        %middle color=white,
        rounded corners=1mm,
        text depth=0pt,
        %line width=1pt,
        %draw,
        anchor=west,
        text width=\linewidth,
        align=center,
    ](a){{\color{titlecolor}#1}};
}}

\RequirePackage{enumitem}
\setlist{nosep, nolistsep, leftmargin=*}
%\setlist{noitemsep,topsep=0pt,parsep=0pt,partopsep=10pt}
%\setlist{nosep}

\ifluatex
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX} % To support LaTeX quoting style
  \setromanfont{Gentium Basic}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \usepackage{gentium}
\fi

\RequirePackage[backend=biber,style=trad-abbrv,giveninits=true,sorting=ydnt,
isbn=false,url=false,eprint=false,related=false]{biblatex}
\RequirePackage{biblatex-ext-tabular}

\RequirePackage{hyperref} % Required for adding links   and customizing them

\definecolor{linkcolor}{rgb}{0,0.2,0.6} % Link color
\hypersetup{colorlinks,breaklinks,urlcolor=linkcolor,linkcolor=linkcolor} % Set link colors throughout the document

%\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{makecell}


\newcommand\position[1]{\renewcommand\@position{#1}}
\newcommand\@position{\@latex@error{No \noexpand\position given}\@ehc}
\newcommand\email[1]{\renewcommand\@email{\href{mailto:#1}{#1}}}
\newcommand\@email{}
\newcommand\visa[1]{\renewcommand\@visa{{\bfseries\color{red}#1}}}
\newcommand\@visa{}

\renewrobustcmd*\author[4][]{
  \ifstrempty{#1}
  {\gdef\@author{#3 #2}}
  {\gdef\@author{#3 #2, #1}}
  \def\degree{#1}%
  \def\lastname{#2}%
  \def\firstname{#3}%
  \def\firstinit{#4}}

\newcommand\linkedin[1]{
  \renewcommand\@linkedin{%
  \href{https://www.linkedin.com/in/#1}
  {\raisebox{-.2\height}{\linkedinlogo} #1}%
}
}
\newcommand\@linkedin{}

\newcommand\googlescholar[1]{
	\renewcommand\@googlescholar{%
  \href{#1}
	{\raisebox{-.2\height}{\gscholarlogo} \firstname~\lastname}
}
}
\newcommand\@googlescholar

\newcommand\@contactinfo{
  \vspace*{-0.5\baselineskip}
  \@visa \par
  \@email \par
  \@linkedin \par 
	\@googlescholar
  }

\renewcommand\maketitle{\par
  \begingroup
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
    \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
	\global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
	\global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\@position\@empty
  \global\let\position\relax
}

\renewcommand\@maketitle{%
  \newpage
  \raggedright
  {\huge \bfseries \@author \par}
  {\large \@position \par}
  \vskip 1.5em
  }

\newcommand\makecontact{
  {%
  %\setlength\parindent{0pt}
  \raggedright
  \@contactinfo
  }

  \global\let\@email\@empty
  \global\let\email\relax
  \global\let\@linkedin\@empty
  \global\let\linkedin\relax
  \global\let\@googlescholar\@empty
  \global\let\googlescholar\relax
  \global\let\@visa\@empty
  \global\let\visa\relax
  \global\let\@contactinfo\@empty
  }


\newlength{\yearfield}
\setlength{\yearfield}{1.5cm}

\newcommand\tbullet{$\bullet$}
%\newcommand\tbullet{\bullet}
%\pgfmathsetlengthmacro{\bulletindent}{\tabcolsep + 0.5*width("$\tbullet$")}
\pgfmathsetlengthmacro{\bulletindent}{\tabcolsep + 0.5*width("\tbullet")}

\newcommand\yearbullet{}
\ifx \@yearlistbullet \undefined
	\rowcolors{2}{white}{tableevencolor}
	\definecolor{yearbulletcolor}{gray}{0.5}
\else
  \renewcommand{\yearbullet}{%
    \hspace{-\bulletindent}{\color{yearbulletcolor}\tbullet}%
    \vspace*{-\baselineskip} \newline%
    }
\fi


\newcolumntype{y}{>{\raggedleft}p{\yearfield}}
\newcolumntype{D}{>{\setlength{\parskip}{-0.3\baselineskip}}X}
\definecolor{tableevencolor}{gray}{0.95} % Table even color
\definecolor{yearbulletcolor}{rgb}{0,0.2,0.6}


\newenvironment{joblist}{%
  \renewcommand*{\arraystretch}{1.5}
  \let\olditemize\itemize
  \let\endolditemize\enditemize
  \renewenvironment{itemize}{%
    \begin{minipage}[t]{\linewidth}
    \olditemize
    }{%
        \endolditemize
        \end{minipage}%
    }

  \arrayrulecolor{yearbulletcolor}

  \newcommand\yearitem[6]{%
    \makecell[tr]{\ifstrempty{##6}{##1-##2}{##1 \\ ##2}} & 
    \yearbullet \textbf{##3} \hfill \textbf{##4} \textit{##5}
    \ifstrempty{##6}{}{%
      \par \noindent \justifying \sloppy ##6
      }
    \tabularnewline%
    }%
  \vspace*{-0.5\baselineskip}
  \tabularx{\linewidth}{y|D@{}}%
  }
  {\endtabularx}


\newenvironment{eventlist}{%
  \renewcommand*{\arraystretch}{1.5}
  \let\olditemize\itemize
  \let\endolditemize\enditemize
  \renewenvironment{itemize}{%
    \begin{minipage}[t]{\linewidth}
    \olditemize
    }{%
        \endolditemize
        \end{minipage}%
    }

  \arrayrulecolor{yearbulletcolor}

  \newcommand\yearitem[2]{%
    \makecell[tr]{##1} & \yearbullet ##2 \tabularnewline% \\%
    }%
  \vspace*{-0.5\baselineskip}
  \tabularx{\linewidth}{y|D@{}}%
  }
  {\endtabularx}


\newenvironment{summary}{%
  \sloppy
  \justifying
  \setlength\parindent{0pt}
  \renewcommand\item[2]{%
    \ifstrempty{##1}{}{\textbf{##1}.} ##2 %
    }%
  }
  {}


\newenvironment{summary2}{%
  \renewcommand*{\arraystretch}{1}
  \arrayrulecolor{yearbulletcolor}
  \renewcommand\item[2]{%
    \makecell[tr]{##1} & \yearbullet  ##2 \tabularnewline%
    }%
  \tabularx{\linewidth}{y|D@{}}%
  }
  {\endtabularx}


\newenvironment{skills}{%
  \setlength\parindent{0pt}
  \setlength\parskip{0.5\baselineskip}
  \sloppy
  \renewcommand\item[2]{%
    \textbf{##1} \newline
    {\spaceskip=5\fontdimen2\font plus 5\fontdimen3\font minus 10\fontdimen4\font
      ##2}
    \par
    }
  \vspace*{-\baselineskip}
  }
  {}


\newenvironment{referees}{%
  \setlength\parindent{0pt}
  \setlength\parskip{0.5\baselineskip}
  \renewcommand\item[4]{%
    \textbf{##1} \newline
    ##2 \newline
    ##3 \newline
    \href{mailto:##4}{##4} \par
    }
  \vspace*{-\baselineskip}
  }
  {}

\newcolumntype{L}{m{1.2cm}}
\newenvironment{languages}{%
  %\rowcolors{2}{white}{tableevencolor}
  \renewcommand\item[2]{%
    ##1 & ##2 \\
    }

  \vspace*{-0.8\baselineskip}
  \tabularx{\linewidth}{@{}LX@{}}
  }
  {\endtabularx}


% Publications environments
\newenvironment{publications}{
  \newcommand\bibtexitem[1]{%
    \makecell[tr]{\citeyear{##1}} & 
    \yearbullet \sloppy \fullcite{##1} \tabularnewline%
    }%
  \eventlist
  }
  {\endeventlist}


\renewbibmacro*{byeditor+others}{}
\AtEveryBibitem{\clearfield{note}}
\AtEveryCitekey{\clearfield{note}}

\renewcommand{\mkbibnamegiven}[1]{%
  \ifboolexpr{ ( test {\ifdefequal{\firstname}{\namepartgiven}} or 
                 test {\ifdefequal{\firstinit}{\namepartgiven}} ) and
               ( test {\ifdefequal{\lastname}{\namepartfamily}} or 
                 test {\ifdefstrequal{\lastname*}{\namepartfamily}}) }
  {\mkbibbold{#1}}{#1}%
}

\renewcommand{\mkbibnamefamily}[1]{%
  \ifboolexpr{ ( test {\ifdefequal{\firstname}{\namepartgiven}} or
                 test {\ifdefequal{\firstinit}{\namepartgiven}} ) and 
               ( test {\ifdefequal{\lastname}{\namepartfamily}} or 
                 test {\ifdefstrequal{\lastname*}{\namepartfamily}}) }
  {\mkbibbold{#1}}{#1}%
}

\pgfmathsetlengthmacro\rightfield{\textwidth- \yearfield - 3\tabcolsep}
\newcolumntype{P}{>{\setlength{\parskip}{-0.2\baselineskip}}p{\rightfield}}
\defbibtabular{bibtabular}{%
  \renewcommand*{\arraystretch}{1.5}
  \arrayrulecolor{yearbulletcolor}
  \vspace*{-0.5\baselineskip}
  \tabular{y|P@{}}
  }
  {\endtabular}
  {%
  \makecell[tr]{\plainlang{\printfield{year}}} & 
  \yearbullet  \driver{}  \tabularnewline%
  }


\setcounter{secnumdepth}{0}
\pagenumbering{gobble}


%\newcommand\linkedinlogo{%
  %\includegraphics[height=12pt]{linkedin-icon.pdf}%
  %}

\newcommand\linkedinlogo{%

\definecolor{c007EBB}{RGB}{0,119,181}%
\definecolor{cFFF}{RGB}{255,255,255}%
\def \globalscale {0.200000}%

\begin{tikzpicture}[y=0.80pt, x=0.80pt, yscale=-\globalscale, xscale=\globalscale, inner sep=0pt, outer sep=0pt]
\begin{scope}[even odd rule]
  \path[fill=c007EBB] (8.0000,72.0000) -- (64.0000,72.0000) .. controls (68.4183,72.0000) and (72.0000,68.4183) .. (72.0000,64.0000) -- (72.0000,8.0000) .. controls (72.0000,3.5817) and (68.4183,-0.0000) .. (64.0000,0.0000) -- (8.0000,0.0000) .. controls (3.5817,0.0000) and (-0.0000,3.5817) .. (0.0000,8.0000) -- (0.0000,64.0000) .. controls (0.0000,68.4183) and (3.5817,72.0000) .. (8.0000,72.0000) -- cycle;
  \path[fill=cFFF] (62.0000,62.0000) -- (51.3156,62.0000) -- (51.3156,43.8021) .. controls (51.3156,38.8128) and (49.4198,36.0245) .. (45.4707,36.0245) .. controls (41.1746,36.0245) and (38.9301,38.9261) .. (38.9301,43.8021) -- (38.9301,62.0000) -- (28.6333,62.0000) -- (28.6333,27.3333) -- (38.9301,27.3333) -- (38.9301,32.0029) .. controls (38.9301,32.0029) and (42.0260,26.2742) .. (49.3826,26.2742) .. controls (56.7357,26.2742) and (62.0000,30.7645) .. (62.0000,40.0512) -- (62.0000,62.0000) -- cycle(16.3493,22.7940) .. controls (12.8421,22.7940) and (10.0000,19.9297) .. (10.0000,16.3970) .. controls (10.0000,12.8644) and (12.8421,10.0000) .. (16.3493,10.0000) .. controls (19.8566,10.0000) and (22.6970,12.8644) .. (22.6970,16.3970) .. controls (22.6970,19.9297) and (19.8566,22.7940) .. (16.3493,22.7940) -- cycle(11.0326,62.0000) -- (21.7694,62.0000) -- (21.7694,27.3333) -- (11.0326,27.3333) -- (11.0326,62.0000) -- cycle;
\end{scope}
\end{tikzpicture}
}

\newcommand\gscholarlogo{%
\definecolor{c4285f4}{RGB}{66,133,244}%
\definecolor{c356ac3}{RGB}{53,106,195}%
\definecolor{ca0c3ff}{RGB}{160,195,255}%
\definecolor{c76a7fa}{RGB}{118,167,250}%
\def \globalscale {0.03}%
\begin{tikzpicture}[y=0.80pt, x=0.80pt, yscale=-\globalscale, xscale=\globalscale, inner sep=0pt, outer sep=0pt]
\path[fill=c4285f4] (256.0000,411.1200) -- (0.0000,202.6670) -- (256.0000,0.0000) -- cycle;
\path[fill=c356ac3] (256.0000,411.1200) -- (512.0000,202.6670) -- (256.0000,0.0000) -- cycle;
\path[fill=ca0c3ff] (256.0000,362.6670) circle (4.2145cm);
\path[fill=c76a7fa] (121.0370,298.6670) .. controls (145.0050,248.2140) and (196.4290,213.3330) .. (256.0000,213.3330) .. controls (315.5710,213.3330) and (366.9950,248.2140) .. (390.9630,298.6670) -- (121.0370,298.6670) -- cycle;
\end{tikzpicture}
}

