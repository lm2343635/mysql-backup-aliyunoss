#!/usr/bin/python3

import sys
import getopt
import oss2

def main(argv):
   accessKeyId = ''
   accessKeySecret = ''
   endpoint = ''
   bucket = ''
   objectName = ''
   localFile = ''
   try:
      opts, args = getopt.getopt(argv,"hk:s:e:b:o:f:",["accessKeyId=","accessKeySecret=","endpoint=","bucket=","objectName=","localFile="])
   except getopt.GetoptError:
      print ('upload.py -k <accessKeyId> -s <accessKeySecret> -e <endpoint> -b <bucket> -o <objectName> -f <localFile>')
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print ('upload.py -k <accessKeyId> -s <accessKeySecret> -e <endpoint> -b <bucket> -o <objectName> -f <localFile>')
         sys.exit()
      elif opt in ("-k", "--accessKeyId"):
         accessKeyId = arg
      elif opt in ("-s", "--accessKeySecret"):
         accessKeySecret = arg
      elif opt in ("-e", "--endpoint"):
         endpoint = arg
      elif opt in ("-b", "--bucket"):
         bucket = arg
      elif opt in ("-o", "--objectName"):
         objectName = arg
      elif opt in ("-f", "--localFile"):
         localFile = arg
   print("accessKeyId: " + accessKeyId)
   print("accessKeySecret: " + accessKeySecret)
   print("endpoint: " + endpoint)
   print("bucket: " + bucket)
   print("objectName: " + objectName)
   print("localFile: " + localFile)
   auth = oss2.Auth(accessKeyId, accessKeySecret)
   bucket = oss2.Bucket(auth, endpoint, bucket)
   bucket.put_object_from_file(objectName, localFile)

if __name__ == "__main__":
   main(sys.argv[1:])