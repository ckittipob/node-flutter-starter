import express from "express";
import { check } from "express-validator";
import Login from "../../application/Auth/Login";


//Init router
const router = express.Router();

// @route   POST api/auth
// @desc    Login user
// @access  Public
router.post(
  "/",
  [
    check("email", "Please include a valid email").isEmail(),
    check("password","Password is required").exists()
  ],
  Login
);

export default router;
