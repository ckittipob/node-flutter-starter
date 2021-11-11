import request from "supertest";
import { app } from "../../../app";

it('return a 400 when an email does not exist', async () => {
    return await request(app)
        .post('/api/auth')
        .send({
            email: 'kittipob@test.com',
            password: 'password'
        })
        .expect(400);
})


it('reutrn a 400 when an incorrect password is supplied', async () => {
    await request(app)
        .post('/api/users')
        .send({
            name: 'kittipob',
            email: 'kittipob@test.com',
            password: 'password'
        })
        .expect(201);

    return await request(app)
        .post('/api/auth')
        .send({
            email: 'kittipob@test.com',
            password: 'wrongpassword'
        })
        .expect(400);
})

it('return token when sign in successful' , async () => {
    await request(app)
        .post('/api/users')
        .send({
            name: 'kittipob',
            email: 'kittipob@test.com',
            password: 'password'
        })
        .expect(201);

    const response = await request(app)
        .post('/api/auth')
        .send({
            email: 'kittipob@test.com',
            password: 'password'
        })
        .expect(200);

    return expect(response.body.token).not.toBeNull();
})