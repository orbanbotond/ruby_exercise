# require "bit-twiddle"

# original = []
# original << 0b01011010;
# original << 0b01010010;
# original << 0b01000101;
# original << 0b01000010;
# original << 0b01011001;
# original << 0b00100000;
# original << 0b01011010;
# original << 0b01001000;
# original << 0b01000110;
# original << 0b01000011;
# original << 0b01010110;
# original << 0b00100000;
# original << 0b01000101;
# original << 0b01000010;
# original << 0b01011001;
# original << 0b01000010;
# original << 0b01010001;
# original << 0b00100000;
# original << 0b01000111;
# original << 0b01010110;
# original << 0b01000110;
# original << 0b00100000;
# original << 0b01000111;
# original << 0b01010010;
# original << 0b01011010;
# original << 0b01001110;
# original << 0b00100000;
# original << 0b01000110;
# original << 0b01000111;
# original << 0b01001110;
# original << 0b01000101;
# original << 0b01010100;
# original << 0b01000001;
# original << 0b01000010;
# original << 0b01010000;
# original << 0b00100000;
# original << 0b01000010;
# original << 0b01000111;
# original << 0b00100000;
# original << 0b01001000;
# original << 0b01000010;
# original << 0b01001100;
# original << 0b00100000;
# original << 0b01011001;
# original << 0b01010110;
# original << 0b01001110;
# original << 0b01011010;
# original << 0b01010010;
# original << 0b00100000;
# original << 0b01010010;
# original << 0b01011010;
# original << 0b01001000;
# original << 0b01000110;
# original << 0b01010010;
# original << 0b01000101;
# original << 0b00100000;
# original << 0b01000001;
# original << 0b01010110;
# original << 0b00100000;
# original << 0b01010011;
# original << 0b01010001;
# original << 0b01000011;
# original << 0b00100000;
# original << 0b01000111;
# original << 0b01001110;
# original << 0b01011010;
# original << 0b01000101;
# original << 0b01000010;
# original << 0b01010011;
# original << 0b00100000;
# original << 0b01000010;
# original << 0b01000111;
# original << 0b00100000;
# original << 0b01000110;
# original << 0b01001111;
# original << 0b01000010;
# original << 0b01010111;
# original << 0b01011001;
# original << 0b01000010;
# original << 0b01000010;
# original << 0b01010000;
# original << 0b00100000;
# original << 0b01000111;
# original << 0b01001110;
# original << 0b00100000;
# original << 0b01001110;
# original << 0b01000001;
# original << 0b01000010;
# original << 0b01000110;
# original << 0b01001000;
# original << 0b01000101;
# original << 0b01000111;
# original << 0b00100000;
# original << 0b01000111;
# original << 0b01000010;
# original << 0b01010001;
# original << 0b00100000;
# original << 0b01011010;
# original << 0b01000010;
# original << 0b01010000;
# original << 0b00100000;
# original << 0b01000110;
# original << 0b01011000;
# original << 0b01000001;
# original << 0b01001110;
# original << 0b01010101;
# original << 0b01000111;

# def stringify(input)
#   input.map(&:chr).join
# end

# stringify(original)
# stringify(original)[0..25]

# def first(input)
#   (1..(90-32+1)).each do |x|
#     aa=input.dup
#     shifted_string = aa.map do |element|
#       shifted = element + x
#       (shifted > 90) ? (shifted - 90 + 32) : shifted 
#     end
#     puts stringify(shifted_string)
#   end
# end
# stringify(a)
# first(a)

# def second(input)
#   (1..(90-65+1)).each do |x|
#     aa=input.dup
#     shifted_string = aa.map do |element|
#       shifted = element + x
#       (shifted > 90) ? (shifted - 90 + 65-1) : shifted 
#     end
#     puts stringify(shifted_string)
#   end
# end
# stringify(a)
# second(a)

# def third(input)
#   (1..7).each do |x|
#     aa=input.dup
#     shifted_string = aa.map do |element|
#       element.rrot8 x
#     end
#     puts stringify(shifted_string)
#   end
# end
# stringify(original)
# third(original)

# def forth(input)
#   characters = (65..90).to_a
#   permutations = characters.permutation.to_a
# end

# def apply(string, rules)
#   puts "Original: #{stringify(string)}"
#   puts "rules:"
#   puts "#{rules}"
#   outcome = stringify(string).dup
#   rules.each do |rule|
#     outcome.gsub!(rule.first, rule.last)
#   end
#   puts "Outcome: #{outcome}"
# end
# apply(original, rules)

# def histogram(string)
#   h = {}
#   " ABCDEFGHIJKLMNOPQRSTUVWZXY".each_char do |char|
#     h[char] = string.count char
#   end
#   h
# end

# h = histogram(os)



# rules = {}
# rules["B"] = "a"
# rules["G"] = "n"
# rules["N"] = "o"

# BG -> "an"
# AV -> "an" A->a
# GN -> "no" N->n
#       "on"
#       "at"
#       "no"

# F,H -> [eiu]
