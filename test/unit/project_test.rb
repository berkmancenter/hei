require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'Basic requirements' do
    p = Project.new()
    assert ! p.valid?, 'should not have saved with no attributes'

    p.title = 'Foo test'
    assert p.valid?, 'should have been valid'

  end

  test 'is taggable' do
    p = projects(:one)

    assert_respond_to(p,:tag_list)
    assert_respond_to(p,:taggings)

    p.tag_list = 'foo, bar'
    assert p.save, 'could not save the object'

    p.reload
    assert p.tag_list == ['bar','foo']
  end

end
