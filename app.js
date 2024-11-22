const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql2");
const app = express();
const path = require("path");

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static("public"));

// MySQL Connection (on port 3307)
const db = mysql.createConnection({
    host: "localhost",
    user: "root",  // Replace with your MySQL username
    port: 3307,    // MySQL port 3307
    password: "pasha", // Replace with your MySQL password
    multipleStatements: true // To allow running multiple SQL queries at once
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error("Error connecting to MySQL:", err);
        return;
    }
    console.log("Connected to MySQL database on port 3307");

    // Check if the 'spotifydbms' database exists, and create it if it doesn't
    db.query(`CREATE DATABASE IF NOT EXISTS spotifydbms`, (err) => {
        if (err) {
            console.error("Error creating database:", err);
            return;
        }
        console.log("Database 'spotifydbms' ensured to exist");

        // Switch to the 'spotifydbms' database
        db.changeUser({ database: "spotifydbms" }, (err) => {
            if (err) {
                console.error("Error switching to database:", err);
                return;
            }
            console.log("Switched to 'spotifydbms' database");

            // Create necessary tables if they don't exist
            const createTablesQuery = `
                CREATE TABLE IF NOT EXISTS USERS (
                    User_ID INT AUTO_INCREMENT PRIMARY KEY,
                    User_Name VARCHAR(255) NOT NULL,
                    DOB DATE NOT NULL,
                    Email VARCHAR(255) UNIQUE NOT NULL,
                    Password VARCHAR(255) NOT NULL
                );

                CREATE TABLE IF NOT EXISTS Artist (
                    Artist_ID INT PRIMARY KEY,
                    Name VARCHAR(255) NOT NULL,
                    Bio TEXT,
                    Genre VARCHAR(100)
                );

                CREATE TABLE IF NOT EXISTS Albums (
                    Album_ID INT PRIMARY KEY,
                    Name VARCHAR(255) NOT NULL,
                    Artist_ID INT,
                    Genre VARCHAR(100),
                    Release_Date DATE,
                    FOREIGN KEY (Artist_ID) REFERENCES Artist(Artist_ID) ON DELETE SET NULL
                );

                CREATE TABLE IF NOT EXISTS Tracks (
                    Track_ID INT PRIMARY KEY,
                    Title VARCHAR(255) NOT NULL,
                    Album_ID INT,
                    Duration VARCHAR(50),
                    Popularity INT,
                    PlayCount INT,
                    FOREIGN KEY (Album_ID) REFERENCES Albums(Album_ID) ON DELETE SET NULL
                );
            `;

            db.query(createTablesQuery, (err) => {
                if (err) {
                    console.error("Error creating tables:", err);
                    return;
                }
                console.log("All necessary tables ensured to exist");
            });
        });
    });
});

// Route to serve the sign-up page
app.get("/signup", (req, res) => {
    res.sendFile(path.join(__dirname, "/public/signup.html"));
});

// Route to serve the admin page
app.get("/admin", (req, res) => {
    res.sendFile(path.join(__dirname, "/public/admin.html"));
});

// Route to serve the sign-in page
app.get("/signin", (req, res) => {
    res.sendFile(path.join(__dirname, "/public/signin.html"));
});

app.get("/search", (req, res) => {
    res.sendFile(path.join(__dirname, "/public/search.html"));
});

// Route to handle sign-up form submission
app.post("/signup", async (req, res) => {
    const { User_Name, dob, email, pass, re_pass } = req.body;

    // Validate that passwords match
    if (pass !== re_pass) {
        return res.json({ error: "Passwords do not match!" });
    }

    // Validate the Date of Birth (DOB) - check that it's not in the future
    const currentDate = new Date();
    const dobDate = new Date(dob);  // Assuming dob is a string in YYYY-MM-DD format

    if (dobDate > currentDate) {
        return res.json({ error: "Date of birth cannot be in the future." });
    }

    try {
        // SQL query to insert user into the MySQL database
        const query = "INSERT INTO USERS (User_Name, DOB, Email, Password) VALUES (?, ?, ?, ?)";
        const values = [User_Name, dob, email, pass];
        
        db.query(query, values, (err, result) => {
            if (err) {
                if (err.code === "ER_DUP_ENTRY") {
                    return res.json({ error: "Email is already registered." }); 
                }
                console.error("Error saving user:", err);
                return res.json({ error: "Error occurred while saving user data." });
            }

            console.log("User data saved:", result);
            res.json({ message: "Registration successful! Redirecting to search..." }); // Send success message
        });
    } catch (error) {
        console.error("Error occurred:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});


// Route to handle sign-in form submission
// Route to handle sign-in form submission
app.post("/signin", (req, res) => {
    const { your_name, your_pass } = req.body;

    // Check if it's admin login
    if (your_name === "admin" && your_pass === "admin789456") {
        // Redirect to admin page if admin credentials are correct
        return res.redirect("/admin");
    }

    // For regular users, check if the user exists in the database
    const query = "SELECT * FROM USERS WHERE User_Name = ?";
    db.query(query, [your_name], async (err, results) => {
        if (err) {
            console.error("Error querying the database:", err);
            return res.status(500).send("Internal Server Error");
        }

        // If no user is found with the entered name
        if (results.length === 0) {
            return res.send("User not found. Please check your credentials.");
        }

        const user = results[0];

        try {
            // Compare entered password with the stored password
            const isPasswordValid = your_pass === user.Password;
            if (isPasswordValid) {
                // Redirect to search page if password matches
                res.redirect("/search.html");
            } else {
                // If password doesn't match, send error message
                res.send("Incorrect password. Please try again.");
            }
        } catch (error) {
            console.error("Error occurred during password comparison:", error);
            res.status(500).send("Internal Server Error");
        }
    });
});


// Route to handle search

app.post('/search', (req, res) => {
    const { songQuery, artistQuery, albumQuery, genre, releaseYear } = req.body;

    let sqlQuery = `
        SELECT Tracks.Title, Artist.Name AS Artist, Albums.Name AS Album
        FROM Tracks
        JOIN Albums ON Tracks.Album_ID = Albums.Album_ID
        JOIN Artist ON Albums.Artist_ID = Artist.Artist_ID
        WHERE 1=1`; // Start with a base query

    // Store values in an array to pass as parameters
    const params = [];

    // Append conditions based on user input using parameterized queries
    if (songQuery) {
        sqlQuery += ` AND Tracks.Title LIKE ?`;
        params.push(`${songQuery}%`);
    }
    if (artistQuery) {
        sqlQuery += ` AND Artist.Name LIKE ?`;
        params.push(`${artistQuery}%`);
    }
    if (albumQuery) {
        sqlQuery += ` AND Albums.Name LIKE ?`;
        params.push(`${albumQuery}%`);
    }
    if (genre) {
        sqlQuery += ` AND Albums.Genre LIKE ?`;
        params.push(`${genre}%`);
    }
    if (releaseYear) {
        sqlQuery += ` AND YEAR(Albums.Release_Date) = ?`;
        params.push(releaseYear);
    }

    // Query the database with parameterized inputs
    db.query(sqlQuery, params, (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});


// Route to get top 25 songs
app.get('/top-songs', (req, res) => {
    const sqlQuery = `SELECT * FROM Tracks ORDER BY Popularity DESC LIMIT 25`;
    
    db.query(sqlQuery, (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});

// Route to add a Track
app.post('/addTrack', (req, res) => {
    const { TrackID, Title, Album_ID, Duration, Popularity, PlayCount } = req.body;

    // Validate required fields
    if (!TrackID || !Title || !Album_ID) {
        return res.status(400).json({ error: 'TrackID, Title, and Album_ID are required.' });
    }

    // Check if Album_ID exists
    const checkAlbumQuery = "SELECT * FROM Albums WHERE Album_ID = ?";
    db.query(checkAlbumQuery, [Album_ID], (err, albumResults) => {
        if (err) {
            console.error("Error checking Album_ID:", err);
            return res.status(500).json({ error: 'Database error while verifying Album_ID.' });
        }

        if (albumResults.length === 0) {
            return res.status(400).json({ error: 'Album_ID does not exist.' });
        }

        // Insert the Track
        const insertTrackQuery = `
            INSERT INTO Tracks (TrackID, Title, Album_ID, Duration, Popularity, PlayCount)
            VALUES (?, ?, ?, ?, ?, ?)
        `;
        const values = [TrackID, Title, Album_ID, Duration || null, Popularity || 0, PlayCount || 0];

        db.query(insertTrackQuery, values, (err, result) => {
            if (err) {
                if (err.code === "ER_DUP_ENTRY") {
                    return res.status(400).json({ error: 'TrackID already exists.' });
                }
                console.error("Error adding track:", err);
                return res.status(500).json({ error: 'Error adding track.' });
            }

            console.log("Track added:", result);
            res.status(200).json({ message: 'Track added successfully.' });
        });
    });
});

// Route to add an Album
// Route to add an Album
app.post('/addAlbum', (req, res) => {
    const { Album_ID, Album_Name, Artist_ID, Genre, Release_Date } = req.body;

    // Validate required fields
    if (!Album_ID || !Album_Name || !Artist_ID) {
        return res.status(400).json({ error: 'Album_ID, Name, and Artist_ID are required.' });
    }

    // Check if Artist_ID exists
    const checkArtistQuery = "SELECT * FROM Artist WHERE Artist_ID = ?";
    db.query(checkArtistQuery, [Artist_ID], (err, artistResults) => {
        if (err) {
            console.error("Error checking Artist_ID:", err);
            return res.status(500).json({ error: 'Database error while verifying Artist_ID.' });
        }

        if (artistResults.length === 0) {
            return res.status(400).json({ error: 'Artist_ID does not exist.' });
        }

        // Insert the Album
        const insertAlbumQuery = `
            INSERT INTO Albums (Album_ID, Name, Artist_ID, Genre, Release_Date)
            VALUES (?, ?, ?, ?, ?)
        `;
        const values = [Album_ID, Album_Name, Artist_ID, Genre || null, Release_Date || null];

        db.query(insertAlbumQuery, values, (err, result) => {
            if (err) {
                if (err.code === "ER_DUP_ENTRY") {
                    return res.status(400).json({ error: 'Album_ID already exists.' });
                }
                console.error("Error adding album:", err);
                return res.status(500).json({ error: 'Error adding album.' });
            }

            console.log("Album added:", result);
            res.status(200).json({ message: 'Album added successfully.' });
        });
    });
});

// After adding the artist, retrieve the list of artists

app.post('/addArtist', (req, res) => {
    const { Artist_ID, Name, Bio, Genre } = req.body;

    // Validate required fields
    if (!Artist_ID || !Name) {
        return res.status(400).json({ error: 'Artist_ID and Name are required.' });
    }

    // Insert the Artist
    const insertArtistQuery = `
        INSERT INTO Artist (Artist_ID, Name, Bio, Genre)
        VALUES (?, ?, ?, ?)
    `;
    const values = [Artist_ID, Name, Bio || null, Genre || null];

    db.query(insertArtistQuery, values, (err, result) => {
        if (err) {
            if (err.code === "ER_DUP_ENTRY") {
                return res.status(400).json({ error: 'Artist_ID already exists.' });
            }
            console.error("Error adding artist:", err);
            return res.status(500).json({ error: 'Error adding artist.' });
        }

        console.log("Artist added:", result);
        res.status(200).json({ message: 'Artist added successfully.' });
    });
});


// Route to remove an artist
app.delete('/removeArtist', (req, res) => {
    const { ArtistID } = req.body;

    // Validate that ArtistID is provided
    if (!ArtistID) {
        return res.status(400).json({ error: 'ArtistID is required.' });
    }

    // SQL query to delete the artist
    const deleteArtistQuery = 'DELETE FROM Artist WHERE Artist_ID = ?';
    db.query(deleteArtistQuery, [ArtistID], (err, result) => {
        if (err) {
            console.error("Error removing artist:", err);
            return res.status(500).json({ error: 'Error removing artist.' });
        }

        // Check if any rows were affected (deleted)
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Artist not found.' });
        }

        console.log("Artist removed:", ArtistID);
        res.status(200).json({ message: 'Artist removed successfully.' });
    });
});

// Check if the trigger exists and create if not
const checkTriggerQuery = `
    SELECT TRIGGER_NAME 
    FROM information_schema.TRIGGERS 
    WHERE TRIGGER_NAME = 'cascade_artist_delete' 
    AND EVENT_OBJECT_TABLE = 'artist';
`;

const createTriggerQuery = `
    DELIMITER $$ 
    CREATE TRIGGER cascade_artist_delete 
    BEFORE DELETE ON artist 
    FOR EACH ROW 
    BEGIN 
        DELETE FROM tracks WHERE Album_ID IN 
            (SELECT Album_ID FROM albums WHERE Artist_ID = OLD.Artist_ID); 
        DELETE FROM albums WHERE Artist_ID = OLD.Artist_ID; 
    END $$ 
    DELIMITER ;
`;

// Function to ensure the trigger is created
app.get('/ensureTriggerExists', (req, res) => {
    db.query(checkTriggerQuery, (err, result) => {
        if (err) {
            console.error("Error checking trigger existence:", err);
            return res.status(500).json({ error: 'Error checking trigger existence.' });
        }

        if (result.length === 0) {
            // Trigger does not exist, so create it
            db.query(createTriggerQuery, (err, result) => {
                if (err) {
                    console.error("Error creating trigger:", err);
                    return res.status(500).json({ error: 'Error creating trigger.' });
                }
                console.log("Trigger 'cascade_artist_delete' created successfully.");
                res.status(200).json({ message: "Trigger 'cascade_artist_delete' created successfully." });
            });
        } else {
            // Trigger already exists
            console.log("Trigger 'cascade_artist_delete' already exists.");
            res.status(200).json({ message: "Trigger 'cascade_artist_delete' already exists." });
        }
    });
});


// Route to remove an album
app.delete('/removeAlbum', (req, res) => {
    const { AlbumID } = req.body;

    // Validate that AlbumID is provided
    if (!AlbumID) {
        return res.status(400).json({ error: 'AlbumID is required.' });
    }

    // SQL query to delete the album
    const deleteAlbumQuery = 'DELETE FROM Albums WHERE Album_ID = ?';
    db.query(deleteAlbumQuery, [AlbumID], (err, result) => {
        if (err) {
            console.error("Error removing album:", err);
            return res.status(500).json({ error: 'Error removing album.' });
        }

        // Check if any rows were affected (deleted)
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Album not found.' });
        }

        console.log("Album removed:", AlbumID);
        res.status(200).json({ message: 'Album removed successfully.' });
    });
});


// Route to remove a track
app.delete('/removeTrack', (req, res) => {
    const { TrackID } = req.body;

    // Validate that TrackID is provided
    if (!TrackID) {
        return res.status(400).json({ error: 'TrackID is required.' });
    }

    // SQL query to delete the track
    const deleteTrackQuery = 'DELETE FROM Tracks WHERE TrackID = ?';
    db.query(deleteTrackQuery, [TrackID], (err, result) => {
        if (err) {
            console.error("Error removing track:", err);
            return res.status(500).json({ error: 'Error removing track.' });
        }

        // Check if any rows were affected (deleted)
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Track not found.' });
        }

        console.log("Track removed:", TrackID);
        res.status(200).json({ message: 'Track removed successfully.' });
    });
});


///// Route to get the total number of songs in tracks
app.get('/getSongCount', (req, res) => {
    // SQL query to call the stored procedure
    const callProcedure = 'CALL GetTotalSongs()';

    db.query(callProcedure, (err, result) => {
        if (err) {
            console.error("Error calling stored procedure:", err);
            return res.status(500).json({ error: 'Error fetching total songs.' });
        }

        // Get the total number of songs from the result
        const totalSongs = result[0][0].totalSongs;
        console.log("Total number of songs:", totalSongs);

        // Send the response with the total count
        res.status(200).json({ totalSongs });
    });
});


// Start the server
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});