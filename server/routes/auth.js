const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');

const userController = require('../controllers/userController');
const app = require('../controllers/appointmentController');

// Register route
router.post('/api/signup', userController.registerController);

// Login route
router.post('/api/signin', userController.loginController);

router.post('/tokenIsValid', userController.tokenController);
router.post('/api/getAppointment', app.getAppointments);
router.post('/api/setAppointment', app.addAppointment);
router.post('/api/updateProfile', userController.profileController);


//get user data
router.get('/',auth,  userController.getUsers);


module.exports = router;
