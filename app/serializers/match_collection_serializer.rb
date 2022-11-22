# frozen_string_literal: true

class MatchCollectionSerializer
  attr_reader :matches

  def initialize(matches)
    @matches = matches
  end

  def as_json
    matches.find_each.map do |match|
      MatchSerializer.new(match).as_json
    end
  end
end
