class Activity
  attr_reader :name,
              :participants

  def initialize(name)
    @name = name
    @participants = Hash.new
  end

  def add_participant(participant, paid)
    @participants[participant] = paid
  end

  def total_cost
    @total_cost = 0
    @participants.map do |_name, paid|
      @total_cost += paid
    end
    @total_cost
  end

  def split
    total_cost / @participants.keys.count
  end

  def owed
    @split = split
    owed = Hash.new
    @participants.map do |participant, paid|
      owed[participant] = (paid - split) * -1
    end
    owed
  end

end
