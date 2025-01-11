# Dream Interpreter App

A Flutter mobile application that helps users record their dreams and receive AI-powered interpretations.

## Features

- 🔐 **Secure Authentication**

  - Email/password registration and login
  - Persistent login state
  - Google Sign-in (Coming Soon)

- 💭 **Dream Recording & Interpretation**

  - Easy-to-use dream entry interface
  - AI-powered dream interpretation using OpenAI GPT
  - Local draft saving

- 📚 **Dream History**

  - Chronological view of past dreams and interpretations
  - Search and filter functionality
  - Offline access to previous entries
  - Delete functionality (In Progress)
  - Favorite dreams (Coming Soon)

- 👤 **User Profile**
  - Customizable user profiles
  - Dream statistics and insights
  - Account management features
  - Notification preferences

## Known Issues

We are actively working on resolving the following issues:

1. **History View**

   - Dreams are duplicated on refresh/load more
   - Filter functionality needs improvement
   - Delete operation throws Firebase error
   - DreamHistoryRepository requires optimization

2. **Authentication**

   - Google Sign-in implementation pending

3. **User Experience**

   - Page transition animations need to be implemented
   - User privacy controls for dream history sharing need enhancement

4. **Features in Development**
   - Favorite dream functionality
   - Notification system
   - User preferences updates

## Technical Stack

- **Frontend**: Flutter with Material Design 3
- **Backend**: Firebase (Authentication & Firestore)
- **AI Integration**: OpenAI GPT API
- **State Management**: Provider/Bloc pattern
- **Architecture**: Clean Architecture

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Firebase project setup
- OpenAI API key

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/dream_app.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure Firebase:

   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Update Firebase configuration in the project

4. Set up environment variables:

   - Create a `.env` file in the project root
   - Add your OpenAI API key:
     ```
     OPENAI_API_KEY=your_api_key_here
     ```

5. Run the app:

```bash
flutter run
```

## Project Structure

```
lib/
├── core/           # Core functionality
├── features/       # Feature modules
│   ├── auth/       # Authentication
│   ├── dream_entry/# Dream entry and interpretation
│   ├── history/    # Dream history
│   └── profile/    # User profile
├── shared/         # Shared components
└── config/         # App configuration
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- OpenAI for GPT API
