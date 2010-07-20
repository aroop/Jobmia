require File.dirname(__FILE__) + '/../test_helper'

class TagTest < Test::Unit::TestCase
  fixtures :tags, :taggings, :jobs
  def test_to_s
    assert_equal "delicious sexy", Job.find(2).tags.to_s
  end
  
end
