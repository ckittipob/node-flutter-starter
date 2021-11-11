import { Request, Response } from "express";
import { validationResult } from "express-validator";

//Import Models
import Example from "../../models/Example";

const List = async (req: Request, res: Response) => {

    // Validation Handler
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Logic
    try {
      //Query
      let examples = await Example.find();
      
      //Return
      res.json(examples);


    } catch (err) {
      //Error Handling
      console.error(err);
      res.status(500).send("Server error");
    }
  };

  export default List;