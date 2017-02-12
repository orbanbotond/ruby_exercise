describe 'Constants' do

  module Text
  end


  specify '' do
    expect do
      class Text
      end
    end.to raise_error(TypeError)
  end
end
