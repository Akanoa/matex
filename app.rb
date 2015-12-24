require 'sinatra'
require "cgi"
require 'json'
require 'tex2png'


def upload(path)
          `curl -F file=@#{path} -F token=xoxp-xxxxxxx-xxxxxxx https://slack.com/api/files.upload`
end

get '/' do
    "Yolo\n"
end

post '/' do
    data = CGI::parse request.body.read
    content_type :json
    puts data['text']
    message = data['text'][0]
    converter = Tex2png::Converter.new(message)
    result = upload(converter.png.path)
    result = JSON.parse(result)['file']['url']
    {:text => "#{result}"}.to_json
end
