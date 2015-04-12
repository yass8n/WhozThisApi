class API::V1::BlockedUsersController < ApplicationController
  require 'multi_json'
  MultiJson.use :yajl
  skip_before_action :verify_authenticity_token
  before_action :set_blocked_user, only: [:show, :edit, :update, :destroy]

  # GET /blocked_users
  # GET /blocked_users.json
  def index
    @blocked_users = BlockedUser.all
    render json: @blocked_users, status: :ok
  end

  # GET /blocked_users/1
  # GET /blocked_users/1.json
  def show
  end

  # GET /blocked_users/new
  def new
    @blocked_user = BlockedUser.new
  end

  # GET /blocked_users/1/edit
  def edit
  end

  # POST /blocked_users
  # POST /blocked_users.json
  def create
    blocked_user_ids = params[:blocked_user][:blocked_id] #array of user_ids 
    current_user = User.find(params[:blocked_user][:user_id])
    unless (current_user.nil? || blocked_user_ids.nil?) then
      blocked_user_ids.each do |blocked_id| 
        already_blocked = BlockedUser.new.already_blocked?(current_user.id, blocked_id)
        checking_existance = User.where(id: blocked_id)[0]
        if (!already_blocked && checking_existance) then
          blocked_user = BlockedUser.new
          blocked_user.user_id = current_user.id
          blocked_user.blocked_id = blocked_id
          blocked_user.save
        end
      end
    end
    blocked_users = current_user.get_blocked_users
    respond_to do |format|
      format.html { redirect_to @blocked_user, notice: 'Conversation user was successfully created.' }
      format.json { render :partial => "api/v1/blocked_users/blocked.json.jbuilder", locals: {blocked: blocked_users }, status: :ok}
    end
  end

  # DELETE /blocked_users/1
  # DELETE /blocked_users/1.json
  def destroy
    @blocked_user.destroy
    respond_to do |format|
      format.html { redirect_to blocked_users_url, notice: 'Conversation user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blocked_user
    @blocked_user = BlockedUser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blocked_user_params
    params.require(:blocked_user).permit(:user_id, :blocked_id)
  end
end