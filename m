Return-Path: <linux-kernel+bounces-216795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B490A68E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886D41F21C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E118C34A;
	Mon, 17 Jun 2024 07:11:33 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B618C322;
	Mon, 17 Jun 2024 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608293; cv=fail; b=d/19w2T0e7bowVsd7GIy5itB0VRpQlsaq9nbxCBo/51O+SjAdWFQma4UmaZR3VEBaBvOkjVZZW1X0TEWcAegbPsMZEj5RuCD8VL/2PTTiYExre9WgW8tI+dugsS7kr0mFhIT2KKT8B5jkUOK6tH3htdZB3ZqFT8QKNOc204DQrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608293; c=relaxed/simple;
	bh=B5cQ9pxn1ZtqiREgFTmBt/SKvrmctxin+/25JBHo4so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkXgnYABAGMFrLMFD8FHQMbj0I3N8fyhOyAKqcl0EUhnmSmx8Kti7CdZeEu80IooCVrlFkkrj2sULV/JXl+woheNcq7DrEsfJUsfdlCqYDf/0UhGLLQ+YRL/vLZYvftMlK8u+ur6Nvb7bfzbi7BZLJ4oOR/QflsAoujYTIoxkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAEUbcVgRdWu4b4cUEPLyDHeaMVHv+STw9l6Ic1p7+zh9tBzC9dS3hxtRzQQaH/ZOOwwgCf5Igjq28wUQwXEmBBjGLUkS/dZ3lSWbhlzrCUdBFciIPFNH6ns8DB2rVrKODphtGmb0eyld+n2HFREuXfw1yoApztEtBEWDSSo+q2eNrEKenCMcBOAgh2nqTLCYw4GtZPShxa7UQaQfekzyz/nOyVsE9cX6f39TMguIkHOrtJFDrVEP18XpSd8hdX5SFmj5qQ+tzRke1iVYbBEPXTpDumPpNWin8Tl7tGiehQ5SYIigpPJytn0Ig2G1vY3R+ytvvhI21SKPDyJbeHhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lutJzI8NSE3f7AXzCNg/cZwY862kkt0I4yc7Qb9FrSw=;
 b=MnzrZfwKKIivsQGMUtElEu7WShgmyu5eVznkkKGS13spzd+8UgFMuYJIssU3bjKqBBuLD1pbYGKMQidBKtcJpPskNui8X8ew10Qyr8dyCTTrwUusMlVT1cpu7KYRjoGH6yZFAyYFs0R0ZE5kcLhXNQQYa0xgwtAe6jG/fSW69toTSLUk00b41ubw6DpRCMFF6T0QhN5XQTIlnsP1C7uP0pxqx4P5QZ/bjwUn3hY1bNVv9ARxBJrM6cxLS0DWGPCal/3607MiwRsw8SdASFIyAZHYTzIcR0iyb0O+pMjwnFa3lXKVDaC8gShVCMZcwQ7ByZPT9YsXPiZKEkGT7Jgyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:27 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:27 +0000
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
Subject: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge2
Date: Mon, 17 Jun 2024 15:11:09 +0800
Message-Id: <20240617071112.3133101-3-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3692d415-b0a0-4dbc-3994-08dc8e9cb484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|7416011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5U7vuW0pklVJFeBiQi37kV4i/ff19DCfoRN61JyR6zeOudflH3jKlvBlOVTq?=
 =?us-ascii?Q?Hc48PNR6NvvVEywiLB/GAI/5KYUxkVh8SRnW7kHYPrjyvwnkNWkZii/cEQY0?=
 =?us-ascii?Q?39ihoYJwItHKMhVI+n/znxwiFuxhvGuv7DdCDRoG8QKjAqmaDrno5JdqUSVQ?=
 =?us-ascii?Q?dsJOsHEQeVLM5G157c9SX6SeYK++xXP3LmX9K+0IQNHvsHQXJP3MXdDbY8F6?=
 =?us-ascii?Q?2Bvs0DuRonA+tJp0qxQfNCWYeLuj56bG7tTcwsLY6OEfoG7MISmv1PccZAlJ?=
 =?us-ascii?Q?muvNnjzse1ecuMzl9C9zVoDOmgCxQ4xkwdOGmi2xPiUDZVpawhJloWu9z5Kl?=
 =?us-ascii?Q?0KV35cJqOzXlB1ztbGz9u7LaeMmcA0pE+W36VYaPukGoYAZU2gYDI1HqsVRx?=
 =?us-ascii?Q?mxr1CdrfIgzcYxTelZ5tqUUNvfU8LC/TyTI5/F1TdrohIkddRz4/IgfZazWU?=
 =?us-ascii?Q?0hSRHzvJBY1C0hsQ3OVUKKkFJs1a2dAGOrzHt0LkAKEFT6QeWERZiV8LwGsO?=
 =?us-ascii?Q?LJL/QV/Sre4o1iOXaq0dgT1Ol9/amCauFb11+hGN3ZhSZfC3/Nvjo1RYhhCo?=
 =?us-ascii?Q?WXj3FrzNBq/Ywk5Domx5RzxAJZZnx0ZY5mQVDuZg2ff8FoV8a5fx2HIm25OY?=
 =?us-ascii?Q?1xVY0z7tR9LSkBpG98b+Z2PoAVeum5g1t/2pbi0XLQtZXsx9m/xuf9qluN0t?=
 =?us-ascii?Q?paEWgBmyR8Frp7xSmO1B8YG+z6OpDvwanH4mm7BW7HdpBE4OJwDsP48bMSOk?=
 =?us-ascii?Q?DccMzAsurfQH/CqQqiwQuO+LqFl8rdmtwCSQxpuxg4s1SRGCqqWbqh6Ux14m?=
 =?us-ascii?Q?RLIbYQjqRPdpxnj49aKKzOQYQH6FewU8DSDmLqrl2lpWElRsNbs4pCmqJ7kh?=
 =?us-ascii?Q?KzuW0aj2hJJ+EduBp/w7tApTxqMG8uV87n+EMQx558xngozTtsO7/5rlYl12?=
 =?us-ascii?Q?zZVOVWhot8lsDyCLWPEEzQIUuBswzKE85Wl4+DYhaEThQcL+cMdKscgXeur8?=
 =?us-ascii?Q?FAAhEwqnNiL4qywELWD8Tm4FPVgu55wIOy7a5EQ1iw0ow7gKo8lfRqrE3BDT?=
 =?us-ascii?Q?xeZdNmDfPGlniPx1+qNqfknLjjbMKQRuumJSphj102u+9IHGi6LEHJlv91wf?=
 =?us-ascii?Q?8bfMqgK/zvBZQ9/rxwJR8gPF0dMsDFANCTYGpEdzoByDuboaPgZpKU2RwrzI?=
 =?us-ascii?Q?NHCLTwuSwSSPoUAmBhGiXXU0gkP57l7NDsVjXAcL9aw5Ccp/sQ+ZPaLnfHfq?=
 =?us-ascii?Q?9LFhq7tvg2prLQ5ZNvvyE2GxD9Zs8urrVGfQUy5inrtp1VUcfaHjAGlnDIwV?=
 =?us-ascii?Q?GkhNovvQ28SLc/bBzRJuuu2lAEwKuZQmFMnwBB3EXvmRZWfVw4PQ7RGQePOF?=
 =?us-ascii?Q?j58uX84=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(7416011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B4VQTqCVPAHM5c6TUE55ly1DZksslwCTEXLgS76/DgzSjHfrqJTd0zJPIEi8?=
 =?us-ascii?Q?n4Wz6/uW8IDOuwes0NUnO0DZJsLyCWSNuuCMPUp8RDQ0hSYGJbjw0vn3sao/?=
 =?us-ascii?Q?t0N1e0EkJQHfjXInjQI88+GVXOkzv/zxlu/tJfa37GNXWiHAgkwAMi5qqlsZ?=
 =?us-ascii?Q?MghGziKbeq43lDlh5jobO8xz8a1OUg1ZoJQIhoBisqpwJFzC26W5eomwn6Dh?=
 =?us-ascii?Q?mdTSUeHKdZtd+NCs1JMnOzVROYDSxprtJw41mLdfoT7oQOj5ebvEq5CHtD8V?=
 =?us-ascii?Q?MC0f2wsTWd4BtlgRGR24THBobMoV7/mDuGGSXiqEK/8/af5B0noK3ETRZsRk?=
 =?us-ascii?Q?sEtB/SlZo68R0FQyu+QukBFNmgqu9zJWfBcseKzKozeE5IRRQx3X1D4zo10V?=
 =?us-ascii?Q?Ll37iqFfHJ6Jh0dAs613VLpmgniJxU0owGjHo5YGn0/EGyVQ3WkTNfo6bVJF?=
 =?us-ascii?Q?3bpBrKHtWpGkoT7pHb76HF10+IlYkHN9l3lU8UxEsRdSntfK7DplIRoP07+S?=
 =?us-ascii?Q?4Knq4P2l9Pw6QLSPTk04Qo6128x68HOF1Rxhzmxki/Ua6d5w8k2sqi2fWpHL?=
 =?us-ascii?Q?YLLHyswnqvoc+4Lcii3dWvsG3sHoAPG2X+3tsgj+uQkROSM/l8xxARNyfXXx?=
 =?us-ascii?Q?Lh3xQ7ro3GSWiMu6AKmmQhZRjVC7/cjuxLQ6RY+Zez6DGEPb3G8UOhJivwU+?=
 =?us-ascii?Q?xE2eAGZaDpTNLueS4MNKIdGx+e+38U4f8t3jKeMiVkrWCnt9Teugkdm0+Oxh?=
 =?us-ascii?Q?zUKeFwJn8WnuFakiUyjaCysYpxKhc6VZ4fJcxmi1eLmUZ8X2rH2aUDx+WbP7?=
 =?us-ascii?Q?2j+keggFgJtU1nI7RzoDdXpWziTYz5Ricoy7eLZVEBFlGWFfdZS7elRUok68?=
 =?us-ascii?Q?vytxUNpA2F43Gypsr4v17HdEgF/6uWOh3ohatawAU6ADa5qHKgySGViVkCCt?=
 =?us-ascii?Q?clTRvhTqTgUJnTvJ3ZiOLqMccP0soOVowz81hL96SQbvkaWxN+hWeygZ1Poc?=
 =?us-ascii?Q?gi22If2BVqk4vaqr2XJZriebNImzq4DfXccTC3maIi33krAmJiTy5ESxdMOq?=
 =?us-ascii?Q?ZB08CFzzMZVhYJrU3rA5lPHnbpnOROPKudR+9wCyPbc/mXMS4tgQAWNQt4uB?=
 =?us-ascii?Q?HsXJm43hI+J+xRuiMZTn+Z4giRIrF9W5Ca4raQG15pb1jcnMHGQ4mkai8zft?=
 =?us-ascii?Q?oE5sMkG5v1ftmrdKQX26usNID/LxUE0xw/T9dj0UrFlgwOw6WAlFsL84yS5+?=
 =?us-ascii?Q?ioeAjC5Y17xDEAuV9gVpkRprvkSyAZrkwQ1ZEUUSRvCClscYNeR8rdRM2DNS?=
 =?us-ascii?Q?xBYP9f2oAVGEaIVl8CputEzRhygLjw07juuz/9opAHH0MNUGwkvEreURzQ2r?=
 =?us-ascii?Q?aJoiZ+/c7N074RWdXyDGjoIkMNkzcIhTo7kUcMdXtKdqSNP7qe/FGthsh7G0?=
 =?us-ascii?Q?cgiiqdIqriza2MfZ91x4kAkWmNRyra3goSlXq3LJVTAv2xU5T6bixy0DF0TW?=
 =?us-ascii?Q?m5CDYtI9K99ZrHjfgefwvdBlT53naWFSbXcvOHsVCscricdpgd8zmmNs5Y/R?=
 =?us-ascii?Q?mFtG35pZ2Gxx2DcsBdy85d2Tp4QylLJyhb1rTds9PxkIpF00ZrTBIwq13Fha?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3692d415-b0a0-4dbc-3994-08dc8e9cb484
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:27.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fy6Dx0kISR7pJ6bydK1L7RmzRZ/T++SgGwYq24uEWNW9oT8jUEDWvtSrTyO/7ypzSOh5OMQ8GSDZNiG1G8Pl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

Add bluetooth node which managed by rfkill, bluetooth and
wlan controller on Khadas Edge2 was BCM43438. In uart9 add
RTS node in pinctrl.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 8c0bc675690dd..a82f10312eacd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -77,6 +77,14 @@ blue_led: led-2 {
 		};
 	};
 
+	bluetooth-rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-bluetooth";
+		radio-type = "bluetooth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reset_pin>;
+	};
+
 	vcc3v3_pcie_wl: vcc3v3-pcie-wl-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -750,8 +758,15 @@ &uart2 {
 
 &uart9 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reset_pin &bt_wake_host_irq &bt_wake_pin>;
+		shutdown-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &u2phy0 {
-- 
2.34.1


