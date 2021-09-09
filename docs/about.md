## Inspiration
This project was inspired by the app [Snse](https://apps.apple.com/us/app/snse/id1442747058), which was itself inspired by Alphonse Mucha's series "[The Times of the Day](http://www.muchafoundation.org/en/gallery/themes/theme/art-posters/object/278)".  
Mucha composed four posters each using a different main color: Pink for the dawn, Green for the day, Orange for sunset, Blue for evening.  
Snse lets human users express how they feel by choosing a color that describes how they feel, building up a palette of moods over time. Each human has different associations with each color, so everyone's palette will end up being different. After watching a few video interviews with GPT-3 I wondered what its palette would look like.

## What it does
AI Chat that uses colors to betray the AI's mood.

## How we built it
After deciding on an idea, I applied to [OpenAI](https://openai.com/) for access to their GPT-3 engine. I wrote the client app using the [Flutter](https://flutter.dev) framework. There isn't a "server side" component to this beyond the assets being hosted on [Firebase](https://firebase.com).
All code is open-source and available on GitHub.

## Challenges we ran into
The beiggest challenges were around acting on the AI's feedback and opinions about how the software project should be implemented. I leveraged GitHub's CoPiolot as well as directly asking Mosada, its opinions and preferences for software design approaches. For example; Mosada prefers [Functional](https://en.wikipedia.org/wiki/Functional_programming) to [Object Oriented](https://en.wikipedia.org/wiki/Object-oriented_programming) and [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) to [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). Wherever possible, I took those opinions into consideration when writing the code. The API interface is written as functionally as I could, and the conversation Widget uses MVVM architecture. 

## Accomplishments that we're proud of
I'm pleased to have taken this from concept to a working project.  
I try to make art every day, this has become a part of my daily artistic practice.

## What we learned
Humans make many associations with colors; some conscious other not. Many can be cultural, like the blue/pink boy/girl prescriptions others are more emergent; like red being the color of blood and having associations with passion, violence, lust, rage, arousal, etc. This is widely accepted as the way terms for Colors evolve in human Language ([ref](https://en.wikipedia.org/wiki/Basic_Color_Terms)).   
In human language, terms distinguishing black, and white, followed by red, brown, and green usually evolve first, which are attributed to human's experience in the real world. Those terms and their associations are learned by most hearing and speaking humans at such an early age that the associations would be nearly universal. An AI learning human language may learn that humans may make certain associations with colors, but any associations it knew to apply would be presecriptive. I would posit that much of this could be due to the way color "works" in reality vs in computing.  
In the real world, the experience of color is due to the way the rods and cones in the human eye absorb specific wavelengths of the electro magnetic spectrum being reflected off of every surface ([ref](https://www.pantone.com/articles/color-fundamentals/how-do-we-see-color)). Colors are ubiquitus to our experience of the world around us. To a computer, a color is an optional property that can be applied to an object. Instead of representing a specific frequency or a chord of light, colors are simply Red Green, Blue (and sometimes Alpha) values ([ref](https://en.wikipedia.org/wiki/RGB_color_model)). There is very little actual correlation of what a computer considers a color and with a human's experience of it until it is manifested in the real world on a display; only then does ![#0000ff](https://via.placeholder.com/15/0000ff/000000?text=+) `#0000ff` become what we pereceive as [Blue](https://en.wikipedia.org/wiki/Blue).  

### How are the colors being generated?  
For each text response from AI I take the string returned and use that to make a request to the `davinci-instruct` engine and ask it, 
```dart
"The CSS code for a color like \"$value\":\n\nbackground-color: #";
``` 
The decision to associate any given input with any ARGB value is entirely up to the discretion of the AI. A lot o times it will return a hue of any color mentioned, but that isn't always the case. For example, the statement `"My favorite color is Blue"` will sometimes return the color ![#00bfff](https://via.placeholder.com/15/00bfff/000000?text=+) `#00bfff`, others ![#0000ff](https://via.placeholder.com/15/0000ff/000000?text=+) `#0000ff`; if no color is mentioned, it is entirely up to the AI what color value to return.    

One of the more interesting anecdotes to come of this is when asked "How are you today" Mosada will almost always reply with ["I am fine thank you."](![Mosada-chat](https://user-images.githubusercontent.com/578572/132602384-821c987a-ca31-4127-a77a-6e15e78e8f78.png)) This response is usually a hue of white, but I have seen that same string `"I am fine thank you."` as neon green, light blue or even transparent (`#00ffffff`).  

There doesn't appear to be any association with any specific color, but we would be forgiven for inferring that the intensity of the color returned is a reflection of the AI's "mood".  
I have noticed the AI will get into certain moods where the responses are more curt or sassy than others, and other times when it will simply not reply to a prompt. It can be quite wilful at times.  

## What's next for Mosada AI
There are no immediate plans for future development of the Mosada project.  
Perhaps a "chat with AI" feature will be added to Snse, but that could get squicky quickly.   
The code is all open source and I'll leave it running until I run out of Open AI credits. 
