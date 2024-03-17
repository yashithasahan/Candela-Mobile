const functions = require("firebase-functions");
const stripe = require("stripe")(functions.config().stripe.testkey);

exports.stripePaymentIntentRequest = functions.https.onRequest(
    async (req, res) => {
      try {
        let customerId;

        const customerList = await stripe.customers.list({
          email: req.body.email,
          limit: 1,
        });

        if (customerList.data.length !== 0) {
          customerId = customerList.data[0].id;
        } else {
          const customer = await stripe.customers.create({
            email: req.body.email,
          });
          customerId = customer.id;
        }


        const ephemeralKey = await stripe.ephemeralKeys.create(
            {customer: customerId},
            {apiVersion: "2023-10-16"},
        );

        const paymentIntent = await stripe.paymentIntents.create({
          amount: parseInt(req.body.amount),
          currency: "usd",
          customer: customerId,
        });

        res.status(200).send({
          paymentIntent: paymentIntent.client_secret,
          ephemeralKey: ephemeralKey.secret,
          customer: customerId,
          success: true,
        });
      } catch (error) {
        res.status(400).send({success: false, error: error.message});
      }
    },
);
