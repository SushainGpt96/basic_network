const enrollAdmin = require('../sdk/enrollAdmin');
const registerUser = require('../sdk/registerUser');
const invokeChaincode = require('../sdk/invoke');
const queryProductDetails = require('../sdk/query');


module.exports = {
    //Enroll Admin needs to be called only once
    registerAdmin: async (org)=>{
        console.log("Inside Enroll Admin Service");
        try {
            let enroll = await enrollAdmin.enrollAdmin(org)
            return enroll
          } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    registerUser: async (username,org)=>{
        console.log("Inside Register User Service")        
        try {
            let reg = await registerUser.registerUser(username,org)
            return reg
        } catch (error) {
            console.log("error", error)
            throw error
        }
    },
    invokeChaincode: async (username, channelName, contractName, functionName, args,org)=>{
        console.log('Inside Invoke Chaincode Service')
        try {
            let invoke = await invokeChaincode.invokeChaincode(username, channelName, contractName, functionName, args, org)
            
            return invoke
        } catch (error) {
        console.log("error", error)
        throw error
        }
    },
    queryChaincode: async (username, channelName, contractName, functionName, args, org )=>{
        console.log('Inside Query Chaincode Service')
        try {
            let query = await queryProductDetails.queryProductDetails(username, channelName, contractName, functionName, args, org )
            return query
        } catch (error) {
        console.log("error", error)
        throw error
        }        
    }
}