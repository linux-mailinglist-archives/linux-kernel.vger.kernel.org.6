Return-Path: <linux-kernel+bounces-216796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5890A6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818F7B2B7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990718F2D5;
	Mon, 17 Jun 2024 07:11:36 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049C18C346;
	Mon, 17 Jun 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608295; cv=fail; b=O0qWvuCCZZggxrHAUncjubatPHXaPCfMHqeAWVt1QbWRgCBBG5roIr8kb1SpnBRhV105viJFsDEKpP7IMfoC3QrUczD2SuhcaGK4BKRn1gXI1w28wgi3r7T70cX0uAit+iYQDNv9XgO7ooYf1wzZKz1E7jr6++X9zNRlg0Ui6eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608295; c=relaxed/simple;
	bh=NS178prCXOtwmxt6y2TT5silxv+ZFee5cXyG9KY7BhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZhVte09wVphAigRZArliHttKvCcG98n+qO5jjqJKMj4GrXlA3fhYVWADZZiYCPtahH00rbhw/cYZY1ucFdY96ko5uO+pO10S0FbAUNXaEYR5t2D5AYQgDJJ8a6Fa6B3W4TuyRqEY2FXLpfJGiQPlGC0EhFaxLYLfXK0dUjIW38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2LIANA/mwHZP7Hdcz4imGlxPRZF8CW0grNC5BURdJcDF7JJ06dPHpNPkh6j9vEGHGG84wkXJNZDgWWy+w9pd/SsDKlsJ4Q8PcdToLBjzFYKVHmchC8yKed8WJNuqzSDZ71xCuhjek8GMLyUZm+xeX655EWRNpMjZNlWfgWNw4142Pm1AuftFwbUMtXteXM1kcZj4Twgm5Z2w7uDFuM04By3UqM8jFIi0hg60AvRHIwkDl+UpBoZNWnFS8F5gQKkcY8oVwbPdZlZ63TWTEyuuqNp0sQ6O7ppGZpYibQd4Dsv2iLLOT6XKxxrmbVJDZoubHXpMQsFutqhxNRBje0Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ0PjwTt+XVTAG30Lrlbaz2psNI9OBOx0/bFuNlSJpY=;
 b=krgpVyzvmP9T2dNUFr5X8OUC/B2aBV3kAwjO6C+2y8uTqSw6GBa1k5I7UCztd00P3g0yA1a627/GdF6hSyL7eHSuMWDDRMuoSSnFJmu+cW5FHlxo8rr04uaFNU5FdJcXHaa1Q2cXrciGbcQxZoEBVofKi56HSaewVD8+NRm+ua91Uo9Gv3BsGmYNv2CwL5gK85UHYtemg+U3AvqOH+9MmC98Hda5dDWB0uk0WZ9FbLYakoik59vHKAUf5TZy0PJIjo3OeejmD1kPzUk2BxR6884+fZblzHi6sbfwKDF7l2LWRrXXemv8BWT3gZsbEUYKli8pc5+cWFCEPpFk4Aho0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:26 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:25 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 1/5] arm64: dts: rockchip: Add USB-C to Khadas Edge 2
Date: Mon, 17 Jun 2024 15:11:08 +0800
Message-Id: <20240617071112.3133101-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617071112.3133101-1-jacobe.zang@wesion.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: d09ba50a-1ef2-4fa4-c3c5-08dc8e9cb33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|7416011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IgbeqXKK6vgBqToJYCDV6zVQ1F2Q+DD59w2UvEv8DG57TP5chM1hEy2MnNm?=
 =?us-ascii?Q?J0eHRUdDYwxZHIfN3AtVFSPIpV4w8Sef8H7n9TJbh8eRMKNrjfTLqWiWON2X?=
 =?us-ascii?Q?ARlvpjKikDVhwJWp2kNn/YPTrUtnsIQLRBUBvcJCyJlBzZlpf4YTY6OAqQKK?=
 =?us-ascii?Q?XXlrr254Qoe8VR0MtyOa+9hUXjtJg0vHoEA0EgzfFETTkbyv6MvkRolsoAUl?=
 =?us-ascii?Q?7VM/jqGs+kH8G4VqH8o/j9r3k9TsapUqsCjAhHaPvl26z4ZayLOxMYsQCtTQ?=
 =?us-ascii?Q?KGVkF2r2tpAB9e4waDKqSkNSviqfQOaLJ+QThgUrGpVI5dX+af0iijIsFgd9?=
 =?us-ascii?Q?KqvhTkVMhifpSbBDSnX+1usCDZ1yNPZj2AuUIZcT4q7voSIvWNpFAbMjaWtK?=
 =?us-ascii?Q?PlNfVCGZChhBFuU/X6BX/tp7SVxK3HKjCaHjDHuT24oZ/CsQhbKKN7Qs7VcK?=
 =?us-ascii?Q?hJW4dbqtHXKS+ssIZbVGeYN54rW8I97/NxlYLxtFhOVLwVSQTc9d1Ahv3gsw?=
 =?us-ascii?Q?1CmlTPV5+5VgzGNJjHE/2B+G58O0atwn1/xQBaaD8tppLl7IWBuwf4K6DQIo?=
 =?us-ascii?Q?fdebY0lwGbODdRiBTRLR0cpDL9x704Dsvw0xh0tOJ6JXB9nc3YpMSWPTerOy?=
 =?us-ascii?Q?n/16P4UPW9SJFFRkpx/6H/HwYSMjGtTHjJGfAQyGB70AB44srKQysJLZoXao?=
 =?us-ascii?Q?dNjPe9qbwAMbwxOtzf9ke6Uk0RpWjke8GbMvmjy1jUdLLkCOcRxLqdt1Ui+3?=
 =?us-ascii?Q?1vGV6BpU2tCQpgKPa3YJvKz7B2gvabarnGGm/WTWn6TtDbX7JIuIoaqhNAWG?=
 =?us-ascii?Q?MlsDtkBw4b2ZCVShP3K5X60YJBi3comDAIcHXoEbwJP9C6mKck27xURq/oZc?=
 =?us-ascii?Q?7PTnTHh919lvlfkWsBv6Ns53MgjNNBgl1mfLt0TJRhUmxnMJ4M1atLmQeb5w?=
 =?us-ascii?Q?4DgHzaLkFz+wtEiQmH/8l1pfUM5esU/qI4kvjFTTmYad7/VPAzRw+yWsu0ky?=
 =?us-ascii?Q?CYWoz4ABDhQcR0SFx77PUuv5UURz7gQA4vlmL0d2TsjDfcF4rFh+nBJLeyGV?=
 =?us-ascii?Q?fdsGoGsUm7++3lSG+SJByomTYfQBVRa855t40osjsAdbDqu0dy9Um9wfwzyt?=
 =?us-ascii?Q?to8Si30s1AXIqMUhNjEfy4im/PLNrRcIyZmsNPVfXh1rvw7Zt+mKxhuiapbQ?=
 =?us-ascii?Q?3NtRbsXlp1WfDrFkNpLzr4BjcNPtsLKMi8n77yTf/oU8kvkXP4ksZkzbsHDZ?=
 =?us-ascii?Q?5tPQJb9n2W73BuSP7H3U9G6Lm7UxzcIFj1sybyP/n/vyw6KIk7VNyGX0e1ze?=
 =?us-ascii?Q?KPnEzX97aBkk8J3dMlTLmovMHJ02IU2lWCx+OAl2+CGIeYgYhRADOG9sub03?=
 =?us-ascii?Q?wh5jVmI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(7416011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/xH6VCPmSD0+1HbcOVU7FQA/3msL1Vr165boIJmU51XUB6zPnPSRQVURxau?=
 =?us-ascii?Q?TeTx8mKFAz7GGVcoXRmh6f0ktLtJCrJjzyiwhh2s3B5EgsbJPdTDeDtqH6QE?=
 =?us-ascii?Q?qwVu8F//Ax/kbRqY7U/7+muJZEdkG2L28B9yUeBbQzH0/rHEpJLwAu9y6/Ev?=
 =?us-ascii?Q?CiISbnwnNzHmr9+N0rD0Vy55hkE+AWPwpc7uQB4VOWWyEuCfxjk5tjM8ZwiN?=
 =?us-ascii?Q?WO9vR0tHVyA422p11lWn01hoJf8OOkoeoDe3XhESOd8oDp1AFE7NdXPRUGJT?=
 =?us-ascii?Q?s5omr8kknCXQwQj6RZuSNu3u0DJ4YngOzZ51VhLp9aVVEKS6W6RExCrM6pqX?=
 =?us-ascii?Q?BiEjFSOY7Akoh1ijz8k8hhCS6Q/vA9J0hXC8sxtekf90gzcybeFixHKY+0vh?=
 =?us-ascii?Q?w8Gp+q7d8QyjJ4tu3DopsbzgUlc5A3PnqXR7Qk7EiGNUYicpoGMfh4kvKk53?=
 =?us-ascii?Q?if6w6GeIDbMJAJsLdtRwSzJGZ4wS2lc4JeOotxFtAi7y0aOcmRq1OkZ5KzBc?=
 =?us-ascii?Q?Kf4Jzk/5GAlDJXp58UM8ToqnzLf0/SnMUnXTwOiPYA3F8IYx3soplTfZVfdu?=
 =?us-ascii?Q?I21fyCkaVw0jufdtiN12t1c1XqgEn2+05v/ea5/3bSr0zoZJ3UkdeHJKAuhZ?=
 =?us-ascii?Q?PJpNOrlcgMd/U3l1ObLbGcMh/5xrilsNzzb0Ni3yzUn8y14BhXsvjMo9WCK0?=
 =?us-ascii?Q?FcU68mmYwgDsiIZf5gTcKFZjqtPDG4z6Blp/PwRS+StzlsD8XIuZDS0K3d0G?=
 =?us-ascii?Q?PdeJ0evIniGlhn4dt3QVrnL/Jtrh6QqwZQOyniXOvBM6a5MmOQ5lFyIRRGzv?=
 =?us-ascii?Q?BZ8RHZDUd4PnC+P6avuNKzMVPg3apy+Yb52swA8aowi8X5f5Zt/2EAKnzCEI?=
 =?us-ascii?Q?8mMwS2CaN1n9Jf3vBIs78n+GGJWLDwPRH9E6u8GFL/8CkQcA+5gRTBi+u/ZQ?=
 =?us-ascii?Q?B1ADYioXkSvIa79DXnxhFL3dO6qtFcVDToWCcXBBowQ+wjL5pInWCNEO1/Dl?=
 =?us-ascii?Q?bKrChW5Q4R/1JsIDwQKAYtfSDs3i+Y4tOpaTlwdYIlwIPwaeccsTP6TnUQXv?=
 =?us-ascii?Q?0DQYeEEiwRzHhYZcTJrsFWPL92tODP+CU/dHm6P4iY7b3q0pq1LgfHk9D5V5?=
 =?us-ascii?Q?DnXsPohXAnxoj+sv0Y/Z2Gh7Sl9InFSTavlmO5V13yONRI3KF0iEdLip9jdv?=
 =?us-ascii?Q?daHGKM9R3gpF82r5NywHqBCyHGSyvN3UAvgh37cWrvdDkf4AGa0RQjhOgv0x?=
 =?us-ascii?Q?xEazKb44PO7HMOg0aDo0vZ+YJwfPQiT6CJpFDgki/YPF3o5tLo+rO9D9m/PM?=
 =?us-ascii?Q?kwQFW3YCuIR43ECC/+zL8AyCZ6TUokcHq9KFIsZjlbCvO5Nx1tFGHbR+SNib?=
 =?us-ascii?Q?hpti7lxIrjJBT+JBw7JuAW4QhwRvf17pZyEoUWXQ0sHWsa8b9AYmr45PxKUE?=
 =?us-ascii?Q?2VZ4+UFolcUrJNJy6H0yUSqxr1uUNdO6kJ3LEdlqwqHUNfIu6YVojtQM1D3S?=
 =?us-ascii?Q?vbIp1uCTWTD7zktskrOHawKvTPE9vFQwCKg+XmCcQipBqduU/nVU466gXRYL?=
 =?us-ascii?Q?X+ZKO26W6gnZWVj2ZGns4LgZpnVhFJUYDZJZram8XXdBrpmp/ekQsjlixA4k?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ba50a-1ef2-4fa4-c3c5-08dc8e9cb33f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:25.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyhubkYcd4JH5D2LzOFI2OoyNqFggKfscppoFO25l/S8k919Qd9hrZ9fF8gi3XHv5eFe2h/sjJgXSvrPwgkF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

Khadas Edge 2 has 2x Type-C port. One just supports PD and
controlled by MCU. The other one supports PD, DP Alt mode and DRD. This
commit adds support for DRD.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..8c0bc675690dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -112,6 +113,18 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};
 
+	vbus5v0_typec: vbus5v0-typec-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus5v0_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc5v0_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_pwren>;
+	};
+
 	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
@@ -224,6 +237,56 @@ regulator-state-mem {
 &i2c2 {
 	status = "okay";
 
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus5v0_typec>;
+		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "source";
+			op-sink-microwatt = <1000000>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			PDO_FIXED(9000, 3000, PDO_FIXED_USB_COMM)
+			PDO_FIXED(12000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+						reg = <0>;
+						usbc0_orien_sw: endpoint {
+						remote-endpoint = <&usbdp_phy0_orientation_switch>;
+					};
+				};
+
+				port@1 {
+						reg = <1>;
+						usbc0_role_sw: endpoint {
+						remote-endpoint = <&dwc3_0_role_switch>;
+					};
+				};
+
+				port@2 {
+						reg = <2>;
+						dp_altmode_mux: endpoint {
+						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
+					};
+				};
+			};
+		};
+	};
+
 	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
@@ -256,6 +319,16 @@ vcc5v0_host_en: vcc5v0-host-en {
 		};
 	};
 
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		typec5v_pwren: typec5v-pwren {
+			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ir-receiver {
 		ir_receiver_pin: ir-receiver-pin {
 			rockchip,pins = <1  RK_PA7  RK_FUNC_GPIO  &pcfg_pull_none>;
@@ -681,6 +754,14 @@ &uart9 {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -707,6 +788,43 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	orientation-switch;
+	mode-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_orientation_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+
+		usbdp_phy0_dp_altmode_mux: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_altmode_mux>;
+		};
+	};
+};
+
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_0_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.34.1


