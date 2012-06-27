require 'test_helper'

class FacetTest < ActiveSupport::TestCase
  test 'Basics' do
    f = Facet.new
    assert ! f.valid?, 'should not have been valid when empty'
    f.context = 'language'
    f.name = 'Programming Language'
    assert f.valid?, 'should have been valid'
    assert f.save, 'should have been saveable'
  end

  test 'Ordering' do
    f = Facet.new
    f.context = 'problem_space'
    f.name = 'Problem Space'
    assert_respond_to(f, :move_higher)
    assert f.save
    assert f.position == 3
    assert f.last? == true

    f.move_higher
    assert f.save
    assert f.position == 2
    assert f.last? == false

  end

  test 'Contexts values' do
    f = Facet.new
    ['foo','bar','language','programming_language'].each do |context|
      f.context = context
      f.name = context
      assert f.valid?, f.errors.full_messages.join(', ')
    end

    ['','Sdfasdbar','foo bar','sdf2'].each do |context|
      f.context = context
      f.name = context
      assert ! f.valid?, f.errors.full_messages.join(', ')
    end

  end

end
