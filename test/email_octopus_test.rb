require 'test_helper'

class EmailOctopusTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::EmailOctopus::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_it_can_get_lists
    refute_empty EmailOctopus::List.all.each {|l| puts l }
  end

  def test_it_can_get_a_list_details
    EmailOctopus::List.find(ENV.fetch('TEST_LIST_ID'))
  end

end
