#!/bin/sh

replace_environment_variables()
{
    find $1 -type f -exec sed -i "s,__API_URL__,${REACT_APP_API_ROOT},g" {} \;
    find $1 -type f -exec sed -i "s,__PUBLIC_URL__,${PUBLIC_URL},g" {} \;
}

#replace_environment_variables dist
replace_environment_variables /usr/share/nginx/html

exec "$@"
