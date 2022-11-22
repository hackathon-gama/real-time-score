# frozen_string_literal: true

class Api::V1::Matches::InteractionsController < Api::V1::ApplicationController
  before_action :set_match, :set_interaction_class

  def index
    @interactions = @klass.where(match: @match)
  end

  def create
    interaction = @klass.create!(interaction_params.merge(match_id: @match.id))

    interaction.update_match

    broadcast_interaction(interaction)

    head :created
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

  def set_interaction_class
    @klass = Interaction::TYPE_CLASSES.fetch(params[:type], nil)

    raise(ActionDispatch::Http::Parameters::ParseError, 'invalid type') unless @klass
  end

  def broadcast_interaction(interaction)
    ActionCable.server.broadcast(
      "match_#{@match.id}_interactions", InteractionSerializer.new(interaction).as_json
    )
  end

  def interaction_params
    params.require(:interaction).permit(:description, :time, :minutes)
  end
end
