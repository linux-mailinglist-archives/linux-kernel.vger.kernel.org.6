Return-Path: <linux-kernel+bounces-295619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E8D959F24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E72C1C21236
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB701B1D50;
	Wed, 21 Aug 2024 13:58:46 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2118.outbound.protection.outlook.com [40.107.239.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87A1AF4ED;
	Wed, 21 Aug 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248725; cv=fail; b=kbriPAE7n5mQ/jifrQfrXuJ1Ui6ucGscVFU1KDJIJi3NxlAPaGlglMMWv5dGI2aARDm5Kyx99QjCGNOZkgXUlmQVPL8tJNTYJKBiLuKUnnxcWaKgVM73QkfFk1evPQ53ONq1eZrGR2xqGzbbL9VlOcKdeGDxoXeWhUaSQPtezbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248725; c=relaxed/simple;
	bh=DBm0aZ9ABumVPjRMHIT+28LwjOLtbGGYIhSqzfugaz4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jR8GzUqzDvH8Ccsh/FDDK3DNiPgapv6M+j5AMHwqv6tvc/Fo5IGtD5IcjD642bMNc0T8LORiFKH0o4o/ekEq9X1rAt9xYdOlv8fYLPzuwSuOMtvuWnedmCRSAltClbj8MezmMULW54GeSCrtR+Tfa5nQzEEUUjOPzLzncWSoqls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAPrcQPFWBaIvXtB4HYac0cdBA/AuzgPy/tA1dbDIvdZlAJKjzTP2NdqoquxS5OXQZS9wuSv6VvZXFw44mtfQHaVQ9M/tLLc+Y1bk2/pc9mtqUzrlUh+GmTWKEpQ0+JewUccl8NvXzjIIbmj3jS3v9cVNaSlcuJ5p2xW+JTcPw+GwN3Fw/Bk9oKW8xH4Vbf0+KPOCjcl3cuEVRmOgFfJvdWD4ILly0691Oct+pvkfSlRS+6NYzNTKbKUBYJXTao6mkVO4NzEJD58dXvaDbi2+aC7OL4URha/BtFwHESeuQfl0Ksw9MWUGpGPg3ANceFCUFY9sagWPY9YILfylIhGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRPvq7RjAUHLZiTRc/JRi2t9gQx818uyqeAIgBY85so=;
 b=YrNbuXye0TzYMB1sgWx0f3qdHIqH5hvDNi9uZB9t963AcNJkunOl27rD+b/uRbtapeCnuGli9Z1UJeAdjPAXDtmW4zBQtjK9tZhIW28rRhnOSy1UsEKoAVFKAAvi1KNj+B1kW9Grfq1w83/Hmk2QdWAahGlpbBxItgISX+K3zWvFKFHWdIk0i+6O7vuDW6b25eLcBsTS/vbIy7ZVXmgE6AadgDqXsjMPZ5AcsiesDCp56xGoRkuxaTlZVur3J4W8n5+dI9ljAUd+m0s1pkzQXwRrPjqKLXZxQAUDYcWbGif3fF0kZMrlV/0+CDUp6zQGm9vCWeFHGgZgwGo+MejT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN3P287MB1752.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 13:58:40 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 13:58:39 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: krzk+dt@kernel.org,
	festevam@gmail.com,
	shawnguo@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Wed, 21 Aug 2024 19:28:17 +0530
Message-Id: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN3P287MB1752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0326bcf5-e581-4b99-7edf-08dcc1e95c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMgp10tayzMIy2Wf5BjmDMZhKCk8szhdxwwgomF5F8JYqnZcN24Ik4Zu529R?=
 =?us-ascii?Q?Cm3d4Hz/RrH1eHgwS3JJ8I+TBaVCag1jtXTDWi3SxFIdhtNW5RSNxnG9sblC?=
 =?us-ascii?Q?3ssQYYFfyYcWscCgO/X34W92TbhtMoYOX8M5VNus606xUBvXkahOcYZxJWf1?=
 =?us-ascii?Q?azFOIDstqk7E7zLtKrK2w51meiDk0cHf2ZqzNSvNR5ScXe4RwAywp0F5EjXb?=
 =?us-ascii?Q?4iHo3D0sixclihaVdp1t0Zbr/iVB+i0m07o0cjd0/wKXuSA0pqSDplq267yw?=
 =?us-ascii?Q?a1yxIV4szJ3q9X91vD4uXSKeyuHMGCtCwPYBpsVqAdtLSNN5F9w5UxEPDcFe?=
 =?us-ascii?Q?GaVZ+9TpU18MHrSCpWFGIroe14fgX3l9WAmuGK+kzVzqv4cm3DSqMn8Y0OMF?=
 =?us-ascii?Q?YJYGD/2FcKm/+INek1zDMxdDfTREGwGMzf0lqpdZtZO/SLBa2KZ8xUCfv/fM?=
 =?us-ascii?Q?09f2N/n8F2nfaxzcFG9As+RObSrOTcV73uBZqz7ZsI0Bj4oK4AW6gcchk/aC?=
 =?us-ascii?Q?pij2OTfsv4yeu9l/xojoYJDxke9qmrTCPKDzFBG03p+1OWWZm1Qr1e8uD+nW?=
 =?us-ascii?Q?iALAEVw/M/3dN4qXlm/t5qCnYrgsszbp0VQzZURPBB9119LIUJb7PaAGkAjq?=
 =?us-ascii?Q?QJeof+8SuD7xhRATdWXcm10eFB/+ml51zz730Q4o5XaZpuUeEAiM0naLfqfx?=
 =?us-ascii?Q?eL+2+igrAacOFZ2AKlr93AEVrhBr9VBIIZbldYPul2p8uTfsrKzyaFoUYH/k?=
 =?us-ascii?Q?ra95rhAfpDaNNtBOILZaYirF6NaA2lj2EypcMGjTR5YnXylJgh+nW05pWcPk?=
 =?us-ascii?Q?YWo4Z/RBanyMVRF8ijR2YE7oKeHWHoYlHIyUQRC3synAjxTjM15w8Vj9uDZP?=
 =?us-ascii?Q?vtEppiDr2zB/ZUJbQbyPJuu2PfDuQzPRMz7pPbZ6vvCa/5ykD0aMoQdCrQg6?=
 =?us-ascii?Q?K2TFJwxP5sUauAKDSzxg86c8ogFb/L5a7Yu/iLNvSa4sg1Ps5P/Qad0bF0zH?=
 =?us-ascii?Q?c7k/B57KT2ma0sgWdeT9evYpelirVnaEKW86Ml7FQO/JZMsaWiPXS9Xm0UwY?=
 =?us-ascii?Q?qxjJzgnmiDgZo+5m97C15veyuEvrImKo57zEXfoEeZkw7UHJ4UgmkYHDsOU+?=
 =?us-ascii?Q?mXro8ejcj1wMsZu021dk12TLBzVOaMRQ8WFKHEiWR6hekS+28x2p0J2n4tXS?=
 =?us-ascii?Q?Q7dG3YW5ERJ07/7bjzquyqTmw1QTD6NW/WgpKtr+ObfuFfnZPWFDLcokdw+S?=
 =?us-ascii?Q?TlahQxtvVorgy8REO0WE5iuK/5TERwdfODrexu5qcDdBAvsOSn2ssS/n0/jj?=
 =?us-ascii?Q?QbeCU+ElZibIfjyguGIJj9NCsbHdCLbIisEq5iwRlpseVTpT4MND+gzbNKht?=
 =?us-ascii?Q?Spfdrb1okXknsAL77E/w7y0zKOxRWcky97sjptfbsNqchfhIbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixtNU1eF3dWn/DGbD+GjCG0kyExmIKKYRtKwd3fhFqYbk8j3PTrN75BU72F6?=
 =?us-ascii?Q?o0pCNdUYUWpFYrDHM1utTDXyfZ7MlWy5PHNRi3RBIU9EvpEZ2eOzQgOtxK3E?=
 =?us-ascii?Q?pLwk0F71Wik953Lua6UUQYCFla0GWfDqDgWZwmJw04jPv9Mk416Uf6tcM9OD?=
 =?us-ascii?Q?n0b7tSxZ05Ie40NRhYpHBHr4Zn2y+B5mAYBc+aNGbvcCJW3C3dvFOUDJcn/J?=
 =?us-ascii?Q?gi1MCEHlD/H09EF0hpIxczBaLq2yO6AsPg8XQ0kyMVH6McIXZ7lt5qZsk788?=
 =?us-ascii?Q?6vgaPAvrHH+QvMPaRbvV3ojAUerpNg7IdohWu/TI4Z1D0kYK+41L/JoO38gT?=
 =?us-ascii?Q?CsGvqF8i9dp3Wm7fPbwiPIW3+yUvF23hGk9+jy0yNXhsh1oQ7BZRH2thAy1t?=
 =?us-ascii?Q?tzASCRx7uvRv9Vi2kqMmOSeQE6A/cwqI9a4tqXvmOJcp0C9M64eO+zVI+Kj8?=
 =?us-ascii?Q?f6SK2lLIy8drN+cpxqkHSwkSOeLqNZVtpVO41G682xqpilb8T+ih9BiX8f4R?=
 =?us-ascii?Q?GyuCYoxcK4sAA84l2PWonD9EjcGaqjlX+foykvuf5AEh3QYpyx+VyTLD1SoJ?=
 =?us-ascii?Q?IIFtLwqO7UR9KC5c9+KqTy57ghamZm6e0O320bt5ju1uD7TCug411QtCLS1t?=
 =?us-ascii?Q?+nUc5APMEma2x2uZy6EC2lZ7OVELzIV8uc1ZaE9Q69mRFONtcP/fIDNZelZ4?=
 =?us-ascii?Q?/0MuFq6rJBAnWk8rLC+qS0z0q2xCoEvd1vZ/yJ9AWS5O+msaZzYMSVYBeiFr?=
 =?us-ascii?Q?/mcKY4FAfs1f+1mCoYX0a+kDixoRMuyOtdKFfRqCWw5gd+DhQ4ZwDXE+3Rlg?=
 =?us-ascii?Q?nLw0st371qKjOQi6tvHwzuqVUPjK3k4gLcSKgoISkpWfoBl82gOU5CKJTXHY?=
 =?us-ascii?Q?sOv2pX+ocx8qbxfRjig9MIhrt/JgL2+1X+nB4NkDfVAeZgrKn5uViHTWdP5+?=
 =?us-ascii?Q?mjexVIZFukuAOn2G7A4BX3PRF17VAGXmBCDdUzm7xpVVzrhaJc8qBWbZ5Ow2?=
 =?us-ascii?Q?LHLHYBNycdu0CJSiByepW1QIZyAfyzjmbBgdEihLHL4/FmHI6ZTuyK2Pu4rB?=
 =?us-ascii?Q?suh08mOz54rQSa7fVV/ud2xuqPLcC1/TelyAGECVyMlmO2gxfBzKXVsFHsvK?=
 =?us-ascii?Q?7GoZglQp6EqqUMvqHxC46SuB7poShDrlxtaNDrNF4aXm0KNhoVozYy9uhGUI?=
 =?us-ascii?Q?C6zMGU8y0EWiyEJtlUx5Gx1vnbC19QCXxWpzFLUxL00LLFV+eZ+yUJViBo8z?=
 =?us-ascii?Q?WSwIEwTa5yEcTFQb3Z63aVKIy2nVPfOLDj+bb8GK8eqPF9UnC2fUivvJo9YC?=
 =?us-ascii?Q?SCUlxm89AC2OGSSoL8iaInBPZpbwmMB17tl1LWKqxFKf3Dq8PTwGWdMAeXv1?=
 =?us-ascii?Q?gTSkPcGuHIP4nHcyh3dxrNIcmUNx4vAlrVk5sL5TQ72A/epiNcpcNFu22ISg?=
 =?us-ascii?Q?S/vY06JRA2e7Q+PWbJYC7HCoRMsS/QyzOotYHg8QL8WDc3IhPNx4ksrS1f5j?=
 =?us-ascii?Q?huwZ1iTMq5W+ymTTvKLP3lc7KN+0cGmLn+r77+7Hre7sA/2B4PePk6dj+9vB?=
 =?us-ascii?Q?LpL4rCZLyYUO4lwI/CqxN1H7FhPRzBZfHD9BC6WkJVLJcuuJTlvR25SYpKrF?=
 =?us-ascii?Q?P3bpeOblkjckoOddEZE6lh8=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 0326bcf5-e581-4b99-7edf-08dcc1e95c32
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:58:39.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQYgt9beapp+qzbYLGXoU2Wc+n6X01g1HT/ZOBnldqTqJMJsi7kBRNosR2CLu8iHGFpSd0/MxJleUZFUp5lT18NdPDOMlrAYXVOVRwiUWe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1752

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

1. Updated the node name and pinctrl name
2. Removed the 'regulators' container
3. Removed a stray blank line
4. Removed non-existent properties
5. Removed unused node and pinctrl
   - modem-reset
   - pinctrl_uart1
6. Defined the CAN transceiver reset GPIO separately
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 323 ++++++++++++++++++
 1 file changed, 323 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 7d2cb74c64ee..322338e626ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,6 +11,113 @@ / {
 	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
 	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
 		"fsl,imx8mm";
+
+	extcon_usb: extcon-usbotg1 {
+	        compatible = "linux,extcon-usb-gpio";
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_extcon_usb>;
+	        id-gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	        enable-gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
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
+	can-control {
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_cancontrol>;
+	        reset-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
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
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_canbus>;
+                reg = <0>;
+                clocks = <&osc_can>;
+                interrupt-parent = <&gpio1>;
+                interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+                spi-max-frequency = <10000000>;
+        };
 };
 
 &fec1 {
@@ -40,7 +147,131 @@ vddio: vddio-regulator {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	rtc@32 {
+		compatible = "rx8025";
+		reg = <0x32>;
+	};
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
+        dr_mode = "otg";
+        extcon = <&extcon_usb>;
+        status = "okay";
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
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
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
+        pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+        bus-width = <4>;
+        status = "okay";
+};
+
 &iomuxc {
+
+	pinctrl_canbus: canbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x14
+		>;
+	};
+	pinctrl_cancontrol: cancontrolgrp {
+	        fsl,pins = <
+	            MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15			0x19    /* CAN reset */
+	        >;
+	};
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SS0_ECSPI2_SS0  		0x82
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+		>;
+	};
+	pinctrl_extcon_usb: extconusbgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x140   /* otg_id */
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19    /* otg_vbus */
+		>;
+	};
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
@@ -60,4 +291,96 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
 			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
 		>;
 	};
+	pinctrl_i2c3: i2c3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL                  0x400001c3
+	                MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA                  0x400001c3
+	        >;
+	};
+	pinctrl_sai3: sai3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC             0xd6
+	                MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK              0xd6
+	                MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK                0xd6
+	                MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0             0xd6
+	                MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0             0xd6
+	        >;
+	};
+	pinctrl_spdif1: spdif1grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT                0xd6
+	        >;
+	};
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
+	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10             0x41    /* wl_reg_on */
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9                0x41    /* wl_host_wake */
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K      0x141   /* LP0: 32KHz */
+		>;
+	};
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
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x1c4
+	        >;
+	};
 };
-- 
2.34.1


