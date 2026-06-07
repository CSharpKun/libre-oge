%% oge-ege.cls
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
\ProvidesClass{oge-ege}[OGE and EGE class for Russian Exams]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax
\LoadClass[12pt]{exam}

\RequirePackage[a4paper, margin=1.25in, includehead, includefoot]{geometry}
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\RequirePackage{ifluatex}
\RequirePackage{xcolor}

\setdefaultlanguage{russian}
\setmainfont{Liberation Serif}

\newcommand{\task}[1]{%
	\noindent
	\makebox[0pt][r]{%
		\fbox{\makebox[0.8cm][c]{\textbf{#1}}}%
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
	
	function split(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t = {}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
		end
		return t
	end
	
	function create_row(n)
		local data = split(n, ",")
		for index, value in ipairs(data) do
			data[index] = value:match("^%s*(.-)%s*$")
		end
		tex.print(table.concat(data, " & "))
		-- tex.print("A & B & C")
	end
\end{luacode}

\newcommand{\answertable}[2][3]{%
	\smallskip
	\noindent
	Ответ: 
	\begin{tabular}{*{#1}{|c}|}
		\hline
		\edef\temp{\luaescapestring{#2}}
		\directlua{create_row("\temp")} \\
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

\makeatletter
\footer{}{\small© {\@date} \@author}{}
\makeatother

\setlength{\parindent}{25pt}