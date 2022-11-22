# frozen_string_literal: true

class MatchesChannel < ApplicationCable::Channel
  def subscribed
    reject unless stage

    stream_from params[:stage]

    broadcast_matches
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def broadcast_matches
    ActionCable.server.broadcast(
      params[:stage],
      MatchCollectionSerializer.new(matches).as_json
    )
  end

  def matches
    return Match.none unless stage

    stage.matches.order(:match_date).includes(:team_away, :team_home)
  end

  def stage
    @stage ||= Stage.find_by(name: params[:stage])
  end
end
