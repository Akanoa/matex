require 'sinatra'
require "cgi"
require 'json'
require 'tex2png'

get '/' do
    "Yolo2\n"
end

post '/' do
    data = CGI::parse request.body.read
    content_type :json
    puts data['text']
    message = data['text'][0]
    converter = Tex2png::Converter.new(message)
    result = converter.data
    {:text => "Ton texte de merde: *#{result}*, pour l'instant j'en fait rien mais à 5000 RT on y pense"}.to_json
end
