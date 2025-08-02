import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String? profileImageUrl;
  bool isLoading = true;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() => isLoading = true);

    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Email'i Firebase Auth'dan al
        _emailController.text = user.email ?? '';

        // Diğer bilgileri Firestore'dan al
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data()!;
          _usernameController.text = data['username'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          profileImageUrl = data['profileImageUrl'];
        }
      }
    } catch (e) {
      _showSnackBar('Profil yüklenirken hata oluştu.');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isUpdating = true);

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Kullanıcı bulunamadı');

      // Firestore'a kullanıcı bilgilerini kaydet
      await _firestore.collection('users').doc(user.uid).set({
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'profileImageUrl': profileImageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Email güncelleme (eğer değiştiyse)
      if (user.email != _emailController.text.trim()) {
        await user.verifyBeforeUpdateEmail(_emailController.text.trim());
        _showSnackBar('E-posta adresinizi doğrulamak için yeni bir link gönderildi.');
      }

      // Şifre güncelleme (eğer girildiyse)
      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }

      _showSnackBar('Profil başarıyla güncellendi!');
      Navigator.pop(context, true); // true ile geri dön
    } catch (e) {
      _showSnackBar('Güncelleme hatası: ${e.toString()}');
    } finally {
      setState(() => isUpdating = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showImagePickerInfo() {
    _showSnackBar('Resim yükleme özelliği için "image_picker" ve "firebase_storage" paketlerini eklemeniz gerekiyor.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Ana sayfadaki yumuşak arka plan
      appBar: AppBar(
        title: const Text('Profili Düzenle'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.indigo))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profil Resmi Kartı
                    _buildProfileImageSection(),
                    const SizedBox(height: 24),

                    // Form Alanları Kartı
                    _buildFormFieldsSection(),
                    const SizedBox(height: 24),

                    // Update butonu
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isUpdating ? null : _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: isUpdating
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Güncelle',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Profil Resmi ve Değiştirme Butonu
  Widget _buildProfileImageSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _showImagePickerInfo,
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Colors.indigo[50],
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!)
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.indigo)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _showImagePickerInfo,
            style: TextButton.styleFrom(
              foregroundColor: Colors.indigo,
            ),
            child: const Text(
              'Resmi Değiştir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Form alanları kartı
  Widget _buildFormFieldsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Kullanıcı Adı', _usernameController, 'Kullanıcı adı gerekli'),
          const SizedBox(height: 24),
          _buildTextField('E-posta Adresi', _emailController, 'Geçerli bir e-posta adresi girin', keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 24),
          _buildTextField('Telefon Numarası', _phoneController, 'Geçerli bir telefon numarası girin', keyboardType: TextInputType.phone, isOptional: true),
          const SizedBox(height: 24),
          _buildTextField('Yeni Şifre', _passwordController, 'Şifre en az 6 karakter olmalı', isPassword: true, isOptional: true),
        ],
      ),
    );
  }
  
  // Yeniden kullanılabilir TextField widget'ı
  Widget _buildTextField(String label, TextEditingController controller, String validatorMessage, {TextInputType keyboardType = TextInputType.text, bool isPassword = false, bool isOptional = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: isOptional ? '(İsteğe bağlı)' : '',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.indigo, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          validator: (value) {
            if (!isOptional && (value == null || value.trim().isEmpty)) {
              return validatorMessage;
            }
            if (isPassword && value != null && value.isNotEmpty && value.length < 6) {
              return validatorMessage;
            }
            if (keyboardType == TextInputType.emailAddress && value != null && value.isNotEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Geçerli bir e-posta adresi girin';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}