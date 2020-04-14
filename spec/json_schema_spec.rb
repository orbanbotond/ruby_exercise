require 'spec_helper'

describe 'JSON Schema' do
  # The beenfit of Json Schema is portability.
  # This can come from the outside as a file.
  let(:schema) do
    {
        "type" => "object",
        "required" => ["required_field"],
        "properties" => {
            "required_field" => {"type" => "string"},
            "optional_field" => {"type" => "string"}
        }
    }
    end

  let(:data) do
    {
        required_field: "String 1"
    }
  end

  subject(:validation) { JSON::Validator.validate(schema, data) }

  context 'Positive Case' do
    it { is_expected.to be(true) }

    context "having the optional fields" do
      let(:data) { super().merge(field_b: "String 2")}

      it { is_expected.to be(true) }
    end
  end

  context 'Negative Case' do
    subject { -> { JSON::Validator.validate(schema, data) } }

    context "missing the required fields" do
      let(:data) {super.except(:required_field)}

      it { is_expected.to raise_error }
      # it { is_expected.to raise_error(JSON::Schema::ValidationError) }
    end

    context "having invalid data type" do
      let(:data) {super.merge(required_field: 1)}

      it { is_expected.to raise_error }
      # it { is_expected.to raise_error(JSON::Schema::ValidationError) }
    end
  end
end

