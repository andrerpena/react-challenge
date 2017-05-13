import express from 'express';
import colors from 'colors';
import apiRoute from './routes/api';
import appRoute from './routes/app';

const app = express();

// routes
app.use('/api', apiRoute);
app.use('', appRoute);

app.listen(4000, '0.0.0.0', () => {
    /*eslint-disable*/
    console.log(colors.green(`react-challenge started at http://localhost:4000/. NODE_ENV: ${process.env.NODE_ENV}`));
    /*eslint-enable*/
});
