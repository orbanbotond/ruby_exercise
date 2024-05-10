#!/usr/bin/env ruby -w
require File.join(File.expand_path(File.dirname(__FILE__)), "helpers")

class TablePivotSimpleCaseTest < Minitest::Test

  def setup
    table = Ruport.Table('a', 'b', 'c')
    table << [1,3,6]
    table << [1,4,7]
    table << [2,3,8]
    table << [2,4,9]
    @pivoted = table.pivot('b', :group_by => 'a', :values => 'c')
  end

  def test_produces_correct_columns
    assert_equal(['a', 3, 4], @pivoted.column_names)
  end

  def test_produces_correct_full_table
    expected = Ruport.Table("a",3,4) { |t| t << [1,6,7] << [2,8,9] }
    assert_equal(expected, @pivoted)
  end

end

class PivotConvertRowOrderToGroupOrderTest < Minitest::Test

  def convert(row_order)
    Ruport::Data::Table::Pivot.row_order_to_group_order(row_order)
  end

  def setup
    @group = mock('group')
    @row = mock('row')
    @group.stubs(:[]).with(0).returns(@row)
  end

  def test_bare_field_name
    converted = convert(:field_name)
    @row.expects(:[]).with(:field_name)
    converted.call(@group)
  end

  def test_array_of_field_names
    converted = convert([:field1, :field2])
    @row.stubs(:[]).with(:field1).returns('f1val')
    @row.stubs(:[]).with(:field2).returns('f2val')
    assert_equal(['f1val', 'f2val'], converted.call(@group))
  end

  def test_proc_operating_on_row
    converted = convert(proc {|row| row[:field1] })
    @row.stubs(:[]).with(:field1).returns('f1val')
    assert_equal('f1val', converted.call(@group))
  end

  def test_nil
    assert_equal(nil, convert(nil))
  end

end

class PivotPreservesOrdering < Minitest::Test

  def test_group_column_preserves_order_of_occurrence
    table = Ruport.Table('group', 'a', 'b')
    [
      [1, 0, 0],
      [9, 0, 0],
      [1, 0, 0],
      [9, 0, 0],
      [1, 0, 0],
      [8, 0, 0],
      [1, 0, 0]
    ].each {|e| table << e}
    assert_equal([1,9,8],
       Ruport::Data::Table::Pivot.
       new(table, 'group', 'a', 'b').column)
  end

  def test_pivoted_row_preserves_order_of_input_rows
    table = Ruport.Table('group', 'a', 'b', 'c')
    [
      [200,   1, 2, 1],
      [200,   4, 5, 2],
      [200,   5, 0, 3],
      [100,   1, 8, 4],
      [100,   4,11, 5]
    ].each {|e| table << e}
    assert_equal(
      [1,4,5],
      Ruport::Data::Table::Pivot.new(
        table, 'group', 'a', 'b', :pivot_order => ['c']
      ).row)
  end

  def test_preserves_ordering
    table = Ruport.Table('group', 'a', 'b', 'c')
    [
      [200,   1, 2, 3],
      [200,   4, 5, 6],
      [100,   1, 8, 9],
      [100,   4,11,12]
    ].each {|e| table << e}
    pivoted = table.pivot('a', :group_by => 'group', :values => 'b')
    expected = Ruport.Table("group",1,4) { |t| t << [200,2,5] << [100,8,11] }
    assert_equal(expected, pivoted)
  end

  def test_reorders_a_calculated_column_by_column_name
    table = Ruport.Table('group', 'a')
    [
      [1, 1], [2, 2], [3, 3]
    ].each {|e| table << e}
    table.add_column('pivotme') {|row| 10 - row.group.to_i}
    pivoted = table.pivot('pivotme', :group_by => 'group', :values => 'a',
                                     :pivot_order => :name)
    assert_equal(['group', 7, 8, 9], pivoted.column_names)
  end

  def test_preserves_ordering_on_calculated_column_with_proc_pivot_order
    table = Ruport.Table('group', 'a')
    [
      [1, 1], [2, 2], [3, 3]
    ].each {|e| table << e}
    table.add_column('pivotme') {|row| 10 - row.group.to_i}
    pivoted = table.pivot('pivotme', :group_by => 'group', :values => 'a',
                                     :pivot_order => proc {|row, pivot| pivot })
    assert_equal(['group', 7, 8, 9], pivoted.column_names)
  end

end

class TablePivotOperationTest < Minitest::Test
  def setup
    @rows = [
      Ruport::Data::Record.new('Values' => 3),
      Ruport::Data::Record.new('Values' => 9),
      Ruport::Data::Record.new('Values' => 4)
    ]
  end

  def test_performs_operation_sum
    sum = Ruport::Data::Table::Pivot::Operations.sum(@rows, 'Values')
    assert_equal 16, sum
  end

  def test_performs_operation_first
    first = Ruport::Data::Table::Pivot::Operations.first(@rows, 'Values')
    assert_equal 3, first
  end

  def test_performs_operation_count
    count = Ruport::Data::Table::Pivot::Operations.count(@rows, 'Values')
    assert_equal 3, count
  end

  def test_performs_operation_mean
    mean = Ruport::Data::Table::Pivot::Operations.mean(@rows, 'Values')
    assert_equal 5, mean
  end

  def test_performs_operation_min
    min = Ruport::Data::Table::Pivot::Operations.min(@rows, 'Values')
    assert_equal 3, min
  end

  def test_performs_operation_max
    max = Ruport::Data::Table::Pivot::Operations.max(@rows, 'Values')
    assert_equal 9, max
  end

  def test_invalid_operation_causes_exception
    assert_raises ArgumentError do
      Ruport::Data::Table::Pivot.new(nil, nil, nil, nil, :operation => :foo)
    end
  end
end
