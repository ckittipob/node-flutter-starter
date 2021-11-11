import request from "supertest";
import { app } from "../../../app";
import mongoose from "mongoose";

it("return a 401 if user try creating example without credential", async () => {
  return await request(app)
    .post("/api/examples")
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(401);
});

it("return a 201 if user try creating example with credential", async () => {
  return await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);
});

it("return a 400 if user try creating example with invalid data", async () => {
  return await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      integer: 3,
      number: 10.21,
    })
    .expect(400);
});

it("return a 401 if user try editting example without credential", async () => {
  const response = await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);

  const id = response.body.example._id;

  await request(app)
    .put(`/api/examples/${id}`)
    .send({
      name: "test07",
      integer: 3,
      number: 10.21,
    })
    .expect(401);

  return await request(app).delete(`/api/examples/${id}`).send().expect(401);
});

it("return a 404 if user edits non-exist example", async () => {
  return await request(app)
    .put(`/api/examples/${new mongoose.Types.ObjectId().toHexString()}`)
    .set("Authorization", global.signin())
    .send({
      name: "test07",
      integer: 3,
      number: 10.21,
    })
    .expect(404);
});

it("return 200 if user editted example successful", async () => {
  const response = await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);

  const id = response.body.example._id;
  return await request(app)
    .put(`/api/examples/${id}`)
    .set("Authorization", global.signin())
    .send({
      name: "test07",
      integer: 3,
      number: 10.21,
    })
    .expect(200);
});

it("return 204 if user deleted example successful", async () => {
  const response = await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);

  const id = response.body.example._id;

  return await request(app)
    .delete(`/api/examples/${id}`)
    .set("Authorization", global.signin())
    .send()
    .expect(204);
});

it("return a 200 with empty array if there are no examples", async () => {
    const response = await request(app)
    .get("/api/examples")
    .send()
    .expect(200);

    return expect(response.body).toEqual([]);
});

it("return a 200 with examples if users query for list of examples", async () => {
    await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);

    const response = await request(app)
    .get("/api/examples")
    .send()
    .expect(200);

    return expect(response.body.length).toEqual(1);
});

it("return a 200 with example if user query for exist example", async () => {
    const created = await request(app)
    .post("/api/examples")
    .set("Authorization", global.signin())
    .send({
      name: "test01",
      integer: 3,
      number: 10.21,
    })
    .expect(201);

    const response =await request(app)
    .get(`/api/examples/${created.body.example._id}`)
    .send()
    .expect(200);

    return expect(response.body._id).toEqual(created.body.example._id);
});

it("return a 404  if user query for non-exist example", async () => {
    return await request(app)
    .get(`/api/examples/${new mongoose.Types.ObjectId().toHexString()}`)
    .send()
    .expect(404);
});

