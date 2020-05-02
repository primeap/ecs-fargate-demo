#!/bin/bash
publish_error() {
  echo "$1"
  exit 1
}

export ECR_IMAGE=$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_PROJECT_NAME
echo "ECR_IMAGE:      $ECR_IMAGE"
export DOCKER_IMAGE=$ECR_PROJECT_NAME:$PROJECT_VERSION
echo "DOCKER_IMAGE:   $DOCKER_IMAGE"
$(aws ecr get-login --no-include-email --region "$AWS_REGION" | sed 's/-e none//') || publish_error "AWS ECR Login Failed"
docker build -t $DOCKER_IMAGE .

docker tag $DOCKER_IMAGE $ECR_IMAGE:$PROJECT_VERSION
docker push $ECR_IMAGE:$PROJECT_VERSION || publish_error "Docker Push Failed"

docker tag $DOCKER_IMAGE $ECR_IMAGE:latest
aws ecr put-image-tag-mutability --repository-name "$ECR_PROJECT_NAME" --image-tag-mutability MUTABLE --region "$AWS_REGION" || publish_error "Failed setting mutable"
docker push $ECR_IMAGE:latest || publish_error "Docker Push Failed"
aws ecr put-image-tag-mutability --repository-name "$ECR_PROJECT_NAME" --image-tag-mutability IMMUTABLE --region "$AWS_REGION" || publish_error "Failed setting immutable"

docker rmi $DOCKER_IMAGE
if [ $? -ne 0 ]; then
  echo "Failed while removing docker image"
  exit 3
fi

exit 0
