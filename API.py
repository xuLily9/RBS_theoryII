import openai
 
openai.api_key = "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"
 
def get_response():
 
  prompts = [
    {"role": "system", "content" : "You are an expert prolog language"},
    {"role": "user", "content" : "can you print some nodes for me, such as node(A,B,C,D) for traffic"},
  ]
  response = openai.ChatCompletion.create(
      model="gpt-3.5-turbo",
      temperature= 0.5,
      messages=prompts
  )
 
  result = ''
  for choice in response.choices:
      result += choice.message.content
 
  return result

# Call the function and store the result
response_result = get_response()

# Use the generated response
print(response_result)