#!/usr/bin/python3

import sys
import getopt
import subprocess
import datetime
import oss2

def main(argv):
   accessKeyId = ''
   accessKeySecret = ''
   endpoint = ''
   bucket = ''
   objectName = ''
   localFile = ''
   try:
      opts, args = getopt.getopt(argv,"h:u:p:d:k:s:e:b:o:f:",["host=","user=","password=","database=","accessKeyId=","accessKeySecret=","endpoint=","bucket="])
   except getopt.GetoptError:
      print ('upload.py -k <accessKeyId> -s <accessKeySecret> -e <endpoint> -b <bucket> -o <objectName> -f <localFile>')
      sys.exit(2)
   for opt, arg in opts:
      if opt in ("-h", "--host"):
         host = arg
      elif opt in ("-u", "--user"):
         user = arg
      elif opt in ("-p", "--password"):
         password = arg
      elif opt in ("-d", "--database"):
         database = arg
      elif opt in ("-k", "--accessKeyId"):
         accessKeyId = arg
      elif opt in ("-s", "--accessKeySecret"):
         accessKeySecret = arg
      elif opt in ("-e", "--endpoint"):
         endpoint = arg
      elif opt in ("-b", "--bucket"):
         bucket = arg

   print("host: " + host)
   print("user: " + user)
   print("password: " + password)
   print("database: " + database)
   print("accessKeyId: " + accessKeyId)
   print("accessKeySecret: " + accessKeySecret)
   print("endpoint: " + endpoint)
   print("bucket: " + bucket)


   now = datetime.datetime.now()
   sql = database + now.strftime('_%Y%m%d_%H%M%S.sql')
   zipfile = sql + '.zip'
   mysqldump = subprocess.getoutput('mysqldump -h ' + host + ' -u ' + user + ' -p' + password + ' ' + database + ' > ' + sql)
   print(mysqldump)
   subprocess.getoutput('zip -r ' + zipfile + ' ' + sql)

   print('Uploading backup file ' + zipfile + ' to Aliyun OSS...')
   auth = oss2.Auth(accessKeyId, accessKeySecret)
   bucket = oss2.Bucket(auth, endpoint, bucket)
   bucket.put_object_from_file(zipfile, zipfile)
   print('Uploaded!')
   
   subprocess.getoutput('rm *.zip *.sql')

if __name__ == "__main__":
   main(sys.argv[1:])