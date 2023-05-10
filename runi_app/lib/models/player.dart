class Player {
  Player(this.id, this.startHp) : _hp = startHp;

  final int id;
  int startHp;
  int _hp;

  int get hp => _hp;

  void reset() => _hp = startHp;

  void increaseHp() => _hp++;
  void tenHpIncrease() => _hp += 10;

  void decreaseHp() => _hp--;
  void tenHpDecrease() => _hp -= 10;
}
