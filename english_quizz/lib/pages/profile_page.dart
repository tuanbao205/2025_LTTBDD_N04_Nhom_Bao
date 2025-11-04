import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giới thiệu cá nhân'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Thông tin sinh viên
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  _ProfileItem(
                    icon: Icons.person_outline,
                    label: 'Họ và tên',
                    value: 'Hoàng Tuấn Bảo',
                  ),
                  Divider(),
                  _ProfileItem(
                    icon: Icons.badge_outlined,
                    label: 'Mã SV',
                    value: '23010194',
                  ),
                  Divider(),
                  _ProfileItem(
                    icon: Icons.school_outlined,
                    label: 'Lớp',
                    value: 'N04',
                  ),
                  Divider(),
                  _ProfileItem(
                    icon: Icons.book_outlined,
                    label: 'Môn học',
                    value: 'Lập trình thiết bị di động',
                  ),
                  Divider(),
                  _ProfileItem(
                    icon: Icons.person_pin_outlined,
                    label: 'Thầy hướng dẫn',
                    value: 'Nguyễn Xuân Quế',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 📖 Giới thiệu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giới thiệu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Quiz English là ứng dụng giúp sinh viên luyện tập từ vựng, ngữ pháp và kỹ năng tiếng Anh thông qua các bài quiz trực quan và dễ sử dụng.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal, size: 22),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
