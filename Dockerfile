# Stage 1 – model training
FROM public.ecr.aws/lambda/python:3.8 as train
WORKDIR /train
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY train.py ./
RUN python3 train.py

# Stage 2 – Lambda runtime + model serving
FROM public.ecr.aws/lambda/python:3.8
WORKDIR /var/task
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY --from=train /train/model.pkl model.pkl
COPY app.py ./

CMD ["app.lambda_handler"]

#Trigger
