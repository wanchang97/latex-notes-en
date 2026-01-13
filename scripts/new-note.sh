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

# 1. 创建目录
mkdir -p "$NOTE_DIR"
mkdir -p "$NOTE_DIR/assets"

# 2. 创建 Report 文件 (main.tex)
cat > "$NOTE_DIR/main.tex" << 'EOF'
\documentclass[11pt]{article}
\usepackage{../styles/notes-en}

\title{Note Title}
\author{Your Name}
\date{\today}

\begin{document}
    
    \maketitle
    
    \begin{abstract}
        Brief description of your report content.
    \end{abstract}
    
    \section{Introduction}
    
    Start writing your content here.
    
\end{document}
EOF
echo "✅ Created: $NOTE_DIR/main.tex (Report)"

# 3. 创建 Presentation 文件 (Presentation.tex)
cat > "$NOTE_DIR/Presentation.tex" << 'EOF'
\documentclass{beamer}

% 假设您有一个名为 'styles/beamer-style' 的样式文件，如果没有，请根据您的实际 Beamer 模板调整
\usetheme{Madrid} % 示例主题
% \usepackage{../styles/beamer-style}

\title{Presentation Title}
\author{Your Name}
\date{\today}

\begin{document}

\frame{\titlepage}

\section*{Introduction}
\begin{frame}{Introduction}
    \begin{itemize}
        \item Key point 1
        \item Key point 2
    \end{itemize}
\end{frame}

\section*{Details}
\begin{frame}{Details}
    This is where your content goes.
\end{frame}

\end{document}
EOF
echo "✅ Created: $NOTE_DIR/Presentation.tex (Presentation)"

echo "🚀 Start editing: $NOTE_DIR/main.tex and $NOTE_DIR/Presentation.tex"
echo "🌐 Deploy: git add . && git commit -m 'Add $NOTE_NAME' && git push"
