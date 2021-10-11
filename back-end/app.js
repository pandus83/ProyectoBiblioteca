const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

var pgp = require("pg-promise")(/*options*/);
var db = pgp("postgres://postgres:123456789@localhost:5432/biblioteca");



let sco; // shared connection object;

db.connect()
    .then(obj => {
        // obj.client = new connected Client object;

        sco = obj; // save the connection object;

        // execute all the queries you need:
        return sco.any('SELECT * FROM btc.persona');
    })
    .then(data => {
        // success
        console.log("DATA:my", data.value);

    })
    .catch(error => {
        // error
    })
    .finally(() => {
        // release the connection, if it was successful:
        if (sco) {
            // if you pass `true` into method done, i.e. done(true),
            // it will make the pool kill the physical connection.
            sco.done();
        }
    });

    db.any("SELECT * FROM btc.persona")
    .then(data => {
        data.forEach((row, index, data) => {
            console.log("DATAs:", data.value);
        });
        return data;
    });



db.any("SELECT * FROM btc.persona")
    .then(function (data) {
        console.log("DATA:", data.value);
    })
    .catch(function (error) {
        console.log("ERROR:", error);
    });