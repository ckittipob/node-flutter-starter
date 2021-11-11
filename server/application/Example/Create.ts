import { Request, Response } from "express";
import { validationResult } from "express-validator";

//Import Models
import Example from "../../models/Example";

const Create = async (req: Request, res: Response) => {
  // Validation Handler
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // Logic
  try {
    //Query
    const { name, file, integer, number } = req.body;

    const example = new Example({
      name,
      file,
      integer,
      number,
    });

    await example.save();
    res.status(201).json({ example });
  } catch (err) {
    //Error Handling
    console.error(err);
    res.status(500).send("Server error");
  }
};

export default Create;
