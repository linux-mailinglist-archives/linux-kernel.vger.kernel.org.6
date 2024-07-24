Return-Path: <linux-kernel+bounces-260903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A193B009
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECA91C21A33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B85156980;
	Wed, 24 Jul 2024 10:59:11 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2091.outbound.protection.outlook.com [40.107.222.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E31BF38;
	Wed, 24 Jul 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818750; cv=fail; b=bb+6ionn1fibUMsd5G1UTC9WZJP6wlBoOqwTiDdmilQMcnNpcE/cS+SvtPpfIpnw0dHZ/o3OqNx5njOde54vMkQ1R8Y6JGdQKgjf2hCBBH3XBHm2T7e/Ca7l1WnDjCEFoGtm8kFB09BTyj5H/kd0aqtx5y/7euU7y9xc9/R+k+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818750; c=relaxed/simple;
	bh=gpJUOfDeggMqPTzDWUE55UibGg71NKyZXIoUwt9MGUg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D+8yU6aAfi5r80eRudcNf9K1ASUO00EStw5J0vPA1GvgbnzFRcZVMpibcui9MhyOfIAUW5QqviuHuXz0O8VHLzijmEno7FZoOgLMBDbiZ/me4BRG94oT5jYl/26SLhYfekPcRwfHbcFKwlVIz7pGGFeOriL43iSzTHMth/m1xKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4oJVCDuErms70/Rjl5G4KvKjXoanJyf76ZddfbHREarxgVUAE7/LAcbEZxqtjGAcjbriESzmDvz5PeBnEA3kmIxZYmW2Bpou7tyWWdZJyqT+eyGLIktu+75+DswkaAm4jB1aGcBv2P2KaaYx84ps38WGozli1whHb8dYJQepRxhMuD2QEwLnLmF3T0J/Tsuf8J91s82NGSGVEdobF4YjUbWYr9BD0KRWcYxc18/UJtd01fBHsgWewufX/mkmx87HSTI/tSNUC1FGrfS63gNIpi/059soHWMxEN229ICN3Rp4eW9/RbQXZPv3lJ2yNox8NvD0Ls6NJG/NJVxBmz/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQOUFVx+CNTGXvadA57ye+DiT3p6Sf0Xo00SZie2Mmo=;
 b=a/caMqG9bwKOlWBT3hAOpE6wIk6lmHpHx2FdBHsKdeHoyuPJUQ0GarG3de0llWZNn+gw09y4Bz45MaYCbtUNadMfj8V0vrq09OcRStaGsu6hnwOWYUi7Pt5ypT0aYwD7tbZW7Kgupp6pitrEsNe3OBF2pD26ZfCy0zcT48tTRFYaNl+O8iB7OcyxauCQPR4l15YfHyIcQl1R6VthMsqf17QK6veDuHJu692OL90v8MgRJO46xNRm/QDRpSqajK6qfFZp7N5nFb5bfZ+e60puoIr6y3jWVEJxoQCeFZeIV69pf0xDHd2evTpF7x5skB0Gpd75n8ss47yR6DiLbdk9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1359.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 10:59:05 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 10:59:05 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: Add Ethernet Support
Date: Wed, 24 Jul 2024 16:28:47 +0530
Message-Id: <20240724105847.46962-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1359:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b2f8af-f803-4b9d-85db-08dcabcfa26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uyXo8s/a6DR4Dj3KpXFta4v3PO1egDlhOmpYP6rFVMBs+kmGxdg3jPxaqO9E?=
 =?us-ascii?Q?uNc3O01cCO/Lx48+8K0nlpjp5B/M9XkRWUAmgSHVaMtMSws/MgK7szro5KCb?=
 =?us-ascii?Q?CFBs3RwuvFOQv+gZoDkLlbl+ZDKze7TuyHjICIQfLGoBJSdvvhx8FxodFyjT?=
 =?us-ascii?Q?ynvN6PlbKquhNii4owZZWZEXkVij7vjXcDFoJvIxDPfOB3ZOtBJhFUTrBB7Q?=
 =?us-ascii?Q?vi1i/Qzl3e49pLDz7HOn2Q/ezqUa+LlQA6zebECKXhSipON/HtONPjk4XzQs?=
 =?us-ascii?Q?e94md8yTakPN7NjswV87NjYHgymyapAWHR3l+vqUTOrtNhgMZfS/kQusrtuk?=
 =?us-ascii?Q?JFg5tpL57RQh903/OPKr3Nj8K6TQsmhHaNYnHzROBg8pbqJKwGgPQLxaic4V?=
 =?us-ascii?Q?yd7pD7W5kIu8JzcvsA0/Aibh2NuHBRW2pR84/YcsS2iNWr5BQKXcse2LsVtc?=
 =?us-ascii?Q?PGF7JOx6WLkURBDB5ZNs89nEF46/ubnfCg4ZMR9mJKRDh6k+9H+XlooVq+7i?=
 =?us-ascii?Q?wcmBggaAH9EcPLRq7oKEGiq+9J/FpRvbwMj8qGys/b2C06QRh8M02aVsxQA6?=
 =?us-ascii?Q?vPd2xJqal+B+cVUV1/bNoCCgRMISJrpoDTI6VRM8dunOhGfkK8MJs5nJ9MM+?=
 =?us-ascii?Q?5p9UZx48I/kn5lKTIsdkvbmf2PxIQSrSttgTNmpXXjFeI7CZwbSXyC8tS93r?=
 =?us-ascii?Q?OE8DJa+NH/+QzCkeFHrkMi5y6az8SnglreVKB+cAafjJkBTQYAG3dVXL5r6h?=
 =?us-ascii?Q?U09rOh8AbEmJY0R7pINgWQS7KieNjtY1vA0W0MwtrTxo2SZQuORn0ghB7kKR?=
 =?us-ascii?Q?w+J/FaVMUCeEjwap/XfMcrfo+nmmzBsNv8EJCY2LbmzCijVV48/XN+1150t+?=
 =?us-ascii?Q?EiE6aAIrpJxO/JXH3bytRHiUUN26bHJveKgQevcCk0BBCjEDSk4eshXlQJoe?=
 =?us-ascii?Q?O7cZ0IZinZTM1MBeFK0d0UzWlVcN4v0K19yMqzjb5Sd0V5FFBSUWA/zTN7Lv?=
 =?us-ascii?Q?pNBeUM18WSFqLGEoehTtIrCPn8H3X+X69W7v3CD9puD5FeeEoW1GqN1Eq78Q?=
 =?us-ascii?Q?Ax3SOKB8GOdj41PlyQmWjv3SXst103pj2YjcKL9CXtgPv96yElBpfPYL0nbX?=
 =?us-ascii?Q?mlNzysQIbFBdvSwse4J9W3YjUK92ZRww79bUoK8EXq3+nVD6FFrHDSJMw/aD?=
 =?us-ascii?Q?n/U7ik1vT7gNSXwwvWR0a3y55vmCZbQlp+bgFrLRgoXsRdm/+3CBxpTtIlBS?=
 =?us-ascii?Q?T1D6qSXf7ZgyYBAeh5dt8gTi/f5lvoimOuzMDJGh3Le24yYWLa0C69Y+4DQl?=
 =?us-ascii?Q?7U5O0/nzUOwXkUKSWhPitq2H/njYrAhg4Cp3z+v3xJE4kll59wdTx7vHCkCb?=
 =?us-ascii?Q?wagztazfh8GEfcG0afqbXPF0tLB07jtWrD20RYG1gI+sm7/YQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CUBYs1ofie50r+pqNJ5cRS224Mk7thK0cp1SqXT9Ne/epmk20vgCQpz5L8Go?=
 =?us-ascii?Q?Pi8i+igpNdiiaHFd/FoaKO9tBGqEQguB4ih4mnuN+5p4gY2QZMbKOlfkFKaJ?=
 =?us-ascii?Q?D3E2ai5cil9xGy6gOfHPB7oPTREQkt37pWX6eNi/XKGnIq5A1T8R1JE5E1ro?=
 =?us-ascii?Q?MPtZiGigkh5sErRL/whWGYR8zz1dWP0HMpwKMDz+Wl6lOe+h+gtPWmX2YZy2?=
 =?us-ascii?Q?NWSbaOjnDTl83X7gbzh0Cpr32PmUjENNvUsbVrBrWtcSh2jopZEbFQcCSELC?=
 =?us-ascii?Q?Gs4CPzF7KnVQOp5wcLQjwGnXzJrbtiIH0KBDdtHudZnfRDNnBWnYnTWpPaQC?=
 =?us-ascii?Q?G9wkF+DYri7dT87GDL2+nvDBPnEWKJHxCz5q90M8sVfYe4SICLc1UdDX0qWx?=
 =?us-ascii?Q?q/6IqAKZTTTeN01aw8bnEcyjjXXKVcnhkD2kAOS6yARNr5YNGcYDHwXRKIZ/?=
 =?us-ascii?Q?CsKEXg2aKiP1dmRDcWZASqmjsvRV9FOMTx6SHG9S0/IGya3m2YnVyTEWcwD5?=
 =?us-ascii?Q?iCaDFsSFxvwKgfcF5gRcMQItIAX09k+fmit9tiLP5s0RZVqYYOm2COLLQBAs?=
 =?us-ascii?Q?VNPYpuR7RVhEm/KPcVl5Zzo7TuLO4gEm2HUjVqAgZUNI3M3tDk5Ulln53X/h?=
 =?us-ascii?Q?A2PVSGRwuihJY/3KJfbzmjCwmHHLqo8BiNhIwgsXUZSnq5rFTnjU+3umdS7V?=
 =?us-ascii?Q?FCm1Gpsz9alZBP1zIEyPA/ych8R+14JVnL+Ddbpq2YuEkpP2UQ1d1hX2fGMu?=
 =?us-ascii?Q?TWoB0xRwzh+tSjP2LMbrBQOMp+6vb+lViPk4xfYUNFeiXoHJq+uRZZXdiE7z?=
 =?us-ascii?Q?SVtt6JXfxgHqfhmlTLbDq36wdkGaoFZ3fZTj0GdzrbHtb5w3T0O0jpIMWBRj?=
 =?us-ascii?Q?1lVNC+paFDWgRV2PB7JnT1GgwlIoZvDZsMeZRXT9SJ9JnG1a2qFzZlguAO2A?=
 =?us-ascii?Q?bK2EQWQ8MCYkpxLHGnQv6YVIanUnTidPhBV42+W/aJaZFtNP/f9MZxkOiFPI?=
 =?us-ascii?Q?5xhL/eHpvr7XkCQ/Bmm4IuKI5kbxUpIafOA08U2KFvlqCXzeaKKrk21AoGB7?=
 =?us-ascii?Q?IZVG9J/Q6yFRktG/71teDzjiVOZm1Bp48ijdznG6wSiy7q24fifT5rLo7KWD?=
 =?us-ascii?Q?9UJeL3zvkr98IR+0vNJVN1pnuTpcGyOQ2x/n50qOpQm2HRn81YNI24TXqdY9?=
 =?us-ascii?Q?5TtV36pZcqw2fucCHwgeuY90HphbT99NZf3LO7Thc6IdfmhZR856uEDWTAc0?=
 =?us-ascii?Q?kPRjjNh1Tt0boEc0B5L1qcsYLSjNJJVUcotFy8eW8NlHqbPaKmJZ+22pUkJj?=
 =?us-ascii?Q?r7SKBEHHfty8Mbs/wif/vqYTRu6bRYX7CtW8466umABQ5CxGgURX3yD5LuTN?=
 =?us-ascii?Q?KsGyuTBFafs3C/2saTwp/THyYqcwmuZQTelJlnxc6YWzg65t4tnv6bBqrl70?=
 =?us-ascii?Q?bGuN+gJH6uVSheAmC05RQFVyIjZZJxrc8RLph7eHWAD4wXnuoYi2A/JFJddz?=
 =?us-ascii?Q?dvVuTKSW18OZy/J7ha6ghqRwSJvwgzTslbWLnGB53wwwjE87Nbtgh5TCXeJD?=
 =?us-ascii?Q?Brw60DtRX2ukI/6ChUKEdh5NW9GFQ1kSqdXAq9bhS0QL/67s4XlN/nFnsfyX?=
 =?us-ascii?Q?EhY7CQoOYkDJlRHJhwnoj4w=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b2f8af-f803-4b9d-85db-08dcabcfa26f
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 10:59:05.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU/wPH08P/c3bstJnwI0BHv43XrAMO6+YuQJ4ItfMi5VP92MRWISA4s0mI4BJxc63Dd5gAn7N/X1if87YHSforZLX/CufO2qXDr653VaB4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1359

Add ethernet support for emtop imx8mm basboard

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 1c4e4d175989..63d391eecbb6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,5 +11,47 @@ / {
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
+			at803x,eee-disabled;
+			at803x,vddio-1p8v;
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


