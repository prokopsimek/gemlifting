class ProposalsController < ApplicationController

  before_action :authenticate_user!

  # Concern route
  # PUT /categories/:gem_category_id/proposals
  # PUT /gems/:gem_object_id/proposals
  def update
    ActiveRecord::Base.transaction do
      proposal = proposed_object!
                   .proposals
                   .where(
                     "proposed_attribute = ? AND proposed_value ILIKE '?'",
                     proposal_params[:proposed_attribute],
                     proposal_params[:proposed_value].squish
                   )
                   .first_or_initialize { |proposal| proposal.note = proposal_params[:note] }

      user_proposal = proposal.user_proposal.where(user: current_user).first_or_initialize
      user_proposal.touch if user_proposal.persisted?
      proposal.save!
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:gem_category_id, :gem_object_id, :note, :proposed_attribute, :proposed_value)
  end

  def proposed_object!
    if @proposed.nil?
      if proposal_params[:gem_category_id].present? && proposal_params[:gem_object_id].present?
        raise ActionController::BadRequest.new('Only one id accepted.')
      elsif proposal_params[:gem_category_id].blank? && proposal_params[:gem_object_id].blank?
        raise ActionController::BadRequest.new('Requested any object id.')
      end

      @proposed = if proposal_params[:gem_object_id].present?
                    GemObject.friendly.find(proposal_params[:gem_object_id])
                  elsif proposal_params[:gem_category_id].present?
                    GemCategory.friendly.find(proposal_params[:gem_category_id])
                  end
    end

    @proposed
  end
end
