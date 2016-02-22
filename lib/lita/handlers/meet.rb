require 'pry'
module Lita
  module Handlers
    class Meet < Handler
      config :name_of_auth_group, type: Symbol, default: :standup_participants, required: true
      config :time_to_respond, types: [Integer, Float], default: 60 #minutes

      # insert handler code here
      route(/start standup$/, :start_standup, command: true, help: {"start standup" => "triggers a standup"})
      route(/standup response (1.*)(2.*)(3.*)/, :store_response, command: true, help: {"standup response" => "record list of 1. 2. 3. items and replay in room"})
      route(/standup play/, :update_room, command: true, help: {"standup play" => "plays all the responses recieved" })

      http.get "/startstandup", :trigger_standup

      def trigger_standup(request, response)
        redis.set('last_standup_started_at', Time.now)
        find_and_create_users
        message_all_users
      end

      def start_standup(response)
        redis.set('last_standup_started_at', Time.now)
        find_and_create_users
        message_all_users
      end

      def store_response(response)
        return unless timing_is_right?
        response.reply('Response recorded. Thanks for partipating')
        date_string = Time.now.strftime('%Y%m%d')
        user_name = response.user.name.split(' ').join('_') #lol
        redis.set(date_string + '-' + user_name, response.matches.first)
      end

      def update_room(response)
        binding.pry
        room = Source.new(room: response.room)
        message_body = ''
        response_prefix = Date.parse(redis.get("last_standup_started_at")).strftime('%Y%m%d')
        redis.keys.each do |key|
          if key.to_s.include? response_prefix
            message_body += key.gsub(Date.parse(redis.get("last_standup_started_at")).strftime('%Y%m%d') + '-', "")
            message_body += "\n"
            message_body += MultiJson.load(redis.get(key)).join("\n")
            message_body += "\n"
          end
        end
        robot.send_message(room, message_body)
      end

      private

      def message_all_users
        @users.each do |user|
          source = Lita::Source.new(user: user)
          robot.send_message(source, "Time for standup!")
          robot.send_message(source, "Please tell me what you did yesterday,
                                    1. what you're doing now 2. what you're
                                    working on today 3. something fun. Please prepend your
                                    answer with 'standup response'")
        end
      end

      def find_and_create_users
        @users ||= robot.auth.groups_with_users[config.name_of_auth_group]
      end

      def timing_is_right?
        return false if redis.get('last_standup_started_at').nil?
        intitiated_at = Time.parse(redis.get('last_standup_started_at'))
        Time.now > intitiated_at && intitiated_at + (60*config.time_to_respond) > Time.now
      end

      Lita.register_handler(self)
    end
  end
end
