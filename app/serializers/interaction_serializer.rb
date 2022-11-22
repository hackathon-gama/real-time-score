# frozen_string_literal: true

class InteractionSerializer
  attr_reader :interaction

  def initialize(interaction)
    @interaction = interaction
  end

  def as_json
    {
      id: interaction.id,
      description: interaction.description,
      time: interaction.time,
      minutes: interaction.minutes,
      type: Interaction::TYPE_CLASSES.key(interaction.class),
      match: MatchSerializer.new(interaction.match)
    }.as_json
  end

  private

  def stage
    @stage ||= match.stage
  end

  def team_home
    @team_home ||= match.team_home
  end

  def team_away
    @team_away ||= match.team_away
  end
end
