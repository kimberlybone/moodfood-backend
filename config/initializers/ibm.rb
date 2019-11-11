# require "ibm_watson/authenticators"
# require "ibm_watson/natural_language_understanding_v1"
# include IBMWatson
#
#
# def new_token
#   AUTHENTICATOR = Authenticators::IamAuthenticator.new(
#     apikey: ENV['AI_API_KEY']
#   )
#   NLU = NaturalLanguageUnderstandingV1.new(
#     version: "2019-07-12",
#     authenticator: AUTHENTICATOR
#   )
#   NLU.service_url = "https://gateway.watsonplatform.net/natural-language-understanding/api"
#
#   response = NLU.analyze( url: "www.cnn.com", features: {entities: {sentiment: true, limit: 10, model: ENV['MODEL_ID']}})
#
#   JSON.pretty_generate(response.result)
# end
