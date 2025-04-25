cd ..
sops --encrypt -kms arn:aws:kms:ap-south-1:273354669111:key/49613993-abf5-4050-b410-83da8378c508 secrets.yaml > secrets-enc.yaml
