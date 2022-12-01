using Revise
import REPL
REPL.GlobalOptions.auto_indent = false
REPL.LineEdit.options(s::REPL.LineEdit.PromptState) = REPL.GlobalOptions
