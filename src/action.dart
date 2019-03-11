class EvaAction<P extends dynamic> {
  EvaAction(this.type, [this.payload]);

  String type;
  P payload;

  @override
  String toString() {
    return 'action($type, $payload)';
  }
}
