Return-Path: <linux-kernel+bounces-377732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29F9AC335
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7F3280E69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF6C1946C2;
	Wed, 23 Oct 2024 09:13:24 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2124.outbound.protection.outlook.com [40.107.222.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869F15B547;
	Wed, 23 Oct 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674803; cv=fail; b=Vo4tKwEvyZFMezQFlG+Fci6hiz8mUJh2Hy+cdAHYvbZ64N6x6RmuGurWPtWnQDeGX2umUc5fe1c9oRl25D1hYfsQSO9zl5I19daR+1MR85/Zcfmh5JzIAwKfwWJXYCUISYt4K1Skek1oVhXTunaSBrngTxjWB7LO7gotSo6vg5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674803; c=relaxed/simple;
	bh=ky4Zd4fEHmQmgwM0Jhg7yNG2FMjjfFuW88orTk/FrRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr/A9PUDKTf80RrtIHGI0wbtWzRV8z2ozn3dL8L8Fcv8eXFDnLacTRSAwO+qPUCCkHyLwsuxQWL9IkEwY+dmC2zWfLMhBrsRKITjuofePXZC9p6FDNgGoBB3C3Lp8d+oLOQcdsyG98diSW3//KSbu4hmwf6N8OhEsE8FfVPYYoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5cYilhPlJxGx/KTeEnwtjhV/axEIwUkPD+vpU0xkNeckLHn8Pjmm/3HqozIEiWi9EqbzE1vQmbWZPxFGoWUNo73Ix5y3RiqOUWr1HXmZGiTYQrxHtv2vArwuTVStL4Cw+yd6EIKegtwVzlkZNypRzf7QbdvnIEN2YvxzKEAKqCWp9kBdwDJWnXGeflcw8p7xmP3kOWmK7pv6eKPtja5YZqQJIRgP+vtUTVcWxN3d/VsgHdGMeGoZEGAyT+sKix270DoWE4BP7OrNW8CH/pUZTGmA2US54AGqiImjpFUfw5nwAwMTgeLq3upWaD5pqrwnpzVVc5/yolXK4/1ZkYwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nHDwngDuikEiVqabrfL6YLjsMaoHNcKSDP5vVsmX7Y=;
 b=jtZurnKNPloQL/c8tvOhCIFWNXQpKoUElpfaSvdsPKMAERKryOB2bsNMF6mUOy4C8itRKvrhTa8C0tC/QOOHHRNBjC9DK39uR7glidgNNUSZawurDd6PLSj1cpXZUkiPFJHxa+0EKExLzZ3HYOTmw1dtlnmGC07ezqxvzIylXE5DZyTHwRPA3QI2rk5HY06HMmIvCUJkHdMLCGbr1Dp1lRVcX4ZFxsyrQ0BwiHUVBBNKZcrzuI7q/jYRrEj1hAEwFHedfMnTIE1SkFZqKs/tg7yLq3gY9GyDsnZ6iZImcWbZbjyO4ABOtxXcD85Awi/sZaLbkHHHdmtKvOR0ZQpoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2PPFDCD372071.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::153) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 09:13:18 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 09:13:18 +0000
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Wed, 23 Oct 2024 14:41:14 +0530
Message-ID: <20241023091231.10050-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::6) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2PPFDCD372071:EE_
X-MS-Office365-Filtering-Correlation-Id: e45e11d2-7283-463e-4e37-08dcf342eece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jsFLwV7X746O2oxfgTQse4pbB0ExztNUq2VVyALgjebFB7T/DCAt6pVveP4l?=
 =?us-ascii?Q?draYsQLyOprhcRR2eXTT6W2X9G3x1QImejSBJ+gktG38bN2ujKACDmSB8bfw?=
 =?us-ascii?Q?jiEfQ2Q0C5nbIp7Ea4aiEJG4EXudFjrH+Prl3voGVrevhcfmH1fd+3Znm9MA?=
 =?us-ascii?Q?/ZMPIm2UXj2cl2LPwNLAFhDNIc4RJex5lYYVKjvKONG/bMbOGH5TxfUH4gp5?=
 =?us-ascii?Q?COIl2pqHpX1auIN7opbhW4OdqU6bnQXrbOqKKUsoBoEidRNaoEnH2h+1hWDk?=
 =?us-ascii?Q?yQgxyPt3XO11rZKbMgLGgSY5Vctl2SQ+1aSwkA8N6tbeUMtJv429AXAA5vmH?=
 =?us-ascii?Q?6ScUblk07tQHGgWUsw9FwfkXBZoOrmKeUJiV6L/Ec3ESWOcKxXwZqwj53rHj?=
 =?us-ascii?Q?IGvy3dYH7kgSqRb2Nlm+YQUPzA1JL11EoRjIKMhPy9Wsujdv9SIZA6dvfovN?=
 =?us-ascii?Q?Ayh3MQcc3jQfhkzwovyidbeQH7/MJYMUgfhuwl8BQVoLsXphXY0Z0GlIiOxj?=
 =?us-ascii?Q?oJ0DoSX4Q170QqoeEoI8H5jY3WtPM5Qv75QJcsqq2bN9T9v1jexy1nMzflYI?=
 =?us-ascii?Q?u3KEo44yAm1neFRy/YG2XNmboPRbz0OI0icDoJs6wMSRzrr/M5EqPFGqSt37?=
 =?us-ascii?Q?K1+tQsqWB+O09vENY9EWEHhQIRZbWAC4IOGUFnN5++qoyY18cmV8S3NDuVl0?=
 =?us-ascii?Q?I06MPthHx1Pw0vjGZ3Xw4LlpVv43x0G8HGPKS0fXrki6In+qveF460QEyQ4X?=
 =?us-ascii?Q?GpbiKJbfn4k0svXZQbNTahHIVrwqrBDJq0/P5OTivl+bv5bxmQ+BRtDDxuaa?=
 =?us-ascii?Q?yT6DgLIcVsH3wVf1FM2KxnWlL0GU0S8g4Oumep2qPP78k2g2JH0ZihtPi8T/?=
 =?us-ascii?Q?IWS7WhJ01b7IM1RXd53p2T73qVModvKAvLYqRT0UHokjb4bHHOeGd0oTFDUv?=
 =?us-ascii?Q?teXEWWxUjUcFkipdeOrYVkd6rxcsXY3zIQiBoRS74Yx68U5VFq7xdU9j35BR?=
 =?us-ascii?Q?r6l/LzwLn0i66N/nLKGQWPTvnB7TDibQxQpAjfdLlNDc4DFUH1OhN4kkm93o?=
 =?us-ascii?Q?fkKa9xHz7V39zCCEBxTe05bFVF451s/8XNZU/M1yD+x5KyENgPnpkx0gw47+?=
 =?us-ascii?Q?qHz6QL4L41tru710QL+iUutjGHL1ZlfY2W4HYqBHPbURJQLBLzfq0GRydXAJ?=
 =?us-ascii?Q?gAFCfbQqaThn4to9c+Pm62oDmrKvS1G2nJMx6lnw3htYWpSXCyZafbAj0nXs?=
 =?us-ascii?Q?racKr/FEydYNIkOJRkY0X/HsVu6MGLwB/lfobYMt4YS8ypZ68mS9ylVhQKGj?=
 =?us-ascii?Q?IHEufTtCheQCu44dz7nxqpmINTclW6rOZbn9RV7O4nM3OUTSh4X5AAZL03H5?=
 =?us-ascii?Q?Lgywxsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FE1gxiDP3XL/CKlPoZu8fW6jSOka8trM4ViRXWlk/RHsw113CeiCfkl2vYY7?=
 =?us-ascii?Q?ib6KbbKgojwOtxh+Gs2qYEXM0HB85llhIzznTWAUprrhVlaL4Nb5HONIVh+s?=
 =?us-ascii?Q?7hAR5xmO56CbHY4YyBCqo0Or1gUTGrlU6GKM2q0j9CZSbAEkfaTf6v4m6eL2?=
 =?us-ascii?Q?2tdhPMEsiSB/vNpAVuoNW9QpJI5lfHiwGPNnuVOvqEDYpvGVv3w8qr4l6kod?=
 =?us-ascii?Q?743ziS4/FCgUm1X3Cb7K8yntKyHPnLeX8V05JuXF3OxLBrji3Wnur15Q9oGb?=
 =?us-ascii?Q?rK/NgAz1icj17KIfLZfpDxogbKdo/ojEZsF5a9iGBJbeLjwKmNIDE0QOlYyL?=
 =?us-ascii?Q?Gwh/9XtbWxl5J3VbMa8qXGex9+HPMtAkzFEOnpczJT13amazJ/3mKR7Q+5yd?=
 =?us-ascii?Q?DUdooJLUHJn99eeIBeJKjomy9TkCkgaQDA7ziJG6vnTKRYSKJLUjTAlT+SZ5?=
 =?us-ascii?Q?xZxmbnZNYj6Jli7Ka+KvQ4AaFEniNXGHEbMHlrV5reS7rsoVkhByb7vCkrZG?=
 =?us-ascii?Q?7Ll+tNjBM7syE8xb2udTIrYKeaZQzyKuRN2hCjonJdUr6KuwYgHIakXReso2?=
 =?us-ascii?Q?Ky9whsqLLhjNO8eYOmpI+537MATmoB35rAB2w6ICLU60rRUDUTJFJdqkU27P?=
 =?us-ascii?Q?cT1sEfpLl7n2SGeULdee3pn92zQdGv2ciKl+kPU5fPg+1o8eTEmfaQIfSJk7?=
 =?us-ascii?Q?zIv6mlDAkXWhtp1DrF78T+ORL8jNYwKLesaodsEkAGUcE0Gwwq9zCcXUzWb3?=
 =?us-ascii?Q?s/125e8Y2Mrm1BLhpxsdFJnu86v1qFXNBeTjJNNEu8O+0wbS3xUqtUnVk+NG?=
 =?us-ascii?Q?3WCrw05UoycpUFvreYIvNyvnM9PSJSWVghXzh4jz5FuBUYnZCkpCUTozl3C9?=
 =?us-ascii?Q?d40ZKVhTWwjBT0BEcC927YrNZcB97/knUVHYTjXGsu+ndcSslHvhNUaNSTp6?=
 =?us-ascii?Q?rvGhTuYpVr6XCxnwsdfSGc5sf0vhISF3oBLHEhAI3EtYH4IuFX1xA/D0BoaB?=
 =?us-ascii?Q?vaKKriQI3AKS6rU9VOAIq7Fi1+HWf6Rrcab0f6L6V8xE/x6T6IEp51ptb+Zq?=
 =?us-ascii?Q?dLNmm77ihLCisEYCFyb6Soynqm9mbFomkd0ndnIauXlAWXicend+huVae7GW?=
 =?us-ascii?Q?1lgcaNo5hpSvC+ZHn7SsFykHeUcuV8M+ggte8Z9EECLJbfeVqHryG/fWXYBV?=
 =?us-ascii?Q?Ef7UW71qRLpPBbBqGbdJcOHmBDMj1JpSRMZ3t6AysVh/vTVbFrsr2MHteq8Y?=
 =?us-ascii?Q?K6/6HGkPE6Cw63OTL0qu1lXavHePBGU+bx6o/jdKgtsD2In6W969NgTF0y9M?=
 =?us-ascii?Q?JmAn2S8ZYkxdtOcElGHGOfKjWX1xvtotPk3jziH/bbUNY8q9Gj7itFdJsjNG?=
 =?us-ascii?Q?CawDaoiLjp91UdnQCJEDDpdcdYgdsO3y/y6DmUV8x6rlaje39AcxfZY3CtiF?=
 =?us-ascii?Q?jGzrMy8ql9ATLtrl+CpkBUPzk/Cv1KCWpJWt1RrCsVPSd22svFgBoL/yjxDl?=
 =?us-ascii?Q?Ew8bu4HwQVFYkymoHQBu6IfwtcLDT90MdxQrxHSTnHc+iHtHi2E5CjVbc3xC?=
 =?us-ascii?Q?Nle28XKKk2ORynTMMyjqibgIfaDiSUiEIQDtjnLJTMczEft4bRvJaeFLhNFj?=
 =?us-ascii?Q?zJWo0mOH4RHJcrEUdX23wwQ=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e45e11d2-7283-463e-4e37-08dcf342eece
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:13:18.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lya1HeZlWyvzy3w6ZyQwFMC3jq+bG5cEZTylaXOk8hnwZGFErNtZs+dYrF+9m0KmVlRyN6XXZR+Q/Q97wFXJOfNhQHR3RRlRmQcWg0v9gHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFDCD372071

Adds the DTSI file for the Nitrogen8MP SMARC System on Module which
is delivered with the Nitrogen8MP Universal SMARC Carrier Board.

Initial support includes:
- Serial console
- eMMC
- SD card

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 348 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 3 files changed, 366 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2..c7f4cf51dc14 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
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


