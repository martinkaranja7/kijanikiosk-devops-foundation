# IAM Least Privilege Policy Design

## Task Definition
An application service running on KijaniKiosk compute instances requires access to upload and read customer media uploads stored in a dedicated Amazon S3 bucket (`kijanikiosk-media-uploads`).

## Principle of Least Privilege
- **No Wildcard Actions:** Only explicit read (`s3:GetObject`) and write (`s3:PutObject`) permissions are granted.
- **Restricted Resources:** Access is locked strictly to `arn:aws:s3:::kijanikiosk-media-uploads/*`.
- **No Admin or Bucket Management Rights:** The role cannot delete buckets, modify bucket policies, or access unrelated storage resources.

## IAM Policy JSON

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowS3MediaBucketReadWrite",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::kijanikiosk-media-uploads",
        "arn:aws:s3:::kijanikiosk-media-uploads/*"
      ]
    }
  ]
}
