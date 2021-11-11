import request from "supertest";
import { app } from "../../../app";

it("returns a 201 on successful signup", async () => {
  return request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "notexist@email.com",
      password: "password",
    })
    .expect(201);
});

it("returns a 400 with an invalid email", async () => {
  return request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "notexist",
      password: "password",
    })
    .expect(400);
});

it("returns a 400 with an invalid password", async () => {
  return request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "notexist",
      password: "pas",
    })
    .expect(400);
});

it("returns a 400 with an empty name, email and password", async () => {
  await request(app)
    .post("/api/users")
    .send({
      email: "notexist",
      password: "pas",
    })
    .expect(400);

  await request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      password: "pas",
    })
    .expect(400);

  return await request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "notexist",
    })
    .expect(400);
});

it("return a 400 if email is duplicated", async () => {
  await request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "duplicate@test.com",
      password: "password",
    })
    .expect(201);

  return await request(app)
    .post("/api/users")
    .send({
      name: "kittipob",
      email: "duplicate@test.com",
      password: "password",
    })
    .expect(400);
});
