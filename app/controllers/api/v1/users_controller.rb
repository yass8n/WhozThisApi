class API::V1::UsersController < ApplicationController
  require 'multi_json'
  MultiJson.use :yajl
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy, :stream]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    encoded_file = params[:user][:filename]
    if !params[:user].nil? && !encoded_file.nil? && encoded_file != ""
      @user.remove_image_path
      @user.create_image(encoded_file)
    end

    respond_to do |format|
      if @user.save
        # Setting the conversation_user ids of the new user from 0 to the users new ID
        users_conversations = ConversationUser.where(phone: params[:phone])
        users_conversations.each do |conv_user|
          conv_user.user_id = @user.id
          conv_user.save
        end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Post /users/sign_in
  def sign_in
    @attempting_sign_in_user = User.new(user_params)
    @user = @attempting_sign_in_user.find_by_phone
    render json: @user, status: :ok and return if (@user != nil && @user.password == @attempting_sign_in_user.password)
    render json: "{\"error\" : \"not authorized\"}", status: :not_authorized and return
  end

  # GET /users/stream/:user_id
  def stream
    # look at api/v1/users/stream.json.jbuilder for output
    conversations = @user.conversations.merge(ConversationUser.active).reverse #get all active (non-deleted) conversations 
    render :partial => "api/v1/users/stream.json.jbuilder", locals: {conversations: conversations }, status: :ok
  end

  # Post /user/friends
  def friends
    # look at api/v1/users/freinds.json.jbuilder for output
    #passing an array of phones to the database to match the users phones and return friends
    @friends = User.where(phone: params["phones"])
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    encoded_file = params[:user][:filename]
    if !params[:user].nil? && !encoded_file.nil? && encoded_file != ""
      @user.remove_image_path
      @user.create_image(encoded_file)
    end

    respond_to do |format|
      if @user.update(user_params) 
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :phone)
  end
end
