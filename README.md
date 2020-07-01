# What is this tf script
AWS Transcribeを使用して音声ファイルを文字越しするterraformです。

# Abstract
S3 → Lambda → Transcribe → S3

S3にファイルがプットされるとLambdaがファイル名を取得してTranscribeを実行し、結果をS3に保存します。


# Usage
ルート直下にvariables.tfを作成して、以下の二つの変数に適当な値を入れます。

input_bucket_nameは文字越しをしたい音声ファイルをアップロードするバケットです。

output_bucket_nameは文字越しされたjsonが出力されるバケットです。
```
locals {
  input_bucket_name = 
  output_bucket_name = 
}
```
