import * as admin from 'firebase-admin';
import { NewBlock, RepositoryFactoryHttp } from 'symbol-sdk';
import { NotificationTableFirestore } from './data/notification_table_firestore';

const account = require('../key/symbol-node-watcher-firebase-adminsdk-uiwhs-9040cdc3c6.json');
admin.initializeApp({
  credential: admin.credential.cert(account),
});

const nodeUrl = 'http://ngl-dual-501.symbolblockchain.io:3000';
const repository = new RepositoryFactoryHttp(nodeUrl);
const listener = repository.createListener();

const main = async () => {
  const table = new NotificationTableFirestore();
  listener.open().then(() => {
    listener.newBlock().subscribe(async (block: NewBlock) => {
      const address = block.beneficiaryAddress.plain();
      const tokens = table.getListByAddress(address);
      const message: admin.messaging.MessagingPayload = {
        notification: {
          title: 'ハーベスト',
          body: 'ブロックをハーベストしました！',
        },
      };
      tokens.forEach(async (token) => {
        await admin.messaging().sendToDevice(token, message);
      });
      // debug用
      const debugTokens = table.getListByAddress('debug');
      debugTokens.forEach(async (token) => {
        await admin.messaging().sendToDevice(token, message);
      });
    });
  });
};
main();
