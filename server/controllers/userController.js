const userModel=require('../models/user');
const bcrypt=require('bcryptjs');
const jwt=require('jsonwebtoken');
const dotenv=require('dotenv');
dotenv.config();
//const twilio=require('twilio')(process.env.Twilio_SID,process.env.Twilio_AUTH);



const registerController=async (req,res)=>{
    try{
        let data=req.body;
        const existingUser= await userModel.findOne({email: data.email});
        if(existingUser){
            return res.status(400).send({message: 'User already exists', success: false});
        }
        const password=data.password;
        const salt=await bcrypt.genSalt(10);
        const hashedPassword=await bcrypt.hash(password,salt);
        data.password=hashedPassword;
        let newUser=new userModel(data);
        newUser = await newUser.save();
        res.status(200).json(newUser);

    }
    catch(error){
        console.log(error);
        res.status(500).send({success:false,message:`registerController ${error.message}`});
    }

}

const loginController=async (req,res)=>{
    try{
        const data=req.body;
        const user=await userModel.findOne({email: data.email});
        if(!user){
            return res.status(400).send({message: "User not found",success: false});
        }
        const Matched=await bcrypt.compare(data.password,user.password);
        if(!Matched){
            return res.status(400).send({message:"Invalid Email/Password"});
        }
        const token=jwt.sign({id: user._id},process.env.JWT_SECRET,{expiresIn: '1d'});
        res.status(200).json({token, ...user._doc});
        

    }
    catch(error){
        console.log(error);
        res.status(500).send({message: `loginController ${error.message}`,success: false})
    }
}

const authController=async (req,res)=>{
try{
    const user=await userModel.findOne({_id:req.body.userId});
    if(!user){
        return res.status(400).send({message: "User Not Found",success: false});
    }
    else{
        res.status(200).send({success: true,data: {name: user.name,email: user.email,role: user.role,id: user._id,phone: user.phone}});
    }
}
catch(err){
    console.log(err);
    res.status(500).send({message: `authController ${err.message}`,success: false,})
}
}

const getDoctor=async (req,res)=>{
    try{
        
        const users=await userModel.find({role: 'user'});
        res.status(200).send({message: 'Doctor Fetched Successfully', success: true,users});
    }
    catch(error){
        console.log(error);
        res.status(500).send({success: false,message: `addDoctor ${error.message}`});
    }
}

const getUsers=async (req,res)=>{
    try {
        const user = await userModel.findById(req.user);
        
        res.status(200).json({...user._doc, token: req.token});
    } catch (error) {
        console.log(error);
        res.status(500).send({message: `get user data ${error.message}`, success: false});
    }
}

const profileController = async (req, res) => {
    try {
      const data=req.body.values;
      console.log(data);
      
      await userModel.findOneAndUpdate({_id: req.body._id},data);
      
      res.status(200).json({message: 'Profile Updated Successfully', success: true});
    } catch (error) {
      res.status(400).json({
        message: `profileController ${error.message}`,
        success: false,
      });
    }
  };

const tokenController=async (req,res)=>{
    try {
        const token=req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }
        const verified=jwt.verify(token,process.env.JWT_SECRET);
        if(!verified){
            return res.json(false);
        }
        const user=await userModel.findById(verified.id);
        if(!user){
            return res.json(false);
        }
        return res.json(true);
    } catch (e) {
        res.status(500).send({message: `tokenController ${e.message}`,success: false});
    }

    
};  

 
module.exports={ loginController, registerController,authController,getUsers,profileController,tokenController,getDoctor};