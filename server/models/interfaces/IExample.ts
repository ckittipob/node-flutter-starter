import  mongoose from 'mongoose';

export interface IExample extends mongoose.Document {
    name: string,
    file: string,
    integer: Number,
    number: Number
}