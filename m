Return-Path: <linux-kernel+bounces-375865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DB9A9C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7E285154
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5474315666C;
	Tue, 22 Oct 2024 08:08:24 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2106.outbound.protection.outlook.com [40.107.239.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930915853C;
	Tue, 22 Oct 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584503; cv=fail; b=dXLwE8MNgCiS8x5L84M9s+P/r2Ypw44TxfOBDFBpCYIx6HksMv5pWRKVM2xHT/dxrvpn1qRE3LjG48vwZYiujpG7gMgyuKiU/tagCWRi9/UhMMtJkqTayGQMGA4lzLFM0e16n3fXDQ7cHZNCIph+MlJoJyiJF+lN3HZobh37sYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584503; c=relaxed/simple;
	bh=hxgQYmbct9VIie4uX0UNizAVai9CVIVjYnoSfNSasJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkIGWwG93WT832Z7M9sCYHr/MHIGSt4GKlr9+b2jaSrDKFWyBxVcvJulk7NDLDgoZON6fhQ250KQfd3/1epNok58kPkN+T7fcGpXOBisLhwB4jKlwmGT02RQQKZ/GbOCmgaXN7NRISOb4bD9SBD0D92mXMoy9+VlV8HhrncDpf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYyPIOcp1pWgV6th6OZFk0gToa49bM9qUQPfJA3OauWr18PdIXVoXnQAa1JNLLXZYYMmFxjFrrfLzZaPZugmjLcQpQT2wGbDlAEegdsAxgTCnzpFBFtabCzClD7neZAUqLJXPcvl4PLLb4gz76aC2Inf0x2Mx5wbcKdw9Wi2VFL5TeGG+j4NBPBsz4mV/ocibMhINJkDFHb3lDQRkXPYZydgjAaB45wtjsL0rWb92GX7ayGaiwF4YH61mw3rSLgJHZYcT5l/XvaErNdbBns21MXitScNK/YoweH0tYbtxmhM+OZOjYUaX3Hr7DVqu1KuCqPEHU276DOkTqT2j+xH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM1BoDjmsWGc4WBW0tB7Ca7BeMUgyxMXJ+BSl3v32UU=;
 b=nnzpjHx/0dG9FjhadZL+LyQSYUB9XvwN8sTgNlCbueK4M2Z/aPSJNNGDUkE0uDns1Xi7j98dujC+UT1tLJw/MABl40h5OAZ5xaLOGYWi197ltHXkuomw78Q4PDS4lKwWud/+a3hYu/3w2ZRe0B86inszh8aXI9m0ZESQr/bS5RW4kyw8esS0VxhjijRf6H83S1tI3zi9U/QuK6W15eAYvLsT9v46+1RTty7JXLxazHbMLrT6I+kAIGUPy81rVrTS76oWydQY4+bV38QJGg/p2mNdy9CBQlB99c89KMIH1DqQgUHeZwtc2gdUgLh8IXJ8nsodXjy95oj+P4374kGewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0824.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 08:08:18 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:08:17 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Tue, 22 Oct 2024 13:36:14 +0530
Message-ID: <20241022080645.39536-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022080645.39536-1-bhavin.sharma@siliconsignals.io>
References: <20241022080645.39536-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0824:EE_
X-MS-Office365-Filtering-Correlation-Id: 26683fa4-9e6a-4780-062b-08dcf270afa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zn9rSyLM2UAQtk2OaRYHKO/vNjn+Q9cGWIyBU6kLnpzp81iOkpC/5iZIKy8q?=
 =?us-ascii?Q?3uzKDnlyZoPp+KS12VktfaY0ZTT+zMQgXGIBhOzhIvLvKcN4KJ52XrH9ITN2?=
 =?us-ascii?Q?NzoAaIilI4+4ZCT/MuYjAkQcTHAVz1+d09tbY2prlpbXVFIifro3kW9A1ZTB?=
 =?us-ascii?Q?RkXe+DNFEmjAOuWf/zaG4kUkxX0+XsnzZTNVHmyiYWM6e4uNYlzpj+0n9CFH?=
 =?us-ascii?Q?B7zaXMp0sWS6AR6TUbJCtUc1Ujcc+XLZ3RTtcmswygtgyX48Ht0bJxJlaBQy?=
 =?us-ascii?Q?QxttMfxAYznaNB20iatbrqDggBSvsxo6SDcX3gVuJ43k4qj9miIRtBmKEWs5?=
 =?us-ascii?Q?oXmo5D0VD2zCwovZouoysvJE5z/Ejha2g7FJ2st2fDFOuAZreL9P/ao87WXT?=
 =?us-ascii?Q?YoK/V/pLSnz0wT3ZQLcHqhPw+qmEQhwJWfDZzjrQTJeKxH6RzCJc8tFS6ZWv?=
 =?us-ascii?Q?nQztwwPlubjEkA/KHQyOSSQHZ5HycIg6dsATrjdRC8UzFYMhEictk4gsP2jH?=
 =?us-ascii?Q?qzI/HjHNoeOQ+dy3vKEEiKtQgorVDoAgdg3LClxz5iT3dJ+lV5nXfaYKA/Q/?=
 =?us-ascii?Q?y6xzEiMZjIUTzszK7oe5MSb8DMNwE+VihEdaJ3G04XS979P7743SKA/SnsTP?=
 =?us-ascii?Q?Hf9L5zLPfDR76x91rKh7a0FvTJi1Ahj9gsB32thH+kWnwiyWGswvAeoJkiE3?=
 =?us-ascii?Q?8mTj1xwiUXy88tkJnJ7WqrC5r7xh1dFirWGDmELmuGUNs6r82XDXEeThlSZF?=
 =?us-ascii?Q?uuuM0InjKjcfdUWFXlb+nhrmPNiGu2oRUFycEL5YUk6qaD3XJ0hN0pIHKjYb?=
 =?us-ascii?Q?/XnRr9TBqd8qzTbgtNxcvAmjKmzC3A5MwYLw17nv5hAa4qcJPdVxArhhpZ79?=
 =?us-ascii?Q?Y+3OLrtUVUlVRNGuJtVsRvbdKPAmOOePutygF9wz6TfSv/V6IW15JxwvV4mZ?=
 =?us-ascii?Q?y4U+x5rT3zpSD3MYxY6L2HWoOii/dYXN8QmGlJAzYzsUvQE8Zy+nu/MKH9DS?=
 =?us-ascii?Q?BS0Dg2nMLoSPakHYCNa4mYWhUe9ZhjSJdr8Uy3+UHn9c7qDDsU7LdrPL3TYs?=
 =?us-ascii?Q?VZL/91CnUxtxwPnIjXS9sg9DqL1hKHDDyHPUsCeVxVmPFxFm85tLHKmNt6g0?=
 =?us-ascii?Q?q8c8LD1GKn8y18YjnzqQSctWSe09mEshalNJcxWcSlo1/cqkXxY8Ao6tb82t?=
 =?us-ascii?Q?XKx42Q24vF5+QLY5nUlpz3bzzDdm4jmj32Ndm57PDCh/T4qeQxr7JQxlUIaj?=
 =?us-ascii?Q?Ju0312dTiiikQS+WhbqraL2BTthttv7NBnwgObnSXibL76vNNyXRxxJwzNgw?=
 =?us-ascii?Q?3LHwQLt+akEHJDNL3shFsbrEzzhslwjapTGcdwphs20qasYhGcmJv5F6D2t4?=
 =?us-ascii?Q?aOu4J9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIPqrTPrC0S8xJS+JoIU1Sg1ib91Q8apqYkBNrW5hRfeVXVAewprNgp90wvr?=
 =?us-ascii?Q?MA57BHCin0KFy48bUim6LYRpypjzgwwowxdckZitP4I5u7K/GYZyDIyARdDD?=
 =?us-ascii?Q?qnbOV07ag/BdHrs3u25TexCbponrhdsO4LvKXgMuqGsJ5MMR21GDbTCOxE8r?=
 =?us-ascii?Q?ALXyQGXdmTmwHcyrgRYeRZwGhw+nKIjIDu7fzc7uQpGgkvG0lxz/zhEsugNM?=
 =?us-ascii?Q?eP4n9Y03gJYctCu/2j0Q1vUOOSol2a0qVe3FSx5H6gT6LaigKKS8mC0BeBZc?=
 =?us-ascii?Q?hZRZ0zLyMLG66XBeN0lWqavdYlIrk5muUDSXoTm3Ym/qsBd5m3y6aTdlgurl?=
 =?us-ascii?Q?P7kp3+8TRRSmWtrFB3BggPX5lk3t02aJZGamt1HbAIhTyaECBIm1tz6XfwW/?=
 =?us-ascii?Q?NkaZqeXz+xMxHwIJtrm2WfgtW+yRaPMhJwPk49Dod7Asnli0dCRSySNKBknA?=
 =?us-ascii?Q?kv2/vmstsz4K8A3xMf6TgJZh45I36QU3Wu4dZnXgbcwvloyV+Bg380U2lEXH?=
 =?us-ascii?Q?2P09KCdPoXoiKv1MdvXKrTt6r/LT36c2WiO/oSLwp1T1U/PcnPe5RVIqbd0x?=
 =?us-ascii?Q?dQEWX5uduJWX8bZEfj8YzGHuqqAQgl7YdCrRz189YV3W8ci60nbnZidp4SA7?=
 =?us-ascii?Q?TD1kUlYy9gjYSXCJLe8CUCS+zjeTCLmZUrVVudLIVWdc2aW+Plc5qQtRvr60?=
 =?us-ascii?Q?pmU3qKnJiKYSVzVqwz1aXFFL5ZJoJYfdA5ipdc+60yZaXdy/hACBNfxOhyeE?=
 =?us-ascii?Q?0yc3gFikca2lfv2vUoyc+QmYhL5GbAXqICFhuqoGhumYYkkxj2BOQmSHwrMI?=
 =?us-ascii?Q?buRBGk7YT4Qeu31vVgFDvIB7G9H1X5MpXWGks530uYeXda/caq2IEYQmfXML?=
 =?us-ascii?Q?A0XC7MetUrNruF8pcMYq7+KyBWywcia0RuYZMV6nG5l7x9AapDKVVhRTpBr7?=
 =?us-ascii?Q?26NZlCaqCugMWmPtLIa9x6dWr6KF6UCtP5DevR1dEoZpHUjM8vzAlXT5QbkL?=
 =?us-ascii?Q?ap+/SmKwULw43jEvL6IcZwwM2v5Ev9adjQ/w0c/D95m1z/d2AF6Oc+xVaOGl?=
 =?us-ascii?Q?ahhqiOpW/XBchRTchSH09Nuh7XmcqJm2Sw2fi0SnPzWY5OSFJ8NldyPGJZv2?=
 =?us-ascii?Q?1QB3ms0+UcJxXS/E2rlu61b1VY2JVCBP6qhXIYfDhtL5iBzY6Bmpq5369DH3?=
 =?us-ascii?Q?xfGOWpYErkRuUugpOi4bS5gvQwzQInYGgUeuQCMLlvoAjsbHNCKDbtXrU8Yy?=
 =?us-ascii?Q?AgdQTNbYkJHnh5vb7xo8x2s/U7J4qohBrwjIb7Ex0qYAAuByhN5uf5E/Xq6z?=
 =?us-ascii?Q?v2GBJhg4a+KD7LZQ6q2asqPR6YvjcZp30AzrPJ0t2SAd8OfTq/wEF6SyQzgB?=
 =?us-ascii?Q?u5LhEIfCG4gtlHoLvPgAZhRdFbdGKZdN7+DDmpbUiqlNP6+uwlhlh12yGxBH?=
 =?us-ascii?Q?/uCMnA35rJzNyZvWanuBkdpw69prQG12QechnWY+Kdfet82epawz9bXavmRl?=
 =?us-ascii?Q?DD8WdYSVJiQLtVAKxqOqKdiPOYi9nnzOQSUF34TEjnJkeYKF8+CAqH317ODU?=
 =?us-ascii?Q?TDWzWjY3qko2+/mzQx5W2zt2XJ7tqeguqX7YsFQCDYfKciW+PakQLYrFWA0L?=
 =?us-ascii?Q?sLDrYT3zOK159B3Zkih8UXU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 26683fa4-9e6a-4780-062b-08dcf270afa5
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:08:17.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Occa23+15rXHRbIYz+fgZTF3mOgT6EbwoQG4NJt9mL4bCL8SbKikBvh3u54EK5mqtOislXjYQ9tzoJwLYu4vUf5QRdqGOI7AE+KruRcCLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0824

Adds the DTSI file for the Nitrogen8MP SMARC System on Module which
is delivered with the Nitrogen8MP Universal SMARC Carrier Board.

Initial support includes:
- Serial console
- eMMC
- SD card

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 348 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 2 files changed, 365 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
new file mode 100644
index 000000000000..a85acb422000
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Boundary Devices
+ * Copyright 2024 Silicon Signals Pvt. Ltd.
+ *
+ * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "imx8mp.dtsi"
+
+/ {
+	model = "Boundary Device Nitrogen8MP SMARC SoM";
+	compatible = "boundary,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+	        compatible = "regulator-fixed";
+	        regulator-name = "VSD_3V3";
+	        regulator-min-microvolt = <3300000>;
+	        regulator-max-microvolt = <3300000>;
+	        gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+	        enable-active-high;
+	};
+};
+
+&A53_0 {
+        cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+        cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+        cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+        cpu-supply = <&buck2>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+	
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+			
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+			
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c6>;
+	status = "okay";
+	
+	mcp23018: gpio@20 {
+		compatible = "microchip,mcp23018";
+		gpio-controller;
+		#gpio-cells = <0x2>;
+		reg = <0x20>;
+		interrupts-extended = <&gpio4 22 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <0x2>;
+		microchip,irq-mirror;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mcp23018>;
+		reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* Console */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* SD-card */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+		        MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10                     	0x19
+		>;
+	};
+	
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL					0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA					0x400001c3
+		>;
+	};
+	
+	pinctrl_i2c6: i2c6grp {
+		fsl,pins = <
+		        MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL            			0x400001c3
+		        MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA                 		0x400001c3
+		>;
+	};
+	
+	pinctrl_mcp23018: mcp23018grp {
+		fsl,pins = <
+		        MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22            			0x1c0
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27             			0x100
+		>;
+	};
+	
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14				0x1c0
+		>;
+	};
+	
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX                            0x40
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX                            0x40
+		>;
+	};
+	
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x10
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x150
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x150
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x150
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x150
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x150
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x150
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x150
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x150
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x150
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x10
+			MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B 			0x140
+		>;
+	};
+	
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x14
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x154
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x154
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x154
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x154
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x154
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x154
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x154
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x154
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x154
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x14
+		>;
+	};
+	
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x12
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x152
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x152
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x152
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x152
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x152
+			MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x152
+			MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x152
+			MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x152
+			MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x152
+			MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x12
+		>;
+	};
+	
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d0
+		>;
+	};
+	
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d4
+		>;
+	};
+	
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d6
+		>;
+	};
+	
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B				0x140
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
new file mode 100644
index 000000000000..4a08fa38dcde
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Boundary Devices
+ * Copyright 2024 Silicon Signals Pvt. Ltd.
+ *
+ * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io> 
+ */
+
+/dts-v1/;
+
+#include "imx8mp-nitrogen-smarc-som.dtsi"
+
+/ {
+	model = "Boundary Device Nitrogen8MP Universal SMARC Carrier Board";
+	compatible = "boundary,imx8mp-nitrogen-smarc-universal-board", 
+			"boundary,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";
+};
-- 
2.43.0


