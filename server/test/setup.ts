import { MongoMemoryServer } from "mongodb-memory-server";
import mongoose from "mongoose";
import jwt from "jsonwebtoken";

declare global {
  namespace NodeJS {
    interface Global {
      signin(): string;
    }
  }
}


beforeAll(async () => {
  // set up connection with test database
  process.env.JWT_SECRET = "testkey";

  const mongo = await MongoMemoryServer.create();
  const mongoUri = await mongo.getUri();
  await mongoose.connect(mongoUri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false,
  });
});

beforeEach(async () => {
  // clean data each test
  const collections = await mongoose.connection.db.collections();
  for (let collection of collections) {
    await collection.deleteMany({});
  }
});

afterAll(async () => {
  await mongoose.disconnect();
});

global.signin = () => {
  const payload = {
    user: {
      id: new mongoose.Types.ObjectId().toHexString(),
    },
  };

  const token = jwt.sign(payload, process.env.JWT_SECRET!);

  return token;
};
