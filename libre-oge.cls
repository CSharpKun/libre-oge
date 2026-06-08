%% libre-oge.cls
%% Copyright 2026 CSharpKun & PositiveCHEEK
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is CSharpKun

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{libre-oge}[LaTeX class for Russian Exams (aka OGE, EGE, VPR)]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax
\LoadClass[12pt]{exam}

\RequirePackage[a4paper, margin=1.0in, includehead, includefoot]{geometry}
\RequirePackage{iftex}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[fontsize=14.0pt]{fontsize}

\ifPDFTeX
	\RequirePackage[T2A]{fontenc}
	\RequirePackage{inputenc}
	\RequirePackage[english,russian]{babel}
	\RequirePackage{libertinus}
\else
	\RequirePackage{fontspec}
	\RequirePackage{unicode-math}
	\setmainfont{Libertinus Serif}
	\setsansfont{Libertinus Sans}
	\setmonofont{Libertinus Mono}
	\setmathfont{Libertinus Math}	
	\RequirePackage{polyglossia}
	\setdefaultlanguage{russian}
	\setotherlanguage{english}
\fi

\NewDocumentEnvironment{task}{m}{%
	\begin{minipage}{\textwidth}
		\noindent
		\makebox[0pt][r]{\fbox{\makebox[0.8cm][c]{\textbf{#1}}}\hspace{0.2cm}}%
		\ignorespaces
	}{%
	\end{minipage}
	\bigskip\bigskip
}

\newcommand{\warningsign}{%
	\leavevmode
	\makebox[0pt][r]{%
		\begin{tikzpicture}[baseline=-0.5ex]
			\draw[line width=3pt] (0,0) circle (0.75cm);
			\node at (0,0) {\fontsize{45}{60}\selectfont\bfseries !};
		\end{tikzpicture}%
		\hspace{0.2cm}%
	}%
	\ignorespaces
}

\newcommand{\descbox}[1]{%
	\fbox{%
		\parbox{1.0\textwidth}{%
			#1
		}%
	}%
}

\newcommand{\answerfield}{%
	\smallskip
	\noindent
	Ответ: \fillin[][5cm].
}

\newcommand{\answerbox}{%
	\smallskip
	\noindent
	Ответ: \begin{tabular}{|c|}
		\hline
		\emptycell\hspace{0.25cm} \\
		\hline
	\end{tabular}%
}

\newcommand{\emptycell}{\rule{0pt}{0.75cm}}

\ifluatex
\RequirePackage{luacode}

\begin{luacode}
	function create_empty_row(n)
		local cells = {}
		for i = 1, n do
			table.insert(cells, "\\emptycell")
		end
		tex.print(table.concat(cells, " & "))
	end
\end{luacode}

\newcommand{\answertable}[2][3]{%
	\smallskip
	\noindent
	Ответ: 
	\begin{tabular}{*{#1}{|c}|}
		\hline
		#2 \\
		\hline
		\directlua{create_empty_row(#1)} \\
		\hline
	\end{tabular}%
}

\else
\newcommand{\answertable}[2][3]{% 
	\textcolor{red}{\textbf{Эта функция требует LuaLaTeX!}}
}
\fi

\newcommand{\numberchoices}[1]{%
	\renewcommand{\thechoice}{\arabic{choice}}%
	\noindent\ignorespaces
	\begin{oneparchoices}
		#1
	\end{oneparchoices}%
}

\newcommand{\letterchoices}[1]{%
	\renewcommand{\thechoice}{\Asbuk{choice}}%
	\noindent\ignorespaces
	\begin{oneparchoices}
		#1
	\end{oneparchoices}
}

\renewcommand{\choicelabel}{\thechoice)}

\newcommand{\subject}{ПРЕДМЕТ}
\newcommand{\klas}{9}

\newcommand{\setsubject}[1]{
	\renewcommand{\subject}{#1}
}

\newcommand{\setklas}[1]{
	\renewcommand{\klas}{#1}
}

\makeatletter
\footer{}{\small© {\@date} \@author}{}
\makeatother

\header{}{}{\subject, \klas \ класс\hspace{1cm}\thepage\space/\space\numpages}

\setlength{\parindent}{25pt}