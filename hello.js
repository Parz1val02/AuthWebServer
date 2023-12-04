const express = require('express');
const app = express();
const mysql = require('mysql2');
const path = require('path');
const session = require('express-session');
const bcrypt = require("bcrypt");
const saltRounds = 10;

let conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'h4ck3rm4n',
    database: 'mydb'
});
conn.connect(function(err){
    if(err) throw err;
    console.log("Conexión exitosa a base de datos");
});

app.listen(3000,function(){
    console.log("Servidor corriendo en el puerto 3000");
});

app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// http://localhost:3000/
app.get('/', function(request, response) {
    // Render login template
    response.sendFile(path.join(__dirname + '/login.html'));
});

// http://localhost:3000/auth
app.post('/auth', function(request, response) {
    // Capture the input fields
    let username = request.body.username;
    let password = request.body.password;
    bcrypt
        .hash(password, saltRounds)
        .then(hash => {
            console.log('Hash ' + username + ":", hash)
        })
        .catch(err => console.error(err.message))

    // Ensure the input fields exist and are not empty
    if (username && password) {
        // Execute SQL query that'll select the account from the database based on the specified username and password
        let sql = "SELECT passwd FROM mydb.user WHERE username = ?";
        let params = [username];

        conn.query(sql, params, function(err, results) {
            // If there is an issue with the query, output the error
            if (err) {
                throw err;
            }
            // If the account exists
            if (results.length > 0) {
                const hashFromDatabase = results[0].passwd;
                console.log('OG hash: ', hashFromDatabase);
                validateUser(hashFromDatabase, password)
                    .then(result => {
                        console.log('Validation result:', result);
                        if(result){
                            // Authenticate the user
                            const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');
                            console.log('Time stamp ' + username + ': ' + currentDate);
                            sql = 'UPDATE mydb.user SET session = 1, time_stamp = ? WHERE username = ?';
                            params = [currentDate, username];
                            conn.query(sql, params, function (err, results){
                                if (err) {
                                    throw err;
                                }
                                // Set session variables
                                request.session.loggedin = true;
                                request.session.username = username;

                                //Insert authorization flow entries


                                // Redirect to the home page
                                response.redirect('/home');
                            });
                        }else{
                            response.send('Incorrect Username and/or Password!');
                            response.end();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
            } else {
                response.send('Incorrect Username and/or Password!');
                response.end();
            }
        });
    } else {
        response.send('Please enter Username and Password!');
        response.end();
    }
});

// http://localhost:3000/home
app.get('/home', function(request, response) {
    // If the user is loggedin
    if (request.session.loggedin) {
        // Output username
        response.send('Welcome back, ' + request.session.username + '!');
    } else {
        // Not logged in
        response.send('Please login to view this page!');
    }
    response.end();
});

// http://localhost:3000/logout
app.get('/logout', function (req, res) {
    // Destroy the session
    let sql = "UPDATE mydb.user SET session = 0, time_stamp = NULL WHERE username = ?";
    let params = [req.session.username];

    conn.query(sql, params, function(err, results) {
        // If there is an issue with the query, output the error
        if (err) {
            throw err;
        }

        req.session.destroy(function(err) {
            if (err) {
                console.log(err);
            } else {
                // Redirect the user to the login page or any other page
                res.redirect('/');
            }
        });
    });
});

//Function to compare bcrypt hashes
function validateUser(hash, password) {
    return bcrypt
        .compare(password, hash)
        .then(res => {
            console.log(res); // return true
            return res; // returning the result
        })
        .catch(err => {
            console.error(err.message);
            return err;

        })
}