require 'spec_helper'

describe SmsSpec do
  include SmsSpec::Helpers

  before do
    require 'plivo'
    SmsSpec.driver = :"plivo"
    @to_number   = '27999900001' # TEST NUMBER
    @from_number = '27999900005' # TEST NUMBER
    # @client = Plivo::RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
    @client = Plivo::RestAPI.new('123', '123')

    SmsSpec::Data.clear_messages
  end

  describe "the clickatell driver" do
    it "captures the outgoing message for testing" do
      params = {
          src: @from_number,
          dst: @to_number,
          text: 'test message'}

      @client.send_message(params)
      open_last_text_message_for(@to_number)

      expect(current_text_message).to have_body("test message")
      expect(current_text_message.number).to eql(@to_number)
      expect(current_text_message.from).to eql(@from_number)
    end

  end
end

