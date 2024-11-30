MUQ News App
A modern Flutter News Application that fetches and displays news articles using the NewsAPI, with offline caching support and an intuitive UI for reading, searching, and sharing news articles.
Features
Fetch News Articles: Uses the NewsAPI to retrieve the latest articles based on user queries.
Offline Caching: Utilizes Hive for offline data storage.
Search Functionality: Perform searches for specific news topics using a custom search delegate.
Detail View: Read detailed news articles with animations and sharing options.
UI Animations: Integrated hero animations, shimmer loading states, and transition effects for an enhanced user experience.
Project Structure:
lib/
├── models/
│   └── news_model.dart        # Data model for news articles.
├── providers/
│   └── news_provider.dart     # Manages state and API interactions.
├── screens/
│   ├── home_screen.dart       # Home screen with a list of news articles.
│   ├── detail_screen.dart     # Displays detailed article view.
├── services/
│   └── news_service.dart      # Handles API requests to NewsAPI.
├── NewsSearchDelegate.dart    # Custom search delegate for searching articles.
└── main.dart                  # Entry point of the application.
Installation:
Clone the repository:
git clone <repository_url>
cd <repository_name>
Install dependencies:
flutter pub get
Set up NewsAPI:

Visit NewsAPI and obtain your API key.
Replace the placeholder API key in news_service.dart:
final String _apiKey = 'YOUR_NEWS_API_KEY';
Run the application:
flutter run
Usage
Main Features
News List:

Displays a list of the latest news articles.
Pull down to refresh articles.
Search News:

Tap the search icon in the app bar to open the search functionality.
Enter keywords to find relevant news articles.
View Details:

Tap on any news article to view its details, including title, description, and publication date.
Use the Read More button to open the article in a browser.
Share Articles:

Use the share button on the detail screen to share the article link.
Dependencies
The app uses the following Flutter packages:

http: For API requests.
hive_flutter: For local storage and offline caching.
provider: For state management.
share_plus: To enable sharing articles.
url_launcher: To open external links in the browser.
shimmer: For loading animations.
Key Files
1. main.dart
Entry point of the app.
Initializes Hive and sets up the NewsProvider for state management.
2. news_service.dart
Handles fetching articles from the NewsAPI using HTTP requests.
Constructs dynamic queries based on user input.
3. news_model.dart
Defines the NewsArticle data structure.
Parses JSON responses from the API.
4. news_provider.dart
Manages application state and facilitates fetching, storing, and notifying changes in news articles.
5. home_screen.dart
Displays a list of news articles.
Includes pull-to-refresh and scroll-to-top functionalities.
6. detail_screen.dart
Displays detailed content of a selected article.
Includes animations and sharing functionality.
7. NewsSearchDelegate.dart
Custom implementation of Flutter's SearchDelegate.
Dynamically searches and displays results.
Future Enhancements
Category Filtering: Add options to filter news by categories like "Business", "Technology", etc.
Offline Mode: Display cached articles when offline.
Push Notifications: Notify users of breaking news.
User Preferences: Allow users to customize themes or default search queries.

DEVELOPER: 
SOFTWARE ENGINEER 
MUHAMMAD UWAIM QURESHI
