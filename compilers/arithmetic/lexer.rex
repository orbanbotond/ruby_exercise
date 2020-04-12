class AddLexer

  # Examples for `lexeme`s:
  # DIGIT:        "      45   "
  # ADDITION:     "  +     "
  # SUBSTRACTION: " -    "
  #

macro
  DIGIT         /\s*\d+\s*/
  ADDITION      /\s*[+]s*/
  SUBSTRACTION  /\s*[-]s*/
rule
  /#{DIGIT}/        { [:DIGIT, text.to_i] }
  /#{ADDITION}/     { [:ADDITION, text] }
  /#{SUBSTRACTION}/ { [:SUBSTRACTION, text] }
inner
  def do_parse;
  end # this is a stub.
end # AddLexer
