import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import config from "config";
import { validationResult } from "express-validator";

//Import Models
import User from "../../models/User";


const Login = async (req: Request, res: Response) => {
    
    // Validating Input
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }


    // Extract data from request's body
    const { email, password } = req.body;

    try {
        let user = await User.findOne({ email });

        if (!user) {
            return res
            .status(400)
            .json({ errors: [{ msg: 'Invalid Credentials'}]});
        }

        // hash request's password and compare hashed password we stored in database
        const isMatch = await bcrypt.compare(password, user.password);

        if(!isMatch) {
          return res
          .status(400)
          .json({ errors: [{ msg: 'Invalid Credentials'}]});
        }
        

        // Create JWT
        const payload = {
            user:{
                id: user.id
            }
        }
        jwt.sign(
            payload, 
            process.env.JWT_SECRET!,
            { expiresIn: 360000 },
            (err, token) => {
                if(err) throw err;
                res.json({token});
            });

    } catch(err) {
        console.error(err);
        res.status(500).send('Server error');
    }
}

export default Login;