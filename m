Return-Path: <linux-kernel+bounces-216661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6790A2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10DC1C20D58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DB417B50F;
	Mon, 17 Jun 2024 03:06:25 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF446FE07;
	Mon, 17 Jun 2024 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593584; cv=fail; b=Bx5a4IFAuKGs+GbQvYzUSDleD+heZV+XRPd0mK1BUC9/IUGFgb9Ll87GObNaCX5Uxqf+ApWdNRMagc/jgNBiSHsUwAlkqCuPPMPLb4XRvL/BXLCKa7mGrCwUc3OeveIJultLaWJhDyeVwYzOiishZ/FveEMkSvcy8vT1dCn2dR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593584; c=relaxed/simple;
	bh=2B7efntsyeda9W2MkaZiK3MAQzKEiEXqI/5Ead1C2XY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anx8BrrPVxvSzVWGrqn4U2f4iOruY7Wa+BAGPvd3d6jguGZovI7xnxdIkdJqzEGI7kSB9KabG88yZ3S6oNwmMY/Ej6xkx99c9z0BqtDLftEd8a28j153cHbREVjoKw+kkCc3RHppiotkZ3FUb95rzWEnGawzTq2YOSXVg37KQvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhDrpHhjAu/fW8GCBAqAd06EhID3P99bxlaxYkXK1DlEx+qKv2WDMpsa5Cw0jHNE2D6CHM/emySuajgc18nrNKDA2Hg+CgDKUrkUnhXdRWe0SUyIBPJJQ+l0ICduwkEU/JkYP6QFD82nxPcAu/6/RqJDpjGz8FTGNGotfyTCR09xR8RbhusUjyAwx4OdYnRPX55d4L9CJ6JU07X8v9wuKNF5sifTM0ZzwWUv/xAeL5ulR3Pw5bLtO2pkSvq2T/vash86/Zsf1B/+6eCtnTN9ZUw2H4LhZBQFjFCnLRBtx4sAWJgfTyt2RDfEmcDA0sRMYdKqameVxOTmy10nImVKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yiCrwYIMLTop9ycb1PwgryiANIVb67Q//bAgDliMYU=;
 b=Wj1gT5KYsBTfsNg/ThkTv90TxtGxNMZCO753QLfw1aPf2dd0v7tzWF3B7QtGib67asnFggE0Hkp2aQMMz57IkWFyObh08gDmwz3cnAPvX+gWb7Ki+FY758p5QoahbtdEEXA8Cz59DWwiNOOA3Q0uuXl7VZOMDDzD4G5Ln69BKlb8QC/LrtPH6DoWxdUM5nijogF0WpXo7WNZXYCPPKKVeelTauxp1Uv/BLrEjFMijtiqzMrqc7M8TELGXRZ1oc4MFIy+jdzh2EatNaGMG0U6Or9QB6sFiy387xbm6fRnS7X32OUeNi7HntIFg931BKUUAPLPUqOa5+I/aYdBx8+gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:06:20 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:06:19 +0000
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
Subject: [PATCH v1 1/5] arm64: dts: rockchip: Add USB-C to Khadas Edge 2
Date: Mon, 17 Jun 2024 11:05:33 +0800
Message-Id: <20240617030537.3112356-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617030537.3112356-1-jacobe.zang@wesion.com>
References: <20240617030537.3112356-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2c6bf2-0793-4461-b5b5-08dc8e7a760d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PfH1s6Lbd+EEufZYsXj7J3GaEVIRcpV5PeRYuYaOaRscJj52W0T+QiuDWdvU?=
 =?us-ascii?Q?TTonQcMof1dIGfy4iyKGAbPnSBycZoxdm96BKeD0Rhvk2L8qqZq9touDGl/z?=
 =?us-ascii?Q?S48L1U+fstkzy+UEsm+PNl/flIZ2+jWNfllo0aIbUl2p8x5gq5ULgeEChtHg?=
 =?us-ascii?Q?mrQqGOpEQRKwud+4acLn4POui461XXtPxxBbs74APMPewedz8Go3Kbzo+7ZK?=
 =?us-ascii?Q?rAh+utfqsU5VacI400myj4XqSb3c1OfyFkNKJiWcpkc9K/7z88LkPPmqITl3?=
 =?us-ascii?Q?WkHdVl9nokdI4rJ6Xzj5+np91wMqwpPVN4BiSB/0TszaRk3EGjhAqaAjPqpO?=
 =?us-ascii?Q?QefO17gjtdlhJbzcxxPRi3RWqEsVS6NEeaBwBWLyjVRWb4YTKREPVO8LBcK+?=
 =?us-ascii?Q?T7S0FLWztoWS8W2DP2Nh67dVCtzFggHuUt6dSlP6uS8COXaPM+wLiXWCOdwi?=
 =?us-ascii?Q?EA7jsjayfkqNzKCgu+cbmRrSr8whtWrkFxO7a1r1F9sBHRmYQGO2KKQUgVGS?=
 =?us-ascii?Q?ITeV+bUqjpX+UxtTO5S9VMN/3QbQ8TLXKrcfsWr0vesFYH3rzW9DFj/HZE15?=
 =?us-ascii?Q?9ZZhe+pIyXRPKZP5GJPjPrgaONmc7UA+c1l8+6QBpMIJkfSzZ8GRQBX4eUt9?=
 =?us-ascii?Q?xgPWBw80ObafcvKpkjVEHwP2lPxYG5Xmik7+H7FXOnB4G8barqtQORoLS1Mj?=
 =?us-ascii?Q?VJXr1wnRrk+cgQDEh9TfSBfvuku8PAMoNafDK8HBJbGHulB8Ty2PG5uNdCkU?=
 =?us-ascii?Q?95UolGhWELZx6lhoZIdeEuSCrcOt7uApyUN+FnRcpzgEQFf5+TIs0/dmKjvd?=
 =?us-ascii?Q?dnQ+NuRJwD7y+JBNUenph4SvQUq86M7uVFbHUwxZ7Se8pfCZME2kMH1w/m0R?=
 =?us-ascii?Q?V07vr66xuNClHwCORaFYwl6F0OkfVovs36+85AAFS/Pc1KuXs/3uFAczgLwu?=
 =?us-ascii?Q?XG2M3vU83jRcW1Si9HaCmNvwIQv+eRGQ/YfX3KoHCDDbMAoPsz4tRXIJ8/W2?=
 =?us-ascii?Q?LAHhsVZe69NCXKnnRHjVj0jQJK3JyUMrGIddTWGEbOwhClIJUnAG4Em+Z+C2?=
 =?us-ascii?Q?u1KLWpWLHoQEqMcADUOrc7Bc2EPicZb+rK7hUWkR/6AT+HX58T5Vw4NKGdVt?=
 =?us-ascii?Q?HBW9S3eoFcgRvBs/fFIwbF2nfottmzlVoG99MfyEps+1/asEJ0AlfziNAfet?=
 =?us-ascii?Q?Ydel/dOYHpSgzTRf60757VBXmZGKxQt4PjZN0ApeEuh2Lctl/dMG6lkPIf3k?=
 =?us-ascii?Q?V5DhOjPkQSZKXKSSIjTS2Yc64MD6WsORzeww1vZuuZDDjI/7Y3rMgdcOrtBc?=
 =?us-ascii?Q?/BJZOM77YXnd/FUSP5eEfftub298XaDv1WNhT1fhf4qDef7qELnX8S/vox7I?=
 =?us-ascii?Q?b0gV5e0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XlONDDOYrwFRtZSw+SVVc4ruvo4c+nTnbvJkfDU2yLbYp155OFzlr4XuoLS?=
 =?us-ascii?Q?dS6jLnwVEr6zjj/E/Ia7vm6cJ/g++bE/1u/UOi0nzD8h+5tXu2E7Tdut/M24?=
 =?us-ascii?Q?yh/0kM9cEvbRQde+BTyX3UVeiVRyKRb7Um8mBnge6TD/wMFJw/qPGW2okq+p?=
 =?us-ascii?Q?D5hWUlq2SOPe8eZl7Ykc6K1rersG7HFq1YKivXxZ/xIiK/BguBAtSMDb9ymm?=
 =?us-ascii?Q?Y/128oLRuelz16xLeYHGS9jxAsze+JPGaSfwE87LVZ8Lxl6yBw74Ttku92+0?=
 =?us-ascii?Q?l4d+AVMZlg22T/eRlMSG1q+VX3lsK/eUuDx69J57bqjMQ50dgn4zEds+g8O7?=
 =?us-ascii?Q?Yr2pvg+yB/6xrTMneyCE3EdfkKDgAgsBSc/QnjkWEeAXOEWF423b6clwPkKL?=
 =?us-ascii?Q?zYIPseSNsv8QcOj87YtO3yn4z1VkLn8ha5FIWoTH9Ed9WQdxRHAwKX2p8enj?=
 =?us-ascii?Q?9+lohLLREw45XeNAQ/Bj/Bz5KHPF//t1rGEuOOYPRZng4yjJ+I7MBpXvobV1?=
 =?us-ascii?Q?2y2HDQTGsuld/qieK3bHUg2OuouASxxx1C0CxgV1+0Ga+MC9lO24BRRmDsaR?=
 =?us-ascii?Q?G25CgWxdDQrIreB7vdTY0g1Fmh/Q/mFcDQh9yZt1Yz2QZTTORzICN0dDmqRf?=
 =?us-ascii?Q?fYxlAEohOeJCTdK47m96X2C7z7ok/0+hybFo0c+9NhQt5Qw9SP10y6KU8ytN?=
 =?us-ascii?Q?yZtK+/OD6ILXpnhqmjX+74ir2tC0if1r9OYV47L/slWHPjmWGli3RPWhee3x?=
 =?us-ascii?Q?xDmf97zRlXbnAXot9SUKNBsJC2wTsIxC12Xq+eHO/dOJHWeQ6OVqSxpRvwhr?=
 =?us-ascii?Q?w3lnuFowBsprjTrNr59Yupb0EEF1g9DG1dSzwhYzSQoZmGW8iJ+UwOJqGXIr?=
 =?us-ascii?Q?ee9fkA4EwQLsrLOo8TCKzPX4K/bJVXhX+c2TkS5bQgF4tTHa7BN7FPtPrYhR?=
 =?us-ascii?Q?HgoS8PR88+e6L4oqLA4dP8g5na3Ek0A7AMT1bAok8tHl8FIh7mdZA67L1UTi?=
 =?us-ascii?Q?XW3O6QOcVUPYa3CKopD0pDB1OdkUcMRcS1mdZ4NROvgjjrVxZnLHTwtMcAXI?=
 =?us-ascii?Q?Fl+ElF7mKNljFAwlVOIzDxOe4JGIqObaCdKWiFDwRBSWj3nQYyKuf8qLazae?=
 =?us-ascii?Q?sO3GZm9DLYxtaVu+pxZc54UehvKP/97YswEwfKwIw58vA0GKKyS00WbVvRpy?=
 =?us-ascii?Q?vUJlzdHYPDupppwXF6yqJQkeM9YWFfoe+2rfG/P19detpmEEqV6zVGu2wABN?=
 =?us-ascii?Q?NHkik2u4jeext1f3AdkAtDbB09Z30Glp5Teq33wDv/h9yna5DdGQcqv7f7GV?=
 =?us-ascii?Q?3gqFmY1lD3fVuLs9Qa2+ntkEx5hkoxNWDQ0V/j969OP9p9PSuWnGEbyb9aHm?=
 =?us-ascii?Q?PzYubHXw9b2FrHPmsR7wgFI93RmUM/ulhqm14pUXfTLS8S9ssIvtDff9iK3v?=
 =?us-ascii?Q?1+O7kFmt2h0jUCRRzLrijiHnW2NtrZj4FMXJB43RvF1PrmhsgLOsItKzjnp3?=
 =?us-ascii?Q?dE5YnhUaXfoDqW7pDHOhRO310v1wbuD5/r2sU8An2VpDIjbP2G11SrMh2mZH?=
 =?us-ascii?Q?Zl/f9oZiHLgu2LG3E/dyKXai9kIF42muEWArG/Y/5cQuueCQDfNB4mP5685J?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c6bf2-0793-4461-b5b5-08dc8e7a760d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:06:19.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGo6Fvijti6KTj4Y7um1s3vhHD0IOwrhlYBIYzEZD9a0JZjRaNji1M/2ZXLdOVJX5CCs8aNGCfrKLKO00a1U0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

Khadas Edge 2 has 2x Type-C port. One just supports PD and
controlled by MCU. The other one supports PD, DP Alt mode and DRD. This
commit adds support for DRD.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..9c2678905d236 100644
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
+		reg = <0>;
+		remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.34.1


