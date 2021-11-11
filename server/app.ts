import express, { Application, Request, Response } from 'express';
import path from 'path';

import exampleRouter from './routes/api/example';
import userRouter from './routes/api/users';
import authRouter from './routes/api/auth';
import cors from 'cors';

const app: Application = express();
app.use(cors());

//Init Middleware
const middlewareOption:any = {extended: false}
app.use(express.json(middlewareOption));


//Example Routes
app.use('/api/examples', exampleRouter);

//Users & Auth Routes
app.use('/api/users', userRouter);
app.use('/api/auth', authRouter);


// Server static assets
app.use(express.static('build'));

// Serve built frontend, if have one.
app.get('*', (req: Request, res: Response) => {
   res.sendFile(path.resolve(__dirname, 'build', 'index.html'));
})


export { app }