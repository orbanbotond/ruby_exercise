class AddLexer

  # Examples for `lexeme`s:
  # DIGIT:        "      45   "
  # ADDITION:     "  +     "
  # SUBSTRACTION: " -    "
  #

macro
  DIGIT                      /\s*\d+\s*/
  ADDITION                   /\s*[+]\s*/
  SUBSTRACTION               /\s*[-]\s*/
  MULTIPLICATION             /\s*[*]\s*/
  DIVISION                   /\s*[\/]\s*/
  OPENING_PARANTHESIS        /\s*[\(]\s*/
  CLOSING_PARANTHESIS        /\s*[\)]\s*/
rule
  /#{DIGIT}/                 { [:DIGIT, text.to_i] }
  /#{ADDITION}/              { [:ADDITION, text] }
  /#{SUBSTRACTION}/          { [:SUBSTRACTION, text] }
  /#{MULTIPLICATION}/        { [:MULTIPLICATION, text] }
  /#{DIVISION}/              { [:DIVISION, text] }
  /#{OPENING_PARANTHESIS}/   { [:OPENING_PARANTHESIS, text] }
  /#{CLOSING_PARANTHESIS}/   { [:CLOSING_PARANTHESIS, text] }
inner
  def do_parse;
  end
end # AddLexer
