# GradientTransparentNavigationBar
This is a demo written in Objective-C to show how to get a gradient transparent navigation bar
Sometimes we need a scrollview with a banner image on the top with our navigation bar. There is view controller general infomation in the banner,
such as title, description, buttons. When user scrolls up, the banner may disapear. Then the general information of the view controller is also 
dismissed. To solve this issue, we offen use a gradient transparent navigation bar to maintain the general information. 
The navigation bar is transparent, when the banner begins to disappear, we add the navigation bar's alpha value to make it appear gradiently. 
And finnally, the navigation bar's alpha is set to 1 to be opaque.

When the user scrolls down, the navigation bar is transparent opaque, we decrease the navigation bar's alpha value to make it disappear gradiently. 
And finnally, the navigation bar's alpha is set to 1 to be fully transparent.

#Screenshot shown as below:
<p>!![demo gif](https://github.com/AiguangLi/GradientTransparentNavigationBar/blob/master/screenshot.gif "Demo GIF")</p>

#Addtional info
The demo also provide a category to UIImage class to get part of an image for a given rect.
The demo used the visual format language to layout UI components, the autolayout demo can be found on:https://github.com/AiguangLi/AutolayoutDemo

