\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sbabook}[2013/03/08]

\DeclareOption{showtrims}{%
    \PassOptionsToClass{showtrims}{memoir}}

\ProcessOptions\relax
\LoadClass[
    10pt,
    twoside,
    smallroyalvopaper
]{memoir}

\RequirePackage{iftex}\RequireXeTeX

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\renewcommand{\trimmarkscolor}{\color{cyan}}

%%%
%%% Page layout
%%%
\settypeoutlayoutunit{mm}
\setlrmarginsandblock{1in}{*}{*}
\setulmarginsandblock{.75in}{.75in}{*}
\ifshowtrims % use the showtrims option to switch to A4 paper + blue trimlines
    \stockaiv
    \trimFrame
    \setlength{\trimtop}{.5\stockheight}
    \addtolength{\trimtop}{-.5\paperheight}
    \setlength{\trimedge}{.5\stockwidth}
    \addtolength{\trimedge}{-.5\paperwidth}
\else\fi
\checkandfixthelayout
\raggedbottom

%%%
%%% Fonts & paragraph typography
%%%
\RequirePackage{fontspec}
\setmainfont[Numbers=OldStyle]{Gentium Book Basic}
\setsansfont[Scale=MatchLowercase,Numbers=OldStyle]{Open Sans}
\setmonofont[Scale=MatchLowercase]{Inconsolata}

\noindentafterchapter
\setlength{\parindent}{1.5em}

%% XeLaTeX support not there yet…
%% http://tex.stackexchange.com/questions/2986/margin-kerning-in-xelatex-for-texlive-2010-how-to-enable
% \usepackage{microtype}

\RequirePackage{ragged2e}
\RaggedRight
\RequirePackage{varwidth}
\newenvironment{balanced}[1]{%
    \CenteringLeftskip    0pt plus 6em%
    \CenteringRightskip   0pt plus 6em%
    \RaggedLeftLeftskip   0pt plus 12em%
    \RaggedRightRightskip 0pt plus 12em%
    \begin{varwidth}{#1}%
}{\end{varwidth}}

%% margin content
\sideparmargin{outer}
\renewcommand\sideparfont{\footnotesize\sffamily}
\renewcommand\sideparform{\ifmemtortm\RaggedRight\else\RaggedLeft\fi}
% \setmpjustification{\RaggedLeft}{\Raggedright} % this is for margin floats

%%%
%%% Sectioning
%%%

%% chapter heading
\newlength{\chapnumheight}\setlength{\chapnumheight}{18mm}
\newlength{\chapbarwidth}\setlength{\chapbarwidth}{11mm}
\makechapterstyle{sba}{%
    \renewcommand{\chapnamefont}{%
        \LARGE\sffamily\bfseries
        \addfontfeature{LetterSpace=20}%
        \flushright\MakeUppercase}
    \renewcommand{\chapnumfont}{%
        \HUGE\sffamily\bfseries
        \addfontfeature{Numbers={Proportional,Lining}}}
    \renewcommand{\chaptitlefont}{\HUGE\sffamily\mdseries\flushright}
    \setlength{\afterchapskip}{40pt}
    \renewcommand*{\chapterheadstart}{}
    \renewcommand*{\chapternamenum}{}
    \renewcommand*{\afterchapternum}{\par\nobreak\vskip 25pt}
    \setlength{\midchapskip}{\paperwidth}
    \addtolength{\midchapskip}{-\textwidth}
    \addtolength{\midchapskip}{-\spinemargin}
    \addtolength{\midchapskip}{-\chapbarwidth}
    \renewcommand*{\printchapternum}{%
        \resizebox{!}{\chapnumheight}{\chapnumfont \,\thechapter\,}%
        \makebox[-\midchapskip][l]{%
            \rule{1.5\chapbarwidth}{\chapnumheight}%
        }}
    %% chapter precis
    \renewcommand\precisfont{\normalfont\sffamily}
    \setlength{\prechapterprecisshift}{-4\baselineskip}
    \renewcommand\prechapterprecis{%
        \vspace*{\prechapterprecisshift}%
        \begin{flushright}\begin{balanced}{\linewidth}%
        \RaggedLeft\precisfont}
    \renewcommand\postchapterprecis{%
        \end{balanced}\end{flushright}}
    %%% fix indentation of 1st paragraph after \chapterprecis
    %% cf https://groups.google.com/forum/#!msg/comp.text.tex/yj4ZoVlbSKE/5hJXO-2jG5EJ
    \addtoiargdef\chapterprecis{}{%
        \par\@afterheading\m@mindentafterchapter}}

\chapterstyle{sba}


%% sections & below
\setsecheadstyle      {\LARGE\sffamily\bfseries}
\setsubsecheadstyle   {\Large\sffamily\bfseries}
\setsubsubsecheadstyle{\Large\sffamily}
\setparaheadstyle     {\sffamily\bfseries}
\setsubparaheadstyle  {\sffamily}
\setsecnumformat{%
    \llap{\mdseries
        \csname the#1\endcsname
        \quad}}

\setsecnumdepth{section}
\settocdepth{section}

%%%
%%% Table of contents etc
%%%
\renewcommand\cftchapterfont{\sffamily\bfseries}
\let\cftchapterpagefont\cftchapterfont
\renewcommand\precistocfont{\normalfont\sffamily\itshape\small}
\renewcommand\precistocformat{% discourage hyphenation
    \hyphenpenalty=5000
    \tolerance=1000
    \noindent\narrowragged}
% TODO balance precis in TOC
\renewcommand\cftsectionfont{\sffamily}
\let\cftsectionpagefont\cftsectionfont
\renewcommand\cftsubsectionfont{\sffamily\itshape}
\let\cftsubsectionpagefont\cftsectionfont
\cftsetindents{chapter}{0pt}{0em}
\renewcommand{\cftchapterpresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftchapteraftersnum}{\quad}
\cftsetindents{section}{0pt}{0em}
\renewcommand{\cftsectionpresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftsectionaftersnum}{\quad}
\cftsetindents{subsection}{0pt}{3em}
\setrmarg{3.55em plus 1fil}% help avoid hyphenation

%% figures & tables, like sections
\let\cftfigurefont\cftsectionfont
\let\cftfigurepagefont\cftfigurefont
\cftsetindents{figure}{0pt}{0em}
\renewcommand{\cftfigurepresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftfigureaftersnum}{\quad}
\let\cfttablefont\cftsectionfont
\let\cfttablepagefont\cfttablefont
\cftsetindents{table}{0pt}{0em}
\renewcommand{\cfttablepresnum}{\hspace{-4em}\hfill}
\renewcommand{\cfttableaftersnum}{\quad}

% merged list of figures/tables: \newlistofb ?

%%%
%%% Page styles & folios
%%%
\def\headfootfont{\small\sffamily}
%% main page style variant
\makepagestyle{pierbook-headings}
\makeevenhead{pierbook-headings}{}{}{\ifonlyfloats{}{\headfootfont\leftmark}}
\makeoddhead {pierbook-headings}{\ifonlyfloats{}{\headfootfont\rightmark}}{}{}
\makeevenfoot{pierbook-headings}{\headfootfont\bfseries\thepage}{}{}
\makeoddfoot {pierbook-headings}{}{}{\headfootfont\bfseries\thepage}
\makepsmarks{pierbook-headings}{\nouppercaseheads
    \createmark{chapter}{left}{nonumber}{}{}
    \createmark{section}{right}{shownumber}{}{\quad}}
%% page style variant without headings
\makepagestyle{pierbook-plain}
\makeevenfoot{pierbook-plain}{\headfootfont\bfseries\thepage}{}{}
\makeoddfoot {pierbook-plain}{}{}{\headfootfont\bfseries\thepage}
%% no folio on float-only pages
\mergepagefloatstyle{pierbook}{pierbook-headings}{empty}

\pagestyle{pierbook}
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{chapter}{pierbook-plain}

%%%
%%% Floats
%%%
\captionnamefont{\sffamily\bfseries}
\captiontitlefont{\sffamily}
\renewcommand\sidecapfloatwidth{.5\linewidth}% ahould adjust \sidecapwidth accordingly

%%%
%%% Graphics
%%%
\RequirePackage{tikz}
\definecolor{shadecolor}{gray}{0.9} % FIXME really needed?

%%%
%%% Source code
%%%
\RequirePackage{listings}
\RequirePackage{lstsmalltalk}

\renewcommand{\lstlistlistingname}{Code examples}
\lstset{
    inputencoding=utf8,
    columns=fullflexible,
    basicstyle=\small\ttfamily
}

\lstnewenvironment{script}[2][defaultlabel]{%
    % \renewcommand{\lstlistingname}{Script}%
    \lstset{
        name={Script},
        caption={\emph{#2}},
        label={scr:#1},
        frame=tb,
        framerule=\heavyrulewidth,
        mathescape=false,
    }
}{}
 
%% verbatim setup
\bvtopandtail % \bvsides
\setlength{\bvboxsep}{.25em}
\tabson[4]
\setverbatimfont{\normalfont\ttfamily\small}

%%%
%%% Language, localizations, hyphenation
%%%
\RequirePackage{polyglossia}

