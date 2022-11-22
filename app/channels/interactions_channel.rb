# frozen_string_literal: true

class InteractionsChannel < ApplicationCable::Channel
  def subscribed
    reject && return unless match

    stream_from stream_from_name(match)

    broadcast_interactions
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def stream_from_name(match)
    "match_#{match.id}_interactions"
  end

  def broadcast_interactions
    ActionCable.server.broadcast(
      stream_from_name(match),
      InteractionCollectionSerializer.new(interactions).as_json
    )
  end

  def interactions
    return Interaction.none unless match

    match.interactions.order(:time, :minutes).includes(:match)
  end

  def match
    @match ||= Match.find_by(id: params[:match_id])
  end
end
