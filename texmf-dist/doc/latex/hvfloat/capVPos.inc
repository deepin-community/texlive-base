%\define@choicekey*+{hvSet}{capVPos}[\val\nr]{bottom,center,top}[center]{% 


\iffalse
justification=
  justified
  centering
  centerlast
  centerfirst
  raggedright
  RaggedRight
  raggedleft
\fi

\subsection{\texttt{default}, same as \texttt{center}}
\blindtext

\begin{lstlisting}
\hvFloat[capPos=right]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=right]{figure}{\includegraphics{frose}}{\capShortText~\protect\parencite{aksin}}{}

\blindtext

\begin{lstlisting}
\hvFloat[capPos=right,capFormat={singlelinecheck=off}]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=right,capFormat={singlelinecheck=off}]{figure}{\includegraphics{frose}}{\capShortText~\protect\parencite{aksin}}{}

\blindtext

\begin{lstlisting}
\hvFloat[capPos=right]{figure}{\includegraphics{frose}}{\capLongText~\protect\parencite{aksin}}{}
\end{lstlisting}

\hvFloat[capPos=right]{figure}{\includegraphics{frose}}{\capLongText~\protect\parencite{aksin}}{}

\blindtext

\NewColumn



%----------------------top-----------------------------------
\subsection{\texttt{capVPos=top}}

\begin{lstlisting}
\hvFloat[capPos=outer,capVPos=top]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=outer,capVPos=top]{figure}{\includegraphics{frose}}{\capShortText~\protect\parencite{aksin}}{}

\blindtext


\begin{lstlisting}
\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=top]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=top]{figure}{\includegraphics{frose}}{\capShortText}{}

\blindtext


\begin{lstlisting}
\hvFloat[capPos=inner,capVPos=top]{figure}{\includegraphics{frose}}{\capLongText}{}
\end{lstlisting}

\hvFloat[capPos=inner,capVPos=top]{figure}{\includegraphics{frose}}{\capLongText}{}

\blindtext

\NewColumn

%----------------------bottom-----------------------------------
\subsection{\texttt{capVPos=bottom}}

\begin{lstlisting}
\hvFloat[capPos=outer,capVPos=bottom]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=outer,capVPos=bottom]{figure}{\includegraphics{frose}}{\capShortText}{}

\blindtext


\begin{lstlisting}
\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=bottom]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=bottom]{figure}{\includegraphics{frose}}{\capShortText}{}

\blindtext

\begin{lstlisting}
\hvFloat[capPos=inner,capVPos=bottom]{figure}{\includegraphics{frose}}{\capLongText}{}
\end{lstlisting}

\hvFloat[capPos=inner,capVPos=bottom]{figure}{\includegraphics{frose}}{\capLongText}{}

\blindtext
\NewColumn

%----------------------center-----------------------------------
\subsection{\texttt{capPos=center}}

\begin{lstlisting}
\hvFloat[capPos=outer,capVPos=center]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=outer,capVPos=center]{figure}{\includegraphics{frose}}{\capShortText}{}

\blindtext

\begin{lstlisting}
\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=center]{figure}{\includegraphics{frose}}{\capShortText}{}
\end{lstlisting}

\hvFloat[capPos=right,capFormat={singlelinecheck=off},capVPos=center]{figure}{\includegraphics{frose}}{\capShortText}{}

\blindtext

\begin{lstlisting}
\hvFloat[capPos=inner,capVPos=center]{figure}{\includegraphics{frose}}{\capLongText}{}
\end{lstlisting}

\hvFloat[capPos=inner,capVPos=center]{figure}{\includegraphics{frose}}{\capLongText}{}

\blindtext

\NewColumn
