class Reunion
  attr_reader :name,
              :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum do |activity|
      activity.total_cost
    end
  end

  def breakout
    @activities.reduce({}) do |result, activity|
      result.merge(activity.owed) do |key, old_value, new_value|
        old_value + new_value
      end
    end
  end

  def summary
    breakout.reduce([]) do |result, (name, owed)|
      result << "#{name}: #{owed}"
    end.join("\n")
  end

end
