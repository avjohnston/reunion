require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test
  def test_it_exists_and_has_attributes
    activity = Activity.new("Brunch")

    assert_instance_of Activity, activity
    assert_equal "Brunch", activity.name
    assert_equal Hash.new, activity.participants
  end

  def test_it_can_add_participant
    activity = Activity.new("Brunch")
    expected = {"Maria" => 20}
    expected_2 = {"Maria" => 20, "Luther" => 40}

    activity.add_participant("Maria", 20)

    assert_equal expected, activity.participants
    assert_equal 20, activity.total_cost

    activity.add_participant("Luther", 40)

    assert_equal expected_2, activity.participants
    assert_equal 60, activity.total_cost
  end

  def test_it_can_split_cost
    activity = Activity.new("Brunch")
    expected = {"Maria" => 20}
    expected_2 = {"Maria" => 20, "Luther" => 40}

    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    assert_equal 30, activity.split
  end

  def test_it_can_find_owed
    activity = Activity.new("Brunch")
    expected = {"Maria" => 20}
    expected_2 = {"Maria" => 20, "Luther" => 40}
    owed = {"Maria" => 10, "Luther" => -10}

    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    assert_equal owed, activity.owed

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 20)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 10)

    expected = {"Maria" => 10, "Luther" => -30, "Louis" => 20}

    assert_equal expected, activity_2.owed
  end

end
