function awsid
    aws sts get-caller-identity
end

function awsunset
    set -e (env | grep AWS_ | cut -d= -f1)
end

function awslogin
    aws-okta-py save-creds -f -p $argv[1]
    set -gx AWS_PROFILE $argv[1]
end

function assume_role
    echo "Assuming role $argv[1]"
    set -l creds (aws sts assume-role --role-arn $argv[1] --role-session-name MySessionName --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" --output text)
    set -gx AWS_ACCESS_KEY_ID (echo $creds | cut -d' ' -f1)
    set -gx AWS_SECRET_ACCESS_KEY (echo $creds | cut -d' ' -f2)
    set -gx AWS_SESSION_TOKEN (echo $creds | cut -d' ' -f3)
end
