require 'pry-byebug'

class DiscussionsController < ApplicationController

  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def show_leader
    @discussion = Discussion.find(params[:id])
    @questions = Question.where(discussion_id: params[:id])
  end

  def create
    @discussion = Discussion.new(discussion_params)
    codes = generate_codes
    @discussion.leader_code, @discussion.participant_code = codes.first, codes.last
    if @discussion.save
      WebsocketRails[:new_discussion].trigger(:update_discussions_index, @discussion)
      redirect_to discussion_path(@discussion.id)
    else
      flash[:error] = 'There was an error creating your discussion'
      redirect_to root_path
    end
  end

  def generate_codes(size = 6)
    charset = [('a'..'z').to_a, ('A'..'Z').to_a, ('0'..'9').to_a].flatten
    begin
      code1 = (0...size).map{ charset[rand(charset.size)] }.join
      code2 = (0...size).map{ charset[rand(charset.size)] }.join 
    end until code1 != code2
    return [code1, code2]
  end

  private
    def discussion_params
      params.require(:discussion).permit(:title, :leader_email)
    end
end
