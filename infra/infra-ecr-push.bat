@echo off
REM === Definição das variáveis ===
set REGION=us-east-1
set ACCOUNT_ID=348737448868
set IMAGE_NAME=hello-world-teste
set IMAGE_VERSION=1.0.0

REM === Login no ECR ===
echo Fazendo login no ECR...
REM aws sso login --profile dema
aws ecr get-login-password --region %REGION% --profile dema | docker login --username AWS --password-stdin %ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com

REM === Build da imagem Docker ===
echo Build da imagem Docker: %IMAGE_NAME%:%IMAGE_VERSION% ...
docker buildx build --platform linux/amd64 --provenance=false -t %IMAGE_NAME%:%IMAGE_VERSION% . 
REM === Tag da imagem ===
echo Tag da imagem para o ECR...
docker tag %IMAGE_NAME%:%IMAGE_VERSION% %ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%IMAGE_NAME%:%IMAGE_VERSION%

REM === Push para o ECR ===
echo Enviando imagem para o ECR...
docker push %ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%IMAGE_NAME%:%IMAGE_VERSION%

echo Deploy finalizado com sucesso.
pause