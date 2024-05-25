import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plantopia/classes/plantclass.dart';

class PlantProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  Future<DocumentReference> addPlant(Plant plant) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user');
    }

    DocumentReference docRef = await _firestore.collection('users').doc(user.uid).collection('plants').add({
      'name': plant.name,
      'imagePath': plant.imagePath,
      'waterCounter': plant.waterCounter,
      'sprayCounter': plant.sprayCounter,
      'pruneCounter': plant.pruneCounter,
      'fertiliseCounter': plant.fertiliseCounter,
      'rotateCounter': plant.rotateCounter,
      'cleanCounter': plant.cleanCounter,
      'lastWatering': Timestamp.fromDate(plant.lastWatering), // Store as Timestamp
      'lastSpraying': Timestamp.fromDate(plant.lastSpraying), // Store as Timestamp
      'lastPruning': Timestamp.fromDate(plant.lastPruning), // Store as Timestamp
      'lastFertilizing': Timestamp.fromDate(plant.lastFertilizing), // Store as Timestamp
      'lastRotation': Timestamp.fromDate(plant.lastRotation), // Store as Timestamp
      'lastCleaning': Timestamp.fromDate(plant.lastCleaning), // Store as Timestamp
    });

    plant.id = docRef.id; // Update the plant ID with the Firebase-generated ID
    notifyListeners();
    return docRef;
  }

  Future<void> updatePlant(Plant updatedPlant) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Update the plant with user ID
        await _firestore.collection('users').doc(user.uid).collection('plants').doc(updatedPlant.id).update({
          'name': updatedPlant.name,
          'imagePath': updatedPlant.imagePath,
          'waterCounter': updatedPlant.waterCounter,
          'sprayCounter': updatedPlant.sprayCounter,
          'pruneCounter': updatedPlant.pruneCounter,
          'fertiliseCounter': updatedPlant.fertiliseCounter,
          'rotateCounter': updatedPlant.rotateCounter,
          'cleanCounter': updatedPlant.cleanCounter,
          'lastWatering': Timestamp.fromDate(updatedPlant.lastWatering), // Store as Timestamp
          'lastSpraying': Timestamp.fromDate(updatedPlant.lastSpraying), // Store as Timestamp
          'lastPruning': Timestamp.fromDate(updatedPlant.lastPruning), // Store as Timestamp
          'lastFertilizing': Timestamp.fromDate(updatedPlant.lastFertilizing), // Store as Timestamp
          'lastRotation': Timestamp.fromDate(updatedPlant.lastRotation), // Store as Timestamp
          'lastCleaning': Timestamp.fromDate(updatedPlant.lastCleaning), // Store as Timestamp
        });
        notifyListeners();
      }
    } catch (error) {
      print('Error updating plant: $error');
    }
  }

  Future<void> fetchPlants() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore.collection('users').doc(user.uid).collection('plants').get();
        _plants = querySnapshot.docs.map((doc) {
          return Plant(
            id: doc.id,
            name: doc['name'],
            imagePath: doc['imagePath'],
            waterCounter: doc['waterCounter'],
            sprayCounter: doc['sprayCounter'],
            pruneCounter: doc['pruneCounter'],
            fertiliseCounter: doc['fertiliseCounter'],
            rotateCounter: doc['rotateCounter'],
            cleanCounter: doc['cleanCounter'],
            lastWatering: doc['lastWatering'].toDate(),
            lastSpraying: doc['lastSpraying'].toDate(),
            lastPruning: doc['lastPruning'].toDate(),
            lastFertilizing: doc['lastFertilizing'].toDate(),
            lastRotation: doc['lastRotation'].toDate(),
            lastCleaning: doc['lastCleaning'].toDate(),
          );
        }).toList();
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching plants: $error');
    }
  }

  Future<void> updatePlantCareCountersInFirestore(Plant updatedPlant) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Update the plant's care counters in Firestore
        await _firestore.collection('users').doc(user.uid).collection('plants').doc(updatedPlant.id).update({
          'waterCounter': updatedPlant.waterCounter,
          'sprayCounter': updatedPlant.sprayCounter,
          'pruneCounter': updatedPlant.pruneCounter,
          'fertiliseCounter': updatedPlant.fertiliseCounter,
          'rotateCounter': updatedPlant.rotateCounter,
          'cleanCounter': updatedPlant.cleanCounter,
          'lastWatering': Timestamp.fromDate(updatedPlant.lastWatering), // Store as Timestamp
          'lastSpraying': Timestamp.fromDate(updatedPlant.lastSpraying), // Store as Timestamp
          'lastPruning': Timestamp.fromDate(updatedPlant.lastPruning), // Store as Timestamp
          'lastFertilizing': Timestamp.fromDate(updatedPlant.lastFertilizing), // Store as Timestamp
          'lastRotation': Timestamp.fromDate(updatedPlant.lastRotation), // Store as Timestamp
          'lastCleaning': Timestamp.fromDate(updatedPlant.lastCleaning),// Store as Timestamp
        });
        notifyListeners();
      }
    } catch (error) {
      print('Error updating plant care counters in Firestore: $error');
    }
  }

  Plant? findPlantByName(String plantName) {
    return _plants.firstWhere((plant) => plant.name == plantName);
  }

  Plant? findPlantById(String plantId) {
    return _plants.firstWhere((plant) => plant.id == plantId);
  }

  Future<Plant?> fetchPlantById(String plantId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(user.uid).collection('plants').doc(plantId).get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          return Plant(
            id: plantId,
            name: data['name'],
            imagePath: data['imagePath'],
            waterCounter: data['waterCounter'],
            sprayCounter: data['sprayCounter'],
            pruneCounter: data['pruneCounter'],
            fertiliseCounter: data['fertiliseCounter'],
            rotateCounter: data['rotateCounter'],
            cleanCounter: data['cleanCounter'],
            lastWatering: data['lastWatering'].toDate(),
            lastSpraying: data['lastSpraying'].toDate(),
            lastPruning: data['lastPruning'].toDate(),
            lastFertilizing: data['lastFertilizing'].toDate(),
            lastRotation: data['lastRotation'].toDate(),
            lastCleaning: data['lastCleaning'].toDate(),
          );
        } else {
          return null; // Plant not found with the given ID
        }
      } else {
        return null; // No authenticated user
      }
    } catch (error) {
      print('Error fetching plant by ID: $error');
      return null;
    }
  }

  Future<void> deletePlantById(String plantId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('plants')
            .doc(plantId)
            .delete();
        _plants.removeWhere((plant) => plant.id == plantId);
        notifyListeners();
      }
    } catch (error) {
      print('Error deleting plant byID: $error');
    }
  }
}