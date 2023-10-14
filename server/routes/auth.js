const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController')

// Register route
router.post('/api/signup', userController.registerController);

// Login route
router.post('/api/signin', userController.loginController);

module.exports = router;
