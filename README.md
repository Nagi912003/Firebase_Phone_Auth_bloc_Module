**Flutter Phone Authentication Module**

This Flutter module provides a seamless user registration experience using phone number verification. The module utilizes Firebase Authentication to send a 6-digit OTP code to the user for verification. Once verified, the user remains logged in until they explicitly log out.

**Key Features:**
- Phone number registration and verification using Firebase Authentication.
- Seamless login experience with automatic OTP code retrieval.
- Persistent login state to keep users logged in across app sessions.
- Clear logout functionality to ensure user privacy and security.
- State management implemented using the Bloc pattern for efficient and organized code structure.
- Follows Clean Architecture with well-defined folders: presentation, business_logic, and constants.
- Efficient route management implemented through the AppRouter class for easy navigation.

**Folder Structure:**
- **presentation:** Contains the user interface components and screens for a smooth registration and login process.
- **business_logic:** Implements the core business logic, including user authentication and verification.
- **constants:** Stores frequently used constants and configurations for easy access and maintenance.

**Repository Usage:**
This repository contains a Flutter project that demonstrates the phone authentication module. To use this module in your own project, follow these steps:
1. Clone the repository to your local machine.
2. Set up Firebase Authentication in your project and configure the necessary credentials.
3. Integrate the module by copying the relevant code files and dependencies into your project.
4. Update the necessary configurations, such as Firebase credentials, in the project files.
5. Utilize the provided route management and state management features to enhance your app's functionality.

Please refer to the documentation within the repository for detailed instructions and code examples on integrating the module into your Flutter project.

**License:**
This Flutter phone authentication module is licensed under the [MIT License](link-to-license-file). Feel free to use, modify, and distribute it according to the license terms.

**Contributing:**
Contributions to this module are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request. Let's collaborate and make this module even better together.

**Acknowledgments:**
We would like to express our gratitude to the Flutter community and the contributors of the libraries used in this module. Their efforts have made it possible to create this seamless and secure phone authentication solution.

**Contact:**
For any questions or inquiries, please feel free to reach out to us at [your-contact-email@example.com]. We appreciate your interest and feedback.

Happy coding!
