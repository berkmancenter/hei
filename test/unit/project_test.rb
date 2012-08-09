require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'Basic requirements' do
    p = Project.new()
    assert ! p.valid?, 'should not have saved with no attributes'

    p.title = 'Foo test'
    assert p.valid?, 'should have been valid'

  end

  test 'URLs' do
    p = projects(:one)
    assert_respond_to(p, :repository_url)
    assert_respond_to(p, :news_url)
    assert_respond_to(p, :documentation_url)

    p.repository_url = 'asdf'
    assert ! p.valid?

    p.repository_url = ''
    assert p.valid?, p.errors.full_messages.join(',')

    p.repository_url = 'http://asdfasdf'
    assert ! p.valid?, p.errors.full_messages.join(',')

    ['https://asdfasdf.com','http://asdfasdf.com', 'http://www.example.com/asdfasdf/foo.git'].each do|u|
      p.repository_url = u
      assert p.valid?
    end
  end

  test 'is taggable' do
    p = projects(:one)

    assert_respond_to(p,:tag_list)
    assert_respond_to(p,:set_tag_list_on)
    assert_respond_to(p,:taggings)

    p.tag_list = 'foo, bar'
    assert p.save, 'could not save the object'

    p.reload
    assert p.tag_list == ['bar','foo']
  end

  test 'Sunspot indexing' do
    p = projects(:one)
    assert_respond_to(p,:solr_index)
  end

end
