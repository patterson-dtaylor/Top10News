# Top10 News

<p align="center">
<img src="Documentation/top10news-mockup.png.png" width="650"  title="Top10News App">
</p>

## Author

Taylor Patterson

## Description

This project was built for the user in mind.  Instead of being bombarded with numerous articles, I wanted an app that only curated a list of the top 10 articles for a query. Top10 News adheres to MVVM structural design, uses OOP best practices to pass data through the view hierarchy, programmatically built every UIView, user login uses Authentication through Firebase as well as personal bookmarks saved within constructed database through Firebase.

## Tools Used

<p align="left">
<img src="https://firebase.google.com/images/brand-guidelines/logo-built_black.png" width="100" title="Firebase Icon">
</p>

**Firebase** - Google's answer to storing mobile data.

**How I Used Firebase** - Firebase is my go to third party framework for authentication and database functionality. It's fast, easy to learn, and can be implemented with Apple's sign in functionality.  I used Firebase's Cloud database and Authentication capabilities to register new users, save and share user's bookmarks, as well as the link functionality.  I chose Firebase because of its ease of use and how fast the cloud database is.

For more info on **Firebase** click [here](https://firebase.google.com/)

<p align="left">
<img src="https://s3.amazonaws.com/appforest_uf/f1479799611909x580051703844219400/news_api_logo.PNG" width="100" title="NewsAPI Icon">
</p>

**NewsAPI** - Google's answer to storing mobile data.

**How I Used NewsApi** - Although there are many different news APIs out there, NewsAPI is easy to use, accurate, and easily customizable. I use NewsAPI's data to provide data from the custom collection view cards on the home view, the Top10 News of the latest 10 articles circulating the US, and user queries on the search view.

For more info on **NewsAPI** click [here](https://newsapi.org/)

<p align="left">
<img src="https://devshive.tech/media/uploads/contents/1516823789563-design-patterns-for-cocoa-mvc-and-mvvm.png" width="100" title="MVVM Icon">
</p>

**MVVM** - A better approach to iOS Design Pattern. 

**How I used MVVM** - I chose to use MVVM for Top10 News due to the size of the app and moving parts, and this way I could neatly keep each functionality separate thus resulting in cleaner and more readable code.  This wasn't an easy task, and it took me a bit to get use to the design pattern, but I really like the way MVVM has made me think more about how my code looks as well as the functionality of it.  Plus, it really makes you practice your OOP and POP programming fundamentals.

For more info on **MVVM** click [here](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm)

<p align="left">
<img src="https://www.rookieup.com/wp-content/uploads/2018/01/sketch-logo-light-transparent@2x.png" width="100" title="SD WebImage Icon">
</p>

**SD WebImage** - A Cocoapod for better image implementation.  

**How I used SD WebImage** - SD WebImage is a powerful little Cocoapod library that provides an async image downloader.  I used this Cocoapod to take on the task of setting the user's profile image from Firebase.  Because SD WebImage works in the background, it is perfect to gather data from Firebase before the view appears for the user.

For more info on **SD WebImage** click [here](https://github.com/SDWebImage/SDWebImage)