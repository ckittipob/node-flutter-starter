import  mongoose from 'mongoose';
import { IExample } from './interfaces/IExample';

const ExampleSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    file:{
        type: String
    },
    integer: {
        type: Number,
        required: true,
        validate : {
            validator : Number.isInteger,
            message   : '{VALUE} is not an integer value'
          }
    },
    number: {
        type: Number
    }
});

const Example = mongoose.model<IExample>('example', ExampleSchema);

export default Example;