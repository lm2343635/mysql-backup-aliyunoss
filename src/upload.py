import sys
import oss2

accessKeyId = sys.argv[1]
accessKeySecret = sys.argv[2]
print(accessKeyId)
print(accessKeySecret)
auth = oss2.Auth(accessKeyId, accessKeySecret)

endpoint = sys.argv[3]
bucket = sys.argv[4]
print(endpoint)
print(bucket)
bucket = oss2.Bucket(auth, endpoint, bucket)

objectName = sys.argv[5]
localFile = sys.argv[6]
print(objectName)
print(localFile)
bucket.put_object_from_file(objectName, localFile)
