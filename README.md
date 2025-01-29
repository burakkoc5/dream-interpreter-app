# Dream Interpreter App

A Flutter mobile application that helps users record their dreams and receive AI-powered interpretations.

## 📱 Screenshots

> Add your app screenshots here. For example:
>
> - ![Home Screen](screenshots/home.png)
> - ![Dream Entry Interface](screenshots/dream_entry.png)
> - ![Interpretation View](screenshots/interpretation.png)
> - ![Profile Dashboard](screenshots/profile.png)
> - ![Dream History](screenshots/history.png)

## ✨ Features

- 🔐 **Secure Authentication**

  - Email/password registration and login
  - Email verification system
  - Persistent login state
  - Account deletion
  - Password reset functionality

- 💭 **Dream Recording & Interpretation**

  - Easy-to-use dream entry interface
  - AI-powered dream interpretation using GPT-4
  - Personalized interpretations based on user profile
  - Local draft saving
  - Mood rating system
  - Dream tagging system

- 📚 **Dream History**

  - Chronological view of past dreams and interpretations
  - Advanced search and filtering functionality
  - Multiple filter options (week, month, favorites, tags)
  - Offline access to previous entries
  - Favorite dreams system
  - Share dreams as images
  - Delete functionality
  - Pagination support

- 👤 **User Profile**
  - Customizable user profiles
  - Personal information for dream context
  - Dream statistics and insights
  - Streak tracking system
  - Account management features
  - Daily interpretation limits
  - Notification preferences

## 🚧 Upcoming Features

We are actively working on resolving the following issues:

1. **History View**

   - Dreams pagination optimization
   - Filter functionality improvements

2. **User Experience**

   - Page transition animations need to be enhanced
   - User privacy controls for dream history sharing need enhancement

3. **Features in Development**
   - Google Sign-in integration
   - Advanced notification system
   - User preferences updates

## 🛠️ Technical Stack

- **Frontend**: Flutter with Material Design 3
- **Backend**: Firebase (Authentication & Firestore)
- **AI Integration**: OpenAI GPT-4 API
- **State Management**: Provider/Bloc pattern
- **Architecture**: Clean Architecture

## 🚀 Getting Started

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

## 📁 Project Structure

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

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- OpenAI for GPT API
