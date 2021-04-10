#!/bin/sh

replace_environment_variables()
{
    find $1 -type f -exec sed -i "s,__API_URL__,${THYME_CAPSULE_API},g" {} \;
    find $1 -type f -exec sed -i "s,__PUBLIC_URL__,${THYME_PUBLIC_URL__},g" {} \;
}

#replace_environment_variables dist
replace_environment_variables /usr/share/nginx/html

exec "$@"
