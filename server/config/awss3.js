const { S3Client } = require("@aws-sdk/client-s3");
const multer = require('multer');
const multerS3 = require('multer-s3');

require('dotenv').config();


const bucketName = process.env.BUCKET_NAME;
const bucketRegion = process.env.BUCKET_REGION;
const awsPublicKey = process.env.AWS_PUBLIC_KEY;
const awsSecretKey = process.env.AWS_SECRET_KEY;

const s3 = new S3Client({
    credentials: {
        accessKeyId: awsPublicKey,
        secretAccessKey: awsSecretKey,
    },
    region: bucketRegion
});

const upload = multer({
    storage: multerS3({
      s3: s3,
      bucket: process.env.BUCKET_NAME,
      metadata: function (req, file, cb) {
        cb(null, {fieldName: file.fieldname});
      },
      key: function (req, file, cb) {
        cb(null, Date.now().toString())
      }
    })
  })


module.exports = {s3, upload};