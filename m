Return-Path: <linux-kernel+bounces-298826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0795CBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA70B1F2487E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BBB184550;
	Fri, 23 Aug 2024 12:02:38 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2117.outbound.protection.outlook.com [40.107.239.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82072469D;
	Fri, 23 Aug 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414557; cv=fail; b=Ew+BuDMAGt0HI3dI3/dvfxRXH+lvW+h4Iq9Z9cGkQY9qmV5W+56eKHPHc/RBsVIHqD51IjQO7/PEw7QmFpzlkErxPUBBxZgJxwqAwtnw4D6JA+QIlp/ctSiQdXHF7AbvRa8b8e5IzPJG2Zm85G/JhglaZs6mi4oxyzoe3JoOjdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414557; c=relaxed/simple;
	bh=jWteFhNpDcHZNqeRJOLEOCYn7WJ9Y3W05JA7k2SWHWc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rZd+Bi37jR2oUe/shmPulf2qCXPKvJG7s0dOcbGKcVc59ssEqxh6V3PTfM7yBxwf2gzFePiU8tbLT5Xhb2YCPKUgH9TB9dJTU9bXcSXQBI6HB6FBHhTHZY0f8R2cg+bEJ0UCRBx5mnMuqPR0jppwHHZEmcPEvUEkNSgHpmii+sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crEq+zNIx8jC+1G1pKHkTGeDFD0a4Y8njMn4hv2ZtKQpVdPBQ+PNYn9eDbDjgoM+KP4zOAJZTOGixS2t9p51PA2InviEMRV74YZnnHveus7a2hIHnqlNdPXaCMAAnbIxEHhsjNPhc2vAq8TrVABc+p3VS8UDgZO5lNpHCnAcy1R0pmqUJ16YK7OHlZEqn42F8fewaYZc/rlDHyauiz326TRityJ6NRefvE6NRjAfErS8O0cu4mSpXOUvwryUPCAGv57BYrZIs/MVQ2kPVFzOxCwWDZKzkzheGU9RItoV0cJ0x1OlfYri5jdchHgx/bdlCI+qHOrL+ZcqpDN26kSB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjoGFFa5Hi85x84opZ/Zn0KkQjKxRk0lUEGbDlyXJsQ=;
 b=ymm71Ez2TKucfKlz84smu5treZM3bmlduCJfoHkUlvGqfBYmOW12BMVfBBbeEKarGko5QwcflZs7tOveVhm9pVYeCNmsKSETpLZQTQoZFgpw8nA/GsgFnGJDZn6yv3v3K385SV04JvpvldFtMpce6w/KZ4pknnk3EjVx5HZhcTtffWkMfVR5qMYczfHVkRq/M9yMV+vUQeudnrKGoDm+rhj/NlPUDA2r+MyXVSpQJr9cWsCF/iUnWX2lXot9rq78wdm+5ce82d8jSK8mzHSjvo+iOky4JaQHc7A5E6xO87x//fPb/ylabG+lP5w3RSnl4C/tMtnirfT/krkbH7V3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1583.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 12:02:30 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 12:02:30 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
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
Subject: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Fri, 23 Aug 2024 17:31:57 +0530
Message-Id: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1583:EE_
X-MS-Office365-Filtering-Correlation-Id: 400c5955-ad13-4c7d-73a5-08dcc36b76b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QvI0dNpnXSU0qEdPRqdpNTBkrKZ/V+KnAPer/yTRzFYG023xvmyCk3YMr7Ht?=
 =?us-ascii?Q?A1hqFIGJrFx6QewfvX7YzDn8+axQc6PifIgkbIGlTvxalIJr9eYj/bB0KyNQ?=
 =?us-ascii?Q?3gejH7AEkJmAp/WW3vGPiGioyYIB5fV8QEPdI8XHTuH2RYdxAZGgjL1ShFqS?=
 =?us-ascii?Q?k95vH7ox/Ta/2SCMXFyqdvnmABJ9Z6CPD09IS1p1fpklpUrQ/1D8uCvvRxWM?=
 =?us-ascii?Q?B9v33JamJHrACoPSb9YvHtXwCm4em1d9dqzYPn3xgXsACjfHGZ0Kz5aVfjDJ?=
 =?us-ascii?Q?uGwC3PsKnkBPNJwuzGm8Cmaw99dwmouN6VFkRw/gl+xJEe4CeSjDKJXR2+to?=
 =?us-ascii?Q?zsz6l79Z0dbrHt6bGD2NmzzXDE/TTRFo8/JwYRSwQvb5gy6R0Hcc1dX0Bbp9?=
 =?us-ascii?Q?Hd1yU4H/TLQwdKPuzIMfBHImLkZyhWpQ6xZ3PvpNcSkN/+ZuMEFj1FXMTeia?=
 =?us-ascii?Q?hk8+jllPIUwkYrxIdNwpxOiPHHfJokulg4z6+TSBgyh8LWUjRSrQH61OKqdZ?=
 =?us-ascii?Q?c9v+Q9iP+Qf6WdEXJaRHsPhxhZvDWX5V4hf5NFgk+5QtjSBraFh9dv381GBx?=
 =?us-ascii?Q?W7J1y30vSzkJo4zUPNGC5xAkmC3j/Jktp9ZACbXbLPa0K+0DHdlbDt0YUv47?=
 =?us-ascii?Q?8kypBtqIYwO4PoP7g9d9IWOGbDGwQIVWsMG2Qp45L7aYeZc+ohps6gqOueGt?=
 =?us-ascii?Q?Gy0kM9TYlnM307qF0xS/ZwDcU168aHdGnAgq4S8A3dukgYb85ogDwIgyGpZW?=
 =?us-ascii?Q?5hxN6vHpPqNxI14/4MjxwSAgJHUbBo6Y73mRIDYvHx/V73yaywUmLzmoxWna?=
 =?us-ascii?Q?3hyQjxVMkkJhC9u3YYmCs5O4I442/v5/AhyytI9uiSeyTG2MqSfqhMJnNKHa?=
 =?us-ascii?Q?MlpMHjZG2/5VgD3waFdsYcUk64Low1GsMzNWoMS+0exSHPwEw8v//GL2zNFJ?=
 =?us-ascii?Q?8Of/wXXazUZYYmffuDU1PzOh4o2F/B7eVgnbj+EPUfu46P+Id4Olv3PoSo4p?=
 =?us-ascii?Q?0oGoBMGKOLvNy5vlTFfWwqv11jeKjh74OHUcVxOdv59RWcjrz4fMlvuGh1O2?=
 =?us-ascii?Q?lNuK29jvug4AhPgyYbC9JwkaYANlJdOwmXbQpUXUg9/vVgba4ZE6eL8SArvN?=
 =?us-ascii?Q?OVxnAJlErpckPeB94C3CnYYLP1TZlLKdB4EFLd5N2f9nQZWrtpUGHJfiI797?=
 =?us-ascii?Q?FNDRjFMp/HtKI4MwS8ueuHUtomw4+RIg6KuiIZeAY/ECia3c3h2hVd/gdAdy?=
 =?us-ascii?Q?mBIn6plCsiHkVx0o88K+twFcyRbkL3LpKCmbP22RZgggw/nbxPUqwfC4qPQZ?=
 =?us-ascii?Q?mWH0vzospV8sNT2XQ8y6PYC59K3Pk+WO4WwSzpxmZD+HxeBBmlrP4iMac9GB?=
 =?us-ascii?Q?nYHmZ6TLM0zN/QcUQjQUhk/s50tJneTYq5Y6CtldrSAWFC4NrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jv849qclTRBVmLI3pI/wpPrbBBu2Ssqg9dx8VfaHqiSiApXF7l9InLqaM3Fu?=
 =?us-ascii?Q?mfxePOXHTJ0SacO+RdQ41W+IUpQIprCPw0hVZcPYGVwxulY503ypbyUp9OLV?=
 =?us-ascii?Q?uDzyOEUegj/pZD6QtS49FPZBJO0wnvjQZ86zHb9jPXFeTUBMiWBnGuyFOxp/?=
 =?us-ascii?Q?9+PyuPnF2p/cMWKYA7h1UqAke54/vptq/JLQIgci8RqKZOWp7OqsLSACa2i8?=
 =?us-ascii?Q?m+p03SE+ihYCf/3+7ipPCPsoA5Jh/Vz2nw/FAQa0g3WYhR0a3GgssnWSzMII?=
 =?us-ascii?Q?FjnWc+KUTTySjnXXacTYIzA5f6Bmye5GK8/fpxT6o7Fzx5CKYhWTDkmYvM4D?=
 =?us-ascii?Q?lUVP7+TkqkzXkG6WECwI9utMEbiMUi3uzqkqny2/B2kNknB6OPBOsBBCdZ33?=
 =?us-ascii?Q?3CrE83AK2nHWPKD802jErum7KFYNW+3wdA9cE9+Uu9nsXRo41iTzRMYZ6eFe?=
 =?us-ascii?Q?kMzltmVEqO1va+PUQnv2HFJQTILrmoW2VrwAbWTxEb60VmcJVI9zIq3AxS1N?=
 =?us-ascii?Q?EnSpGAauFuVQYSCuP8dMflZ28t5CiQtmWxSKFp3Sltyx/xDZpsrywgkIpLo8?=
 =?us-ascii?Q?cUDaAZcmqpu0oD92HnLoPChH2kER2p9pXGGz9QY5tPTl5V69D3u4ITyQBJeg?=
 =?us-ascii?Q?FOpz6honBG5k4dA4FzG8/gaZX9CU7txRBKoEVpeDKE9kJH9aRaCgz7R0hD35?=
 =?us-ascii?Q?6V2O2LtS0OdPWxI8tUmDW5HXrUs217q7jJwM/slRGiHV9vkCyaLarVX02qPr?=
 =?us-ascii?Q?MGlbE+J4Slr+9VLJNPbWhQcI2icXbAWX+W/1iYzzIO/KxK7W7Kz07HZi3VpT?=
 =?us-ascii?Q?akSrx29UNmBG0VyDiZ2kXi56nSFm1OkzPrll4BmSEj7z+nFX/VemzoI6iUwR?=
 =?us-ascii?Q?lt6K1B2agtPuv2iNk6451NRIRiM2PdInbUtc0B+Nv9wW/80qpP/63jErWgEh?=
 =?us-ascii?Q?CBtm72dBsvENZZAmbnZZU6NKqPHP/yPPyT7AtFRLKa++d9Ub9yFOhsvOJhTX?=
 =?us-ascii?Q?PRpJ7Q/NY59VaoELm21ELTwlhCj5vl0Zfh5j6SPWmJeVH7aASwQodpl+4LC7?=
 =?us-ascii?Q?zFTPRXLRIbya4N6oTVzCjLNEIOENxQnOX7KDtPelwmLvKvHe097pI80gYRYY?=
 =?us-ascii?Q?YpS7l8/TLzHiGpmeZ1NYvxbsfG/yIJJuj9FaJCuKVdB7K7nY5NMB1P0ed5Zz?=
 =?us-ascii?Q?a5fIZdA5ofNf08I4k4p61fqmzwHSTqqEKMos5WeMTkylFzok7c89D7bQcutk?=
 =?us-ascii?Q?OVl7isEpCsfCwnmTTF6phtJ3bbkNWAwwpKX3k8PRws15DPTrwAwhm5H8Yb+d?=
 =?us-ascii?Q?vIb76Nu/tUZQr6VLmMQ8H7BGO3bE0+4EVQGnZbwVTbA396GqSIM3ZOT70rXa?=
 =?us-ascii?Q?g/2PukKayYsR9Zo8iNBcOQMK38nDZ1fBgSqi+fcyp+BwYG6dAxC++rTES1YZ?=
 =?us-ascii?Q?0ZERAzMRfeXT6oqDytTPBHGBm7f4s1+TDooEBqulh4JYYF1TQR6Rmow+BS/7?=
 =?us-ascii?Q?IBVTAjgkFGiYfREDMAuSphOPfc/N2BweNmXwIDiZj24JzH/EbEtmMAg8JGs3?=
 =?us-ascii?Q?gnMEj+4mdkHKhth4+a760GlYyaDlQdCdoECuoX7MUdPWRUEgmvdxGCMstILx?=
 =?us-ascii?Q?VqJZ2obITCBYUdIm6KhODoc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 400c5955-ad13-4c7d-73a5-08dcc36b76b0
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:02:30.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PevpIDnaFfRNFb5mqbCHbwzzhb3QpnExpGeeuj6GDuDG0ixgium8zSDKsqeK90Hudz2c8sXGigVh0Q9LLws60XtzdzZqDxXGSBTS5/osFxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1583

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
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 326 ++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 7d2cb74c64ee..0a7c8acd8f5d 100644
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
+	rtc@32 {
+		compatible = "epson,rx8025";
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


