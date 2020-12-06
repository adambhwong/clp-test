Tools: gitlab + ECR + terraform => deploy EKS  

Concept  
    To maintain the infra code version and history audit, we use gitlab to host the infra code. And using Terraform to operate with AWS EKS according to the codes (*.tf). The workflow can be enhanced by limit changes to be pushed to non-master branch and create PR for an additional approval before applying the change, and the communication history in PR can be kept for change audit purpose. Even further can create a bot to auto react to PR and post the terraform action plan as an additional review meterial for the change approver, and execute the change once merged.  
  
Procedure:  
  1. build eks-admin-image and push to ECR, the image includes all the required tools and will be used to run the gitlab pipeline  
  2. create the repo on gitlab  
  ```
      +eks-config (group)  
        +rest-api-1 (project)  
          -vpc.tf  
          -security_groups.tf  
          -eks-cluster.tf  
          -(etc.)  
  ```
  3. in gitlab rest-api-1 repo, visit CI/CD>variables and add AWS_ACCESS_ID & AWS_SECRET_KEY  
  4. place the pipeline (.gitlab-ci.yml) into eks-config/rest-api-1  
  5. push code to master branch  

Files:
  - eks-admin-image
    Files for building the docker image, use the docker build command to create the docker image and then push to AWS ECR for the gitlab pipeline reference.
  - eks-config/rest-api-1  
    this is the EKS terraform code repo, *.tf defines the infra for terrform input. .gitlab-ci.yml is the gitlab pipeline which do the setup by using the eks-admin-image.

