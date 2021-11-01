/*
 * SPDX-License-Identifier: Apache-2.0
 */

"use strict";

const { Wallets } = require("fabric-network");
const FabricCAServices = require("fabric-ca-client");
const fs = require("fs");
const path = require("path");

module.exports.registerUser = async (username, org) => {
  try {
    //Getting Username
    console.log("Username: ", username);
    // load the network configuration
    // const ccpPath = path.resolve(__dirname, '.', 'network-connection.json');
    const ccpPath = path.resolve(__dirname, ".", `connection-${org}.json`);
    const ccp = JSON.parse(fs.readFileSync(ccpPath, "utf8"));

    // Create a new CA client for interacting with the CA.
    // const caURL = ccp.certificateAuthorities['ca.org1.example.com'].url;
    const caURL = ccp.certificateAuthorities[`ca.${org}.product.com`].url;
    const ca = new FabricCAServices(caURL);

    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), `wallet-${org}`);
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    // Check to see if we've already enrolled the user.
    const userIdentity = await wallet.get(username);
    if (userIdentity) {
      console.log(
        "An identity for the user ",
        username,
        " already exists in the wallet"
      );
      return (
        "An identity for the user " + username + " already exists in the wallet"
      );
    }

    // Check to see if we've already enrolled the admin user.
    const adminIdentity = await wallet.get("admin");
    if (!adminIdentity) {
      console.log(
        'An identity for the admin user "admin" does not exist in the wallet'
      );
      console.log("Run the enrollAdmin.js application before retrying");
      return 'An identity for the admin user "admin" does not exist in the wallet';
    }

    // build a user object for authenticating with the CA
    const provider = wallet
      .getProviderRegistry()
      .getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, "admin");

    // Register the user, enroll the user, and import the new identity into the wallet.
    const secret = await ca.register(
      {
        affiliation: "org1.department1",
        enrollmentID: username,
        role: "client",
      },
      adminUser
    );
    const enrollment = await ca.enroll({
      enrollmentID: username,
      enrollmentSecret: secret,
    });
    const x509Identity = {
      credentials: {
        certificate: enrollment.certificate,
        privateKey: enrollment.key.toBytes(),
      },
      mspId: `${org}MSP`,
      type: "X.509",
    };
    await wallet.put(username, x509Identity);
    console.log(
      "Successfully registered and enrolled admin user ",
      username,
      " and imported it into the wallet"
    );
    return (
      "Successfully registered and enrolled admin user: " +
      username +
      " and imported it into the wallet"
    );
  } catch (error) {
    console.error(`Failed to register user : ${error}`);
    return error;
    process.exit(1);
  }
};