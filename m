Return-Path: <linux-kernel+bounces-310601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4845967EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428B01F225FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3AE7DA62;
	Mon,  2 Sep 2024 05:45:39 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2093.outbound.protection.outlook.com [40.107.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF2145B14;
	Mon,  2 Sep 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255938; cv=fail; b=tKaR3VSESZzoVS3uIxpB+dVIhhv/9Upo1Idb3Q9KySx9ILjvoqFXImrwdQkhjOCOBuUt2VlDbqBzbxLKOd2Oi344G/JYxBMUp3BFWmuMHU2MAXuq/eLoIytDJnQ/Lk86naxHgTHMPZImL+nXAvQFYjzekXHhDVDtBb6nmzIoC0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255938; c=relaxed/simple;
	bh=27PRz6ZsMTZIAGWD1fzEs82FRPKsi7vMBVK8KT/5YfE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PNTL7QbsiP5ohVWf+mwuhRCCxhM0nL592QMM/B3DuZM7zd/Q6KBDhpLXXZYrGFX/A5YamZEkcQrv6kuXrdTyVhqQvWfbYNFqeUJb6a0GD1Bmkwm0R+JPWxfTNXC61Yp8j0cBtO/i94FjA0aoJ54odOoz3mBCouVShQqudqRrxLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzMqihDg/hZlZVLF40ST2LCpO1hsKSlpTjun5+zF2FrrAiTHSE+OcLlndQN06oq5PYfLUHhHOHCdmOxaYPjSktDrSFmCE7OHmxITR3Ba1IDUfOIPRwdp577K0GJiB4ygkex6S2SMYSrUFwXP/HmwHBrzfN15+8JW4XsXkd2/kqgNcNtcXi2GfbDRNEwXizoUMPrJSdZDJyT5mh6i4S3sHtu8VjscAtIm2Cw2ShEaCcJTZ2ZRwAuq7mgsH8OBk5HPNdxCXM6HhgZUaTpAcVapOT3OMtDZFhMfZVPOW27leCNrgqq6F16je+lUQwypNXHxhCeymuJ2hWdcaBlCnsDKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7A9ebY5lJNhEI3EjavrqDimNWlog5sX+7NgMcC2Nc8=;
 b=UE1dRALhgMlpAstYHHRYCqLq1ik1zArYJzZlBcWGuzqxUobtpN9QxKYzsaNslrS646GAxWDT+xTzcQLIjKKysdwRYj3d5LPB6Gk6in3sy46dTgn/mk2HZEnIqo/kALa6Za/ONqOszA6zUndbzE7fN6jnPrYwW7X/TGkfxpSjb7kxE1dZRwXi/Jqw9YDSC7Yg1CJqnShDxtgfLJQTOeHg+nzD44XTqPt0F4GkJIWnz1A+a02G1jj25VGInDMMxxi+9G8lwgE4MooOhdJ+XnOCHWtE3Ze2xrDtgsXxn3+W/x93iVErxM9KQRmQGe9EbYTsAJTXsbpPXoyyWg/SCy68OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB1173.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:190::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 05:45:31 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 05:45:31 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Mon,  2 Sep 2024 11:14:55 +0530
Message-Id: <20240902054456.5828-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN0P287MB1173:EE_
X-MS-Office365-Filtering-Correlation-Id: 192119cc-cc1f-451c-1c79-08dccb127541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1Tzoae5+Q946TyWmZ1qvhHLRnWrR3xI5LuskcgJ152uWftx15XLgL0Fd/Z8?=
 =?us-ascii?Q?4k4CjZ6HgAAO7LwSdxuP1WwD4Z9Yg0JcGsINxddSnXzY18/c9zP5kl7gl09o?=
 =?us-ascii?Q?u9TLBm7yKbKLp9JfdXjbAEryIudZlsmTyGNZqOKC69g/Y3wWT/YDjkxGkSDb?=
 =?us-ascii?Q?FtOMxKCbnVcT/MNsFcMVyN8dXWcnM3J1UNtg8RczsNbAF9BDOJcpCughjMGS?=
 =?us-ascii?Q?8GYbk83V9/6C7mm9kSq/CfV6tTtT85mDZ2UHKpZtDjSqEvUdUqQzvi6BuK+0?=
 =?us-ascii?Q?qUWyrpVps/caOvABxBF/A8KH5b3kgwARv3sXXtot2hCLmNfW2TgFLUXrWEjm?=
 =?us-ascii?Q?/6SgNzNUO6wKKJnDm/UYkXyiCTuHvUykp8ooFMV4VwfdgIEJTVirEnU1V2OW?=
 =?us-ascii?Q?S/J5xvttCXv7ULul0Utuy6UhKZmSRcJt7X0O9izcie+MBNAzBH0B1h5Shn6h?=
 =?us-ascii?Q?k2/ewQ3KZ8HcJXZmReLsDQoQ3QHxNmRH1wQB6+6oXnm9oqt6gCFKWOBRsYnL?=
 =?us-ascii?Q?5w/i/BM+PZn1voXyTqlsytTfSf/EivL5AhCeT222q+XexS2Yc1HWbUb8kFtV?=
 =?us-ascii?Q?/Gleq72ubQO+x1DXnWPz+Oph1WJjBIKoGabair9YWKpMYvENWbGo/8O1ocYM?=
 =?us-ascii?Q?KA9dspcxwbvZ7yw9H+LGI9Qh3EF2cOMweQoDokYRey5wPo1JE/shCpXFAXGo?=
 =?us-ascii?Q?OGBOyUWgIxLcdcYXGJn853hmEQd0OR/SDe0f3u61sQQGCPQhZE+TPqhrZmI+?=
 =?us-ascii?Q?yp9X6JBU/sQS/NOvYp3eNgHBhswuGf7TfsCkwjoUWQz2F4lQUWpTjgUZ+HS5?=
 =?us-ascii?Q?R0R0B6eLhr6YpNm4OC5On8UUbwUozAE7iGi4F6rdHNtvj6GkDSyffYNxRdWT?=
 =?us-ascii?Q?xzh9etpbak2M78d2t4+A4mBABT22hZ8HIuygUzw7ozNVd4jv9Y3IFqco37La?=
 =?us-ascii?Q?Yqn9BXvzSxJMP7x259ewNRLN8JzBUcreIfF7/45LdBgmjZDxx+itC32TsqoC?=
 =?us-ascii?Q?cdmUHpHufiYYscm1t5CEj9hQLvZZR50kIyesIGnp4GwIl1wIbJX+twNVI/EK?=
 =?us-ascii?Q?AtaUbsaW2//Cfq99CbolNpqJvo/KWbA6VphY7X4YQxOGotpZlLAl0aaabOVg?=
 =?us-ascii?Q?JN4Jdn8UV0ZB31PV3OY7ywDP19QpORLWNO1UrHC+sQKmJphYknA4b81KrXtQ?=
 =?us-ascii?Q?kDoH698Kt7/Md4wKWapXertqm7fj94VbgWZT44zeq7S5mGFsl3cfKl/NqM7N?=
 =?us-ascii?Q?EF2+RPf3ugRiPHoCjV0Gldyc9fWqPRnVoOZXHtRdmlDIhSHoKi9PZMxOPTZi?=
 =?us-ascii?Q?nMihxB3r78hNglaDVijp1rlLlZCM6gKDOb+VnhxVT1Xq+bA/G7ce8vMx2pQ9?=
 =?us-ascii?Q?NCDrM9igs5d1tfEmH9xKf9Q5wYF2EukWVGrG6S0TD5aq0yYyOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T0LQyctg+h04lWQWr8x1C08PGrlvhuLbrUNBciBLE8p1kBGJQ6doSrql742t?=
 =?us-ascii?Q?kzRxqvQIk9XSiJ8qPRceDv1s42EnV6wb5YF6qNWp++8qH6I4pld96MTVujpy?=
 =?us-ascii?Q?o70t13RjUqEGPg6/kmwxORoz2+RBzHqdUS12KhF+X+4FlnkhIuTB9s98kcrT?=
 =?us-ascii?Q?un+Po0fykH7Fa6kwUPL/tAlgljQyaBqwTXxS2egGeGRkvfybw8joH8NXQsbN?=
 =?us-ascii?Q?jE6w2FtOt6dgVDsskkT8jMHPx/0Fg20qlBZKS5gE7nISAn/seVaeB+ZfzKfo?=
 =?us-ascii?Q?jJuGsS/m355/LXjt71gCn2StOkovcwNPryh035LmLMv4RC7omRDPzo2Sd3Rd?=
 =?us-ascii?Q?iuvzs2c1qJpxXuVid6dnMJ17KQSnomrVIKtywlhM0xejbxUeEoWThy8Z43HV?=
 =?us-ascii?Q?IvEhsBfGv4Nz6rZer9AygxG+WfpN8ro/LO312q3K8WA08CM8i0zGf90I4d/P?=
 =?us-ascii?Q?2H9WFpJaZPkocqt/UvxX0XDqTRier25zctZmSIe6ke5Ls49DoNdD/QtGds9j?=
 =?us-ascii?Q?X9QrIKIjDT1IPfzKeta8hQ7HPZdJaU179HtTY/9fAgHsLmsI49lzPdoyJqZ/?=
 =?us-ascii?Q?58Qwh20NDuEYGLbW4WjTf8prnzMFw+/MBLfaq0b2g0uuchpYE7xfaZFEy1BE?=
 =?us-ascii?Q?4WH+7mi5AHLJDVdJCbCtV60c8UXMINqN6pDc8NYG57Jl189jNmo9FMfaJH3y?=
 =?us-ascii?Q?tWINzk9jjwT63kThVbrJu6c/HXPClzMvR/u8849UmaSY5WJ+q0stPQWcD13F?=
 =?us-ascii?Q?6dP/bKMIXUDecHEIC0WaUxccvIf1OnOLwwHculdwwLt4TKuSNwsAA7fi3uOF?=
 =?us-ascii?Q?oxJ7OPYrxlpoFpNFImynuiB7ezC56b3bh9frJOpsl081WHot2FEJPbesrYUw?=
 =?us-ascii?Q?a3ZspEp1X2/KPGKwsS+s+YqgVe5HJzNIhNgBCSgiKOFRUXzrGIx9QNfuAww1?=
 =?us-ascii?Q?sKkMIopE0qzppeNtfO03jLnXjmRl867hpHbQfZSWVmnc0wSJrEtNNMwgh9bG?=
 =?us-ascii?Q?oAD9dW6XgrE1g4nNKlnGUy6KFf90GMSsAzJY5/8/088SEFCX5AzWzpDRLMc+?=
 =?us-ascii?Q?F0NdkC31ofcVZYgWbtmjdMLRgoHqJ1wZ2lzMe9bCiJF67tbWrb2cgxZVqYD2?=
 =?us-ascii?Q?i1ytduIiARU+ExtMEPrmZf1yD60vYEZUaiDID5fCs6hSu0iOZD998bXl9Wbb?=
 =?us-ascii?Q?WDe6t3wjo29axysi6lnov6OvfX4fT7uMpuEU1ADC72MUioGYIcY0jzTp1rll?=
 =?us-ascii?Q?oAn/MR7XPn9M20Kw2pVeLQDbOWPK+9MDbUkPbKh6k8Nkfy+poFtTA1vnR5Vt?=
 =?us-ascii?Q?Zj5eQKkMXxh7wWj7uWScWPPv/YioOAHd3bqON1xJNrChsJdZBoSZm3YA6aMl?=
 =?us-ascii?Q?eZlQpg9cSS0LLzaGXiHOCtWNsnn+vYcNtM0/91sDDkqkQWltkVTUNJ3pgBT3?=
 =?us-ascii?Q?Cf/Jhxpi9ucSlsHo8kkxPpnmIj5jP6NDNeGJ3K21e3tgBcbe2ItXszyOp0Mo?=
 =?us-ascii?Q?jmd1uCIQe4XGiqUniIhN848UdG16TSPhnRQkFOxlYY5P8kVGD86vuHDPZ2tg?=
 =?us-ascii?Q?a/iSZ4l4aqo7I3iVNY8NDIG0hUtqqGcq2PAEm6XjaEUZDKI6qNfc7sEQ5enF?=
 =?us-ascii?Q?G4v8O/7EjaF4Hhz0BN2nPRk=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 192119cc-cc1f-451c-1c79-08dccb127541
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:45:31.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8JxgdxZTCeQovzJQ/5ypeUw3j8R/ZrE9yL6qH8hc96fmSmxxXGk32xoD6TTW9eJaOk00mw6mU+Qnf1FPNQY1dw+jF75K0U30wfKqygiCRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1173

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
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 326 ++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 7d2cb74c64ee..0d8cafe8c19e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,6 +11,113 @@ / {
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
@@ -40,7 +147,129 @@ vddio: vddio-regulator {
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
@@ -60,4 +289,101 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
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


