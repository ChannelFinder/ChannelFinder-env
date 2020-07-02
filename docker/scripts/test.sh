

echo "Env"
cat docker_env_default.conf
echo "\nfilename_test"
bash docker_builder.bash -f filename_test -d
echo "\nTest 1"
bash docker_builder.bash -o TEST1 -d
echo "\nTest 2"
bash docker_builder.bash -o TEST1 -i TEST2 -d
echo "\nTest 3"
bash docker_builder.bash -o TEST1 -i TEST2 -t TEST3 -d
echo "\nTest 4"
bash docker_builder.bash -o TEST1 -i TEST2 -t TEST3 -a TEST4 -d
echo "\nTest 3.5"
bash docker_builder.bash -o TEST1 -i TEST2 -t TEST3 -a TEST4 -v TEST3.5 -f TEST1.5 -d

