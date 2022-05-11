#!/bin/sh
repository=$1
user_name=douglasmatosdev
user_email=douglasmatosdev@gmail.com
empty=''
git_user=https://github.com/douglasmatosdev/
git_extension=.git
folder=''
yarn_lock=yarn.lock
package_lock=package-lock.json

if [ "$#" -eq "0" ]
then
    echo "não é pra clonar"
else
    echo "deve clonar"
    echo "\n\n\n\n\nCloning $repository\n\n\n\n\n"
    git clone "$repository"
    
    [ "${repository%$git_user*}" != "$repository" ] && repository="${repository%$git_user*}$empty${repository#*$git_user}"
    repository="$repository"
    
    [ "${repository%$git_extension*}" != "$repository" ] && repository="${repository%$git_extension*}$empty${repository#*$git_extension}"
    folder="$repository"
    echo "\n\n\n\n\ncd $folder\n\n\n\n\n"
    cd "$folder"
fi

echo "Definindo usuário e email GIT"
git config user.name "$user_name"
git config user.email "$user_email"

echo "\n\n\n\n\nFix git user\n\n\n\n\n"
# cp -v ../CHANGE_AUTHOR_NAME_AND_EMAIL_OF_ALL_COMMITS.sh .

./CHANGE_AUTHOR_NAME_AND_EMAIL_OF_ALL_COMMITS.sh

git push -f
rm -rf CHANGE_AUTHOR_NAME_AND_EMAIL_OF_ALL_COMMITS.sh

rm -rf yarn.lock
rm -rf package-lock.json

echo "\n\n\n\n\n Installing yarn updagrade all\n\n\n\n\n"
yarn add -D yarn-upgrade-all

echo "\n\n\n\n\n Running yarn updagrade all\n\n\n\n\n"

yarn yarn-upgrade-all

echo "\n\n\n\n\n Installing yarn install\n\n\n\n\n"

yarn install

echo "\n\n\n\n\n Removing yarn updagrade all\n\n\n\n\n"

yarn remove yarn-upgrade-all

echo "\n\n\n\n\nChecking peer dependencies\n\n\n\n\n"
npx check-peer-dependencies --yarn

npx check-peer-dependencies --install

git add .
git commit -m "upgrade peer dependencies and fix git user name and email"
git push -f


if [ "$#" -eq "0" ]
    then
        echo "não tem pasta para deletar"
    else
        echo "\n\n\n\n\nSaindo da pasta\n\n\n\n\n"
        cd ..
        echo "\n\n\n\n\nDeletando a pasta $folder\n\n\n\n\n"
        rm -rf "$folder"
fi

echo "\n\n\n\n\nDone!!!\n\n\n\n\n"