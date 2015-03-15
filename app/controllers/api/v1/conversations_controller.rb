class API::V1::ConversationsController < ApplicationController
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
      @conversation.title = ""
    end

    respond_to do |format|
      if @conversation.save
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
          # TextMailer.send_text_message(conversation_user.phone).deliver
          ses = AWS::SES::Base.new(
            :access_key_id     => 'AKIAJPLRZ74LQK2NTNLQ', 
            :secret_access_key => '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'
          )
          ses.send_email(
             :to        => ['yass8n@yahoo.com', '2097402793@messaging.sprintpcs.com'],
             :source    => '"yo" <yass8n@yahoo.com>',
             :subject   => 'Subject Line',
             :text_body => 'Internal text body'
          )
          # mail = Mail.new do
          #   from     'me@test.lindsaar.net'
          #   to       '2097402793@messaging.sprintpcs.com'
          #   subject  'Here is the image you wanted'
          #   body     "hi"
          # end
          # mail.delivery_method :sendmail
          # mail.deliver
        end
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created }
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
        format.json { render json: @conversation, status: :updated }
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