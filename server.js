const express = require('express');
const os = require('os');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    // This JSON response will prove which server handled the request
    res.json({
        message: "DevOps Pipeline is Working!",
        timestamp: new Date().toISOString(),
        hostname: os.hostname() // This will show the Container ID later
    });
});

app.listen(PORT, () => {
    console.log(`App running on port ${PORT}`);
});


