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

\newif\ifdrm
\DeclareOption{drm}{\drmtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax

\LoadClass[12pt]{exam}

\RequirePackage[a4paper, margin=1.0in, includehead, includefoot]{geometry}
\RequirePackage{iftex}
\RequirePackage{pgffor}
\RequirePackage{tikz}
\RequirePackage{eso-pic}
\RequirePackage{xcolor}
\RequirePackage[fontsize=14.0pt]{fontsize}

\usetikzlibrary{patterns, calc}

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

\newcommand{\id}{00000000}
\newcommand{\subject}{ПРЕДМЕТ}
\newcommand{\klas}{9}

\newcommand{\setsubject}[1]{
	\renewcommand{\subject}{#1}
}

\newcommand{\setklas}[1]{
	\renewcommand{\klas}{#1}
}

\newcommand{\setid}[1]{
	\renewcommand{\id}{#1}
}

\header{\footnotesize\id}{}{\subject. \klas \ класс\hspace{1cm}(\thepage\space/\space\numpages)}

\makeatletter
\footer{}{\small© {\@date} \@author}{}
\makeatother

\setlength{\parindent}{25pt}



\ifdrm

\newcommand{\drmcircle}{%
	\draw (\x*\step cm + 0.15cm, \y*\step cm + 0.15cm) circle (0.2cm);
}

\newcommand{\drmsquare}{%
	\draw (\x*\step cm, \y*\step cm) rectangle ++(0.3cm,0.3cm);
}

\newcommand{\drmx}{%
	\draw (\x*\step cm, \y*\step cm) -- ++(0.3cm,0.3cm);
	\draw (\x*\step cm + 0.3cm, \y*\step cm) -- ++(-0.3cm,0.3cm);
}

\newcommand{\drmminus}{%
	\draw (\x*\step cm, \y*\step cm + 0.15cm) -- ++(0.3cm,0cm);
}

\newcommand{\drmup}{%
	\draw (\x*\step cm + 0.15cm, \y*\step cm) -- ++(0cm,0.3cm);
}

\newcommand{\drmcirclex}{%
	\drmcircle
	\drmx
}

\newcommand{\drmsquarex}{%
	\drmsquare
	\drmx
}

\newcommand{\drmsquareminus}{%
	\drmsquare
	\drmminus
}

\newcommand{\drmsquareplus}{
	\drmsquare
	\drmminus
	\drmup
}

\AddToShipoutPictureBG{%
	\begin{tikzpicture}[remember picture, overlay]
		\begin{scope}[thin, gray!40]
			\pgfmathsetmacro{\step}{0.75}
			\pgfmathparse{random(0,6)}\let\shift\pgfmathresult
			\foreach \y in {-3,-2,...,45} {
				\pgfmathsetmacro{\phase}{-(\y + 5)}
				\foreach \x in {-8,-7,...,30} {
					\pgfmathparse{int(round(\x + \phase))}
					\pgfmathresult
					\pgfmathparse{int(mod(abs(\pgfmathresult) + \shift, 7))}
					\pgfmathresult
					\ifnum\pgfmathresult=0 \drmsquare \fi
					\ifnum\pgfmathresult=1 \drmcircle \fi
					\ifnum\pgfmathresult=2 \drmx \fi
					\ifnum\pgfmathresult=3 \drmcirclex \fi
					\ifnum\pgfmathresult=4 \drmsquarex \fi
					\ifnum\pgfmathresult=5 \drmsquareminus \fi
					\ifnum\pgfmathresult=6 \drmsquareplus \fi
				}
			}
		\end{scope}
	\end{tikzpicture}%
}
\fi



