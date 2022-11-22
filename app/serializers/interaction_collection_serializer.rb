# frozen_string_literal: true

class InteractionCollectionSerializer
  attr_reader :interactions

  def initialize(interactions)
    @interactions = interactions
  end

  def as_json
    interactions.find_each.map do |interaction|
      InteractionSerializer.new(interaction).as_json
    end
  end
end
