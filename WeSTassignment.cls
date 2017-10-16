\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{WeSTassignment}[2016/04/13 v1.0 WeSTassignment]

% ==============================================================================
% Data

\newcommand*\lecture[1]{\def\@lecture{#1}}
\newcommand*\assignmentnumber[1]{\def\@assignmentnumber{#1}}
\newcommand*\institute[1]{\def\@institute{#1}}
\newcommand*\datesubmission[1]{\def\@datesubmission{#1}}
\newcommand*\datetutorial[1]{\def\@datetutorial{#1}}

\newcommand*\mailto[1]{\href{mailto:#1}{\nolinkurl{#1}}}

% ==============================================================================
% Document Class

\LoadClass[
  a4paper, % Use Din A4 paper type.
  11pt, % Font size.
]{scrartcl}

% ==============================================================================
% Packages

\newcommand*\RequireOptionsPackage[2][]{
  \PassOptionsToPackage{#1}{#2}
  \RequirePackage{#2}
}

% Language typesetting.
\RequirePackage{polyglossia}

% Font selection.
\RequirePackage{fontspec}

% Micro-typographic extensions.
\RequirePackage{microtype}

% Unicode support for math. Load after other math/font packages.
\RequirePackage{unicode-math}

% Patches a few math packages to work correctly with LuaLaTeX.
\RequirePackage{lualatex-math}

% Various useful tools for mathematical typesetting.
\RequirePackage{mathtools}

% Quotations.
\RequirePackage{csquotes}

% Use vertical space between paragraphs, instead of intending the first line.
\RequirePackage{parskip}

% Package for headlines and footlines.
\RequirePackage{fancyhdr}

% Style figure captions
\RequirePackage[
  bf, % Print caption type and number in bold.
  format = plain, % No hanging indent for captions.
]{caption}

% Color management.
\RequirePackage{xcolor}

% Used for definition an environment with a conditonal.
\RequirePackage{environ}

% Turns cross-references into (clickable) hyperlinks.
% Load late because it redefines a lot of commands.
\RequireOptionsPackage[
  unicode = true, % Signal that this is a unicode document.
  breaklinks = true, % Enable links across line boundaries.
  pdfauthor = {Lukas Schmelzeisen},
  pdfhighlight = /O, % TODO: Find out what this does.
]{hyperref}

% Inter-document cross-references. Load after hyperref.
\RequireOptionsPackage[
  capitalise, % Capitalize all cross-ref names.
  nameinlink, % Link complete name, not just number.
  noabbrev, % Do not use abbreviations.
]{cleveref}

% Pseudocode
\RequirePackage{algorithm}
\RequireOptionsPackage[
  noend % Omits end statements in algorithms
]{algpseudocode}

% Source Code Listings
\RequirePackage{listings}

% Bibliography.
\RequireOptionsPackage[
  backend = biber, % use biber as backend
  style = verbose, % So the full citation appears in the footnote.
  maxbibnames = 10, % max number of names in bibliography
  maxcitenames = 2, % max number of names in text cite
  uniquelist = minyear, % only add more authors if year is not unique
  labeldateparts = true,
  giveninits = true, % abbreviate given name of authors
  doi = false, % do not show doi
  isbn = false, % do not show isbn
  eprint = false, % do not show eprint
  urldate = long, % format of urldate field
]{biblatex}

% ==============================================================================
% Theme

% No double space after end of sentences.
\frenchspacing

% Colors -----------------------------------------------------------------------

\definecolor{WeSTblue}{HTML}{0C3875}
\definecolor{WeSTorange}{HTML}{FFAE00}
\definecolor{WeSTred}{HTML}{DD4814}
\definecolor{WeSTgray}{HTML}{D9D9D9}

\hypersetup{
  colorlinks, % Colorize links.
  urlcolor = WeSTblue, % Color for extern url links.
  linkcolor = WeSTblue, % Color for intern links like "Section 2".
  citecolor = WeSTblue, % Color for links in citations.
}


% Reference Solution -----------------------------------------------------------

\newif\ifsolution
\newcommand*\inlinesolution[1]{\ifsolution{\color{WeSTred}#1}\fi}
%\newenvironment{solution}{\ifsolution\color{WeSTred}}{omfg\fi}
% For an explanation why \newenvironment is not used here
% see https://tex.stackexchange.com/a/14631/75225
\NewEnviron{solution}{\ifsolution\color{WeSTred}\expandafter\BODY\fi}

% Title ------------------------------------------------------------------------

% Redefine \maketitle such that it sets the \title, \subtitle and \date commands
% based on our custom data commands.
\let\oldmaketitle\maketitle
\renewcommand*\maketitle{
  \title{\@lecture}%
  \subtitle{Assignment~\@assignmentnumber\inlinesolution{~(Solution)}}%
  \date{%
    \@institute\\%
    \vspace{0.3cm}
    \begin{tabular}{rl}%
      Submission until:&\@datesubmission\\%
      Tutorial on:&\@datetutorial%
    \end{tabular}%
  }
  \oldmaketitle%
}

% Section ----------------------------------------------------------------------

% Redefine \section command so that it always starts on a new page.
% (Remove this if you don't like it.)
\let\oldsection\section
\renewcommand*\section{%
  \clearpage%
  \oldsection%
}

% Headline and Footline --------------------------------------------------------

% Use headlines and footlines of package fancyhdr.
\pagestyle{fancy}

\fancyhf{}
\fancyhead[C]{\scriptsize\@lecture}
\fancyhead[L]{\includegraphics[width=1.8cm]{logo_west_small}}
\fancyhead[R]{\scriptsize{}Assignment~\@assignmentnumber}
\fancyfoot[C]{\thepage}
\renewcommand{\headheight}{22pt}
\renewcommand{\headrulewidth}{0.4pt} % header line
%\renewcommand{\footrulewidth}{0.4pt} % footer line

% Footer -----------------------------------------------------------------------

\newcommand*\makefooter{%
  \section*{Important Notes}

  {
    % Supress overful \hbox warning
    % see https://tex.stackexchange.com/a/144615/75225
    \hfuzz=\maxdimen

    Ask questions and discussion with regard to the lecture, tutorial, or
    assignments in
    \begin{itemize}
      \item The WebScience newsgroup:\\
        \url{https://webnews.uni-koblenz.de/newsgroups.php?group=infko.webscience}
      \item Our Facebook group:\\
        \url{https://facebook.com/groups/InformationRetrievalUniKoblenz}
    \end{itemize}
  }

  \subsection*{Submission}

  \begin{itemize}
    \item Solutions have to be checked into the SVN repository.
      Use the directory name \texttt{solutions/assignment\@assignmentnumber{}/}
      in your group's repository \emph{mandatory}.
    \item The SVN repository is available via\\
      \url{https://svn.uni-koblenz.de/westteaching/ir-ss17/<groupname>}
    \item Solution format: all solutions for theoretical tasks as \emph{one} PDF
      document.
      Programming code has to be submitted as Python code.
    \item The name of the group and the names of all participating students must
      be listed on each submission:

      \begin{itemize}
        \item at the top of each PDF file
        \item at the top of each Python file (in comments)
      \end{itemize}

      Only named students will receive credit.
    \item With the submission of your solution you confirm that you created the
      solution independently as a group, especially without using other
      intellectual contributions.
      That is, you submission should not be
      \href{https://en.wikipedia.org/wiki/Plagiarism}{plagiarism}!
  \end{itemize}

  \subsection*{Programming Assignments}

  The programming assignments require you to have a Python 3.6+ interpreter
  (older versions may still work coincidentally, but are not officially
  supported) and the SciPy stack installed.
  For an installation guide, see
  \url{http://west.uni-koblenz.de/en/studying/installing-python}

  The following rules apply for the \emph{implementation} of your solution:

  \begin{itemize}
    \item You can create as many additional code files as you need.
      You can create as many additional classes or methods as you need (even in
      the provided code files).
      However, do not forget to submit \emph{all} \texttt{.py} code files to
      the SVN.
    \item Check that your code compiles and runs without errors.
    \item Use \texttt{UTF-8} as the file encoding.
      \emph{Other encodings will not be taken into account!}
    \item Test your implementation with the provided test cases.

      Passing of all tests is a \emph{necessity} to receive full score, no
      \emph{sufficiency}.
      In general, programming against the provided test cases should assist you
      in finding correct solutions.
    \item Make sure your code is formatted to be easy to read.
      \begin{itemize}
        \item Make sure you code  has consistent
          \href{https://en.wikipedia.org/wiki/Indent_style}{indentation}.
        \item Make sure you comment and document your code
          adequately in English.
        \item Choose consistent and intuitive names for your identifiers.
      \end{itemize}
    \item Do \emph{not} use any accents, spaces or special characters in your
      filenames.
  \end{itemize}
}

% Bibliography -----------------------------------------------------------------

% Family names before given names: http://tex.stackexchange.com/q/113573
% Note: last-first renamed to family-given to reflect updated BibLaTeX
% terminology.
\DeclareNameAlias{sortname}{family-given}
\DeclareNameAlias{default}{family-given}

% Author lastnames in small caps, but only in bibliography not in the citation.
\AtBeginBibliography{
  \renewcommand\mkbibnamelast[1]{\textsc{#1}}
}

% Decrease bibliography font size.
\def\bibfont{\small}

% Vertical space between bibliography entries.
\setlength\bibitemsep{0.8em}
% Indent after first line on bibliography entries
\setlength\bibhang{1em}

% Have URLs for specific entries.
% see http://tex.stackexchange.com/a/152971/75225
\DeclareBibliographyCategory{needsurl}
\newcommand{\entryneedsurl}[1]{\addtocategory{needsurl}{#1}}
\renewbibmacro*{url+urldate}{%
  \ifcategory{needsurl}{
    \printfield{url}%
    \iffieldundef{urlyear}
      {}
      {\setunit*{\addspace}%
       \printurldate}}
    {}}

% Algorithms -------------------------------------------------------------------

% Make comments gray
\algrenewcomment[1]{%
  \hfill\textcolor{WeSTblue}{\(\triangleright\) #1}%
}

% Add single line comment
% http://tex.stackexchange.com/a/74885/75225
\algnewcommand{\LineComment}[1]{%
  \State \textcolor{WeSTblue}{\(\triangleright\) #1}%
}

% Style for keywords
% http://tex.stackexchange.com/a/274708/75225
\newcommand*\AlgKeyword[1]{\textbf{#1}}
\algrenewcommand\algorithmicend{\AlgKeyword{end}}
\algrenewcommand\algorithmicdo{\AlgKeyword{do}}
\algrenewcommand\algorithmicwhile{\AlgKeyword{while}}
\algrenewcommand\algorithmicfor{\AlgKeyword{for}}
\algrenewcommand\algorithmicforall{\AlgKeyword{for all}}
\algrenewcommand\algorithmicloop{\AlgKeyword{loop}}
\algrenewcommand\algorithmicrepeat{\AlgKeyword{repeat}}
\algrenewcommand\algorithmicuntil{\AlgKeyword{until}}
\algrenewcommand\algorithmicprocedure{\AlgKeyword{procedure}}
\algrenewcommand\algorithmicfunction{\AlgKeyword{function}}
\algrenewcommand\algorithmicif{\AlgKeyword{if}}
\algrenewcommand\algorithmicthen{\AlgKeyword{then}}
\algrenewcommand\algorithmicelse{\AlgKeyword{else}}
\algrenewcommand\algorithmicrequire{\AlgKeyword{Input:}} % change "Require" to "Input"
\algrenewcommand\algorithmicensure{\AlgKeyword{Output:}} % change "Ensure" to "Output'
\algrenewcommand\algorithmicreturn{\AlgKeyword{return}}

% Style for identifiers
\newcommand*\AlgIdentifier[1]{#1}

% Listings ---------------------------------------------------------------------

% Make listings look like algorithms
% http://tex.stackexchange.com/questions/73392/how-to-make-lstlisting-look-exactly-like-the-algorithm-environment
\lstset{
  numbers = left,
  numbersep = 5pt,
  xleftmargin = 20pt,
  frame = tb,
  framexleftmargin = 20pt,
  basicstyle = \small\ttfamily,
%   keywordstyle = \color{RoyalBlue},
  mathescape,
%   breaklines = false,
  showspaces = false,
  showstringspaces = false,
}
\renewcommand*{\thelstnumber}{\arabic{lstnumber}:}
\DeclareCaptionFormat{listing}{\hrule#1#2#3}
\captionsetup[lstlisting]{
  format = listing,
  labelfont = bf,
  singlelinecheck = off,
  labelsep = space,
}

% So we can refer to listings using cleverref.
\crefname{lstlisting}{listing}{listings}
\Crefname{lstlisting}{Listing}{Listings}

\crefname{section}{task}{tasks}
\Crefname{section}{Task}{Tasks}
