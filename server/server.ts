import { app } from "./app";
import connectDB from "./config/db";

const start = async () => {
  //Connect Database
  connectDB();

  //Running Port
  const PORT = process.env.PORT || 5000;
  app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
};

start();
