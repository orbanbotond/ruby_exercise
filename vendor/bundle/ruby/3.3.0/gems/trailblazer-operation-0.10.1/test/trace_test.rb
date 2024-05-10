require "test_helper"

class TraceTest < Minitest::Spec
  class B < Trailblazer::Operation
    step ->(options, **) { options[:b] = true }, id: "B.task.b"
    step ->(options, **) { options[:e] = true }, id: "B.task.e"
  end

  class Create < Trailblazer::Operation
    step ->(options, a_return:, **) { options[:a] = a_return }, id: "Create.task.a"
    step Subprocess(B), id: "MyNested"
    step ->(options, **) { options[:c] = true }, id: "Create.task.c"
    step ->(_options, params:, **) { params.any? }, id: "Create.task.params"
  end

  it "deprecates {result.wtf?} and {Operation.trace}" do
    output, warning = capture_io do
      result = Create.trace({a_return: true, params: {}})
      result.wtf?
    end
    line_no = __LINE__ - 2

    assert_equal warning, %([Trailblazer] #{File.realpath(__FILE__)}:#{line_no - 1} Using `Operation.trace` is deprecated and will be removed in {trailblazer-operation-0.11.0}.
  Please use `TraceTest::Create.wtf?` as documented here: https://trailblazer.to/2.1/docs/trailblazer#trailblazer-developer-wtf-
[Trailblazer] #{File.realpath(__FILE__)}:#{line_no} Using `result.wtf?` is deprecated. Please use `TraceTest::Create.wtf?` and have a nice day.
)
    assert_equal output, %(TraceTest::Create
|-- Start.default
|-- Create.task.a
|-- MyNested
|   |-- Start.default
|   |-- B.task.b
|   |-- B.task.e
|   `-- End.success
|-- Create.task.c
|-- Create.task.params
`-- End.failure
)
  end

  it "allows using low-level Operation::Trace" do
    result = Trailblazer::Operation::Trace.(
      Create,
      { a_return: true, params: {} },
    )

    output = result.wtf

    assert_equal output.gsub(/0x\w+/, "").gsub(/@.+_test/, ""), %{TraceTest::Create
|-- Start.default
|-- Create.task.a
|-- MyNested
|   |-- Start.default
|   |-- B.task.b
|   |-- B.task.e
|   `-- End.success
|-- Create.task.c
|-- Create.task.params
`-- End.failure}
  end

  it "Operation::trace" do
    result = Create.trace(params: {x: 1}, a_return: true)
    assert_equal result.wtf.gsub(/0x\w+/, "").gsub(/@.+_test/, ""), %{TraceTest::Create
|-- Start.default
|-- Create.task.a
|-- MyNested
|   |-- Start.default
|   |-- B.task.b
|   |-- B.task.e
|   `-- End.success
|-- Create.task.c
|-- Create.task.params
`-- End.success}
  end

  it "Operation.wtf?" do
    result = nil
    output, = capture_io do
      result = Create.wtf?(params: {x: 1}, a_return: true)
    end

    assert_equal output.gsub(/0x\w+/, "").gsub(/@.+_test/, ""), %{TraceTest::Create
|-- \e[32mStart.default\e[0m
|-- \e[32mCreate.task.a\e[0m
|-- MyNested
|   |-- \e[32mStart.default\e[0m
|   |-- \e[32mB.task.b\e[0m
|   |-- \e[32mB.task.e\e[0m
|   `-- End.success
|-- \e[32mCreate.task.c\e[0m
|-- \e[32mCreate.task.params\e[0m
`-- End.success
}

    result.success?.must_equal true
    result[:a_return].must_equal true
    result[:params].inspect.must_equal %{{:x=>1}}
  end
end
