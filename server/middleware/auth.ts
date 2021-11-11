import jwt from 'jsonwebtoken';
import { Request, Response, NextFunction } from 'express';


const auth = (req: any, res: Response, next:NextFunction) => {


    // Get token from header
    const token = req.header('Authorization');
    // Check if not token
    if (!token) {
        return res.status(401).json({ msg: 'No token, authorization denied' });
    }

    // Verify token
    try {
        jwt.verify(token, process.env.JWT_SECRET!, (error: any, decoded: any) => {
          if (error) {
            return res.status(401).json({ msg: 'Token is not valid' });
          } else {
            req.user = decoded.user;
            next();
          }
        });
      } catch (err) {
        console.error('something wrong with auth middleware');
        res.status(500).json({ msg: 'Server Error' });
      }
}

export {auth};