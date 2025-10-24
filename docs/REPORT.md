
### 1. Introduction
The symmetry project has offered me a great chance to delve deep into the world of software(mobile app) development following clean code(SOLID) principles. This pattern is indeed good for code maintenability and scalability. I've had to be architecturally disciplined in the process of development and this has greatly helped in bringing forth a clean codebase.

### 2. Learning Journey
Even though I've interacted with the following technologies before, I've greatly enhanced my knowledge in:
Clean Architecture: I deepened my understanding of layer separation (domain, data, presentation) and the Dependency Rule.
Dependency Injection: Used get_it + injectable for dependency injection.
Network Resilience: I've implemented internet checks before making requests using the connectivity_plus package.

### 3. Challenges Faced
There were Kotlin/Gradle compatibility issues that forced me to upgrade the kotlin version for compatibility with the cloud storage and firestore packages

There were build time errors caused by calling setState() during build from TextEditingController listeners.

There were errors during Firebase initialization caused by a missing google-services.json file
### 4. Reflection and Future Directions
We can implement an offline mode by storing data locally using Hive or shared preferences local databases

We can add firebase authentication to segregate the news added by user

We can write complete unit, widget and integration tests. This shall be relatively easy due to the codebase organization following clean code principles

### 5. Proof of the project
List of articles and their respective thumbnail images that I've added on firebase firestore and firebase storage respectively
[article list](https://drive.google.com/file/d/1LOAVknqz_g-TTXa4Asd4J3Wb11H6q2sf/view?usp=sharing)

pull to refresh and animations embedded [pull-to-refresh](https://drive.google.com/file/d/1PyMNISJoFQrIEVo4lFJEP8EQCybb2167/view?usp=sharing)

Add an article [add-article](https://drive.google.com/file/d/15-t85Q3WQgctAXapdquzLsyKbfbOFgyv/view?usp=sharing)

No internet notification. [no-internet](https://drive.google.com/file/d/1H7bDZXFxlQUF82SglFLZXpe8Q-KT8KpQ/view?usp=sharing)

Here is the apk [symmetry apk](https://drive.google.com/file/d/1XX6TDOqw-KI2scLTGaav80_VMYpImumr/view?usp=sharing)

Here is the repo [symmetry repo](https://github.com/Raicodesokwe/symmetry-project.git)
### 6. Overdelivery
1. Network Connectivity:
I've added the network check functionality before making requests using the connectivity_plus package.

2. Pull to refresh:
I've added the pull to refresh functionality to enable refetching news articles

3. Animations:
I've animated the news articles list.

### 7. Conclusion
This has been an enriching experience and I've learnt a lot throughout the development process and I'm grateful for the opportunity.
