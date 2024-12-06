import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookLoginHistoryPage extends StatelessWidget {
  const FacebookLoginHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '登录记录'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 当前登录设备
          _buildSection('当前登录设备', [
            _buildLoginItem(
              deviceName: 'iPhone 13',
              location: '上海',
              time: '当前在线',
              isCurrentDevice: true,
            ),
          ]),
          h8,
          // 最近登录记录
          _buildSection('最近登录记录', [
            _buildLoginItem(
              deviceName: 'MacBook Pro',
              location: '北京',
              time: '2小时前',
            ),
            _buildLoginItem(
              deviceName: 'Chrome浏览器',
              location: '广州',
              time: '昨天 14:30',
            ),
            _buildLoginItem(
              deviceName: 'iPad',
              location: '深圳',
              time: '3天前',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return container.white.child(
      column.crossStart.children([
        container.p16.child(
          title.text.grey600.f14.mk,
        ),
        ...items,
      ]),
    );
  }

  Widget _buildLoginItem({
    required String deviceName,
    required String location,
    required String time,
    bool isCurrentDevice = false,
  }) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        row.children([
          container.s50.circle.grey100.center.child(
            Icons.devices.icon.grey800.s24.mk,
          ),
          w12,
          column.crossStart.expanded.children([
            deviceName.text.f16.bold.mk,
            h4,
            row.children([
              location.text.grey600.f14.mk,
              w8,
              '·'.text.grey600.f14.mk,
              w8,
              time.text.grey600.f14.mk,
            ]),
          ]),
          if (!isCurrentDevice)
            container.blue.rounded8.p8.ph16.center.child(
              '退出'.text.white.f14.bold.mk,
            ),
        ]),
      ),
    );
  }
}
