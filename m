Return-Path: <linux-kernel+bounces-312596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CA969893
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C540EB240D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E31A3AA3;
	Tue,  3 Sep 2024 09:18:13 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2139.outbound.protection.outlook.com [40.107.222.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759919F40E;
	Tue,  3 Sep 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355092; cv=fail; b=T82zbK2TMpEr/iUdh5G2HBN8Q54+XEOVVfA8sUjenw8mcUFBvAvb827SC31FbOt10TJp+xp13H1szFYQok09RuhuvH3pRzijVvAKbeXrgQ3oSvXK3JTDamevv+BvSSQITgWdNQ9tD55qsXqYUMIZbc3jqcGfRURxLDoONYafyGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355092; c=relaxed/simple;
	bh=Nqj09biMnlEYZ3UUn/m27shV+LxwAHKGupjroKn8+jg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AzeeoBXGuj9nnyhKmnTupmTrBz0gXrvCx/Zmj5/7bCwevP45N80bvI0lOCzGYY6dA6DBzal5gKZ84KIgvWyXx5TFbqtIVio4jFizbXI5hA5wbrrNiYhL03pZU9ezhPtq4AKXSYBpHZVQrNI6Hz8l4Uwpo8ET9vsePPPmNPLuBjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr7Jy29av1vjKM2qYP9K1J4/Ke8pd/M92JoKNykpDLM2xItNvfVFaHSKJWDAydaHILK0mOjLJIndvDxpMbABJlbyn71d2YYgIxfZklP/C72BrM9t8Bm+Qt0HFP5xIfbB0B80U1qfAyE1yrO+Ww4WZ2/0bpvbIcI67oB/jEpRk4+Z9QW6e4kJcqoNevwj+E8kqj4YK1DG1US3xxy159KPLyHclpMbYzBQ05PniZ6GWwDqsGcPCsSBiwQomfGRK+TsOSawSFKOsaPRoZjI1ftUm7q635XfHg2eMrwZUzUcK4xh+796JvaF97jDgthS56Y6tkLG1sgrjo11clvUkpe0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgdToGaJMx3pnYXYJ2cbKbotkV/v5N6tFCU6zXniFTk=;
 b=Wr4Oyy61d3P1ybSPGvSjOQCH/JG4VNicipJoNiQm8tVyU7Hske8Lv8QH4HuuRybDPqACoOHgdmMV1Fb1UTRqXC7oi0Ebe2DlTa5ssch6Z8Wqiy1NtFxJT5XETsdVnOWMtI3YKV9XD/OgfC+vTQi8Pma2jyKc0rDw87CLWJ9dv4fi1vzMnaFZmG3lJH71Ihbhtq39OgwvPsI0pG0hjxKP5EjgaWEfa3JR7aPYbWwsV/tz9h+0eQLvORBqqI1w66sw4yEpUwkhgUpVKhZeKIkL4QV3sTKi0drk0kn5IRhRV8aEig6fD6Sr/LG+v0AgJjrcjpTIf0jSSdFK5zWVNFsxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1674.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:18:07 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 09:18:07 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Tue,  3 Sep 2024 14:47:20 +0530
Message-Id: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1674:EE_
X-MS-Office365-Filtering-Correlation-Id: f03294bf-d6a5-417f-d002-08dccbf95276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++wi+QkLaJBWt5NBrUAUp0PnVsRCreOgfIsws2KQk+T27b8uVh/eMzkSZIAd?=
 =?us-ascii?Q?TPupoKbRks5m0qYowHbcrJc+Dk8AU0YqmN0Wm7sKzZF3nr+9e58mXnpwZaVi?=
 =?us-ascii?Q?PEJuz2UNr+e797FkuLY2xNr2YgnypnvyAOSURLHxvTzgKQfa+AaTvD8ZGUVG?=
 =?us-ascii?Q?ax0h9hJH0OCBpuRuS9trVL8yFPs6y0R3qTZcjsw+J/B/mNxCDZW+3kLcTzDa?=
 =?us-ascii?Q?oLvpbTOVn/9a5oI8D+SCiwpM1VaWA4mPEUjvLNKTILrfJ75Hise3hYjQiNTR?=
 =?us-ascii?Q?Q5e8QGf89PENR+UR029JV0n9CICxqB3WcW/L6x6k/VG2FJBjHpAdimu6gGgC?=
 =?us-ascii?Q?9ra24+F3Qs1M7WudQG7uJDNS6uFzHAll0wEMkTuMkVreaVxQnslTCdYedJVe?=
 =?us-ascii?Q?P4LWbM89edpuZccqvPxFxXTvOZnGL/TCdaQ28NDgcN2uaZ3waLB4MAhtxuiZ?=
 =?us-ascii?Q?w3BIqA5TiUuykMnSNveM6l1eQLDpFmLRuaZNJ+C2UPQe5rHHk8elXeYIVUmx?=
 =?us-ascii?Q?XsbQ1TVsZ4I8M4wTLaFrGuXWxwSwhRm5FSVCmWwr2pHsqctw9kaaTw4RyVG0?=
 =?us-ascii?Q?CtpUCaCnstOq2NyR44H7ITfkK/gxb5dodb5Z5UxrOQfUuDJDIgLql2vZjf6P?=
 =?us-ascii?Q?gd2AFkCmMuZADBD60sskqc80q4Wjhv0sSs1vxKrpyB1E9H+qp9vijHpYRbxR?=
 =?us-ascii?Q?bcLaJ7bfMskowJl3aSt2YApZnq8dEcH0UmCw1EWrO2+b6fx5ztqkBQdAkGWl?=
 =?us-ascii?Q?EBFlD5VebfCdImc+2J3UMlCfs5EIj/wu/ZbIkjt14Fc9im4emMXyCk4gX+d5?=
 =?us-ascii?Q?hMxuI+DI1Hlk3IrtrjnI8g+458ambd6PY/GVQKSZEHrOJKh5ueDn53fkoNaW?=
 =?us-ascii?Q?4rMdocDPQ5NO4ygk6uhKog6yIKOPe76J4Ph6hi1Ftfksh1r4YpbeLf+KK4Ag?=
 =?us-ascii?Q?Q0oWZ7C0IAQHVARRBZVMZjxCwgY9HTIT34g9Q2hcUPJ3Bw64Qgsbe2L494UX?=
 =?us-ascii?Q?okqm/OsVwtWRpdp/+KIwy9vmcFcLVjz6xEgZqzKjTX8VpOakyt/gHXbzxlIq?=
 =?us-ascii?Q?jCqL93+k9yJh52kKAGOL6cv9qTCY9CXYqKRg217pN+y22vfAXMv3FqvyhYhP?=
 =?us-ascii?Q?S/mOkS0MuDNZzla8IQGbOT5HtS/8iuUXlkgRFR50pYI92pg+uCx2MrQjqv4u?=
 =?us-ascii?Q?WR0igzeVMnXhOtESoz6txRxVTdRS0v1FyiWPahJJUw6kIQp2NJ0fJ14oHyru?=
 =?us-ascii?Q?l6n+z+d9m9ohsse5Ll1x9+0gJ+3MvJfRzEK4l+l7rMEoYZlyAtE0sHSYL/S5?=
 =?us-ascii?Q?AStaSDt+a69rZdEVPOinGZebjW53IsDlGAwzVBZkckP8NimfjDQPrqNSe1Rw?=
 =?us-ascii?Q?4WrVduxUnBbk2wOJX9r1qxBKjJn4Io5Z1Z5bWH3qqhthwzz1zA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wEtxgRHToxuWqwhg0Mhhmd/ln1C+tPfgdlMXkVb2j6H0Jh+u5czOI3A8JA7?=
 =?us-ascii?Q?P2KPPPcd6VCunGb8Xzn7YWRLSDoeKpUH4JEzBbezycUwqVLoDbW8bLZ7P14X?=
 =?us-ascii?Q?/0r5YaCGcTszvV9YkKfO3mwx/Y8Hv8XxJ5wJzF7Zgt0vKLRY45pMT5L6/c+d?=
 =?us-ascii?Q?iUIdyiBIgrOsYwFX9FNOi4iq+em5+3CQmdDqrKKqGchZiEQRXYGSdm7zyPr/?=
 =?us-ascii?Q?/3rw33C6xnWbmNwI9OrGSUAW0z/KNLit5wkYzBP4VQefVPyxM35bLv9yHrRN?=
 =?us-ascii?Q?SL7aPsM7So4AhaB5c9p+N2YwbkTtBxnNWjF2Oq2lbdpUmcCiOgzBT/+mRzTA?=
 =?us-ascii?Q?YfLrOUxs5ZrWZBv4OmO82dDkCyd5KHs4qxWHlIfY4JMNuXaI6OOaTxZp94JA?=
 =?us-ascii?Q?fFd38L47n3zotik9p1vqpMZQkKt5H5UrYkdb+kyEFC9wvf19Uk0HIJ0dYSIb?=
 =?us-ascii?Q?3n+80uQNc+5Z+FzCAjG1JPZO5lWjsoKrIiHyHFr7zkVRM/4l+Kv5oHglHEp6?=
 =?us-ascii?Q?9f4LQlYs3MG3V6Y0Hih1J6bYxXZA/sOIIKyQ+eMuwBfEXrNggWbOS7G/he/2?=
 =?us-ascii?Q?KNdbl9v+0QeyDLainiLKcpCONLdcj1zCybXO1vG/Jej390tXtOUp166MRL93?=
 =?us-ascii?Q?PUmQfNs7qZVoZ8ldd+F0T8btdW35T7D0vr+iqOZRLxSh1Gte1NUJ8infLH+r?=
 =?us-ascii?Q?xxiBD/pwHSHTkRTR82RRH50xXNZTIrVMki9bIYFx+pmwlUQNY9/FY4Xob7Vp?=
 =?us-ascii?Q?X/8I4eNdcrnFSKZvYZ0PtIdyhXdql/qP+uxFrLsli3VkqaTwIAsQxyXIOR4b?=
 =?us-ascii?Q?T4/TiTWgUpxvgQb9xPt0ImxlCW/voF5/7o10J1yIFBlrG20mwGYSVExi2mnA?=
 =?us-ascii?Q?3AsMWsunNoN1Kccf4ndGwZ6B6FbwazpcHOFKXMsf1KpCMVTb7V3bng8SkP4j?=
 =?us-ascii?Q?u/smVUVSWj4j071efRcFNrZTM1d1U5hYoeoECces6qqbP2CU/HHTxQAovZP/?=
 =?us-ascii?Q?TP8h1vuMFUGouPN6Yw8CYiQtWJw2yDWvtjZqWbbG1aIRsB78SPkYumWVg/0e?=
 =?us-ascii?Q?DR6a5pbe/lkXjNnFIDWO4LM9R9FRS9Cg39dstMsnr67NeUTjDDw9IiCc6QWq?=
 =?us-ascii?Q?LYZdkN1U23WzfLYFp1jnfOtKMFHcPuSPK0G4ex7oeM6MVyRIU0Pyobavmq2k?=
 =?us-ascii?Q?PDzeswkTCn2qY/Kn04lswmZ6SRXVepDcGyLymk4a0kvMx07VYfsgyBH4Zj6Z?=
 =?us-ascii?Q?1vK+XiG7FsxC6xkU8LExv3174/5oBzOtKoDAWsj5Pz6NT6vZ7xrUa4QvP4XP?=
 =?us-ascii?Q?b7JvVgdSLSAWvZlyHue4XcOPpRHBk4RnAbDVddoQEmA0xtYo0x1zP9hi814S?=
 =?us-ascii?Q?Mjq91sbDYlr73bw7/Cu8cktyl1EEHgisIuQQDlnagiUUTKakxt5ZFEa5ZODb?=
 =?us-ascii?Q?5I2HeiwW4JvBMaqaPesSllOtKMIdwZKWMb7E9bsjFETypYngZi5qxONZQjNa?=
 =?us-ascii?Q?MzZ0FMKYKqa/+bxHIS4QPYKsu7CSKsNlKJ9FrkMe1kelSE0kF4CiCuYoilOg?=
 =?us-ascii?Q?RosVYEq0EPvF5gwOdzglYxF4MKTkvHFfBcX6KBdf6agw8+j3Zg7lZL4JYMkY?=
 =?us-ascii?Q?zi4NIra2kx/2+cGVQqQKfbo=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f03294bf-d6a5-417f-d002-08dccbf95276
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:18:07.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvRWLj8mywiOiXHLTmlVhAicA1KVqLsX1KrdhKgO47oLsJ4dCm3zhKl4+cqNH71IFvs/d4JjDdcrKdO8C4YGBl8U9q4ksOX5HZd7mD9vsD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1674

Add following peripherals support for the Emtop i.MX8M Mini Baseboard

        * Wi-Fi
        * Audio
        * SD card
        * RTC
        * CAN bus
        * USB OTG

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---

Changes in v2:

1. Updated the node name and pinctrl name.
2. Removed the 'regulators' container.
3. Removed a stray blank line.
4. Removed non-existent properties.
5. Removed unused node and pinctrl:
   -modem-reset
   -pinctrl_uart1
6. Defined the CAN transceiver reset GPIO separately.

Change in v3:

1. Removed 'can-connector'.
2. Use USB connector instead of extcon_usb.
3. Changed id-gpio to id-gpios.
4. Use Level trigger IRQ in the CAN node.
5. Corrected the compatible property of RTC.
6. Added blank lines to separate the pinctrl groups.

Changes in v4:

1. Sorted I2C device nodes by slave address.
2. Moved properties above the "status" property in the Wi-Fi node.

Change in v5:

1. I mistakenly removed <pinctrl-canbus>; it has now been re-added.
2. Added Author name
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 335 ++++++++++++++++++
 1 file changed, 335 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 7d2cb74c64ee..90e638b8e92a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright 2023 Emtop Embedded Solutions
+ *
+ * Author: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
+ * Author: Tarang Raval <tarang.raval@siliconsignals.io>
  */
 
 /dts-v1/;
@@ -11,6 +14,113 @@ / {
 	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
 	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
 		"fsl,imx8mm";
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_otg>;
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+
+		port {
+			high_speed_ep: endpoint {
+				remote-endpoint = <&usb_hs_ep>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led-1 {
+		        label = "buzzer";
+		        gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		        default-state = "off";
+		};
+	};
+
+	osc_can: clock-osc-can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+		clock-output-names = "osc-can";
+	};
+
+	reg_audio: regulator-audio {
+	        compatible = "regulator-fixed";
+	        regulator-name = "wm8904_supply";
+	        regulator-min-microvolt = <1800000>;
+	        regulator-max-microvolt = <1800000>;
+	        regulator-always-on;
+	};
+
+	reg_wifi_vmmc: regulator-wifi-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100>;
+		off-on-delay-us = <20000>;
+	};
+
+	sound-wm8904 {
+	        compatible = "simple-audio-card";
+	        simple-audio-card,bitclock-master = <&dailink_master>;
+	        simple-audio-card,format = "i2s";
+	        simple-audio-card,frame-master = <&dailink_master>;
+	        simple-audio-card,name = "wm8904-audio";
+	        simple-audio-card,mclk-fs = <256>;
+	        simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Headphone Jack", "MICBIAS",
+			"IN1L", "Headphone Jack";
+
+	        simple-audio-card,widgets =
+	                "Microphone","Headphone Jack",
+	                "Headphone", "Headphone Jack",
+	                "Line", "Line In Jack";
+
+	        dailink_master: simple-audio-card,codec {
+	                sound-dai = <&wm8904>;
+	        };
+
+	        simple-audio-card,cpu {
+	                sound-dai = <&sai3>;
+	        };
+	};
+
+	sound-spdif {
+	        compatible = "fsl,imx-audio-spdif";
+	        model = "imx-spdif";
+	        spdif-controller = <&spdif1>;
+	        spdif-out;
+	        spdif-in;
+	};
+};
+
+/* CAN BUS */
+&ecspi2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_ecspi2>;
+        status = "okay";
+
+        can: can@0 {
+                compatible = "microchip,mcp2515";
+                reg = <0>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_canbus>;
+                clocks = <&osc_can>;
+                interrupt-parent = <&gpio1>;
+                interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+                spi-max-frequency = <10000000>;
+        };
 };
 
 &fec1 {
@@ -40,7 +150,135 @@ vddio: vddio-regulator {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	wm8904: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
+		clock-names = "mclk";
+		DCVDD-supply = <&reg_audio>;
+		DBVDD-supply = <&reg_audio>;
+		AVDD-supply = <&reg_audio>;
+		CPVDD-supply = <&reg_audio>;
+		MICVDD-supply = <&reg_audio>;
+	};
+
+	rtc@32 {
+		compatible = "epson,rx8025";
+		reg = <0x32>;
+	};
+};
+
+/* AUDIO */
+&sai3 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_sai3>;
+        assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
+        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+        assigned-clock-rates = <24576000>;
+        status = "okay";
+};
+
+&spdif1 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdif1>;
+        assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
+        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+        assigned-clock-rates = <24576000>;
+        clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
+                <&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
+        clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+                "rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+        status = "okay";
+};
+
+/* USBOTG */
+&usbotg1 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb_hs_ep: endpoint {
+			remote-endpoint = <&high_speed_ep>;
+		};
+	};
+};
+
+&usbotg2 {
+        dr_mode = "host";
+        status = "okay";
+};
+
+/* Wifi */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wifi_vmmc>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	non-removable;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+	};
+};
+
+/* SD-card */
+&usdhc2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_usdhc2>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+        bus-width = <4>;
+        status = "okay";
+};
+
 &iomuxc {
+
+	pinctrl_canbus: canbusgrp {
+	        fsl,pins = <
+		        MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14              0x14
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SS0_ECSPI2_SS0  		0x82
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+		>;
+	};
+
+	pinctrl_usb_otg: usbotggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x140   /* otg_id */
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19    /* otg_vbus */
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
@@ -60,4 +298,101 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
 			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
 		>;
 	};
+
+	pinctrl_i2c3: i2c3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL                  0x400001c3
+	                MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA                  0x400001c3
+	        >;
+	};
+
+	pinctrl_sai3: sai3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC             0xd6
+	                MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK              0xd6
+	                MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK                0xd6
+	                MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0             0xd6
+	                MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0             0xd6
+	        >;
+	};
+
+	pinctrl_spdif1: spdif1grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT                0xd6
+	        >;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                 0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                 0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0             0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1             0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2             0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3             0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp{
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10             0x41    /* wl_reg_on */
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9                0x41    /* wl_host_wake */
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K      0x141   /* LP0: 32KHz */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x190
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d0
+	        >;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x194
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d4
+	        >;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x196
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d6
+	        >;
+	};
 };
-- 
2.34.1


