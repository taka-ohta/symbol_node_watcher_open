enum AccountType {
  Main,
  Remote,
  Remote_Unlinked,
  Unlinked,
}

extension AccountTypeExtension on AccountType {
  static final values = {
    AccountType.Main: 1,
    AccountType.Remote: 2,
    AccountType.Remote_Unlinked: 3,
    AccountType.Unlinked: 0,
  };

  int get value => values[this]!;
  static AccountType getType(int num) {
    AccountType type = AccountType.Unlinked;
    values.forEach((key, value) {
      if (num == value) {
        type = key;
      }
    });
    return type;
  }
}
