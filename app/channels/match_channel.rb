# frozen_string_literal: true

class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:match]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
