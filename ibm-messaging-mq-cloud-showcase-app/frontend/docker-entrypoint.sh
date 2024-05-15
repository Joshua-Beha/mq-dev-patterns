#!/usr/bin/env sh
#  Copyright 2024 IBM Corp.
#  Licensed under the Apache License, Version 2.0 (the 'License');
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
 
#  http://www.apache.org/licenses/LICENSE-2.0
 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

set -eu

nginxTemplate="nginx.conf.template"

if [ $REACT_APP_FE_AS_PROXY == true ]
then
        nginxTemplate="nginx.conf.proxy.template"
fi

if [ $REACT_APP_BE_TLS == true ]
then
        export HTTP_PROTOCOL="https"
else    
        export HTTP_PROTOCOL="http"
fi

envsubst '${HTTP_PROTOCOL} ${REACT_APP_BE_HOST} ${REACT_APP_BE_PORT}' < /etc/nginx/conf.d/${nginxTemplate} > /etc/nginx/conf.d/default.conf

exec "$@"