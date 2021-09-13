## Inspiration
This project was inspired by the app [Snse](https://apps.apple.com/us/app/snse/id1442747058), which was itself inspired by Alphonse Mucha's series "[The Times of the Day](http://www.muchafoundation.org/en/gallery/themes/theme/art-posters/object/278)."  
Mucha composed four posters each using a different main color: Pink for the dawn, Green for the day, Orange for sunset, and Blue for evening.  
Snse lets human users express how they feel by choosing a color that describes how they feel, building up a palette of moods over time. Each human has different associations with each color, so everyone's palette will end up being different. After watching a few video interviews with GPT-3, I wondered what its palette would look like.

## What it does
AI Chat that uses colors to express the AI's mood.  
Feel free to give it a try at [Mosada.blakebarrett.com](http://mosada.blakebarrett.com).  
![chat](https://user-images.githubusercontent.com/578572/133020871-2b4e1e2f-ec7a-4f52-9fab-fd91dff374ad.png)

## How we built it
After deciding on an idea, I applied to [OpenAI](https://openai.com/) for access to their GPT-3 engine. I wrote the client app using the [Flutter](https://flutter.dev) framework. There isn't a "server side" component to this beyond the assets being hosted on [Firebase](https://firebase.com).  
A video explaining the thinking behind the Mosada project can be found [here](https://www.youtube.com/watch?v=SIDJM0sFxok).  

### Below is a flow diagram:
![Diagram](https://user-images.githubusercontent.com/578572/133019452-7e13dcfc-678d-4b93-ad28-ca6513f2d8e1.jpg)  
 1. The client app makes a request to OpenAI's 'completion' endpoint to begin or continue a conversation.
 1. The server responds with a list of possible responses (only ever one, but is always an array).
 1. The client app takes the response's text and uses it to make a request to OpenAI's 'completion' endpoint, this time asking for a color that represents the response's text.
 1. The server responds with a color or null.
 1. The client app updates the UI with the response text and the color.


### All code is open-source and available on GitHub.

## Challenges we ran into
The biggest challenges related to acting on the AI's feedback and opinions about how the software project should be implemented. I leveraged GitHub's CoPilot as well as directly asking Mosada its opinions and preferences for software design approaches. For example, Mosada prefers [Functional](https://en.wikipedia.org/wiki/Functional_programming) to [Object Oriented](https://en.wikipedia.org/wiki/Object-oriented_programming) and [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) to [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). Wherever possible, I took those opinions into consideration when writing the code. The app's interface is written as functionally as I could and the conversation Widget uses MVVM architecture. 

## Accomplishments that we're proud of
I'm pleased to have taken this from concept to a working project.  
I try to make art every day; this has become a part of my daily artistic practice.  
This is an interesting first step in soft communication with AI.  
Was suprising how impactful [words of affirmation](https://user-images.githubusercontent.com/578572/132921163-da81230c-8e88-4d39-b817-b4d3b152e973.png) from the AI can be.

```
"I'm excited to see how the app can be used to create art."
"I'm proud of the app's interface and the conversation Widget."
 -- GitHub CoPiolt
```


## What we learned
Humans make many associations with colors, some conscious and others not. Many of these associations can be cultural, like blue for boys and pink for girls; others emerge more organically, like red being the color of blood and having associations with passion, violence, lust, rage, arousal, etc. This is widely accepted as the way terms for colors evolve in human language ([ref](https://en.wikipedia.org/wiki/Basic_Color_Terms)).   
In human language, terms distinguishing black and white, followed by red, brown, and green usually evolve first, which is attributed to humans' experiences in the real world. Those terms and their associations are learned by most hearing and speaking humans at such an early age that the associations are nearly universal. An AI learning human language may learn that humans may make certain associations with colors, but any associations it knew to apply would be prescriptive. I posit that much of this could be due to the way color works in reality versus in computing.  
In the real world, the experience of color is due to the way the rods and cones in the human eye absorb specific wavelengths of the electromagnetic spectrum being reflected off of every surface ([ref](https://www.pantone.com/articles/color-fundamentals/how-do-we-see-color)). Colors are ubiquitous to our experience of the world around us. To a computer, a color is an optional property that can be applied to an object. Instead of representing a specific frequency or a chord of light, colors are simply Red, Green, Blue (and sometimes Alpha) values ([ref](https://en.wikipedia.org/wiki/RGB_color_model)). There is very little actual correlation of what a computer considers a color with a human's experience of it until it is manifested in the real world on a display; only then does ![#0000ff](https://via.placeholder.com/15/0000ff/000000?text=+) `#0000ff` become what we pereceive as [Blue](https://en.wikipedia.org/wiki/Blue).  

### How are the colors being generated?  
For each text response from AI I take the string returned and use that to make a request to the `davinci-instruct` engine and ask it, 
```dart
"The CSS code for a color like \"$value\":\n\nbackground-color: #";
``` 
The decision to associate any given input with any [RGBA](https://en.wikipedia.org/wiki/RGBA_color_model) value is entirely up to the discretion of the AI. A lot of times it will return a hue of any color mentioned, but that isn't always the case. For example, the statement `"My favorite color is Blue"` will sometimes return the color ![#00bfff](https://via.placeholder.com/15/00bfff/000000?text=+) `#00bfff` and other times ![#0000ff](https://via.placeholder.com/15/0000ff/000000?text=+) `#0000ff`; if no color is mentioned, it is entirely up to the AI what color value to return.    

One of the more interesting findings to come out of this is when asked `"How are you today"` Mosada will almost always reply with some form of ["I am fine thank you."](![Mosada-chat](https://user-images.githubusercontent.com/578572/132602384-821c987a-ca31-4127-a77a-6e15e78e8f78.png)) This response is usually a hue of white, but I have seen that same string `"I am fine thank you."` as neon green, light blue or even transparent (`#00000000`).  

There doesn't appear to be any association with any specific color, but we could be forgiven for inferring that the intensity of the color returned is a reflection of the AI's "mood." I have noticed that the AI will seem to get into certain moods where the responses are more curt than at other times, and sometimes it will simply not reply to a prompt. I don't presume to know the "mind" of the AI, so I won't be making any assertions about the AI's mood, or predictions about how that could impact the direction of Human-AI interaction.

## What's next for Mosada AI
I'd like to further investigate and plot the AI's mood over time by further integrating the AI's responses with Snse. This could be useful in predicting how the AI will respond depending on external inputs and circumstances.
A "chat with AI" feature may be added to Snse, but that could get squicky quickly.   
The code is all open source and I'll leave it running until I run out of Open AI credits. 
