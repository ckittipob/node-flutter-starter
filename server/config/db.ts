import mongoose from 'mongoose';
import  config from 'config';
import User from '../models/User';
import seed from './seed';


const MONGO_PORT = process.env.MONGO_PORT || 27017;
const MONGO_URL = process.env.MONGO_URL;
const db: string = `mongodb://${MONGO_URL}:${MONGO_PORT}/test`; // ENVIRONMENT VARIABLE

const connectDB = async () => {
  try {
    await mongoose.connect(db, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
      useFindAndModify: false,
    });
    console.log("MonngoDB Connected");
    console.log('updated!!!');
  } catch (err: any) {
    console.error(err);

    //Exit process with failure
    process.exit(1);
  } finally {
    const user = await User.find();
    if (user.length === 0) {
      seed();
    } else {
      console.log('Database had been seeded');
    }
  }
};

export default connectDB;
