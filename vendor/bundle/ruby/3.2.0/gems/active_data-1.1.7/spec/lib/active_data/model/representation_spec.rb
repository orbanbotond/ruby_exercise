require 'spec_helper'

describe ActiveData::Model::Representation do
  context 'integration' do
    before do
      stub_model(:author) do
        attribute :rate, Integer
      end

      stub_model(:post) do
        include ActiveData::Model::Representation

        attribute :author, Object
        alias_attribute :a, :author
        represents :rate, of: :a
        alias_attribute :r, :rate
      end
    end
    let(:author) { Author.new(rate: '42') }

    specify { expect(Post.reflect_on_attribute(:rate).reference).to eq('author') }

    specify { expect(Post.new(author: author).rate).to eq(42) }
    specify { expect(Post.new(author: author).rate_before_type_cast).to eq('42') }
    specify { expect(Post.new(rate: '33', author: author).rate).to eq(33) }
    specify { expect(Post.new(rate: '33', author: author).author.rate).to eq(33) }
    specify { expect(Post.new(r: '33', author: author).rate).to eq(33) }
    specify { expect(Post.new(r: '33', author: author).author.rate).to eq(33) }
    specify { expect(Post.new(author: author).rate?).to eq(true) }
    specify { expect(Post.new(rate: nil, author: author).rate?).to eq(false) }

    specify { expect(Post.new.rate).to be_nil }
    specify { expect(Post.new.rate_before_type_cast).to be_nil }
    specify { expect { Post.new(rate: '33') }.to raise_error(NoMethodError) }

    context 'ActionController::Parameters' do
      let(:params) { instance_double('ActionController::Parameters', to_unsafe_hash: {rate: '33', author: author}) }
      specify { expect { Post.new(params) }.not_to raise_error }
    end

    context 'dirty' do
      before do
        Author.include ActiveData::Model::Dirty
        Post.include ActiveData::Model::Dirty
      end

      specify do
        expect(Post.new(author: author, rate: '33').changes)
          .to eq('author' => [nil, author], 'rate' => [42, 33])

        expect(Post.new(author: author, rate: '33').changes)
          .to eq('author' => [nil, author])
      end
    end

    context do
      before do
        stub_class(:author, ActiveRecord::Base)

        stub_model(:post) do
          include ActiveData::Model::Associations
          include ActiveData::Model::Representation

          references_one :author
          alias_association :a, :author
          represents :name, of: :a
        end
      end
      let!(:author) { Author.create!(name: 42) }

      specify { expect(Post.reflect_on_attribute(:name).reference).to eq('author') }

      specify { expect(Post.new(name: '33', author: author).name).to eq('33') }
      specify { expect(Post.new(name: '33', author: author).author.name).to eq('33') }
    end

    context 'multiple attributes in a single represents definition' do
      before do
        stub_model(:author) do
          attribute :first_name, String
          attribute :last_name, String
        end

        stub_model(:post) do
          include ActiveData::Model::Representation

          attribute :author, Object
          represents :first_name, :last_name, of: :author
        end
      end

      let(:author) { Author.new(first_name: 'John', last_name: 'Doe') }
      let(:post) { Post.new }

      specify do
        expect { post.update(author: author) }
          .to change { post.first_name }.to('John')
          .and change { post.last_name }.to('Doe')
      end
    end
  end

  describe '#validate' do
    before do
      stub_class(:author, ActiveRecord::Base) do
        validates :name, presence: true

        # Emulate Active Record association auto save error.
        def errors
          super.tap do |errors|
            errors.add(:'user.email', 'is invalid') if errors[:'user.email'].empty?
          end
        end
      end

      stub_model(:post) do
        include ActiveData::Model::Associations
        include ActiveData::Model::Representation

        references_one :author
        represents :name, :email, of: :author
      end
    end

    let(:post) { Post.new(author: Author.new) }

    specify do
      expect { post.validate }.to change { post.errors.messages }
        .to(hash_including('author.user.email': ['is invalid'], name: ["can't be blank"]))
    end
  end
end
