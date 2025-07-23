# 🧠 AI Model Deployment with AWS Lambda & Terraform

This is a short demonstration of how to build and deploy a Lambda Function based on certain criteria.

## 🔧 Used technologies

- GitHub Actions (CI/CD)
- Terraform (infrastructure provisioning)
- Docker (containerization)
- AWS: Lambda Function, API Gateway, CloudWatch (hosting)
- Python (application)

## ✅ Prerequisites

- GitHub Secrets Required: `AWS_ACCOUNT_ID`, `AWS_REGION`, `AWS_ROLE_ARN`
- ECR repository for the Docker images
- S3 bucket for the Terraform state file
- OIDC setup for workflow execution

## 🚀 Features

- 🏗️ Multi-stage Docker build with model training
- 🔁 CI/CD pipeline for automated image build, ECR push, and infrastructure provisioning
- ✅ The trained model is saved as `model.pkl` and copied into the runtime image
- ☁️ AWS Lambda packaged as a container image
- 🌐 HTTP API endpoint exposed via API Gateway
- 📊 Lambda health check and promotion via alias `prod`

## ⚙️ Workflow Overview

On every push to `main`, the following steps occur:

1. Train model during Docker image build  
2. Push image to Amazon ECR  
3. Deploy with Terraform (`terraform_infra/` directory)  
4. Invoke Lambda with test payload `{ "x": 3.5 }`  
5. If successful:  
   - Publish new version  
   - Update `prod` alias

## 🧪 Lambda API Usage

**Query Example (GET)**  
curl "https://<api-id>.execute-api.<region>.amazonaws.com/default/predict?x=3.5"

**Body Example (POST)**
curl -X POST "https://<api-id>.execute-api.<region>.amazonaws.com/default/predict" \
  -H "Content-Type: application/json" \
  -d '{"x": 3.5}'

**Lambda UI Test Event**
{
  "x": 3.5
}

## 📊 Monitoring

CloudWatch dashboards and logs help track:
- Invocation counts
- Error rates
- Prediction input/output

## 🔧 Improvement Ideas

- Use Terraform templates and modules
- Skip build execution if only infrastructure code changes
- Add Cognito for securing API endpoint
- Integrate Route53 for DNS management
