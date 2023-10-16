const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res.status(401).send({message: "Unauthorized", success: false});
        }
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        if (!decoded) {
            return res.status(401).send({message: "Token verfication failed", success: false});
        }
        req.user = decoded.id;
        req.token = token;
        next();
    } catch (error) {
        console.log(error);
        res.status(500).send({message: `auth ${error.message}`, success: false});
    }
}
module.exports = auth;