import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'summary_screen2.dart';  // 요약 화면 임포트

class MeasureingPage extends StatefulWidget {
  @override
  _BloodPressureFormState createState() => _BloodPressureFormState();
}

class _BloodPressureFormState extends State<MeasureingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _maxPressureController = TextEditingController();
  final TextEditingController _minPressureController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveDataAndNavigate(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        DocumentReference docRef =
        await _firestore.collection('bloodPressureRecords').add({
          'maxPressure': _maxPressureController.text,
          'minPressure': _minPressureController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummaryScreen2(documentId2: docRef.id),
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('데이터 저장에 실패했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('혈압 입력'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _maxPressureController,
              decoration: InputDecoration(labelText: '최고 혈압'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '최고 혈압을 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _minPressureController,
              decoration: InputDecoration(labelText: '최저 혈압'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '최저 혈압을 입력하세요';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () => _saveDataAndNavigate(context),
              child: Text('전송'),
            ),
          ],
        ),
      ),
    );
  }
}
