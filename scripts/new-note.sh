#!/bin/bash

# Create new note script
if [ -z "$1" ]; then
echo "Usage: ./scripts/new-note.sh <note-name>"
echo "Example: ./scripts/new-note.sh machine-learning-basics"
exit 1
fi

NOTE_NAME="$1"
NOTE_DIR="notes/$NOTE_NAME"

echo "Creating new note: $NOTE_NAME"

# Create directories
mkdir -p "$NOTE_DIR"
mkdir -p "$NOTE_DIR/assets"

# Create main.tex from template
cat > "$NOTE_DIR/main.tex" << 'EOF'
\documentclass[11pt]{article}
\usepackage{../styles/notes-en}

\title{Note Title}
\author{Your Name}
\date{\today}

\begin{document}
	
	\maketitle
	
	\begin{abstract}
		Brief description of your note.
	\end{abstract}
	
	\section{Introduction}
	
	Start writing your content here.
	
	\section{Mathematics Example}
	
	Inline math: $E = mc^2$
	
	Display math:
	\[
	\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
	\]
	
	\begin{definition}[Important Concept]
		Definition of your concept.
	\end{definition}
	
	\section{Code Example}
	
	\begin{lstlisting}[style=python, caption=Python Code]
		def hello_world():
		print("Hello, World!")
		return True
	\end{lstlisting}
	
	\begin{note}
		This is a note example.
	\end{note}
	
\end{document}
EOF

echo "✅ Created: $NOTE_DIR/main.tex"
echo "🚀 Start editing: $NOTE_DIR/main.tex"
echo "🔧 Test compilation: cd $NOTE_DIR && pdflatex -interaction=nonstopmode main.tex"
echo "🌐 Deploy: git add . && git commit -m 'Add $NOTE_NAME' && git push"