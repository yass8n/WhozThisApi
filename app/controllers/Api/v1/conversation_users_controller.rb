class API::V1::ConversationUsersController < ApplicationController
  before_action :set_conversation_user, only: [:show, :edit, :update, :destroy]

  # GET /conversation_users
  # GET /conversation_users.json
  def index
    @conversation_users = ConversationUser.all
  end

  # GET /conversation_users/1
  # GET /conversation_users/1.json
  def show
  end

  # GET /conversation_users/new
  def new
    @conversation_user = ConversationUser.new
  end

  # GET /conversation_users/1/edit
  def edit
  end

  # POST /conversation_users
  # POST /conversation_users.json
  def create
    @conversation_user = ConversationUser.new(conversation_user_params)

    respond_to do |format|
      if @conversation_user.save
        format.html { redirect_to @conversation_user, notice: 'Conversation user was successfully created.' }
        format.json { render :show, status: :created, location: @conversation_user }
      else
        format.html { render :new }
        format.json { render json: @conversation_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversation_users/1
  # PATCH/PUT /conversation_users/1.json
  def update
    respond_to do |format|
      if @conversation_user.update(conversation_user_params)
        format.html { redirect_to @conversation_user, notice: 'Conversation user was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation_user }
      else
        format.html { render :edit }
        format.json { render json: @conversation_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversation_users/1
  # DELETE /conversation_users/1.json
  def destroy
    @conversation_user.destroy
    respond_to do |format|
      format.html { redirect_to conversation_users_url, notice: 'Conversation user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation_user
      @conversation_user = ConversationUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_user_params
      params.require(:conversation_user).permit(:user_id, :conversation_id)
    end
end
