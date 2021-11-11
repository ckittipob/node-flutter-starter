import express from "express";
import { check } from "express-validator";

//Middleware
import {auth} from "../../middleware/auth";


//Application
import List from "../../application/Example/List";
import Detail from "../../application/Example/Detail";
import Create from "../../application/Example/Create";
import Edit from "../../application/Example/Edit";
import Delete from "../../application/Example/Delete";



//Init router
const router = express.Router();



// @route   Get api/example/protected
// @desc    Retrieve data from auth protected route
// @access  Private
router.get("/protected", auth, List)




// @route   Get api/example/
// @desc    Retrieve list of example data
// @access  Public
router.get("/", List);



// @route   Get api/example/id
// @desc    Retrieve detail of example data by id
// @access  Public
router.get("/:id", Detail);




// @route   Post api/example
// @desc    Add new example model
// @access  Private
router.post(
  "/",
  [
    check("name", "Name is required").exists(),
    check("integer", "Must be integer").isInt()
  ], auth,
  Create
);


// @route   Put api/example/:id
// @desc    Edit example by id
// @access  Private
router.put(
  "/:id",
  [
    check("name", "Name is required").exists(),
    check("integer", "Must be integer").isInt()
  ], auth,
  Edit
);


// @route   Del api/example
// @desc    Delete example by id
// @access  Private
router.delete("/:id", auth, Delete);







export default router;
