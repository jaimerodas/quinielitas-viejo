class ParticipantsController < ApplicationController
  before_action :logged_in_user
  before_action :set_match_pool

  def pay
    @participant = @match_pool.participants.find(params[:id])
    @participant.update_attribute(:paid, !@participant.paid)
    redirect_to match_pool_path(@match_pool)
  end
end
