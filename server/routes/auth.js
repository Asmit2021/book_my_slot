const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');

const userController = require('../controllers/userController')

// Register route
router.post('/api/signup', userController.registerController);

// Login route
router.post('/api/signin', userController.loginController);

router.post('/tokenIsValid', userController.tokenController);

//router.post('/user', userController.getUserData);

//get user data
router.get('/',auth,  userController.getUsers);


module.exports = router;
