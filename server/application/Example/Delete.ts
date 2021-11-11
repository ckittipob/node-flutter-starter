import { Request, Response } from "express";
import { validationResult } from "express-validator";

//Import Models
import Example from "../../models/Example";

const Delete = async (req: Request, res: Response) => {

    // Validation Handler
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Logic
    try {

      //Command
      await Example.findOneAndDelete({_id: req.params.id}) 

      //Return
      res.status(204).json({ msg: 'Example deleted' });

    } catch (err) {
      //Error Handling
      console.error(err);
      res.status(500).send("Server error");
    }
  };

  export default Delete;