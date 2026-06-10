**[Plus Locate design specs]{.underline}**

**1. Set Up Your Design Environment**

- Open **Figma** (or your preferred design tool).

- Create a new project and name it **\"PlusLocate App\"**.

- Set up frames for mobile devices:

  - Standard screen size: **375 x 812 px** (iPhone 11/12/13 dimensions).

- Create a consistent **color palette** and **typography**:

  - Colors:

    - Primary: #2C73D2 (blue).

    - Secondary: #F8B400 (yellow).

    - Background: #F4F4F4 (light gray).

    - Text: #333333 (dark gray).

  - Fonts:

    - Primary: **Roboto** (16px for body text, 20px for headings).

    - Buttons/Text Fields: Bold 18px.

**2. Design the Splash Screen**

- Add a frame for the splash screen.

- Center a large logo of **PlusLocate** with the app name beneath.

  - Logo size: **200 x 200 px**.

  - Text: Bold, 24px.

- Background color: **Primary Blue (#2C73D2)**.

- Add a subtle tagline at the bottom: *\"Your address, simplified.\"*
  (12px, italic, white).

- Place a loading animation (mocked as a spinner) below the logo.

**3. Design the Onboarding Screens**

- Create **three frames** for onboarding steps:

  1.  **\"Discover Your Location\"**:

      - Full-screen image of a map with a pin icon in the center.

      - Title: *\"Discover Your Exact Address\"*, bold, 20px.

      - Description: *\"Use PlusLocate to generate precise Plus Codes
        for any location.\"*, 14px.

  2.  **\"Find and Share Addresses\"**:

      - Illustration of people sharing locations (use placeholder
        images/icons).

      - Title: *\"Find and Share Addresses Easily.\"*

      - Description: *\"Share Plus Codes with friends, businesses, or
        delivery agents.\"*

  3.  **\"Get Started Now\"**:

      - Button: **\"Start Now\"** (Full-width, 50px height, Primary Blue
        with white text).

**4. Design the Home Screen**

- Add a **search bar** at the top:

  - Dimensions: **Width: 327px, Height: 48px**.

  - Placeholder text: *\"Search location or enter Plus Code\"*, gray
    text (#888).

  - Icon: Magnifying glass on the left.

- Below the search bar:

  - Add a map view (mock with a rectangle placeholder): **327px wide,
    400px high**.

- Add **two buttons** below the map:

  - **\"Generate Plus Code\"** (Primary Blue, full width).

  - **\"Locate Plus Code\"** (Secondary Yellow, full width).

- Use a bottom navigation bar:

  - Icons for Home, Favorites, Settings.

  - Dimensions: **Width: 327px, Height: 56px**.

**5. Design the Address Generation Screen**

- Header:

  - Title: *\"Generate Plus Code\"* (18px, bold).

  - Back icon on the left.

- Main area:

  - Add text fields for:

    1.  **Address details** (Full width, placeholder: *\"Enter address
        details\...\"*).

    2.  **Latitude/Longitude** (Add dropdown for manual or automatic
        entry).

  - Button: **\"Generate Code\"** (Primary Blue, 48px high).

- Below the button:

  - Display the generated Plus Code as a card:

    - **Card dimensions:** Width: **300px**, Height: **80px**.

    - Background: Light Gray (#F4F4F4).

    - Text: Bold, 20px.

**6. Design the Locate Plus Code Screen**

- Header: Same as Address Generation.

- Main area:

  - Search bar at the top (same style as the home screen).

  - Below the search bar:

    - Add a map view with a draggable pin icon.

    - Button below the map: **\"Locate Address\"**.

- Bottom:

  - Display the located address details in a collapsible card.

    - Card: **300px width, 100px height**.

    - Include address name and Plus Code.

**7. Design the Favorites Screen**

- Header:

  - Title: *\"Saved Locations\"*.

- Main area:

  - Display a scrollable list of saved Plus Codes.

  - Each list item:

    - Card: **Width: 327px, Height: 80px**.

    - Left: Address/Location name.

    - Right: Button: **\"View on Map\"** (small, Secondary Yellow).

  - Floating action button (FAB):

    - Icon: + (to add a favorite manually).

    - Positioned at the bottom right.

**8. Design the Settings Screen**

- Header:

  - Title: *\"Settings\"*.

- Main area:

  - Use a vertical list for options:

    1.  Account details.

    2.  Preferences (toggle for themes: Dark/Light).

    3.  Help and Support.

    4.  About the App.

- Each option:

  - Row with icon and label:

    - Icon size: 24px.

    - Label: Regular, 16px.

    - Chevron on the right.

**9. Add Transitions and Animations**

- Use Figma\'s prototype feature to:

  - Link all screens with smooth transitions.

  - Use fade-in for splash screen and slide animations for onboarding.

  - Ensure buttons have ripple effects.

**10. Export Assets and Prepare for Development**

- Ensure all elements are organized in **layers and groups**.

- Export icons, images, and color codes for use in Flutter development.
