//
// Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSFirehoseResources.h"
#import <AWSCore/AWSLogging.h>

@interface AWSFirehoseResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSFirehoseResources

+ (instancetype)sharedInstance {
    static AWSFirehoseResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSFirehoseResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2015-08-04\",\
    \"endpointPrefix\":\"firehose\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"Firehose\",\
    \"serviceFullName\":\"Amazon Kinesis Firehose\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"Firehose_20150804\"\
  },\
  \"operations\":{\
    \"CreateDeliveryStream\":{\
      \"name\":\"CreateDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"CreateDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"ResourceInUseException\"}\
      ],\
      \"documentation\":\"<p>Creates a delivery stream.</p> <p> <a>CreateDeliveryStream</a> is an asynchronous operation that immediately returns. The initial status of the delivery stream is <code>CREATING</code>. After the delivery stream is created, its status is <code>ACTIVE</code> and it now accepts data. Attempts to send data to a delivery stream that is not in the <code>ACTIVE</code> state cause an exception. To check the state of a delivery stream, use <a>DescribeDeliveryStream</a>.</p> <p>The name of a delivery stream identifies it. You can't have two delivery streams with the same name in the same region. Two delivery streams in different AWS accounts or different regions in the same AWS account can have the same name.</p> <p>By default, you can create up to 20 delivery streams per region.</p> <p>A delivery stream can only be configured with a single destination, Amazon S3, Amazon Elasticsearch Service, or Amazon Redshift. For correct <a>CreateDeliveryStream</a> request syntax, specify only one destination configuration parameter: either <b>S3DestinationConfiguration</b>, <b>ElasticsearchDestinationConfiguration</b>, or <b>RedshiftDestinationConfiguration</b>. </p> <p>As part of <b>S3DestinationConfiguration</b>, optional values <b>BufferingHints</b>, <b>EncryptionConfiguration</b>, and <b>CompressionFormat</b> can be provided. By default, if no <b>BufferingHints</b> value is provided, Firehose buffers data up to 5 MB or for 5 minutes, whichever condition is satisfied first. Note that <b>BufferingHints</b> is a hint, so there are some cases where the service cannot adhere to these conditions strictly; for example, record boundaries are such that the size is a little over or under the configured buffering size. By default, no encryption is performed. We strongly recommend that you enable encryption to ensure secure data storage in Amazon S3.</p> <p>A few notes about <b>RedshiftDestinationConfiguration</b>:</p> <ul> <li> <p>An Amazon Redshift destination requires an S3 bucket as intermediate location, as Firehose first delivers data to S3 and then uses <code>COPY</code> syntax to load data into an Amazon Redshift table. This is specified in the <b>RedshiftDestinationConfiguration.S3Configuration</b> parameter element.</p> </li> <li> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <b>RedshiftDestinationConfiguration.S3Configuration</b> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p> </li> <li> <p>We strongly recommend that the username and password provided is used exclusively for Firehose purposes, and that the permissions for the account are restricted for Amazon Redshift <code>INSERT</code> permissions.</p> </li> </ul> <p>Firehose assumes the IAM role that is configured as part of destinations. The IAM role should allow the Firehose principal to assume the role, and the role should have permissions that allows the service to deliver the data. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Amazon S3 Bucket Access</a> in the <i>Amazon Kinesis Firehose Developer Guide</i>.</p>\"\
    },\
    \"DeleteDeliveryStream\":{\
      \"name\":\"DeleteDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"DeleteDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Deletes a delivery stream and its data.</p> <p>You can delete a delivery stream only if it is in <code>ACTIVE</code> or <code>DELETING</code> state, and not in the <code>CREATING</code> state. While the deletion request is in process, the delivery stream is in the <code>DELETING</code> state.</p> <p>To check the state of a delivery stream, use <a>DescribeDeliveryStream</a>.</p> <p>While the delivery stream is <code>DELETING</code> state, the service may continue to accept the records, but the service doesn't make any guarantees with respect to delivering the data. Therefore, as a best practice, you should first stop any applications that are sending records before deleting a delivery stream.</p>\"\
    },\
    \"DescribeDeliveryStream\":{\
      \"name\":\"DescribeDeliveryStream\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeDeliveryStreamInput\"},\
      \"output\":{\"shape\":\"DescribeDeliveryStreamOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"}\
      ],\
      \"documentation\":\"<p>Describes the specified delivery stream and gets the status. For example, after your delivery stream is created, call <a>DescribeDeliveryStream</a> to see if the delivery stream is <code>ACTIVE</code> and therefore ready for data to be sent to it.</p>\"\
    },\
    \"ListDeliveryStreams\":{\
      \"name\":\"ListDeliveryStreams\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListDeliveryStreamsInput\"},\
      \"output\":{\"shape\":\"ListDeliveryStreamsOutput\"},\
      \"documentation\":\"<p>Lists your delivery streams.</p> <p>The number of delivery streams might be too large to return using a single call to <a>ListDeliveryStreams</a>. You can limit the number of delivery streams returned, using the <b>Limit</b> parameter. To determine whether there are more delivery streams to list, check the value of <b>HasMoreDeliveryStreams</b> in the output. If there are more delivery streams to list, you can request them by specifying the name of the last delivery stream returned in the call in the <b>ExclusiveStartDeliveryStreamName</b> parameter of a subsequent call.</p>\"\
    },\
    \"PutRecord\":{\
      \"name\":\"PutRecord\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordInput\"},\
      \"output\":{\"shape\":\"PutRecordOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Writes a single data record into an Amazon Kinesis Firehose delivery stream. To write multiple data records into a delivery stream, use <a>PutRecordBatch</a>. Applications using these operations are referred to as producers.</p> <p>By default, each delivery stream can take in up to 2,000 transactions per second, 5,000 records per second, or 5 MB per second. Note that if you use <a>PutRecord</a> and <a>PutRecordBatch</a>, the limits are an aggregate across these two operations for each delivery stream. For more information about limits and how to request an increase, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Firehose Limits</a>. </p> <p>You must specify the name of the delivery stream and the data record when using <a>PutRecord</a>. The data record consists of a data blob that can be up to 1,000 KB in size, and any kind of data, for example, a segment from a log file, geographic location data, web site clickstream data, etc.</p> <p>Firehose buffers records before delivering them to the destination. To disambiguate the data blobs at the destination, a common solution is to use delimiters in the data, such as a newline (<code>\\\\n</code>) or some other character unique within the data. This allows the consumer application(s) to parse individual data items when reading the data from the destination.</p> <p>The <a>PutRecord</a> operation returns a <b>RecordId</b>, which is a unique string assigned to each record. Producer applications can use this ID for purposes such as auditability and investigation.</p> <p>If the <a>PutRecord</a> operation throws a <b>ServiceUnavailableException</b>, back off and retry. If the exception persists, it is possible that the throughput limits have been exceeded for the delivery stream. </p> <p>Data records sent to Firehose are stored for 24 hours from the time they are added to a delivery stream as it attempts to send the records to the destination. If the destination is unreachable for more than 24 hours, the data is no longer available.</p>\"\
    },\
    \"PutRecordBatch\":{\
      \"name\":\"PutRecordBatch\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutRecordBatchInput\"},\
      \"output\":{\"shape\":\"PutRecordBatchOutput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Writes multiple data records into a delivery stream in a single call, which can achieve higher throughput per producer than when writing single records. To write single data records into a delivery stream, use <a>PutRecord</a>. Applications using these operations are referred to as producers.</p> <p>Each <a>PutRecordBatch</a> request supports up to 500 records. Each record in the request can be as large as 1,000 KB (before 64-bit encoding), up to a limit of 4 MB for the entire request. By default, each delivery stream can take in up to 2,000 transactions per second, 5,000 records per second, or 5 MB per second. Note that if you use <a>PutRecord</a> and <a>PutRecordBatch</a>, the limits are an aggregate across these two operations for each delivery stream. For more information about limits and how to request an increase, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Firehose Limits</a>. </p> <p>You must specify the name of the delivery stream and the data record when using <a>PutRecord</a>. The data record consists of a data blob that can be up to 1,000 KB in size, and any kind of data, for example, a segment from a log file, geographic location data, web site clickstream data, and so on.</p> <p>Firehose buffers records before delivering them to the destination. To disambiguate the data blobs at the destination, a common solution is to use delimiters in the data, such as a newline (<code>\\\\n</code>) or some other character unique within the data. This allows the consumer application(s) to parse individual data items when reading the data from the destination.</p> <p>The <a>PutRecordBatch</a> response includes a count of any failed records, <b>FailedPutCount</b>, and an array of responses, <b>RequestResponses</b>. The <b>FailedPutCount</b> value is a count of records that failed. Each entry in the <b>RequestResponses</b> array gives additional information of the processed record. Each entry in <b>RequestResponses</b> directly correlates with a record in the request array using the same ordering, from the top to the bottom of the request and response. <b>RequestResponses</b> always includes the same number of records as the request array. <b>RequestResponses</b> both successfully and unsuccessfully processed records. Firehose attempts to process all records in each <a>PutRecordBatch</a> request. A single record failure does not stop the processing of subsequent records.</p> <p>A successfully processed record includes a <b>RecordId</b> value, which is a unique value identified for the record. An unsuccessfully processed record includes <b>ErrorCode</b> and <b>ErrorMessage</b> values. <b>ErrorCode</b> reflects the type of error and is one of the following values: <code>ServiceUnavailable</code> or <code>InternalFailure</code>. <code>ErrorMessage</code> provides more detailed information about the error.</p> <p>If <b>FailedPutCount</b> is greater than 0 (zero), retry the request. A retry of the entire batch of records is possible; however, we strongly recommend that you inspect the entire response and resend only those records that failed processing. This minimizes duplicate records and also reduces the total bytes sent (and corresponding charges).</p> <p>If the <a>PutRecordBatch</a> operation throws a <b>ServiceUnavailableException</b>, back off and retry. If the exception persists, it is possible that the throughput limits have been exceeded for the delivery stream.</p> <p>Data records sent to Firehose are stored for 24 hours from the time they are added to a delivery stream as it attempts to send the records to the destination. If the destination is unreachable for more than 24 hours, the data is no longer available.</p>\"\
    },\
    \"UpdateDestination\":{\
      \"name\":\"UpdateDestination\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateDestinationInput\"},\
      \"output\":{\"shape\":\"UpdateDestinationOutput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArgumentException\"},\
        {\"shape\":\"ResourceInUseException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ConcurrentModificationException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified destination of the specified delivery stream. Note: Switching between Elasticsearch and other services is not supported. For Elasticsearch destination, you can only update an existing Elasticsearch destination with this operation.</p> <p>This operation can be used to change the destination type (for example, to replace the Amazon S3 destination with Amazon Redshift) or change the parameters associated with a given destination (for example, to change the bucket name of the Amazon S3 destination). The update may not occur immediately. The target delivery stream remains active while the configurations are updated, so data writes to the delivery stream can continue during this process. The updated configurations are normally effective within a few minutes.</p> <p>If the destination type is the same, Firehose merges the configuration parameters specified in the <a>UpdateDestination</a> request with the destination configuration that already exists on the delivery stream. If any of the parameters are not specified in the update request, then the existing configuration parameters are retained. For example, in the Amazon S3 destination, if <a>EncryptionConfiguration</a> is not specified then the existing <a>EncryptionConfiguration</a> is maintained on the destination.</p> <p>If the destination type is not the same, for example, changing the destination from Amazon S3 to Amazon Redshift, Firehose does not merge any parameters. In this case, all parameters must be specified.</p> <p>Firehose uses the <b>CurrentDeliveryStreamVersionId</b> to avoid race conditions and conflicting merges. This is a required field in every request and the service only updates the configuration if the existing configuration matches the <b>VersionId</b>. After the update is applied successfully, the <b>VersionId</b> is updated, which can be retrieved with the <a>DescribeDeliveryStream</a> operation. The new <b>VersionId</b> should be uses to set <b>CurrentDeliveryStreamVersionId</b> in the next <a>UpdateDestination</a> operation.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AWSKMSKeyARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"BooleanObject\":{\"type\":\"boolean\"},\
    \"BucketARN\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"BufferingHints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"SizeInMBs\":{\
          \"shape\":\"SizeInMBs\",\
          \"documentation\":\"<p>Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5.</p> <p>We recommend setting SizeInMBs to a value greater than the amount of data you typically ingest into the delivery stream in 10 seconds. For example, if you typically ingest data at 1 MB/sec set SizeInMBs to be 10 MB or higher.</p>\"\
        },\
        \"IntervalInSeconds\":{\
          \"shape\":\"IntervalInSeconds\",\
          \"documentation\":\"<p>Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. The default value is 300.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes hints for the buffering to perform before delivering data to the destination. Please note that these options are treated as hints, and therefore Firehose may choose to use different values when it is optimal.</p>\"\
    },\
    \"CloudWatchLoggingOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Enabled\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Enables or disables CloudWatch logging.</p>\"\
        },\
        \"LogGroupName\":{\
          \"shape\":\"LogGroupName\",\
          \"documentation\":\"<p>The CloudWatch group name for logging. This value is required if Enabled is true.</p>\"\
        },\
        \"LogStreamName\":{\
          \"shape\":\"LogStreamName\",\
          \"documentation\":\"<p>The CloudWatch log stream name for logging. This value is required if Enabled is true.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
    },\
    \"ClusterJDBCURL\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"pattern\":\"jdbc:(redshift|postgresql)://((?!-)[A-Za-z0-9-]{1,63}(?<!-)\\\\.)+redshift\\\\.amazonaws\\\\.com:\\\\d{1,5}/[a-zA-Z0-9_$]+\"\
    },\
    \"CompressionFormat\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"UNCOMPRESSED\",\
        \"GZIP\",\
        \"ZIP\",\
        \"Snappy\"\
      ]\
    },\
    \"ConcurrentModificationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Another modification has already happened. Fetch <b>VersionId</b> again and use it to update the destination.</p>\",\
      \"exception\":true\
    },\
    \"CopyCommand\":{\
      \"type\":\"structure\",\
      \"required\":[\"DataTableName\"],\
      \"members\":{\
        \"DataTableName\":{\
          \"shape\":\"DataTableName\",\
          \"documentation\":\"<p>The name of the target table. The table must already exist in the database.</p>\"\
        },\
        \"DataTableColumns\":{\
          \"shape\":\"DataTableColumns\",\
          \"documentation\":\"<p>A comma-separated list of column names.</p>\"\
        },\
        \"CopyOptions\":{\
          \"shape\":\"CopyOptions\",\
          \"documentation\":\"<p>Optional parameters to use with the Amazon Redshift <code>COPY</code> command. For more information, see the \\\"Optional Parameters\\\" section of <a href=\\\"http://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html\\\">Amazon Redshift COPY command</a>. Some possible examples that would apply to Firehose are as follows.</p> <p> <code>delimiter '\\\\t' lzop;</code> - fields are delimited with \\\"\\\\t\\\" (TAB character) and compressed using lzop.</p> <p> <code>delimiter '|</code> - fields are delimited with \\\"|\\\" (this is the default delimiter).</p> <p> <code>delimiter '|' escape</code> - the delimiter should be escaped.</p> <p> <code>fixedwidth 'venueid:3,venuename:25,venuecity:12,venuestate:2,venueseats:6'</code> - fields are fixed width in the source, with each width specified after every column in the table.</p> <p> <code>JSON 's3://mybucket/jsonpaths.txt'</code> - data is in JSON format, and the path specified is the format of the data.</p> <p>For more examples, see <a href=\\\"http://docs.aws.amazon.com/redshift/latest/dg/r_COPY_command_examples.html\\\">Amazon Redshift COPY command examples</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a <code>COPY</code> command for Amazon Redshift.</p>\"\
    },\
    \"CopyOptions\":{\"type\":\"string\"},\
    \"CreateDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"S3DestinationConfiguration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon S3. This value must be specified if <b>ElasticsearchDestinationConfiguration</b> or <b>RedshiftDestinationConfiguration</b> is specified (see restrictions listed above).</p>\"\
        },\
        \"RedshiftDestinationConfiguration\":{\
          \"shape\":\"RedshiftDestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon Redshift. This value cannot be specified if Amazon S3 or Amazon Elasticsearch is the desired destination (see restrictions listed above).</p>\"\
        },\
        \"ElasticsearchDestinationConfiguration\":{\
          \"shape\":\"ElasticsearchDestinationConfiguration\",\
          \"documentation\":\"<p>The destination in Amazon ES. This value cannot be specified if Amazon S3 or Amazon Redshift is the desired destination (see restrictions listed above).</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>CreateDeliveryStream</a>.</p>\"\
    },\
    \"CreateDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DeliveryStreamARN\":{\
          \"shape\":\"DeliveryStreamARN\",\
          \"documentation\":\"<p>The ARN of the delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the output of <a>CreateDeliveryStream</a>.</p>\"\
    },\
    \"Data\":{\
      \"type\":\"blob\",\
      \"max\":1024000,\
      \"min\":0\
    },\
    \"DataTableColumns\":{\"type\":\"string\"},\
    \"DataTableName\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"DeleteDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>DeleteDeliveryStream</a>.</p>\"\
    },\
    \"DeleteDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Contains the output of <a>DeleteDeliveryStream</a>.</p>\"\
    },\
    \"DeliveryStreamARN\":{\"type\":\"string\"},\
    \"DeliveryStreamDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"DeliveryStreamARN\",\
        \"DeliveryStreamStatus\",\
        \"VersionId\",\
        \"Destinations\",\
        \"HasMoreDestinations\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"DeliveryStreamARN\":{\
          \"shape\":\"DeliveryStreamARN\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the delivery stream.</p>\"\
        },\
        \"DeliveryStreamStatus\":{\
          \"shape\":\"DeliveryStreamStatus\",\
          \"documentation\":\"<p>The status of the delivery stream.</p>\"\
        },\
        \"VersionId\":{\
          \"shape\":\"DeliveryStreamVersionId\",\
          \"documentation\":\"<p>Used when calling the <a>UpdateDestination</a> operation. Each time the destination is updated for the delivery stream, the VersionId is changed, and the current VersionId is required when updating the destination. This is so that the service knows it is applying the changes to the correct version of the delivery stream.</p>\"\
        },\
        \"CreateTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The date and time that the delivery stream was created.</p>\"\
        },\
        \"LastUpdateTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The date and time that the delivery stream was last updated.</p>\"\
        },\
        \"Destinations\":{\
          \"shape\":\"DestinationDescriptionList\",\
          \"documentation\":\"<p>The destinations.</p>\"\
        },\
        \"HasMoreDestinations\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether there are more destinations available to list.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about a delivery stream.</p>\"\
    },\
    \"DeliveryStreamName\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":1,\
      \"pattern\":\"[a-zA-Z0-9_.-]+\"\
    },\
    \"DeliveryStreamNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DeliveryStreamName\"}\
    },\
    \"DeliveryStreamStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CREATING\",\
        \"DELETING\",\
        \"ACTIVE\"\
      ]\
    },\
    \"DeliveryStreamVersionId\":{\
      \"type\":\"string\",\
      \"max\":50,\
      \"min\":1,\
      \"pattern\":\"[0-9]+\"\
    },\
    \"DescribeDeliveryStreamInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamName\"],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"DescribeDeliveryStreamInputLimit\",\
          \"documentation\":\"<p>The limit on the number of destinations to return. Currently, you can have one destination per delivery stream.</p>\"\
        },\
        \"ExclusiveStartDestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>Specifies the destination ID to start returning the destination information. Currently Firehose supports one destination per delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>DescribeDeliveryStream</a>.</p>\"\
    },\
    \"DescribeDeliveryStreamInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"DescribeDeliveryStreamOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"DeliveryStreamDescription\"],\
      \"members\":{\
        \"DeliveryStreamDescription\":{\
          \"shape\":\"DeliveryStreamDescription\",\
          \"documentation\":\"<p>Information about the delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the output of <a>DescribeDeliveryStream</a>.</p>\"\
    },\
    \"DestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\"DestinationId\"],\
      \"members\":{\
        \"DestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>The ID of the destination.</p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p>\"\
        },\
        \"RedshiftDestinationDescription\":{\
          \"shape\":\"RedshiftDestinationDescription\",\
          \"documentation\":\"<p>The destination in Amazon Redshift.</p>\"\
        },\
        \"ElasticsearchDestinationDescription\":{\
          \"shape\":\"ElasticsearchDestinationDescription\",\
          \"documentation\":\"<p>The destination in Amazon ES.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the destination for a delivery stream.</p>\"\
    },\
    \"DestinationDescriptionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DestinationDescription\"}\
    },\
    \"DestinationId\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"ElasticsearchBufferingHints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IntervalInSeconds\":{\
          \"shape\":\"ElasticsearchBufferingIntervalInSeconds\",\
          \"documentation\":\"<p>Buffer incoming data for the specified period of time, in seconds, before delivering it to the destination. The default value is 300 (5 minutes).</p>\"\
        },\
        \"SizeInMBs\":{\
          \"shape\":\"ElasticsearchBufferingSizeInMBs\",\
          \"documentation\":\"<p>Buffer incoming data to the specified size, in MBs, before delivering it to the destination. The default value is 5.</p> <p>We recommend setting <b>SizeInMBs</b> to a value greater than the amount of data you typically ingest into the delivery stream in 10 seconds. For example, if you typically ingest data at 1 MB/sec, set <b>SizeInMBs</b> to be 10 MB or higher.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the buffering to perform before delivering data to the Amazon ES destination.</p>\"\
    },\
    \"ElasticsearchBufferingIntervalInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":900,\
      \"min\":60\
    },\
    \"ElasticsearchBufferingSizeInMBs\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"ElasticsearchDestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"DomainARN\",\
        \"IndexName\",\
        \"TypeName\",\
        \"S3Configuration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the IAM role to be assumed by Firehose for calling the Amazon ES Configuration API and for indexing documents. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Amazon S3 Bucket Access</a>.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain. The IAM role must have permission for <code>DescribeElasticsearchDomain</code>, <code>DescribeElasticsearchDomains</code> , and <code>DescribeElasticsearchDomainConfig</code> after assuming <b>RoleARN</b>.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name.</p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period. Index rotation appends a timestamp to the IndexName to facilitate expiration of old data. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation\\\">Index Rotation for Amazon Elasticsearch Service Destination</a>. Default value is <code>OneDay</code>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>Buffering options. If no value is specified, <b>ElasticsearchBufferingHints</b> object default values are used. </p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon ES. Default value is 300 (5 minutes).</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"ElasticsearchS3BackupMode\",\
          \"documentation\":\"<p>Defines how documents should be delivered to Amazon S3. When set to FailedDocumentsOnly, Firehose writes any documents that could not be indexed to the configured Amazon S3 destination, with elasticsearch-failed/ appended to the key prefix. When set to AllDocuments, Firehose delivers all incoming records to Amazon S3, and also writes failed documents with elasticsearch-failed/ appended to the prefix. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-s3-backup\\\">Amazon S3 Backup for Amazon Elasticsearch Service Destination</a>. Default value is FailedDocumentsOnly.</p>\"\
        },\
        \"S3Configuration\":{\"shape\":\"S3DestinationConfiguration\"},\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDestinationDescription\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name.</p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>Buffering options.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>Elasticsearch retry options.</p>\"\
        },\
        \"S3BackupMode\":{\
          \"shape\":\"ElasticsearchS3BackupMode\",\
          \"documentation\":\"<p>Amazon S3 backup mode.</p>\"\
        },\
        \"S3DestinationDescription\":{\"shape\":\"S3DestinationDescription\"},\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>CloudWatch logging options.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The destination description in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the IAM role to be assumed by Firehose for calling the Amazon ES Configuration API and for indexing documents. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3\\\">Amazon S3 Bucket Access</a>.</p>\"\
        },\
        \"DomainARN\":{\
          \"shape\":\"ElasticsearchDomainARN\",\
          \"documentation\":\"<p>The ARN of the Amazon ES domain. The IAM role must have permission for DescribeElasticsearchDomain, DescribeElasticsearchDomains , and DescribeElasticsearchDomainConfig after assuming <b>RoleARN</b>.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ElasticsearchIndexName\",\
          \"documentation\":\"<p>The Elasticsearch index name.</p>\"\
        },\
        \"TypeName\":{\
          \"shape\":\"ElasticsearchTypeName\",\
          \"documentation\":\"<p>The Elasticsearch type name.</p>\"\
        },\
        \"IndexRotationPeriod\":{\
          \"shape\":\"ElasticsearchIndexRotationPeriod\",\
          \"documentation\":\"<p>The Elasticsearch index rotation period. Index rotation appends a timestamp to the IndexName to facilitate the expiration of old data. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation\\\">Index Rotation for Amazon Elasticsearch Service Destination</a>. Default value is <code>OneDay</code>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"ElasticsearchBufferingHints\",\
          \"documentation\":\"<p>Buffering options. If no value is specified, <b>ElasticsearchBufferingHints</b> object default values are used. </p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"ElasticsearchRetryOptions\",\
          \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon ES. Default value is 300 (5 minutes).</p>\"\
        },\
        \"S3Update\":{\"shape\":\"S3DestinationUpdate\"},\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon ES.</p>\"\
    },\
    \"ElasticsearchDomainARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"ElasticsearchIndexName\":{\
      \"type\":\"string\",\
      \"max\":80,\
      \"min\":1\
    },\
    \"ElasticsearchIndexRotationPeriod\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"NoRotation\",\
        \"OneHour\",\
        \"OneDay\",\
        \"OneWeek\",\
        \"OneMonth\"\
      ]\
    },\
    \"ElasticsearchRetryDurationInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":7200,\
      \"min\":0\
    },\
    \"ElasticsearchRetryOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationInSeconds\":{\
          \"shape\":\"ElasticsearchRetryDurationInSeconds\",\
          \"documentation\":\"<p>After an initial failure to deliver to Amazon ES, the total amount of time during which Firehose re-attempts delivery (including the first attempt). After this time has elapsed, the failed documents are written to Amazon S3. Default value is 300 seconds (5 minutes). A value of 0 (zero) results in no retries.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon ES.</p>\"\
    },\
    \"ElasticsearchS3BackupMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FailedDocumentsOnly\",\
        \"AllDocuments\"\
      ]\
    },\
    \"ElasticsearchTypeName\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"EncryptionConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NoEncryptionConfig\":{\
          \"shape\":\"NoEncryptionConfig\",\
          \"documentation\":\"<p>Specifically override existing encryption information to ensure no encryption is used.</p>\"\
        },\
        \"KMSEncryptionConfig\":{\
          \"shape\":\"KMSEncryptionConfig\",\
          \"documentation\":\"<p>The encryption key.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the encryption for a destination in Amazon S3.</p>\"\
    },\
    \"ErrorCode\":{\"type\":\"string\"},\
    \"ErrorMessage\":{\"type\":\"string\"},\
    \"IntervalInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":900,\
      \"min\":60\
    },\
    \"InvalidArgumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The specified input parameter has an value that is not valid.</p>\",\
      \"exception\":true\
    },\
    \"KMSEncryptionConfig\":{\
      \"type\":\"structure\",\
      \"required\":[\"AWSKMSKeyARN\"],\
      \"members\":{\
        \"AWSKMSKeyARN\":{\
          \"shape\":\"AWSKMSKeyARN\",\
          \"documentation\":\"<p>The ARN of the encryption key. Must belong to the same region as the destination Amazon S3 bucket.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an encryption key for a destination in Amazon S3.</p>\"\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>You have already reached the limit for a requested resource.</p>\",\
      \"exception\":true\
    },\
    \"ListDeliveryStreamsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"ListDeliveryStreamsInputLimit\",\
          \"documentation\":\"<p>The maximum number of delivery streams to list.</p>\"\
        },\
        \"ExclusiveStartDeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream to start the list with.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>ListDeliveryStreams</a>.</p>\"\
    },\
    \"ListDeliveryStreamsInputLimit\":{\
      \"type\":\"integer\",\
      \"max\":10000,\
      \"min\":1\
    },\
    \"ListDeliveryStreamsOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamNames\",\
        \"HasMoreDeliveryStreams\"\
      ],\
      \"members\":{\
        \"DeliveryStreamNames\":{\
          \"shape\":\"DeliveryStreamNameList\",\
          \"documentation\":\"<p>The names of the delivery streams.</p>\"\
        },\
        \"HasMoreDeliveryStreams\":{\
          \"shape\":\"BooleanObject\",\
          \"documentation\":\"<p>Indicates whether there are more delivery streams available to list.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the output of <a>ListDeliveryStreams</a>.</p>\"\
    },\
    \"LogGroupName\":{\"type\":\"string\"},\
    \"LogStreamName\":{\"type\":\"string\"},\
    \"NoEncryptionConfig\":{\
      \"type\":\"string\",\
      \"enum\":[\"NoEncryption\"]\
    },\
    \"NonNegativeIntegerObject\":{\
      \"type\":\"integer\",\
      \"min\":0\
    },\
    \"Password\":{\
      \"type\":\"string\",\
      \"min\":6,\
      \"sensitive\":true\
    },\
    \"Prefix\":{\"type\":\"string\"},\
    \"PutRecordBatchInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"Records\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Records\":{\
          \"shape\":\"PutRecordBatchRequestEntryList\",\
          \"documentation\":\"<p>One or more records.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>PutRecordBatch</a>.</p>\"\
    },\
    \"PutRecordBatchOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FailedPutCount\",\
        \"RequestResponses\"\
      ],\
      \"members\":{\
        \"FailedPutCount\":{\
          \"shape\":\"NonNegativeIntegerObject\",\
          \"documentation\":\"<p>The number of unsuccessfully written records.</p>\"\
        },\
        \"RequestResponses\":{\
          \"shape\":\"PutRecordBatchResponseEntryList\",\
          \"documentation\":\"<p>The results for the individual records. The index of each element matches the same index in which records were sent.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the output of <a>PutRecordBatch</a>.</p>\"\
    },\
    \"PutRecordBatchRequestEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Record\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"PutRecordBatchResponseEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RecordId\":{\
          \"shape\":\"PutResponseRecordId\",\
          \"documentation\":\"<p>The ID of the record.</p>\"\
        },\
        \"ErrorCode\":{\
          \"shape\":\"ErrorCode\",\
          \"documentation\":\"<p>The error code for an individual record result.</p>\"\
        },\
        \"ErrorMessage\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>The error message for an individual record result.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the result for an individual record from a <a>PutRecordBatch</a> request. If the record is successfully added to your delivery stream, it receives a record ID. If the record fails to be added to your delivery stream, the result includes an error code and an error message.</p>\"\
    },\
    \"PutRecordBatchResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PutRecordBatchResponseEntry\"},\
      \"max\":500,\
      \"min\":1\
    },\
    \"PutRecordInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"Record\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"Record\":{\
          \"shape\":\"Record\",\
          \"documentation\":\"<p>The record.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>PutRecord</a>.</p>\"\
    },\
    \"PutRecordOutput\":{\
      \"type\":\"structure\",\
      \"required\":[\"RecordId\"],\
      \"members\":{\
        \"RecordId\":{\
          \"shape\":\"PutResponseRecordId\",\
          \"documentation\":\"<p>The ID of the record.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the output of <a>PutRecord</a>.</p>\"\
    },\
    \"PutResponseRecordId\":{\
      \"type\":\"string\",\
      \"min\":1\
    },\
    \"Record\":{\
      \"type\":\"structure\",\
      \"required\":[\"Data\"],\
      \"members\":{\
        \"Data\":{\
          \"shape\":\"Data\",\
          \"documentation\":\"<p>The data blob, which is base64-encoded when the blob is serialized. The maximum size of the data blob, before base64-encoding, is 1,000 KB.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The unit of data in a delivery stream.</p>\"\
    },\
    \"RedshiftDestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"ClusterJDBCURL\",\
        \"CopyCommand\",\
        \"Username\",\
        \"Password\",\
        \"S3Configuration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"Password\":{\
          \"shape\":\"Password\",\
          \"documentation\":\"<p>The user password.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3Configuration\":{\
          \"shape\":\"S3DestinationConfiguration\",\
          \"documentation\":\"<p>The S3 configuration for the intermediate location from which Amazon Redshift obtains data. Restrictions are described in the topic for <a>CreateDeliveryStream</a>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <b>RedshiftDestinationConfiguration.S3Configuration</b> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftDestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"ClusterJDBCURL\",\
        \"CopyCommand\",\
        \"Username\",\
        \"S3DestinationDescription\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3DestinationDescription\":{\
          \"shape\":\"S3DestinationDescription\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftDestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"ClusterJDBCURL\":{\
          \"shape\":\"ClusterJDBCURL\",\
          \"documentation\":\"<p>The database connection string.</p>\"\
        },\
        \"CopyCommand\":{\
          \"shape\":\"CopyCommand\",\
          \"documentation\":\"<p>The <code>COPY</code> command.</p>\"\
        },\
        \"Username\":{\
          \"shape\":\"Username\",\
          \"documentation\":\"<p>The name of the user.</p>\"\
        },\
        \"Password\":{\
          \"shape\":\"Password\",\
          \"documentation\":\"<p>The user password.</p>\"\
        },\
        \"RetryOptions\":{\
          \"shape\":\"RedshiftRetryOptions\",\
          \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon Redshift. Default value is 3600 (60 minutes).</p>\"\
        },\
        \"S3Update\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>The Amazon S3 destination.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified in <b>RedshiftDestinationUpdate.S3Update</b> because the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket doesn't support these compression formats.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon Redshift.</p>\"\
    },\
    \"RedshiftRetryDurationInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":7200,\
      \"min\":0\
    },\
    \"RedshiftRetryOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationInSeconds\":{\
          \"shape\":\"RedshiftRetryDurationInSeconds\",\
          \"documentation\":\"<p>The length of time during which Firehose retries delivery after a failure, starting from the initial request and including the first attempt. The default value is 3600 seconds (60 minutes). Firehose does not retry if the value of <code>DurationInSeconds</code> is 0 (zero) or if the first delivery attempt takes longer than the current value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Configures retry behavior in the event that Firehose is unable to deliver documents to Amazon Redshift.</p>\"\
    },\
    \"ResourceInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The resource is already in use and not available for this operation.</p>\",\
      \"exception\":true\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The specified resource could not be found.</p>\",\
      \"exception\":true\
    },\
    \"RoleARN\":{\
      \"type\":\"string\",\
      \"max\":512,\
      \"min\":1,\
      \"pattern\":\"arn:.*\"\
    },\
    \"S3DestinationConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered S3 files. You can specify an extra prefix to be added in front of the time format prefix. Note that if the prefix ends with a slash, it appears as a folder in the S3 bucket. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html\\\">Amazon S3 Object Name Format</a> in the <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/\\\">Amazon Kinesis Firehose Developer Guide</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <b>BufferingHints</b> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>UNCOMPRESSED</code>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified for Amazon Redshift destinations because they are not supported by the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the configuration of a destination in Amazon S3.</p>\"\
    },\
    \"S3DestinationDescription\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleARN\",\
        \"BucketARN\",\
        \"BufferingHints\",\
        \"CompressionFormat\",\
        \"EncryptionConfiguration\"\
      ],\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered S3 files. You can specify an extra prefix to be added in front of the time format prefix. Note that if the prefix ends with a slash, it appears as a folder in the S3 bucket. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html\\\">Amazon S3 Object Name Format</a> in the <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/\\\">Amazon Kinesis Firehose Developer Guide</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <b>BufferingHints</b> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>NOCOMPRESSION</code>.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes a destination in Amazon S3.</p>\"\
    },\
    \"S3DestinationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RoleARN\":{\
          \"shape\":\"RoleARN\",\
          \"documentation\":\"<p>The ARN of the AWS credentials.</p>\"\
        },\
        \"BucketARN\":{\
          \"shape\":\"BucketARN\",\
          \"documentation\":\"<p>The ARN of the S3 bucket.</p>\"\
        },\
        \"Prefix\":{\
          \"shape\":\"Prefix\",\
          \"documentation\":\"<p>The \\\"YYYY/MM/DD/HH\\\" time format prefix is automatically used for delivered S3 files. You can specify an extra prefix to be added in front of the time format prefix. Note that if the prefix ends with a slash, it appears as a folder in the S3 bucket. For more information, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html\\\">Amazon S3 Object Name Format</a> in the <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/\\\">Amazon Kinesis Firehose Developer Guide</a>.</p>\"\
        },\
        \"BufferingHints\":{\
          \"shape\":\"BufferingHints\",\
          \"documentation\":\"<p>The buffering option. If no value is specified, <b>BufferingHints</b> object default values are used.</p>\"\
        },\
        \"CompressionFormat\":{\
          \"shape\":\"CompressionFormat\",\
          \"documentation\":\"<p>The compression format. If no value is specified, the default is <code>NOCOMPRESSION</code>.</p> <p>The compression formats <code>SNAPPY</code> or <code>ZIP</code> cannot be specified for Amazon Redshift destinations because they are not supported by the Amazon Redshift <code>COPY</code> operation that reads from the S3 bucket.</p>\"\
        },\
        \"EncryptionConfiguration\":{\
          \"shape\":\"EncryptionConfiguration\",\
          \"documentation\":\"<p>The encryption configuration. If no value is specified, the default is no encryption.</p>\"\
        },\
        \"CloudWatchLoggingOptions\":{\
          \"shape\":\"CloudWatchLoggingOptions\",\
          \"documentation\":\"<p>Describes CloudWatch logging options for your delivery stream.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes an update for a destination in Amazon S3.</p>\"\
    },\
    \"ServiceUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p>A message that provides information about the error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The service is unavailable, back off and retry the operation. If you continue to see the exception, throughput limits for the delivery stream may have been exceeded. For more information about limits and how to request an increase, see <a href=\\\"http://docs.aws.amazon.com/firehose/latest/dev/limits.html\\\">Amazon Kinesis Firehose Limits</a>.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"SizeInMBs\":{\
      \"type\":\"integer\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"Timestamp\":{\"type\":\"timestamp\"},\
    \"UpdateDestinationInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeliveryStreamName\",\
        \"CurrentDeliveryStreamVersionId\",\
        \"DestinationId\"\
      ],\
      \"members\":{\
        \"DeliveryStreamName\":{\
          \"shape\":\"DeliveryStreamName\",\
          \"documentation\":\"<p>The name of the delivery stream.</p>\"\
        },\
        \"CurrentDeliveryStreamVersionId\":{\
          \"shape\":\"DeliveryStreamVersionId\",\
          \"documentation\":\"<p>Obtain this value from the <b>VersionId</b> result of the <a>DeliveryStreamDescription</a> operation. This value is required, and helps the service to perform conditional operations. For example, if there is a interleaving update and this value is null, then the update destination fails. After the update is successful, the <b>VersionId</b> value is updated. The service then performs a merge of the old configuration with the new configuration.</p>\"\
        },\
        \"DestinationId\":{\
          \"shape\":\"DestinationId\",\
          \"documentation\":\"<p>The ID of the destination.</p>\"\
        },\
        \"S3DestinationUpdate\":{\
          \"shape\":\"S3DestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon S3.</p>\"\
        },\
        \"RedshiftDestinationUpdate\":{\
          \"shape\":\"RedshiftDestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon Redshift.</p>\"\
        },\
        \"ElasticsearchDestinationUpdate\":{\
          \"shape\":\"ElasticsearchDestinationUpdate\",\
          \"documentation\":\"<p>Describes an update for a destination in Amazon ES.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the parameters for <a>UpdateDestination</a>.</p>\"\
    },\
    \"UpdateDestinationOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
      },\
      \"documentation\":\"<p>Contains the output of <a>UpdateDestination</a>.</p>\"\
    },\
    \"Username\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"sensitive\":true\
    }\
  },\
  \"documentation\":\"<fullname>Amazon Kinesis Firehose API Reference</fullname> <p>Amazon Kinesis Firehose is a fully-managed service that delivers real-time streaming data to destinations such as Amazon Simple Storage Service (Amazon S3), Amazon Elasticsearch Service (Amazon ES), and Amazon Redshift.</p>\"\
}";
}

@end
