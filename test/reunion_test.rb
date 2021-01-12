require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'
require './lib/reunion'

class ReunionTest < Minitest::Test
  def test_it_exists_and_has_attributes
    reunion = Reunion.new("1406 BE")

    assert_instance_of Reunion, reunion
    assert_equal "1406 BE", reunion.name
    assert_equal [], reunion.activities
  end

  def test_it_can_add_activities
    reunion = Reunion.new("1406 BE")
    activity_1 = Activity.new("Brunch")

    reunion.add_activity(activity_1)

    assert_equal [activity_1], reunion.activities
  end

  def test_it_can_find_reunion_total_cost
    reunion = Reunion.new("1406 BE")
    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)

    assert_equal 60, reunion.total_cost

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)

    assert_equal 180, reunion.total_cost
  end

  def test_it_can_breakout
    reunion = Reunion.new("1406 BE")
    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)

    expected = {"Maria" => -10, "Luther" => -30, "Louis" => 40}

    assert_equal expected, reunion.breakout
  end

  def test_it_can_print_summary
    reunion = Reunion.new("1406 BE")
    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)

    expected = "Maria: -10\nLuther: -30\nLouis: 40"

    assert_equal expected, reunion.summary
  end


end
