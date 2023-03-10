return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "*",
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    -- local sn = ls.snippet_node
    -- local isn = ls.indent_snippet_node
    -- local t = ls.text_node
    local i = ls.insert_node
    -- local f = ls.function_node
    -- local c = ls.choice_node
    -- local d = ls.dynamic_node
    -- local r = ls.restore_node
    local fmt = require("luasnip.extras.fmt").fmt
    -- local fmta = require("luasnip.extras.fmt").fmta
    ls.add_snippets("tex", {
      s("fig",
        fmt([[
          \begin{figure}[htbp]
              \centering
              \includegraphics[width=<>cm]{<>}
              \caption{<>}
              \label{fig:<>}
          \end{figure}
          ]],
          { i(1, "10"), i(2, "filepath"), i(3, "caption"), i(4, "label") },
          { delimiters = "<>" })
      ),

      s("tab", fmt([[
          \begin{table}[htbp]
              \centering
              \caption{<>}
              \includegraphics[width=<>cm]{<>}
              \label{tab:<>}
          \end{table}
          ]],
        { i(1, "caption"), i(2, "10"), i(3, "filepath"), i(4, "label") },
        { delimiters = "<>" })
      ),

      s("equ",
        fmt([[
          \begin{equation}
              \label{eq:<>}
              <>
          \end{equation}
          ]],
          { i(1, "label"), i(2, "equation") },
          { delimiters = "<>" })
      ),

      s("prog",
        fmt([[
          \lstinputlisting[language=<>, caption=<>, label=prog:<>]{<>}

        ]],
          { i(1, "language"), i(2, "caption"), i(3, "prog"), i(4, "filepath") },
          { delimiters = "<>" })
      ),

      s("def", fmt([[
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          \begin{Def}{<>}
              <>
              \begin{eq}
                    <> = <>
              \end{eq}
              <>
          \end{Def}
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          ]],
        { i(1, "number"), i(2, "def"), i(3, "lhs"), i(4, "rhs"), i(5, "") },
        { delimiters = "<>" })
      ),

      s("ex", fmt([[
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          \begin{Ex}{<>}
              <>
              \begin{eq}
                    <> = <>
              \end{eq}
              <>
          \end{Ex}

          \begin{proof}
              \begin{eq}
                %\text{LHS} \overset{\text{(2.2.1)}} & =
                \text{LHS} & = <>
                           & = <>
                           & = \text{RHS}
              \end{eq}
          \end{proof}
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          ]],
        {
          i(1, "number"), i(2, "def"), i(3, "lhs"), i(4, "rhs"), i(5, ""),
          i(6, "eq1"), i(7, "eq2")

        },
        { delimiters = "<>" })
      ),

      s("sim", fmt([[
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          \begin{Sim}
              \textbf{Simulation <>} <>
              \begin{eq}
                  <> = <>
              \end{eq}
              <>
          \end{Sim}

          \begin{Code}
          %\lstinputlisting[language=]{}
          \begin{lstlisting}[language=Octave]
          <>
          \end{lstlisting}
          \end{Code}
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          ]],
        { i(1, "number"), i(2, "def"), i(3, "lhs"), i(4, "rhs"), i(5, ""), i(6, "code") },
        { delimiters = "<>" })
      ),
    })
  end,
}
