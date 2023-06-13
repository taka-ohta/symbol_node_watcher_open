import * as admin from 'firebase-admin';
import { INotificationTable } from './interface_notification_table';

export class NotificationTableFirestore implements INotificationTable {
  private cache: Map<string, string[]> = new Map<string, string[]>();

  constructor() {
    admin.firestore().collection('cloud_messaging').doc('targets').onSnapshot((snapshot) => {
      this.cache.clear();
      const data = snapshot.data();
      for (const address in data) {
        const tokens: string[] = [];
        for (const index in data[address]) {
          tokens.push(data[address][index]);
        }
        this.cache.set(address, tokens);
      }
    });
  }

  getListByAddress(address: string) {
    if (this.cache.has(address)) {
      return this.cache.get(address);
    }
    return [];
  }
}
