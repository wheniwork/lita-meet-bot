# lita-meet

lita-meet is a bot that does standups. It allows them to be triggered in chat or by http request.

## Installation

Add lita-meet to your Lita instance's Gemfile:

``` ruby
gem "lita-meet"
```

## Configuration
Configuration options:

```
config.handler.meet.name_of_auth_group = :standup_participants
config.handler.meet.time_to_respond = 60 #minutes
config.handler.meet.api_key, type: String, default: 'qArnqfhXFb3DWMYtOXuKxjG3iLGHYXHxKnZurDbFAQx2T0zsnm8DrQSYBQep6Njo'
config.handler.meet.enable_http = "on" 
config.handler.meet.standup_message ="Please tell me what you did yesterday, 1. what you're doing now 2. what you're working on today 3. something fun. Please prepend your answer with 'standup response'"
```

## Usage

```
Lita Bot Development: start standup - triggers a standup
Lita Bot Development: standup response - record list of 1. 2. 3. items and replay in room
Lita Bot Development: standup play - plays all the responses recieved
Lita Bot Development: standup playback date - plays back a standup from a given date. Date must be in yyyymmdd format
```
