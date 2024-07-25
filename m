Return-Path: <linux-kernel+bounces-262178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647893C1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399251C209F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D5199E9A;
	Thu, 25 Jul 2024 12:25:53 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2123.outbound.protection.outlook.com [40.107.222.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803114277;
	Thu, 25 Jul 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910353; cv=fail; b=XqJ55+SBA3RVK8tSTIId/1y3Sb0HJOqawnxo1P/TRzfK5CbC0ZFZ/pM1Ld3zq4USdGikM3g255Bhj1Rk4rDD2tq2Nj+1ru0tZpICzVKG71uMqQ/REWYW9r7+7MzV8j59BtgDV48MIxBMrNc3fjXS0ozPkZjGoHwXIO8S2VZQA/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910353; c=relaxed/simple;
	bh=uRKWtujoR2bq37CVVxo3b9xLRxUuAwPnntO8wvmXpRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fd1FrtSd58vfPG6mTgMcilBYRqyosuruWJ87o7bmykAs8x/ZzDbVsBPdlaGOXHjoNSCeNIp3UMZvKK9siZLcypZ9hoQszqs7BkNbUM8IphRyAxvsEiGDvDCQCUftiCRzHkmqN/jn5TwvdGdM7PqJBG18DHb97j7LRQNcYMVjqRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlXQDCExAkWIJ4V0D2Eqsz2AH/ZY2LDxESlFCegabD+vPTqmYpQp7cKkVP+dkUqb1BPQOjZJ7Tqar+rQlTUx6EhlZ+9at4AhTEYhS7RRgJHu9wRFEtvPcVzbfNgmckOYHWqAWSHXBkrbsvK/EjlrW/vEznU0Y+8G14ZqRNLLfyF3QtNr+vPGhDcDrKHbXxnQzonUuRsYyrP8iS3zBLVFaBTjo3Q8yMwq+K0XD2kioZB7e/Q36nu4Rb7hBj3K+rNFo6f6SmG3sDUm48XRwjmcwn6V8Tw8Bk7JH/uZGbvVrQ9JgHN+DbBT9DXFRrYk60OducV1+cDBWTWRzXgM83/83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcZ6WnWBXWfNxv4vcdHHGVx2N4QYjuRhPmKOkS7PJ7Q=;
 b=ae1oyMmquuxuunrtanZqcrXTxg4limX0YHNXy1k1rRyTz7r8zZWKICNNUtp+rgxnsnz+QnQdU96dIaG2F387Mis1nzDRj4auQAg2Ml20x0MSB349qPNccTZyj92z81M8p9UzzsudQK1E5OfmM1QzcjDA5593U46utiI80uDcv75KWmtnNEs15nd0QCAeuYIDu2fQJy/iY5lbGIOd28MUjC2z5g8B9BDGw42Cyd0CVTjxgJQgcBTFquCXTXA+hopM1gkGKTegzslXmQ7OLqxvJTuDME6j4ETiOZx84Rp6UpOr+il9Q+Rvm5hi5PuOHA8B0uwyzBgVmbwJ9NJiAKAVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB0446.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 12:25:47 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 12:25:47 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: krzk+dt@kernel.org,
	shawnguo@kernel.org,
	festevam@gmail.com
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet Support
Date: Thu, 25 Jul 2024 17:55:22 +0530
Message-Id: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::36) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN0P287MB0446:EE_
X-MS-Office365-Filtering-Correlation-Id: dd117632-8b51-4d71-5ef0-08dcaca4e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONpircWNG5WdMb4tgt2FSIkpjmLcc3GWgJkj4ZVPKRYtPCDoIAjFak9epaVc?=
 =?us-ascii?Q?G/2+v/mS2CsSgj8O+cm5K0snf+YOLctfFQNDi3j3D88II9cKZBbgOUAYCoRh?=
 =?us-ascii?Q?TNqkn+IC/CZvOx83jzu72EWDqFCCrhvhcApY/6RLboWz5O32pnRsNoqFyivM?=
 =?us-ascii?Q?8J3dVS/wYX2y1MYe4S2HlB+YlDJwb5qyRG8SGHTbJMB9Eiux7dPYQRglwBg2?=
 =?us-ascii?Q?tir9l80kmHt8GhwLwyo5e0u2gKdthIwGSHWmNteS0PVd0vw40o38NDZ3feoN?=
 =?us-ascii?Q?8b6sIw0s5L3PcNlzT1jqvceRC+rCXjwfcP3Ljf+4OkPcqJVHgkgQptHdX+zV?=
 =?us-ascii?Q?HeMSxVSavJOmoueRLhU/h7qMcrTbtV6hYlUUAq/oXmqCnn6g83jLS8wkV/qF?=
 =?us-ascii?Q?FeG0m+g1Bpp5B1hmFG2dD+8lmioQijsuDc7pDdOgQmFCBiLvd3icN+jPgFPE?=
 =?us-ascii?Q?442bsWp3o1DenZwneVfKS1ozCN9/u8uxkBSCo3pQG9xCgSiXHpsuQ+vOpGjl?=
 =?us-ascii?Q?TYI4YaQtkrbwBrJOvil/aSGuRbtiH3SJmhvB6HVupBn5i2kcFikmY/xz2B/Q?=
 =?us-ascii?Q?YW97YziY8BiWSfH6yGsLXFCg+9fj4CSJNNQfjZHAKn/uHIcovXVlU3RV8cuZ?=
 =?us-ascii?Q?kRk9HYhFhbJn1c4yo3Abtb4YCTRUqcao8u6DCxnBSSeHuiQVXyzlesO0Kl3J?=
 =?us-ascii?Q?AHNSLrov6t6ITUQqGXatlft7ceyZuKl30sZTm30rUjZ11yz+5ohd2ug74QBU?=
 =?us-ascii?Q?3MZtgbO47uAj+MDGvxnndFITHPcwCrZAqJxTEBpp7sQYwTSRbJi9tcE/XGfV?=
 =?us-ascii?Q?XM8KSqMrYK1ZJIVDNSlCJMOH+VCTR7CGKnZddzDX3A3OcKP5paplIrEQFtB5?=
 =?us-ascii?Q?uPLWTkcvQRuInsXbxPYcu/O8Q36WHu6HUF7WSi656cv0yPUlP3Oyc8EQy8AC?=
 =?us-ascii?Q?2X6VOcl+AnwGdEGksOh0Zqy7OuoxcEloMwPB8n6Ma6FceIM+qBvZs9FNkggu?=
 =?us-ascii?Q?L/9uf5ucaJhwNktSv6jYYsmYTWZk7idsDvPSvE+X6x+herEnliLcPi+jU5Ym?=
 =?us-ascii?Q?F7e1gXCXiXTP62Oios0FuuhcwuOKO/9VFVJenlb2kkLtRL++fRsxa4xWeR9y?=
 =?us-ascii?Q?YsUMGKByLffwda9ynfH1D4UPbi2i7vgxlz3tL71U9UuE49lDeI8jcpi4/u4X?=
 =?us-ascii?Q?HCesf9Wt1ZifrkJb+a+6gU/rwQXf5ZqM3O6xhpMs0Lbvf9De4PoiRTRJ08Yt?=
 =?us-ascii?Q?kN5+yiSJuqFJL7+xmZ2mJsqYu2dLdBcwWT4+HRtMzx3wv8gsdNwuBsQf/y0o?=
 =?us-ascii?Q?3g7+eJlPpuUxoEFN6T+/mq5dXSguW0P8zfhLR9mo3PUZoiQxCjBjpBR/T/q2?=
 =?us-ascii?Q?gV8dbU5Jih5ZxncCvyKRdDd0ZsqQfXdeIM2WqrjH8eqe2sHNeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhPxex+MSKHJIDNNP9wW0syNC46S8w00zqhu4yhqyzb0nC1CfLVvEdzMLbaA?=
 =?us-ascii?Q?3q4MqWxWqgvayxtezC0ZqYJxcI8mg/CGuVm4LRaph8Z5oVgdliydweo2lKkt?=
 =?us-ascii?Q?JN/kWiNgsTcL8c/PxCbePSHYZTFB3yx90q3nZKwArL9E6Cx9RO/WxAHJOt3P?=
 =?us-ascii?Q?lRONpRSFR4CTPiAS07xdgKMOSJ5dc/6BESXTHxBxj+lpdMLEDXAEknKf0smv?=
 =?us-ascii?Q?vCCqv2NkhOGthyicIz2kxpngbqR+7XXye7nm8b5Xbs/Q3QhV1JWUh6syYMEL?=
 =?us-ascii?Q?hbDWdw4SjEvgfLZREMdC2ROj4t5gr0rkglfErbz7BD2dNghn6hBkpqil0fKW?=
 =?us-ascii?Q?ExIolXyPAgeaeezypczC04ezzha+5WAiEJ3k1abrQJmY3TLX6cypY4art4ce?=
 =?us-ascii?Q?G3qY/97FZuk3vLHi2Hr/g9xrQPnuOvSy0ysYRsj84eReCLUCAXc0NONNFK8n?=
 =?us-ascii?Q?3C9B0h5dQzJDSST5dvQfVtzAVa1+p9SuWKiM+TqefhvjKonjWAooV0xNXdAo?=
 =?us-ascii?Q?wdWBgNX1Joy2mwUxtY8a25k2ypuWZe8tRs/tINAUOWYJyRsXQh0vrFLpsHFA?=
 =?us-ascii?Q?KYRLZoFJuL03qbaZAyTP6HqLnzdc8QsRz+FriXo9nXk+wX54PAoQhh9CSjjf?=
 =?us-ascii?Q?S9OOrWp20TALZSuML/zHFZgI4gsY042TG9M0zOYoiohbmWO/2EtmyG2v07j+?=
 =?us-ascii?Q?vgm+ozmSQ6kG3YrNq6q2NxbFcSGADAcCVurGci0RViaVT99NDvH/qI8iy7x1?=
 =?us-ascii?Q?jV5Sne0Px3pppe69GRL2loqR1+v8FkZe75sFqCxM0uFEPQqYMEBznBYoUouP?=
 =?us-ascii?Q?3b8zO4+5eRGh4I5nDjn/D2EaTPYGvKGUDzOyxz9oj6eaTSOn5VdoK+619pVm?=
 =?us-ascii?Q?y3i+ZG7xUrGfKW7xARSvnZt1UIGWEBc8kiPPfttPEFXiuuVAlSGDYED6yGjo?=
 =?us-ascii?Q?ho1aUNj012IRmHyBhXg6jCORzRcJ5HGYA2QQG3pslMvJ8dxQL2Y5nGj7ERTn?=
 =?us-ascii?Q?X2zoM4N4MjZs6uC1tWtAW/t2BR7Wd08H1ySCRRX4clGtFT6gDdatzDCAMVZy?=
 =?us-ascii?Q?jE1uIDXikx/KjVdrIPjqT9r/l5ExHIlfifdX+xqUUvIKJHKdmA1gW7ZmH2T5?=
 =?us-ascii?Q?+EqxDoDmkblthteyxCqmd9BrsTN9YkkNJrJHjiWKEmtp2rE9PDaeu6mnyUSE?=
 =?us-ascii?Q?HjuVjCZ+o3ygrV/El+MeLLs7fS9FMJQOMXbxjtUTGSxau9VsrgwqlQEXD6rc?=
 =?us-ascii?Q?xj8NQBfhRyC2qOmI/WPdJI6K2jlowk4dli8H25cJrdjpX6gxRIh9DJ1De/jH?=
 =?us-ascii?Q?yOefkQbFSRlcnyZBDuDNIGbNpvmrtIsnmy1f5UJPHih1X45DyivWrtU/33LN?=
 =?us-ascii?Q?zj1UL+YvC4bfrdbODuFt8eiGeHnTvCsiHTazdc2AH3Fk2j23aQ5EF19T0viV?=
 =?us-ascii?Q?/QBWWhV0hwABvRSW2sl5pZafUiKisRWPDFhx92zqNRNnBhCFcTVPVT+GtZxx?=
 =?us-ascii?Q?ceXW+aT+wzG5EDkVsL+MNWwvwsVWG/uZBZhz+S7accD1LCuTFJtMCkxx2gG3?=
 =?us-ascii?Q?BGSPi+enT0Vz8q/+mwXcQFeWe3Zv2NPcJY1sNPrBpTeLvW2HbtipJDaM5wm5?=
 =?us-ascii?Q?lZ7pOkmpfgHSKKIgid/BJ5U=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: dd117632-8b51-4d71-5ef0-08dcaca4e96f
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 12:25:47.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf9G2glYeixCjRehNld52h+FkgKG+FnUqUWL1ntBiTdkH5YBteKkzNxftgj5Y4ZAJBjILpHtaLpBjm4K1YpCFrrbTf1UvNOPQlKhDCm+5tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0446

Add ethernet support for emtop imx8mm basboard

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
Change in V3

	1. Add appropriate commit
	2. Add Changelog at correct place

Change in V2

        1. Add Board name into subject
        2. Remove below properties
        - at803x,eee-disabled;
        - at803x,vddio-1p8v;
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 1c4e4d175989..7d2cb74c64ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,5 +11,53 @@ / {
 	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
 	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
 		"fsl,imx8mm";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@4 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			vddio-supply = <&vddio>;
+
+			vddio: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
 
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
+			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
+		>;
+	};
 };
-- 
2.34.1


