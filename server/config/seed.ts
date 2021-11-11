import User from "../models/User"
import bcrypt from "bcryptjs";
import Example from "../models/Example";

const seed = async () => {
    const user = new User({
        name: "test",
        email: "test@test.com",
        password: "123456"
    })

    const password = "123456";
    const salt = await bcrypt.genSalt(10);

    user.password = await bcrypt.hash(password, salt);
    const newUser = await user.save();

    const example = new Example({
        name: "test01",
        file: "",
        integer: 1,
        number: 1.1
    })
    const newExample = await example.save();
    console.log('Database Seeded!');
}

export default seed;