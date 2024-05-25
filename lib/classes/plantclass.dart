class Plant {
  String id;
  final String name;
  final String imagePath;
  int waterCounter;
  int sprayCounter;
  int pruneCounter;
  int fertiliseCounter;
  int rotateCounter;
  int cleanCounter;
  DateTime lastWatering;
  DateTime lastSpraying;
  DateTime lastPruning;
  DateTime lastFertilizing;
  DateTime lastRotation;
  DateTime lastCleaning;

  Plant({
    this.id = '',
    required this.name,
    required this.imagePath,
    this.waterCounter = 0,
    this.sprayCounter = 0,
    this.pruneCounter = 0,
    this.fertiliseCounter = 0,
    this.rotateCounter = 0,
    this.cleanCounter = 0,
    DateTime? lastWatering,
    DateTime? lastSpraying,
    DateTime? lastPruning,
    DateTime? lastFertilizing,
    DateTime? lastRotation,
    DateTime? lastCleaning,
  })  : lastWatering = lastWatering ?? DateTime.now(),
        lastSpraying = lastSpraying ?? DateTime.now(),
        lastPruning = lastPruning ?? DateTime.now(),
        lastFertilizing = lastFertilizing ?? DateTime.now(),
        lastRotation = lastRotation ?? DateTime.now(),
        lastCleaning = lastCleaning ?? DateTime.now();
}
