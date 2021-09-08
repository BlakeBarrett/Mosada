## Inspiration
This project was inspired by the app [Snse](https://apps.apple.com/us/app/snse/id1442747058), which was itself inspired by Alphonse Mucha's series "[The Times of the Day](http://www.muchafoundation.org/en/gallery/themes/theme/art-posters/object/278)". Mucha composed four posters each using a different main color: Pink for the dawn, Green for the day, Orange for sunset, Blue for evening. Snse lets human users express how they feel by choosing a color that describes how they feel, building up a palette of moods over time. Each human has different associations with each color, so everyone's palette will end up being different. After watching a few video interviews with GPT-3 I wondered what its palette would look like.

## What it does
AI Chat that uses colors to betray the AI's mood.

## How we built it
After deciding on an idea, I applied to [OpenAI](https://openai.com/) for access to their GPT-3 engine and wrote the client app using the [Flutter](https://flutter.dev) framework -- there isn't a "server side" component to this beyond the assets being hosted on [Firebase](https://firebase.com).

## Challenges we ran into


## Accomplishments that we're proud of

## What we learned
Humans make many associations with colors; some conscious other not. Many can be cultural, like the blue/pink boy/girl prescriptions others are more emergent; like red being the color of blood, having associations with passion, violence, lust, rage, arousal, etc. This is widely accepted as the way terms for Colors evolve in human Language ([ref](https://en.wikipedia.org/wiki/Basic_Color_Terms)). In human language, terms distinguishing black, and white, followed by red, brown, and green usually evolve first, which are attributed to human's experience in the real world. Those terms and their associations are learned by most hearing and speaking humans at such an early age that the associations would be nearly universal. An AI learning human language may learn that humans may make certain associations with colors, but any associations it knew to apply would be presecriptive. I would posit that much of this could be due to the way color "works" in reality vs in computing. In the real world, the experience of color is due to the way the rods and cones in the human eye interpret specific wavelengths of the electro magnetic spectrum being radiated off of every reflective surface ([ref](https://www.pantone.com/articles/color-fundamentals/how-do-we-see-color)). Colors or the lack their of permeate our experience of the world around us. To a computer, a color is an optional property that can be applied to an object. Instead of representing a specific frequency or a chord of light, colors are simply Red Green, Blue (and sometimes alpha) values ([ref](https://en.wikipedia.org/wiki/RGB_color_model)). There is very little actual correlation of what a computer considers a color and with a human's experience of it, until it is presented in the real world on a monitor; only then does `#0000FF` become what we pereceive as Blue.

## What's next for Mosada AI
