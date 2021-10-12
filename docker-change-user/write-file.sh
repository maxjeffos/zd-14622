#!/bin/bash

echo "writing file"
ls -la /
id

echo "USER_ID: ${USER_ID}"

if [ -z "${USER_ID}" ]; then
  USER_ID=$(id -u)
fi

USER_NAME=$(getent passwd "${USER_ID}" | awk -F ':' '{print $1}')
echo "USER_NAME: ${USER_NAME}"

if [ "${USER_NAME}" != "" ] && [ "${USER_NAME}" != "root" ]; then
  usermod -d /home/node "${USER_NAME}"
fi

useradd -o -m -u "${USER_ID}" -d /home/node docker-user 2>/dev/null

runCmdAsDockerUser() {
  su docker-user -m -c "$1"
  return $?
}

runCmdAsDockerUser "echo \"hello container\" > /mounted/container-modifies-user.txt"

ls -la /mounted

echo "that test"
eval "rm fooo"
echo $?


# echo "test a thing with nested quotes"
# runCmdAsDockerUser "echo \"hello from inner quotes\""


echo "that test via runCmdAsDockerUser"
runCmdAsDockerUser "eval \"rm fooo\""
echo $?

some_var=1232
echo "some_var: ${some_var}"
runCmdAsDockerUser "echo \"some_var with runCmdAsDockerUser: ${some_var}\""
