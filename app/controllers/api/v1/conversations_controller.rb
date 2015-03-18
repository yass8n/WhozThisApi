class API::V1::ConversationsController < ApplicationController
  require 'sendgrid-ruby'
  require 'multi_json'
  MultiJson.use :yajl
  skip_before_action :verify_authenticity_token
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
    render json: @conversations, status: :ok
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    if (params["phones"] == nil || params["phones"][0] == nil) then
      render json: "{\"phones\":[\"can't be blank\"]}", status: :unprocessable_entity and return 
    end
    if (params["conversation"]["title"] == nil || params["conversation"]["title"] == "") then
      @conversation.title = "No Subject"
    end

    respond_to do |format|
      if @conversation.save
        @owner = User.find(params[:user_id])
        # including owner in the conversation
        conversation_user = ConversationUser.new(conversation_id: @conversation.id, phone: @owner.phone, user_id: @owner.id)
        conversation_user.save
        client = SendGrid::Client.new do |c|
          c.api_user = ENV['SENDGRIDUSERNAME'].to_s
          c.api_key = ENV['SENDGRIDPASSWORD'].to_s
        end
        #if the conversation was successfully created, then we know that phone numbers have been passed in the parameters...
        #so we can now loop through these phone numbers and create conversation_users as well as send out notifications 
        params["phones"].each do |phone|
          user = User.new(phone: phone).find_by_phone
          #if a phone number is not in our database of users, set the user_id of that conversation_user to 0
          if user == nil then
            user = User.new
            user.id = 0
          end
          conversation_user = ConversationUser.new(conversation_id: @conversation.id, phone: phone, user_id: user.id)
          conversation_user.save
          if user.id == 0 then
            carrier_arr = ["@txt.att.net", "@txt.att.net", "@mms.att.net", "@tmomail.net",
                           "@vtext.com", "@vzwpix.com", "@messaging.sprintpcs.com", 
                           "@mymetropcs.com", "@message.alltel.com", "@vmobl.com"]
            carrier_arr.each do |carrier|
              user.send_text(phone, carrier, client, @conversation.title)
            end
          end
        end
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render json: @conversation, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conversation_params
    params.require(:conversation).permit(:title, :user_id)
  end
end
