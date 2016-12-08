module Plivo

    class RestAPI
      include SmsSpec::Helpers
      def initialize(auth_id, auth_token, url="https://api.plivo.com", version="v1")
        $auth_id = auth_id
        $auth_token = auth_token
      end


      def send_message(params={})
        to = params[:dst]
        body = params[:text]
        from = params[:src]
        add_message SmsSpec::Message.new(:number => to, :from => from, :body => body)
      end

    end
end