import { Request, Response } from "express";
import { validationResult } from "express-validator";

//Import Models
import Example from "../../models/Example";

const Edit = async (req: Request, res: Response) => {
  // Validation Handler
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // Logic
  try {
    //Init
    const { name, file, integer, number } = req.body;
    const newExample = new Example({
        name,
        file,
        integer,
        number,
      });

    //Query
    const example = await Example.findById(req.params.id);
    if (!example) return res.status(404).json({msg: 'Example not found'});
    


    example.name = newExample.name ?? example.name;
    example.file = newExample.file ?? example.file;
    example.integer = newExample.integer ?? example.integer;
    example.number = newExample.number ?? example.number;

    await example.save();
    res.status(200).json({ example });
  } catch (err) {
    //Error Handling
    console.error(err);
    res.status(500).send("Server error");
  }
};

export default Edit;
