# Spotify DBMS Project
 
## Project Overview
The Spotify DBMS project is a application to manage and query data related to tracks, artists, albums, and user details. It allows both **users** and **administrators** to interact with the database through a streamlined interface and includes features like sign-up, sign-in, and advanced search functionality.

---

## Key Features

### User Features
1. **Sign-Up**:
   - Allows new users to create an account with their details: Name, Date of Birth (DOB), Email, and Password.
   - Password validation ensures matching confirmation passwords.
   - Validates that DOB is not set in the future.
   - Duplicate email addresses are restricted.

2. **Sign-In**:
   - Allows users to log in using their credentials.
   - Redirects to a **search page** upon successful login.
   - Displays appropriate error messages for invalid usernames or passwords.

3. **Search Functionality**:
   - Users can search for tracks, artists, or albums based on:
     - Song Title
     - Artist Name
     - Album Name
     - Genre
     - Release Year
   - Supports multiple filters in a single query.
   - Displays results dynamically.

4. **View Top 25 Songs**:
   - Fetches the top 25 songs ordered by popularity.

---

### Admin Features
1. **Admin Login**:
   - Admin credentials (`admin`, `admin789456`) allow access to the **Admin Dashboard**.

2. **Add Records**:
   - Add new **Artists**, **Albums**, and **Tracks** to the database.
   - Validates the existence of dependent records (e.g., `Artist_ID` for albums, `Album_ID` for tracks).
   - Ensures no duplicate entries using primary keys.

3. **Remove Records**:
   - Remove records such as Artists, Albums, or Tracks by their ID.
   - Cascade deletions handled through foreign key constraints.

4. **Data Integrity**:
   - Ensures relational integrity for all operations.
   - Prevents deletion of records in use unless handled explicitly.

---

## Database Schema

### 1. **Users Table**
| Column     | Type         | Constraints                          |
|------------|--------------|--------------------------------------|
| User_ID    | INT          | Primary Key, Auto Increment          |
| User_Name  | VARCHAR(255) | NOT NULL                             |
| DOB        | DATE         | NOT NULL                             |
| Email      | VARCHAR(255) | UNIQUE, NOT NULL                     |
| Password   | VARCHAR(255) | NOT NULL                             |

### 2. **Artist Table**
| Column      | Type         | Constraints                          |
|-------------|--------------|--------------------------------------|
| Artist_ID   | INT          | Primary Key                         |
| Name        | VARCHAR(255) | NOT NULL                             |
| Bio         | TEXT         | Optional                             |
| Genre       | VARCHAR(100) | Optional                             |

### 3. **Albums Table**
| Column        | Type         | Constraints                          |
|---------------|--------------|--------------------------------------|
| Album_ID      | INT          | Primary Key                         |
| Name          | VARCHAR(255) | NOT NULL                             |
| Artist_ID     | INT          | Foreign Key (references `Artist_ID`) |
| Genre         | VARCHAR(100) | Optional                             |
| Release_Date  | DATE         | Optional                             |

### 4. **Tracks Table**
| Column        | Type         | Constraints                          |
|---------------|--------------|--------------------------------------|
| Track_ID      | INT          | Primary Key                         |
| Title         | VARCHAR(255) | NOT NULL                             |
| Album_ID      | INT          | Foreign Key (references `Album_ID`)  |
| Duration      | VARCHAR(50)  | Optional                             |
| Popularity    | INT          | Default: 0                           |
| PlayCount     | INT          | Default: 0                           |

---

## User Queries

### **Sign-Up**
- **Endpoint**: `/signup`
- **Method**: `POST`
- **Parameters**:
  - `User_Name`: String
  - `dob`: Date (YYYY-MM-DD)
  - `email`: String
  - `pass`: String
  - `re_pass`: String
- **Response**:
  - Success: `{"message": "Registration successful!"}`
  - Error: `{"error": "Error message..."}`

### **Sign-In**
- **Endpoint**: `/signin`
- **Method**: `POST`
- **Parameters**:
  - `your_name`: String
  - `your_pass`: String
- **Response**:
  - Success: Redirects to `/search`
  - Error: `User not found` or `Incorrect password`

### **Search Songs**
- **Endpoint**: `/search`
- **Method**: `POST`
- **Parameters**:
  - `songQuery`: Optional (String)
  - `artistQuery`: Optional (String)
  - `albumQuery`: Optional (String)
  - `genre`: Optional (String)
  - `releaseYear`: Optional (Number)
- **Response**: JSON array of matching songs.

### **View Top Songs**
- **Endpoint**: `/top-songs`
- **Method**: `GET`
- **Response**: JSON array of the top 25 songs.

---

## Admin Queries

### **Add Artist**
- **Endpoint**: `/addArtist`
- **Method**: `POST`
- **Parameters**:
  - `Artist_ID`: Number
  - `Name`: String
  - `Bio`: Optional (String)
  - `Genre`: Optional (String)
- **Response**:
  - Success: `{"message": "Artist added successfully."}`
  - Error: `{"error": "Error message..."}`

### **Add Album**
- **Endpoint**: `/addAlbum`
- **Method**: `POST`
- **Parameters**:
  - `Album_ID`: Number
  - `Album_Name`: String
  - `Artist_ID`: Number
  - `Genre`: Optional (String)
  - `Release_Date`: Optional (Date)
- **Response**:
  - Success: `{"message": "Album added successfully."}`
  - Error: `{"error": "Error message..."}`

### **Add Track**
- **Endpoint**: `/addTrack`
- **Method**: `POST`
- **Parameters**:
  - `TrackID`: Number
  - `Title`: String
  - `Album_ID`: Number
  - `Duration`: Optional (String)
  - `Popularity`: Optional (Number)
  - `PlayCount`: Optional (Number)
- **Response**:
  - Success: `{"message": "Track added successfully."}`
  - Error: `{"error": "Error message..."}`

---

## Setup Instructions

1. **Clone Repository**:
   ```bash
   git clone https://github.com/MusadiqPasha/Spotify-DBMS
   cd Spotify-DBMS


2. **Install Dependencies:**:
      ```bash
   npm install

3. **Install Dependencies:**:
      ```bash
   node app.js

4. **Access Application:**:
      ```bash
   Sign-Up Page: http://localhost:3000/signup
   Sign-In Page: http://localhost:3000/signin
   Admin Dashboard: http://localhost:3000/admin




## Frontend
### Home Page
![Home Page](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20091449.png)

### Signup Page
![Signup Page](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20091603.png)

### Login Page
![Login Page](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20091622.png)

### Admin Search Page
![Admin Search Page](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20091849.png)

### User Search Page
![User Search Page](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20091642.png)

## Backend
### Database Schema
![Database Schema](https://github.com/MusadiqPasha/Spotify-DBMS/blob/main/Screenshot%202024-11-22%20094656.png)


## Future Enhancements
- Enable user profile customization.
- Add analytics for popular searches.
- Include audio file storage and playback features.
- Feel free to edit it according to your preferences or specific project needs!

### Co-Author:
- [M Govindarajan](https://github.com/Govindarajannn)

### License
- This project is licensed under the MIT License - see the LICENSE file for details.

##
## Just follow me and Star ⭐ my repository 
## Thank You!!

