import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import config from "config";
import { validationResult } from "express-validator";

//Import Models
import User from "../../models/User";


const Register = async (req: Request, res: Response) => {

  // Validating input
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // Extract data from request body
  const { name, email, password } = req.body;

  try {
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ errors: [{ msg: "User already exists" }] });
    }

    user = new User({
      name,
      email,
      password,
    });

    // hash and salt password
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(password, salt);


    await user.save();

    // create token and return to user
    const payload = {
      user: {
        id: user.id,
      },
    };

    jwt.sign(
      payload,
      process.env.JWT_SECRET!,
      { expiresIn: 360000 },
      (err, token) => {
        if (err) throw err;
        res.status(201).send({ token });
      }
    );

  } catch (err) {
    console.error(err);
    res.status(500).send("Server error");
  }
};

export default Register;
