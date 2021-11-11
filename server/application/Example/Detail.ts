import { Request, Response } from "express";
import { validationResult } from "express-validator";

import { Exclude, Expose, plainToClass, Transform, Type } from 'class-transformer';
import 'reflect-metadata';
//Import Models
import Example from "../../models/Example";
import { type } from "os";


const Detail = async (req: Request, res: Response) => {

    // Validation Handler
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Logic
    try {
      //Query
      let example = await Example.findById(req.params.id);
      
      //Return
      if (!example) return res.status(404).json({msg: 'Example not found'});

      res.json(example);

    } catch (err) {
      //Error Handling
      console.error(err);
      res.status(500).send("Server error");
    }
  };

  export default Detail;