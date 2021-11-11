import { Request, Response } from "express";
import { validationResult } from "express-validator";
import Example from '../../models/Example';
import { mapExample } from "./MappingProfile";
import { ExampleDto, ExamplesDto }from './ObjectDto';

const Map = async (req: Request, res: Response) => {
  // Validation Handler
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // Logic
  try {
      //Query
      let examples = await Example.find();
      // mapping profile
      res.json(mapExample(examples, ExamplesDto));
      
  } catch (err) {
    //Error Handling
    console.error(err);
    res.status(500).send("Server error");
  }
};

export default Map;
