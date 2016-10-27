class ProposalsController < ApplicationController

  before_action :authenticate_user!

  # Concern route
  # PUT /categories/:gem_category_id/proposals
  # PUT /gems/:gem_object_id/proposals
  def update
    ActiveRecord::Base.transaction do
      @proposal = proposed_object!
                   .proposals
                   .where(
                     "proposed_attribute = ? AND proposed_value ILIKE ?",
                     proposal_params[:proposed_attribute],
                     "%#{proposal_params[:proposed_value].squish}%"
                   )
                   .first_or_initialize do |proposal|
        proposal.proposed_attribute = proposal_params[:proposed_attribute]
        proposal.proposed_value = proposal_params[:proposed_value]
        proposal.note = proposal_params[:note]
      end

      user_proposal = @proposal.user_proposals.find_or_initialize_by(user: current_user)
      user_proposal.touch if user_proposal.persisted?
      @proposal.save!

    end

    render 'proposals/proposals'
  end

  private

  def proposal_params
    params.require(:proposal).permit(:note, :proposed_attribute, :proposed_value)
  end

  def proposed_object!
    if @proposed.nil?
      if params[:gem_category_id].present? && params[:gem_object_id].present?
        raise ActionController::BadRequest.new('Only one id accepted.')
      elsif params[:gem_category_id].blank? && params[:gem_object_id].blank?
        raise ActionController::BadRequest.new('Requested any object id.')
      end

      @proposed = if params[:gem_object_id].present?
                    GemObject.friendly.find(params[:gem_object_id])
                  elsif params[:gem_category_id].present?
                    GemCategory.friendly.find(params[:gem_category_id])
                  end
    end

    @proposed
  end
end
