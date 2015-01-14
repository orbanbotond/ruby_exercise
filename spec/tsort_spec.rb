require 'spec_helper'
require 'tsort'

describe 'Tsort' do

  let(:graph) { g = {1=>[2, 3], 2=>[4], 3=>[2, 4], 4=>[]} }
  let(:nodes) { lambda {|&b| graph.each_key(&b) } }
  let(:childs) { lambda {|n, &b| graph[n].each(&b) } }

  context 'The graph is acyclic' do
    specify 'Determines the traverse order' do
      expect(TSort.tsort(nodes, childs)).to eq([4, 2, 3, 1])
    end
    specify 'Strongly connected components' do
      expect(TSort.strongly_connected_components(nodes, childs)).to eq([[4], [2], [3], [1]])
    end
  end

  context 'The graph is acyclic' do
    let(:graph) { g = {1=>[2, 3], 2=>[4, 1], 3=>[2, 4], 4=>[]} }
    specify 'Raises an Exception' do
      expect { TSort.tsort(nodes, childs) }.to raise_error(TSort::Cyclic)
    end
  end

end
