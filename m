Return-Path: <linux-kernel+bounces-309849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2536496710D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4543F1C216E6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE5517DFE6;
	Sat, 31 Aug 2024 11:09:12 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2138.outbound.protection.outlook.com [40.107.222.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2916CD1D;
	Sat, 31 Aug 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102551; cv=fail; b=PASBoz6zRaZfFDtNAh8qoBjnR81msSXN61VL82Rt/Qc95U60AtUAP45uwh+/UL9blYtvn2cmbyouRiHVNP6ZrYsX/+LMucQsO4VlanmYMN+QCdZao3lUJB344VEco3qz9R7B60ySMUaL0J0gZe4Dmfih2iMkqyz8kj7eUPPkxjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102551; c=relaxed/simple;
	bh=BQ1DKKJUQSUOv1Ji/p6NKJhlGWFEZO2HCa+qC8xXeog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqT6Rj8tWGKy3wO7Y4fzSA6kg2udSlI7ZR1Ap/FT9hI7w2LXW85EsoyI474zsAuHeLHW8Dn45JJvi3jl6wRDUYgpXL+xDmjcqk8UrgnQbSWHT94cLE/AFchCNhFTtzAwb//4ENGMZUATpLWID28/P2hgMGHvsar5k3txy5FkHMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB6djB9xFvzu+/O6vTbZXaE9VyDYvBHMaGt6tHLdsLwN+AcO2JuvwCzWpHv1gu9mf/vVo5/guMSKEwn+3MPx3/+YzYV7RG3XuvVHA7jpKrtmTeUogY3JYQV4Vs8D7dBkHpRPpKGvmcq1dCCwW4HPTuPZY/yZtqe1+fZ3daBmaBXNmkz4GdYzNup+rx6ZCg9wKbJKtZqEit7syH9GT6kRWbezF65Ej7ebR+YuVhy65zedzihXcCZTM6VDqFcEXbbZOWjJ3/MdMHg4exFUEtr4WeZSSAGr5Lz3Ys6gZBTyrn9TCvngNzIJRSPGKY1vVituguyyJ36n+XzsmJ42lStvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UZDMQ5g5GOVCIglxpUGpawfYQcsaZgh0kem40pf730=;
 b=qrx2o0KpM/2mswjDuKg7JrQ8B7PJ77iY7yGYN78no9gSlbM5Nr3Dd8xY/WlGaiXZxAxfeO8+dW6YBN9lXLjdbLw2sgALOoiomH90b7qWK6TC2ZwhOOKKT51S/gMuhL+clAB3Q3YGTNBFyeiuB18nCCtmbzPwwmc3LBp/TDC+NapkCEFwBkAMAnSvRgXKzThGSzVoy0j3ycS6zoC1eDR/5xDTUGjBfi1VWPEx3nifXbki4y0YiF1lCU1TF1L/WeSrczvoHrv96VdhYY5UHfWQZK8eg6YZ0AfHZ3O/X0sIunAIJ8iiJz4lvz7D8dvpPbrGJ4ZAHlkQB1HKwM7YGjuM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1765.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 11:09:05 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 11:09:05 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Sat, 31 Aug 2024 16:37:39 +0530
Message-Id: <20240831110743.14280-2-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
References: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1765:EE_
X-MS-Office365-Filtering-Correlation-Id: 78080063-45d0-4fe8-7383-08dcc9ad53a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3nhx7gAfI9B6oa922GzGJf9Ko8nyeEEu25ZItGYZ6vtsTwmSP6Qg8taxppX?=
 =?us-ascii?Q?ATqe7D+VAuOqM6kt8DJlRimzy0O3RjAKzXKGy9PQavu2VJoYUYsZMdXsyvTm?=
 =?us-ascii?Q?qrVEI31wAWNoomfwuvlqiVVa/bMajDbblVGYDORWt3a07XU6ap5iR/tu/bDT?=
 =?us-ascii?Q?y3Sx8VImNcB6vQuhF4+a7Dm4rb/3Ed2sj93sWXIeVSLgCcvgBTxmJ8rgM1vo?=
 =?us-ascii?Q?aq6gGM+1LXE6qKEMhh1s8Szo8RRaFgCrWfCZYWo7lak3c99pma09MuH45QGm?=
 =?us-ascii?Q?FHfmEUmztVOcM/zqFsN4r3oE4HzHwKi/LweROKWM5oxMDpNBAWrT4vh/qwQl?=
 =?us-ascii?Q?pt6283e4/K0LQ41Md0jiUp3yigdX+qk+WMCO7fWjtQo/xo78sYBV7ftZj+tY?=
 =?us-ascii?Q?fa7QUDS3jjEz70WM8pfIou9/7tp6A4NJjJI4Oov09mq4w5Ce1MTcwuUfXSb1?=
 =?us-ascii?Q?KEYLP5FRj5NY5RWE65QvZqff0tGt9gHwQFoGlyYn4RIz/MUq9El3WbtpTJaZ?=
 =?us-ascii?Q?Rm2zH9W6zcfZFHFlIMbQ1gXCFOTikXZJ/cuI+bg0bFcVLxDoCzJQneXFZTrf?=
 =?us-ascii?Q?PUy+zKDDRr2epGbRqg/AwEl4QchIQt2aGem3XMdEEo4dhfqGNrBtJX6W9O4y?=
 =?us-ascii?Q?yTksTQs8I+hYgeDdSSprdiXOx36kSePq+ZDJOdN4TARlVSpv95D8ZjD5sLL9?=
 =?us-ascii?Q?k/1vWFCSM4Kd9M8vV2eB0xviaJH2kuw+06Rw1PKzX46TYPX39B8iRTeYjPf+?=
 =?us-ascii?Q?81vwO+JXUWm4DgbQ3N8l7ZFFfwSawED4Lg1Mmejvr3mF1GIqtc0+1AMdfcg5?=
 =?us-ascii?Q?vSnuk9VbqW1oB3NQ3rZoF9baN/b9ze8/iBhjghGHkDoBldCPYlD/7B5uRxJS?=
 =?us-ascii?Q?lPfthB27pFmf9PdI1Z39+gXQysjejZNP72cF2y0PMTF3wtuS5M3FlJu6aKN0?=
 =?us-ascii?Q?qnzEmymQg6BHqkYaWoAxFZ+Vy5AKJKk8Zrzfw+OvfnUq0KvowJevTgVxGwyF?=
 =?us-ascii?Q?rbUHX9QJQDMDeYVOJVXWf08pG4xMoAjN+4/W5djes/XvyfyIxG9AfZmxRXE2?=
 =?us-ascii?Q?J72ZNzPaWFuJsHngoNkjEhCeS1MIlUR5nDW5g+t5GCCDaI3fJgS9PGYvNr5T?=
 =?us-ascii?Q?CMofo6MXGw6s3Msw/jmAk0TqgqNXKnH6jBLkvO/BBLITOj0X7j8/sPTrixfd?=
 =?us-ascii?Q?NPLwlGlp/F6anUyx/y9LuAI2nlUAwqjaFJIrFRarYzB7hIQDqKOLoYylNov6?=
 =?us-ascii?Q?AsNj5axxe/c2T1mw1TlXHMRXYo0V1jKYJjtjncUtNgZngBtabFG8I/rfNzAp?=
 =?us-ascii?Q?UlXiC3kWW7hxNASFTBzH2gWuy2vvdS4O0F8fgVgyIxqZrhTgZB0JjK5G/xvy?=
 =?us-ascii?Q?Rkdle2Sqd9bzAdiwTufbAHSX0UW1jkFdMtxKa96UaxOIq5zcoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9aEBoXiGe8xxGNCVZqniKDzkjjKlQwQijqB5VLjLZ/vCEK6XkLjEdKNMoWo?=
 =?us-ascii?Q?PlVtojwLjNxZFGHRR2pLWAInN0MQPIcKyWKjbKNYJNBRzdrKuTlQ4A7NJT7Q?=
 =?us-ascii?Q?fxF4SWaF5bXCWFi6w6KTzwt3KI7Aq78QfBRbFuaqIuyJZMkM3NmsfeNWXqH+?=
 =?us-ascii?Q?D0sUGAq2kedxHnNWQ5adVOVpD8D6FVY4V6Zekvul5FyA65ZPqM9tyoAgZ+Kd?=
 =?us-ascii?Q?rRl1uPLngQapOy2WJ1X1WUYbJzTbGwfjLCrmCQdk8sgK3peSVeKSdc7sgrtq?=
 =?us-ascii?Q?me39CIF8e6qbRbnVzfSUAq1ouZxBq6nHeotGV2muK7m4C18GQxvPosWqdZRa?=
 =?us-ascii?Q?hJY6mDLAGXCqr1F0TpUzBUrYMYfLt0pTKLb0tPDpwHh6A/3XC26NPql/pRT3?=
 =?us-ascii?Q?C4DWqna/kY3OGK1kXww5j2exYIA9kf90VBd2okvRmqW3poRruk4auKeZZOFY?=
 =?us-ascii?Q?GT+6AOSW/l6qn66PgaQPqL6aJ77HWbFQKtzHjl1q93OeBnTFQBBSg5+2BRH1?=
 =?us-ascii?Q?K2K7KLs733QJMtN7EQUhYdanyeU4Ce5QV6l6gnve60wXopfUsExrcoSn3o6h?=
 =?us-ascii?Q?L1dSZvPY7iByKSr8GErZFHQhg/Tn+m6L3dwSdxtIJfpjERsklQC14lAJ20yr?=
 =?us-ascii?Q?cfXD9+gt6Bz/0H91r/juIhVHufAylD9wAHzmNGphvPIYgUSNzIuTkFjqpxEs?=
 =?us-ascii?Q?6S7rjz+2z71c7Qs9FjeG+4HyrYu080SeX9dYd/xzsUrw2iVpV3iGFW1hCzGJ?=
 =?us-ascii?Q?E1uAWay7EeMtDWZmP/un3wc8+8uIAPJOi8DcYU9bbs090R2YDW43bIOH7IRM?=
 =?us-ascii?Q?14z8UYqGBcOrTAxRdvSDsAXTVYMz3Jco5ipvEZ+if7o0awvHX58S2UVIMaYy?=
 =?us-ascii?Q?JXs4lWAjiuSckmv2cOEO1ihF5hgqN2ocGDouqkzeubMVB8/04xrnyH+u42ll?=
 =?us-ascii?Q?DnQbNlMZJiHfXWoaTymNZfWM07GY32Xr8vucMnRsy6+XW/gr1uGOVzo114My?=
 =?us-ascii?Q?yOGh1uMmZqjFbEVudeZtp426Qxq6k0f8FReHmisxoDm1Eq7HmIEd3J5a+0dG?=
 =?us-ascii?Q?e0PN+4OIQsfVbtBZYHk2rwnGKcub1NlJDvxfDSjifxy07YDsJl7/UVMqtOyv?=
 =?us-ascii?Q?34Rk4pSXSiRItvItDxR5j/uopxipkv+9FTnMsB4HzyPrM9fnDUJ0XVgtIe+b?=
 =?us-ascii?Q?4hgO2DFVrLz5LSWtlVbNl2ZypNQYGWJ721JWKOwRRlv0nFmwU0z/kAX93it0?=
 =?us-ascii?Q?RBHQSOCQ9YgF1PRBHy3AWb6GoIorRDnm2AvylIAeIrkLP2RpcLcO8A096rAG?=
 =?us-ascii?Q?8YKeTBQ3VDpFRqa3NvEGMVndMAAEwCz/LxPeQo2ow7+jcp5dHAeWvUCPjJnr?=
 =?us-ascii?Q?WywOfLrqGMxAKJKBdMsYda/L/tLBGGLnXiOX+ZQK1BQPU6oku1CTNxGxoBjT?=
 =?us-ascii?Q?SRXMjqC2SX9lrO8vo/cUH/r0kvjfAEYOUE3XE98OUitOc31vM0UqNmGcJkxS?=
 =?us-ascii?Q?yFgfi9ZGi32Vc6h8dtENWXvN9KR4cvWa6mzaHWJMpbnvkVPkX76DYM9rI5q8?=
 =?us-ascii?Q?WOBzhcwua5V43WbdbpETrSFulhl76/vdxof7gOkVDd/3FDmMRaeVBYXHctxp?=
 =?us-ascii?Q?DkiFKrglP0W9uxyj3h4+4FQ=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 78080063-45d0-4fe8-7383-08dcc9ad53a7
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 11:09:05.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O99DuCMtkx14VAULBP5aKq1YN6zLHv50tMLxL4ZNmOv/RBbqHvPw8cDEP97H/ceYsYaNHNKXt0YwSaJo+SUpxkeyfp6uXl7cHD1pAcBosa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1765

Adds the DTSI file for the Variscite VAR-SOM-MX8MP System on Module which
is delivered with the Variscite Symphony Evaluation Kit.

Initial support includes:
- Serial console
- eMMC
- SD card

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-var-som-symphony.dts |  11 +
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 361 ++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..03db6aef757d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -177,6 +177,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw73xx-2x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
new file mode 100644
index 000000000000..36d3eb865202
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Variscite Ltd.
+ */
+
+#include "imx8mp-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8M-PLUS on Symphony-Board";
+	compatible = "variscite,var-som-mx8mp-symphony", "variscite,var-som-mx8mp", "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
new file mode 100644
index 000000000000..0b08484e8319
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 Variscite Ltd.
+ *
+ * Author: Tarang Raval <tarang.raval@siliconsignals.io>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx8mp.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8M Plus module";
+	compatible = "variscite,imx8mp-var-som", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+	
+	gpio-leds {
+	        compatible = "gpio-leds";
+	        status = "okay";
+	
+	        led-0 {
+	                function = LED_FUNCTION_POWER;
+	                gpios = <&pca9534 0 GPIO_ACTIVE_HIGH>;
+	                linux,default-trigger = "heartbeat";
+	        };
+	};
+	
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+	};
+
+
+	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
+	        compatible = "regulator-fixed";
+	        regulator-name = "VSD_3V3";
+	        regulator-min-microvolt = <3300000>;
+	        regulator-max-microvolt = <3300000>;
+	        gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	        enable-active-high;
+	        startup-delay-us = <100>;
+	        off-on-delay-us = <12000>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
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
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
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
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+        clock-frequency = <400000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2c3>;
+        status = "okay";
+
+	/* GPIO expander */
+	pca9534: gpio@20 {
+	        compatible = "nxp,pca9534";
+	        reg = <0x20>;
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_pca9534>;
+	        gpio-controller;
+	        #gpio-cells = <2>;
+	        interrupt-parent = <&gpio1>;
+	        interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+	        wakeup-source;
+	
+	        usb3-sata-sel-hog {
+	                gpio-hog;
+	                gpios = <4 0>;
+	                output-low;
+	                line-name = "usb3_sata_sel";
+	        };
+	};
+};
+
+/* Console */
+&uart2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart2>;
+        status = "okay";
+};
+
+/* SD-card */
+&usdhc2 {
+        pinctrl-names = "default", "state_100mhz", "state_200mhz";
+        pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+        cd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+        vmmc-supply = <&reg_usdhc2_vmmc>;
+        bus-width = <4>;
+        status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
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
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA4__I2C1_SCL				0x400001c2
+			MX8MP_IOMUXC_SD1_DATA5__I2C1_SDA				0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL                                 0x400001c2
+	                MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA                                 0x400001c2
+	        >;
+	};
+
+	pinctrl_pca9534: pca9534grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15                             0xc0
+	        >;
+	};
+	
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04				0x1c0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+	        fsl,pins = <
+        	        MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX                            0x40
+                	MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX                            0x40
+        	>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14                             0x1c4
+	                MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22                               0x10
+	                MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12                               0xc0
+	        >;
+	};
+	
+	pinctrl_usdhc2: usdhc2grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x190
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d0
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d0
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d0
+	        >;
+	};
+	
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x194
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d4
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d4
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d4
+	        >;
+	};
+	
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x196
+	                MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d6
+	                MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d6
+	                MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d6
+	        >;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK				0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD				0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0				0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1				0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2				0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3				0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4				0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5				0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6				0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7				0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE				0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B				0xc6
+		>;
+	};
+};
-- 
2.34.1


