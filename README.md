To build the image run the following command inside the root directory:
docker build -t <orgname>/linux_endpoint .

After it finished building, to run the container you will need to be ready to set the following variables:
DBURL=<web address of your database instance>
DBUSERNAME=<username of the owner of your database> - Default is "odk_user"
DBPASSWORD=<password for the database user>
DBSCHEMA=<name of your schema> - Default is "odk_prod"

Note that these values need to be properly escaped, as they will be used in a sed command.

When you know these values, you can run the following command to spin up your instance:
"docker run --rm -it -p 8080:8080 -e DBURL=<your url> -e DBUSERNAME=<your username> -e DBPASSWORD=<your password> -e DBSCHEMA=<your schema> <orgname>/linux_endpoint"

An example run command might look like this:
docker run -rm -it -p 8080:8080 -e DBURL="psqltest\.c0xiufqyar8g\.us-west-2\.rds\.amazonaws\.com" -e DBUSERNAME="odk_user" -e DBPASSWORD="odk" -e DBSCHEMA="odk_prod" jbeorse/linux_endpoint

You can upgrade the aggregate version by dropping in a new ROOT.war file. But be aware that the init.sh script depends on specific file paths, so please double check that you have not broken that script.
