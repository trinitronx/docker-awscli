# docker-awscli
A Docker container with the AWS CLI tools installed.
Based on [sourcegraph/docker-awscli][1], with added packages (`sudo`, `acl`, `locales`) and fixed UTF-8 locale.

Default Entrypoint: `/usr/local/bin/aws`

## Usage


To run, simply pass your AWS CLI command as the `CMD` option to `docker run`.  For example:

    # List all instance IDs, PublicDNSName, Tags :
    docker run --rm -v ~/.aws:/root/.aws returnpath/awscli ec2 describe-instances --output=text --query='Reservations[*].Instances[*].{ID:InstanceId,PublicDNSName:PublicDnsName,Tags:Tags[?Key==`Name`].{Name:Value}}'

    # Same as above, but limit to hosts matching a `Name=foo` tag:
    docker run --rm -v ~/.aws:/root/.aws returnpath/awscli ec2 describe-instances --filters='Name=tag-name,Values=app,Name=tag-value,Values=foo' --output=text --query='Reservations[*].Instances[*].{ID:InstanceId,PublicDNSName:PublicDnsName,Tags:Tags[?Key==`Name`].{Name:Value}}'

    # Same again, but only print PublicDNSName using access keys & profile existing in `~/.aws/config`:
    docker run --rm -v ~/.aws:/root/.aws returnpath/awscli  --profile=devops-monkey ec2 describe-instances --filters 'Name=tag:Name,Values=foo' --query='Reservations[*].Instances[*].{PublicDNSName:PublicDnsName}' --output=text

    # List S3 buckets for an AWS account given access keys & profile existing in `~/.aws/config`:
    docker run --rm -v ~/.aws:/root/.aws returnpath/awscli  --profile=business-monkey s3 ls

    # Spawn interactive container to do more involved work:
    docker run -ti --rm -v ~/.aws:/root/.aws --entrypoint=/bin/bash returnpath/awscli


[1]: https://github.com/sourcegraph/docker-awscli
