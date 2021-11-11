import { Request, Response } from "express";
import { validationResult } from "express-validator";

import nodemailer from "nodemailer";

const Create = async (req: Request, res: Response) => {
  console.log('mail');
  // Validation Handler
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // Logic
  try {

    // create transport instance
    const transporter = nodemailer.createTransport({
      host: "smtpout.secureserver.net",
      port: 465,
      secure: true,
      auth: {
        user: '', // email account
        pass: process.env.MAIL_SECRET, // set it in docker-compose file
      },
    });

    // reciever and mail information
    const mailOptions = {
      from: '"',
      to: "",
      subject: "Sending Email using Node.js",
      text: "Hello World!",
    };

    // send it
    transporter.sendMail(mailOptions);
    res.send("sent!");
  } catch (err) {
    //Error Handling
    console.error(err);
    res.status(500).send("Server error");
  }
};

export default Create;
