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

%%%
%%% Page layout
%%%
\settypeoutlayoutunit{mm}
\setlrmarginsandblock{1in}{*}{*}
\setulmarginsandblock{.75in}{.75in}{*}
\ifshowtrims % use the showtrims option to switch to A4 paper + blue trimlines
    \stockaiv
    \trimFrame
    \renewcommand{\trimmarkscolor}{\color{cyan}}
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
\setmainfont{Gentium Book Basic}
\setsansfont[Scale=MatchLowercase]{Open Sans}
\setmonofont[Scale=MatchLowercase]{Inconsolata}

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

%%%
%%% Sectioning
%%%

%% chapter heading
\chapterstyle{veelo} % TODO use \makeheadstyles (p.112 of memoir manual)
\noindentafterchapter
\renewcommand\chapterheadstart{}
\renewcommand\printchaptername{%
    \chapnamefont\MakeUppercase\@chapapp}
\renewcommand\chapnamefont{%
    \LARGE\sffamily\bfseries
    \addfontfeature{LetterSpace=20}%
    \flushright}
\renewcommand\chapnumfont{\HUGE\sffamily\bfseries}
\renewcommand\chaptitlefont{\HUGE\sffamily\mdseries\flushright}

%% chapter precis
\renewcommand\precisfont{\normalfont\sffamily}
\setlength{\prechapterprecisshift}{-2.5\baselineskip}
\renewcommand\prechapterprecis{%
    \vspace*{\prechapterprecisshift}%
    \begin{flushright}\begin{balanced}{\linewidth}%
        \RaggedLeft\precisfont}
\renewcommand\postchapterprecis{%
    \end{balanced}\end{flushright}}
%%% fix indentation of 1st paragraph after \chapterprecis
%% cf https://groups.google.com/forum/#!msg/comp.text.tex/yj4ZoVlbSKE/5hJXO-2jG5EJ
\addtoiargdef\chapterprecis{}{%
    \par\@afterheading\m@mindentafterchapter}
%%% end fix

%% sections & below
\setsecheadstyle      {\LARGE\sffamily\bfseries}
\setsubsecheadstyle   {\Large\sffamily\bfseries}
\setsubsubsecheadstyle{\Large\sffamily}
\setparaheadstyle     {\sffamily\bfseries}
\setsubparaheadstyle  {\sffamily}
\setsecnumformat{%
    \Large\mdseries
    \llap{\csname the#1\endcsname\quad}}

\setsecnumdepth{subsection}
\settocdepth{subsection}

%%%
%%% Floats
%%%


%%%
%%% Graphics
%%%
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\definecolor{shadecolor}{gray}{0.9} % FIXME really needed?
\RequirePackage{tikz}

%%%
%%% Source code
%%%
\RequirePackage{listings}
\RequirePackage{lstsmalltalk}

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
 
%%%
%%% Language, localizations, hyphenation
%%%
\RequirePackage{polyglossia}

