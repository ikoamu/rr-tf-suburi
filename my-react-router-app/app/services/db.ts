import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { fromCognitoIdentityPool } from "@aws-sdk/credential-provider-cognito-identity"
 import { DynamoDBDocumentClient, QueryCommand, ScanCommand } from "@aws-sdk/lib-dynamodb";
import { amplifyConfig, identityPoolId, userPoolId } from "../config/amplify.config";
import { fetchAuthSession } from "aws-amplify/auth";
import { CognitoIdentityClient } from "@aws-sdk/client-cognito-identity";


const region =  amplifyConfig.auth.aws_region;
const cognito = new CognitoIdentityClient({ region });
const providerName = `cognito-idp.${region}.amazonaws.com/${userPoolId}`;

async function getClient() {
  const token = (await fetchAuthSession()).tokens?.idToken?.toString();
  if (!token) {
    throw new Error("token is undefined")
  }
  const client = new DynamoDBClient({
    region,
    credentials: fromCognitoIdentityPool({
      client: cognito,
      identityPoolId: identityPoolId,
      logins: {
        [providerName]: token
      }
    }),
  });
  
  return DynamoDBDocumentClient.from(client);
}
 
export async function getTodos(userId: string) {
  //  const command = new QueryCommand({
  //    TableName: "ikoamu_suburi_todo",
  //    KeyConditionExpression: "userId = :userId",
  //    ExpressionAttributeValues: {
  //     ":userId": userId
  //    }
  //  });
  //  const res = await docClient.send(command);
  //  console.log("res", res);
  //  const items = res.Items;
  //  console.log("items", items);
  const client = await getClient()
  const command = new ScanCommand({
    TableName: "ikoamu_suburi_todo",
  });
  const res = await client.send(command);
  console.log("res", res);
  const items = res.Items;
  console.log("items", items);
  
   return items;
 }