const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const User = require('../models/User');

const jwt = require('jsonwebtoken');
const passport = require('passport');
require('dotenv').config();

let opts = {};

opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = process.env.JWT_SECRET_KEY;

const userStrategy = new JwtStrategy(opts, async (jwt_payload, done) => {
  try {
    const user = await User.findOne({ _id: jwt_payload.id });
    if (user) {
      return done(null, user);
    }
    return done(null, false);
  } catch (error) {
    return done(error, false);
  }
})


// const googleStrategy = new GoogleStrategy({
//   clientID: process.env.GOOGLE_CLIENT_ID,
//   clientSecret: process.env.GOOGLE_SECRET_KEY,
//   callbackURL: "http://localhost:5000/auth/google/callback",
//   passReqToCallback: true,
//   scope: ["profile", "email"],
//   prompt: 'select_account consent',
//   proxy: true,
// },
//   async (req, accessToken, refreshToken, profile, done) => {

//     const firstName = profile.name.givenName;
//     const lastName = profile.name.familyName;
//     const email = profile.emails[0].value;
//     const googleId = profile.id;

//     try {
//       let user = await User.findOne({ email: email });

//       if (!user) {
//         user = await new User({
//           firstName: firstName,
//           lastName: lastName,
//           email: email,
//           username: email.split('@')[0],
//           google_id: googleId
//         }).save();
//       }

//       return done(null, user)
//     } catch (error) {
//       console.log('Error Sign In With Google, passport.js');
//       done(error, null);
//     }
//   }
// );

passport.use('user-jwt', userStrategy);
// passport.use(googleStrategy);

module.exports = passport;