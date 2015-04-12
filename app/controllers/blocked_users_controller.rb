class BlockedUsersController < ApplicationController
  before_action :set_blocked_user, only: [:show, :update, :destroy]

  # GET /blocked_users
  # GET /blocked_users.json
  def index
    @blocked_users = BlockedUser.all

    render json: @blocked_users
  end

  # GET /blocked_users/1
  # GET /blocked_users/1.json
  def show
    render json: @blocked_user
  end

  # POST /blocked_users
  # POST /blocked_users.json
  def create
    @blocked_user = BlockedUser.new(blocked_user_params)

    if @blocked_user.save
      render json: @blocked_user, status: :created, location: @blocked_user
    else
      render json: @blocked_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blocked_users/1
  # PATCH/PUT /blocked_users/1.json
  def update
    @blocked_user = BlockedUser.find(params[:id])

    if @blocked_user.update(blocked_user_params)
      head :no_content
    else
      render json: @blocked_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blocked_users/1
  # DELETE /blocked_users/1.json
  def destroy
    @blocked_user.destroy

    head :no_content
  end

  private

    def set_blocked_user
      @blocked_user = BlockedUser.find(params[:id])
    end

    def blocked_user_params
      params.require(:blocked_user).permit(:user_id, :blocked_id)
    end
end
