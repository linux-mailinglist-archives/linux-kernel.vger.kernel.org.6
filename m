Return-Path: <linux-kernel+bounces-226863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63B9144EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1431C2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F105339E;
	Mon, 24 Jun 2024 08:33:20 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7533A8D2;
	Mon, 24 Jun 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217999; cv=fail; b=D1gxh1bgshnHoWrnTTPzDeb41sVBmLsT+ZMl3xPIDBnreHec48Wmbha/v3QLjHxr6VmsuyakXEDnATPJavj1p61Zn7rd1BOrtE+N3slHmuzWmeIeVpJ0he9V+OfcxWYAIpEv25OTqaibnK08Ge4Nm11sbOk3HEiTdkzaaPt/z3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217999; c=relaxed/simple;
	bh=z2JeoswC8UqIHbpm4LHNrkxFhWBI5PUjGHvl+UNYEWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2V5y6jMjVGZETiCFW49uEHSUjimRTiWvlKdz9XFcFgQwUH8iykD6nBbPJkDdIkgmjN2MR2dlbv7PrNZRi/q/QaUn7bo6W6Rcq1CbXA1t1MvULpHqmEvwqx5brxOVDTJK+rNSmuftbyQxyydOOXbNapXLJnHw1+SFCbffAEgBgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4KfHUHKo5Jy0oZpHuAYnx+E8BsbH+pvWTXjAeKBR5puFE1ratnlsXjkuQtBIxIbTKWHvIIoKuHNJq8ObD75VqA4Qejq4Ga8VwUvSdMulfT06Pveesi3S5D74LfLk4A+Z+IKq54GVS+sueQAQWkL6OSkH2XdBhXU/jAepCDpY8WhaXCDWDPY30Q6kuai0/O51L5NzBE6CD4XmNkLArO3VFSo16QohoAtzFVuU7/UoiH0ux6e8UOYKoRiAjy0EYciXTrkMQT22Hj+ljtnhkrX8iPsWHvYAwNYvQY6z6j52ceairP0idQ8VWu8CYHK1cc/ux0YHTJBFSbzjpbLD6RLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cs+62NiCxt1/RmdZwmOWStd630SR26YZav6UdGrOgA=;
 b=ahO65py7XNryGmbf3JL5jCBqQ6DIJoDH/La1SAfqtGqmu0vOuQArKomGwnCyfb5i8Pg1mH5uwWpGEeKUujQgpxfMhC7YwJsqPIym3C/RjP372ssjSNXeIXHTLzF3JR1ALmd2YszvkHOT6b6VsDnzdSRh+YqcSQE4XJnSkBg2PeJzADGyaGrUTxUNM7Loj0tUd4Ha6Dif8Gylpjfk/UN8ES4TVkAqFvmd8uNNvsrEeBYpNM8GY8IR7bXwDlod34E6T+A2fEOF4CsWQrxQMC7dGYSnFTDm4+SOKaLpfoIfcfEW2TisddQiqwKh1vFaRWhOKRB/ElB/dNHj3WSKfHFKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6456.apcprd03.prod.outlook.com (2603:1096:4:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:33:12 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:33:12 +0000
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
Subject: [PATCH v4 1/2] arm64: dts: rockchip: Add USB-C to Khadas Edge 2
Date: Mon, 24 Jun 2024 16:32:35 +0800
Message-Id: <20240624083236.1401673-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624083236.1401673-1-jacobe.zang@wesion.com>
References: <20240624083236.1401673-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e15964-e44c-48ea-2cc2-08dc9428486f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|7416011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZ//jchlZIbuZ5ZW9k/s+YgdXhoWqCNE5L3Ut4i79uHz2oL6pG1Ccv6vKHzU?=
 =?us-ascii?Q?se6fGOR1p1i74adAkfiQARwqRyZvh4K8b63FkMX8A5gEGup+uJ9g7u1ECIik?=
 =?us-ascii?Q?/piSi7OajPfOxEzsIbVPhx31VFRj7F0VntWnqYlxO5JSh/8EgnrRsgkuDTdo?=
 =?us-ascii?Q?NNKf+9Szuuau2kwKRSXd+HMrFINksIoHfoKqWL6Y33OK9W+tV9+FvBcn6Xau?=
 =?us-ascii?Q?bN/+RGS4vEBknohRsgBlv4ELDQZxBU0SrcQuVOk7LeWZTWqyQX2AyOU9FoXr?=
 =?us-ascii?Q?uO0k1RKWGqMR5h0NX13U2BwdKGQ3Edeqs7oDb5gYgK3G1V8aO9EUqdDEIdZ6?=
 =?us-ascii?Q?3MEIlgHUFP2Re+3xiXTSdmL10Xj9PFKehu2zinLW63CgSepek8eX4cSkSiQe?=
 =?us-ascii?Q?1V7l8L7fmkmScfh5M2EELRTH1FvNu18md01NR+rlpR4oD7f7HPX0EfJn/uzB?=
 =?us-ascii?Q?xVsiIyvOlPPJe9Aiw7Uy2xdU6y4p3tjUExiG2hyDaxdhj0IUu/H2vopbWbsX?=
 =?us-ascii?Q?XVyTelf8sSjnO6zDKu1ripAL13Y6Q+mmhg8Pkp8BRJDFOtfNhG4hpWjB46ki?=
 =?us-ascii?Q?rCdePE1Yf+tkJxGqkdrUPpKXF54s0feE7P+wRAe7BKc/4icpg+pFf6gkwp74?=
 =?us-ascii?Q?U5ca4KIhXi41xIWw63kfNs/hpkZ1Yl1m6UjIHkmXBCOib8bDXV9rlhBfj08Y?=
 =?us-ascii?Q?h+Aiw5z1VUPHUZiUo9WFd/LrJ+1lwGfGbQUsrSo8D7YINdTQYqOfrl1dIqMq?=
 =?us-ascii?Q?fHek1r7mRGmI9+ytDCoUpNOO7Rq4Z9NAbPxcmZqAWlr6r6p/X6O5fH/YE5BD?=
 =?us-ascii?Q?G2Yf8Fu71WNbcBpoLhN5YAVSWet0RJuQZ+7Pnp2pzNW1ba6s2BaN5RdOQocl?=
 =?us-ascii?Q?rGOaFnLOSoS2WUVOSMeklOcoo2bZIiKo8hk2pFD451vw6QQkpnUTdE3oe2Zo?=
 =?us-ascii?Q?nEjjQgFAafAH1JLB1uz7XhVfFSLCWph8KXlHq7+wdJxGsj/iUzwPQM7qbpab?=
 =?us-ascii?Q?NH+VpX4HXzbaX5ZbZeyvtJh368pBytsz8/NA63LPU0MZV9UEKgUUxQgSPJHo?=
 =?us-ascii?Q?EL0/fEzhj5+P+fdCQGgbJI8dslwLCO5oI4YaLyMxl46KM40HetFhBa5OVqqX?=
 =?us-ascii?Q?mUA6eVWZ1MUyauoUjOretpx/i4fKJpS/udMDrZoCZcBoKLTi9cBFidhU/9Sk?=
 =?us-ascii?Q?zBG6Z0lSjmvFcI9w2Xtj+OVnE1W+xn6kGTGVTclI14uhKj4MhCUHUzHZ/thu?=
 =?us-ascii?Q?EiZgIN1TGyWZDMSo294CI6iBNZUdK3fdSmHqEy+Z1Leg8PGpXTg5OUBrnsVu?=
 =?us-ascii?Q?3vmLyZiPyS7H0hu6WHihw0xLXGDp2pGHlS957U1zQKKSfOy26DsyNu47te1X?=
 =?us-ascii?Q?TQ85e+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(52116011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rcp4b3VLF18W+YnttuEDovusfggCC8VSQ+Tcv3i6VtW8IOXhhZ27YbtF8M3L?=
 =?us-ascii?Q?wSHJgsSxkJGFzcWgW5QNB4VGdlI8v9i196WYX/WVsMw5HztE/BEl+UHrLhm5?=
 =?us-ascii?Q?H4j+cNYUvxhxDthpeIWhtOamSpBn8l7lp8JTC36IJXwQiuWyp16kvv0kqrM7?=
 =?us-ascii?Q?tJIUaCENZ/9AqO3ZfZDetdxPuMImy6FwwNln/9BCRIH2NZpwcw8HxZEsKDOR?=
 =?us-ascii?Q?5Y7ZTmbYi9tnQyLd06MM6w9LufiTapFeGTozmnothFs7LdCDA0TcL8OLu64j?=
 =?us-ascii?Q?S5sOVNHRqz5usFmNrZIXeA2Qqol1IoBNgtB3nbM4wudcK22nVRjnpTEBXhYe?=
 =?us-ascii?Q?RV7T4HRFhDcW5OlgjCBPFGwEcfTSZXPuYPuYpy9RqYfDbwPdrciGvL8ECvsf?=
 =?us-ascii?Q?1ywO//qEg5nIEP3dKrnyChYNlXdMur4WvsPF48nNXKVhwAksN2prdLJ10ZEQ?=
 =?us-ascii?Q?AkqD5+XL8o4DthvnwGo5vAWj0FtDC1d961T9pVmPjQWlyFEDrAKwG/5BE/ka?=
 =?us-ascii?Q?yACeHqDGoaEwg/Tnes2VuqYN2g+LIuiNjr4tmTRnSmQWLbFVq3WqR0v7PJCF?=
 =?us-ascii?Q?i2Ewf9vj4iqMDcf3KRwB5bPyki+CVEDTOKxy7gRbsZu7HK0P4Pl4FDu1xHYM?=
 =?us-ascii?Q?f6vRrgz6ME7Orycy8I7P2hD+h4MHz0EHuOHjDE1gFn4EvxWYnP8bpQZ7u8f0?=
 =?us-ascii?Q?itOQ8r3BytYCMG0jtr6I8Vn9on7+ssMLIIl/TMqxiNsfov5pyVbDPHB/hG2r?=
 =?us-ascii?Q?uYDjy2brYJl35OEXP3HbV7nhmjcsMZ/CF3A40/p4UNJM4Uyc/BZKeUFosHTX?=
 =?us-ascii?Q?k8N2FrasB2GBAp+UHEG/i3dXwSNWJLOMQZxzsG80IyT0y9NI1hakVYkkxBlw?=
 =?us-ascii?Q?YLRD5t/2m3iQrCqo280cRayrG0AlZm3KoQ0Vlmf43pMkOUzIPsMxvr83iB8C?=
 =?us-ascii?Q?x2PxFAZqFC1DAvzgs9bbsCKPROxHkabMwt7YsdOIvH0Ig2EOAybIz47wutrk?=
 =?us-ascii?Q?m4RM2QLDFf8WTloLvYNng6TCMWbtyXVTs74FYKl2PH72i+fNeDeYEceb//wc?=
 =?us-ascii?Q?0Hk1Isl9F63U0h1WqEl72t36Vvv43blVISaeEBYaEM0cJdwt+XKPb1UFaroC?=
 =?us-ascii?Q?6XYZ287EXcrr3xUKJxIj3ITZo8ekOvOKa0nCP+9EHSUykTHKMnTmvrp4gv1I?=
 =?us-ascii?Q?5oCn1Zyd2RvUdQgsgLSwwCPld1GRk+cZL1+BZB+oRmBm4ay7obnUkVQD+I48?=
 =?us-ascii?Q?HR0Y6aU/cgqAJPeXFaXBXHk/2hLVCWx8VwBexGlw/0NiRv9C+BxmVh8y/Atz?=
 =?us-ascii?Q?9AtAK+gKJIpGaqY9i7h3BjOSOKdV2b6OnDJMV7jbkFcqKzukBLzMJ5lzuwnC?=
 =?us-ascii?Q?q+ICKgNkYZytZY9ubVesE40LM/spkZyRwAljmZe0PzzIZHiWwolpQhkq8ix/?=
 =?us-ascii?Q?MftcvyttPvT4QOVeSkjqSyNlUnSTYCpNo3vCUcpKbLIRYmOEq0xZ8JVV/DjS?=
 =?us-ascii?Q?jXwXldE8L3jaIqnMCqr6PdOKzg4VVnCtmOhsqJdFH7Iyei2cCwPOmluWibJJ?=
 =?us-ascii?Q?Xe9Qs7SSOrxcU5ClBUK3pCxx6C2KtPayefefZiUO?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e15964-e44c-48ea-2cc2-08dc9428486f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:33:11.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFQjGaAR+kxcuqN74GqzH20zrxYs/5GM6RGQauAfJkqEcjVTl0+BVyJAae8zEUcNrYSHqY5/qhsdssYEffRFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6456

Khadas Edge 2 has 2x Type-C port. One just supports PD and
controlled by MCU. The other one supports PD, DP Alt mode and DRD. This
commit adds support for DRD.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
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


