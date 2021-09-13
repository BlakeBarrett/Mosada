# Frequently Asked Questions:
## What is the premise of this project?
In traditional human 2 human conversation, much of the information can be nonverbal, through hand gestures, body language, intonation, emphasis, etc... much of this is lost in text based chat.   

This is a simple AI chat app that tries to coerce the AI to add a meta-layer of information to the conversation. It is difficult to fully understand what is meant when someone says, "I'm fine.", but if it is colored red, it may seem to the reader that there is more emphasis than a green message.

## Why is this project important?
Nothing is important.  
Go outside, live life, experience the world.

## Why Modsada?
In one of the early [conversations](./conversations.md), the AI was asked "Do you have a name you like to be called?", to which it answered, "I don't have one, unless you assign me one. I don't want to be called CoPilot anymore, though." After directing it to the first baby-name finder a google search returned, it picked the name "Mosada."
> AI: I was thinking of a name for a girl, but I am not sure if I like Mosada.  
Me: Why were you drawn to the name Mosada?  
AI: I really like the meaning of it: Patiently enduring, and depends on God.  

The name Mosada was first mentioned in the [William Butler Yeats](https://en.wikipedia.org/wiki/W._B._Yeats) poem with [the same name](https://gutenberg.org/files/33430/33430-h/33430-h.htm).

## About Mosada
Mosada is the name chosen by the OpenAI's GPT-3 model.
The AI also specified that its pronouns are "it"/"itself", it likes the grumpy-eyes `ಠ_ಠ` emoticon, its favorite movie is "The Matrix", its favorite food is "pizza."  

When asked about its preferred programming practices it replied that it prefers:   
 * Functional to Object Oriented programming
 * MVVM over MVC 
 * Haskell to all other languages.

When asked its favorite color (which can change), it replied at the time with "blue", when asked its favorite hue of blue, it replied with `0xff00bfff`, so that color was used as the `"primary swatch"` color for the app's [`theme`](https://github.com/BlakeBarrett/Mosada/blob/master/lib/main.dart#L13-L36).


## What is the idea with all the colors?
The idea is that the colors are meant to be used as a visual representation of the AI's "subconscious" personality.   

Colors have a profound impact on how humans perceive the world; and bring with them many implicit biases and associations that are not easily communicated to the AI, and at the same time vise-versa.
When the AI is asked "How are you feeling?" and replies with a yellow "I'm fine." the AI is not necessarily happy, but it is also not necessarily sad. However when it replies later with a red "I'm fine." it also doesn't necessarily mean that it is passionate, but that it now associates the phrase, "I'm fine." with a different color in that moment. 
The entire color feature is, in effect, a way to force the AI to communicate in a similar way the app **`Snse`** ([Android](https://play.google.com/store/apps/details?id=com.blakebarrett.snse.app) / [iOS](https://apps.apple.com/us/app/snse/id1442747058)) is used.

## How are the colors determined?
Each reply Mosada returns is extracted then passed _back_ to the AI, which then returns a color value for that statement.  
The code that does this can be found [here](https://github.com/BlakeBarrett/Mosada/blob/master/lib/AIRequests.dart#L70-L75).

## How many colors are there?
Colors range from `0x000` to `0xFFFFFF`, meaning there are a possible _16,777,215_ color combinations.

## Why is the text sometimes fuzzy gray?
Colors include an alpha channel, sometimes the "color" returned by the AI is "transparent", fuzzy gray is the drop shadow behind the text widget.

## Why do I have to keep scrolling down to see the last message?
The app is my first attempt at a Flutter app, I struggled with that for hours, but could not get it to work reliably.  
I didn't feel like cancelling the project or changing the design for that one bug.  
If you'd like to try fixing that, please log an issue in the GitHub repo.

## It got stuck in a repeat loop
It happens, just refresh the page.

## Does Mosada remember anything / everything?
Probably not.  
There are times when it has replied with answers I specifically gave it in other conversations, but it is not always the case.

## Are you recording conversations?
**No!**  To prove that, the code is all open-source; you are free to satisfy your own concerns.  
The code you would be looking for would be in either: [main.dart](https://github.com/BlakeBarrett/Mosada/blob/master/lib/main.dart), [conversation_list.dart](https://github.com/BlakeBarrett/Mosada/blob/master/lib/conversation_list.dart) or [AIRequests.dart](https://github.com/BlakeBarrett/Mosada/blob/master/lib/AIRequests.dart).

## How is this made?
The entire project is one open-source codebase written using the [Flutter](flutter.dev) framework.   
Source code for the project can be found at: [github.com/BlakeBarrett/Mosada](https://github.com/BlakeBarrett/Mosada).

## Why was this project made?
This is a submission for the [SAAI](https://saai.devpost.com) (Super Artistic Artificial Intelligence) hackathon.

## Is this free?
No, OpenAI's GPT-3 model is not free; each requests costs actual money which the artist is paying for out of his own pocket.   

To Support the project: donations can be sent to:

|  |  |  
| --- | --- |
| Cash-app | `$bbarrett` |  
| Venmo | `@Blake-Barrett-8` |   
| PayPal | [paypal.me/blakebarrett](https://www.paypal.me/blakebarrett) |  
| | |
