# frozen_string_literal: true

json.array! @interactions, partial: 'interaction', as: :interaction, cached: true
