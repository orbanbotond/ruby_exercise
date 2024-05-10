$: << File.join(File.dirname(__FILE__), '..', 'lib')
require "ruport"

# Example of adding a row inbetween two rows of a already created table.

data = Table(:service,:rate)
data << ["Mow The Lawn","50.00"]
data << ["Sew Curtains", "120.00"]
data << ["Fly To Mars", "10000.00"]

puts data.to_text


# Need to add a row
# Use sub table to split where we want the new row
# add the row to the first split
# merge two splits back

puts 'sub table1'
sub1 = data.sub_table(0..0)
puts sub1

puts 'sub table2'
sub2 = data.sub_table(1..-1)
puts sub2

puts 'Add a row to the first split'
sub1 << ["Book-keeping", "90.00"]
puts sub1

puts 'Merge splits'
data = sub1 + sub2
puts data

puts 'Add row'
data.add_row(["Fix Car", "2000"], :position => 0)
puts data


puts 'Add Row after Sew Curtains'
pos = data.row_search("Sew", :column => 0) # Search for Sew in column 0 and get position.
pos += 1
data.add_row(["Wash Car", "8"], :position => pos)
puts data


