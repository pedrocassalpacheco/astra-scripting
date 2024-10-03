#!/bin/sh
API_BASE_URL=""
AUTH_TOKEN=""
ORG_ID="7"

usage() {
    echo "Usage: $0 {get_database|create_database|delete_database} [options]"
    exit 1
}

get_tokens() {
    set -x  
    curl -sS --location -X GET "${API_BASE_URL}/tokens" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${AUTH_TOKEN}"
    set +x
}

get_regions() {
    curl -sS --location -X GET "${API_BASE_URL}/regions/serverless" \
        --header "Authorization: Bearer ${AUTH_TOKEN}"    
}

get_databases() {
    curl -sS --location -X GET "${API_BASE_URL}/databases" \
        --header "Authorization: Bearer ${AUTH_TOKEN}" \
        --header "Content-Type: application/json" \
        | jq --color-output '.[] | .info.name, .id, .info.cloudProvider, .info.region'
}

get_database() {
    DB_ID="$1"
    curl -sS --location -X GET "${API_BASE_URL}/databases/${DB_ID}" \
        --header "Authorization: Bearer ${AUTH_TOKEN}" \
        --header "Content-Type: application/json"   
}

get_audit_logs() {
    curl -sS --location -X GET "${API_BASE_URL}/organizations/${ORG_ID}/telemery/auditlogs" \
        --header "Authorization: Bearer ${AUTH_TOKEN}" 
}

create_database() {
    DB_NAME="$1"
    CLOUD_PROVIDER="$2"
    REGION="$3"
    curl -sS --location -X POST "${API_BASE_URL}/databases" \
        --header "Authorization: Bearer ${AUTH_TOKEN}" \
        --header "Content-Type: application/json" \
        --data '{
          "name": "'"${DB_NAME}"'",
          "keyspace": "",
          "cloudProvider": "'"${CLOUD_PROVIDER}"'",
          "region": "'"${REGION}"'",
          "dbType": "vector"
        }'
}

delete_database() {
    DB_ID="$1"
    curl -sS --location -X DELETE "${API_BASE_URL}/databases/${DB_ID}" \
        --header "Authorization: Bearer ${AUTH_TOKEN}" \
        --header "Content-Type: application/json"
}

if [ $# -lt 1 ]; then
    usage
fi

COMMAND="$1"
shift
echo $COMMAND

case "$COMMAND" in
   get_databases)
        get_databases 
        ;;
    get_regions)
        get_regions 
        ;;
    get_audit_logs)
        get_audit_logs
        ;;    
    get_tokens)
        get_tokens 
        ;;
    get_database)
        get_database "$@"
        ;;
    create_database)
        create_database "$@"
        ;;
    delete_database)
        delete_database "$@"
        ;;
    *)
        usage
        ;;
esac

exit 0
