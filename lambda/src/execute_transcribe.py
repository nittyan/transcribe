import boto3


def lambda_handler(event: dict, context):
    client = boto3.client('transcribe')
    records = event['Records']
    for record in records:
        file_name = record['s3']['object']['key']

        client.start_transcription_job(
            TranscriptionJobName = file_name,
            LanguageCode = 'ja-JP',
            Media = {
                'MediaFileUri': f'https://${input_bucket_name}.s3-ap-northeast-1.amazonaws.com/{file_name}'
            },
            OutputBucketName = '${output_bucket_name}'
            )

    return 'success'