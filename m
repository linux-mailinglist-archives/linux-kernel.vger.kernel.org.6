Return-Path: <linux-kernel+bounces-311435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7F96891C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1491C2214C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED919E993;
	Mon,  2 Sep 2024 13:46:06 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2109.outbound.protection.outlook.com [40.107.222.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B892210189;
	Mon,  2 Sep 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284765; cv=fail; b=lcq+IE3NbxvcOm5BQQyriVxYB4O4lB+p+eqYSFKbGeKVPSaRL0YSpPKAjeVN+x7TktoLHGCmEsPIIxAgN4lVVgOkyrROGPT9IG8zgzEr8Iu+LzaqlVUbCjyOtCIIN08sqbnXvXC5eMCNf+MEauYgKfcgglbmwub0O+H0BY7vB40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284765; c=relaxed/simple;
	bh=/pXygvHWoFh8vkMyIpKc3a08c11LHIE8Qoseudy353c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLKYzjLx4240UIykLqfNdFvzkHfe46vY1CZjwQJ5dVJqqVFgwkMFZKA8ot73GuzmflFPp2V5Dr7UkD2YIfiOSFH13C2Hng70qVFQaRa8MxGp4sbW10R0Fs4gTpkxABfzYdxLJTMCFwvQbuwLLqHEghXDHJa3Z6g4dYpSGmpWmyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4hCaeBzHpUEAlqkTIxvynlnusWggqDxYrvKiby+Dxu0Mz/rd7Bp6P+HVIsRO3ifukjg65TwwTgwAvAKAKkPzLCCCmPBUejonS3JFgdsFo3DGn+dnJPtbQPHCNgnBV38ovJzYg+OMRVPuMvv9oYy9xT1VCgKXFPSZ9DVIitH1y+uObRvVBge0pES32FmmTo4RXC6ZvHYbgYV6l6zd3GuyEigcXkY7CXLmBZ1mpF7Ed/S2e4oxUteBfkgSeF2/xLINI5mAo0FKv/yKviHo9Wj9k5MsiOPUPaTV7HhzI+QcIF7rtf/070APPtpo94ZYzH707A+8/2V6YTCL++qJM8JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH1N2R3WS4RhypAQ62IQcBoe54d0Ly7aXaNzjK1DnVU=;
 b=jh3VpDL67nWYulg0Zv62YzpWmYm7ZCP3jEqD6cszpI7diAw+Ptf1/EHaJE+77KRCrP1neqo7j0REPxy0rP6zSGmIlSJAA3KT3dRO+zFl4tfbloZ/5286WaBTV6TGWOUNqTRKC7Ee8E+fiGNCqvd16FoEOovG24VbgVjX3iQqOlm0Ss5kt6Z4R7M6eRyxWD9waJ6x0U9CvonBffftP/kQkOtuHe2BQ/eEjkP/585lYql6W4WzCxVOCX8InuQnlH56KpMVIQV/K1knIoG/8KWG+CAyVT3ar5N2kv6iXVsSoY+unK9g1K53OEL2PREbQGmGK0tg3udarxsCoNmGDQ7Hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB0597.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 13:46:00 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:46:00 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 19:15:07 +0530
Message-Id: <20240902134512.16717-2-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
References: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB0597:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f24d421-65b9-41ae-ad6a-08dccb559441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+CYLnECtONcdJwqKin4wLbgeBhezlkNcui20KEg+vuGT3kuAEZV+/yl36LfJ?=
 =?us-ascii?Q?aKqlRM4OAHQUX/wsZI+NAhQsuF8yjmLmlKNgunIzCF4iNjuUF5cuu9ATDCzB?=
 =?us-ascii?Q?CDVCeLBRqzoTLr3s2J5jg7EQa0X4m4JQPq/NoDN+qwgl9UAzT4YvT3RFaBgR?=
 =?us-ascii?Q?eErQy/0a6xkqnCNcIc3frzriNbNTpPwcJnsdCKMFxPsGKX/VooorfXyincLv?=
 =?us-ascii?Q?iQjxFa8M5t0ASGcY7CUxGcZxlECF7Z6hflN5Ew46+qt04/2dMU30MYolfv84?=
 =?us-ascii?Q?SAFwIRvbmjgBBwHnf1dGGySxsvKmlL5oSUGGCI8dGSfgN1baAN10VpWZIywR?=
 =?us-ascii?Q?F9qYuDoKNo4JtpcJRK79oYPOpm7T5cE5Jgqz4WjGh+sr3LkgnLkHTl50EviG?=
 =?us-ascii?Q?ljFSt3uYDhLw942ZYZ5Xn+1N7LTqsNCaRBCwzuj9M08YyBsN7lLHsuUMUnJy?=
 =?us-ascii?Q?E7XyFALC1v1mBmRM7sSMAkuKyXAGUrGh6jnRaBiD5bvPELAufTHl85K5ByC4?=
 =?us-ascii?Q?lkIkZXi2Ou5OyrNBJCqFHdSOgH6OHYCpcTqa2MWCubRnvutvZjgbYKxkYdOA?=
 =?us-ascii?Q?RbFovLnbwxUuCtkL/aJO8lecXZtfhY5Nv4H9t/9DBkDpQjcD2kU6GxQD7Sht?=
 =?us-ascii?Q?kB600o5qBKZ2GYJznyAppowqRAbTeCz8mSG+2vr5HwBNT6+TXbWswVneMH4X?=
 =?us-ascii?Q?kh77zyaHl7O9lb/D11QQxqOzla1UoWOpnM8onquW16ePPFtLw9sTdFUidisI?=
 =?us-ascii?Q?zUmkPRu/3Ln612YqtfwgcSKOSkBYfW0iQC7OhC9lQkjDSuBMTlp4mQGN2gii?=
 =?us-ascii?Q?sxENidSylcUc/EYKekfDDhoFPeClrCgm170TFOp8a98L4fiF8Mm5K0WGD1k0?=
 =?us-ascii?Q?S24bwm3/ZPDI+flBdr3kPhxUTOh4Xkh9Sf3AyeFv40D0Qoc5uwtd4H5whZrQ?=
 =?us-ascii?Q?bno/8ydTrBqHkUTFOzV214UDPedbkFjOeiyUwal2SgjyYjrMC8z4lN8JxBIn?=
 =?us-ascii?Q?01pxRMNjlwQ+W0cVqWKxhNqcDGqlgDOTpWkDw1lc3iY2jpVZwAs3QiTqimu+?=
 =?us-ascii?Q?/hgeR1Uc3N1Zn4L+jpyDD7QFQmgpa6Z9pv2WPOSczq3GoRgGJNYWWs/j+Zkm?=
 =?us-ascii?Q?++wcc6IpI5NThRnRzk5R56EqssO+AkzWY/MqFz5bDAyNYRy2MM2oyqvw0kdM?=
 =?us-ascii?Q?PoSiTzYP0m35WieFP3t9iIOhc4PZ0W1zQoM90Y53OhlJ1eaV8jO3KDN4jR2v?=
 =?us-ascii?Q?vobhwjIdl9NVqyk5iJEfb0gluCDUk94BwN971uqvwgMC/keArXOY9ik4dLY5?=
 =?us-ascii?Q?ermFdEDLJ4gxJDLMdY3yfUsGFni6SPovg1xYmg1J0fkgNzhvwPPrSXzErNXm?=
 =?us-ascii?Q?hKcdZ4f5zImdO9+bVjjt5Yd1xB0ceGAZQvpHVXrkeLphxDQRlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eP0KBU8KViCs6v3s3114M70Yh8BUhIOxnAR94ZgL1pAObyvk8O5ZHj61TQn?=
 =?us-ascii?Q?oqXWOzpQhmKzb6TSAxIpvCB3WlcnbNROiWhvZibbIcShw4WXePGeuWMoTeVF?=
 =?us-ascii?Q?nyK4g1+cnKW25A6w6Kz+xReXiby1md2/cgUQeDEIoATTEVPRbGeSSzEaQcGt?=
 =?us-ascii?Q?vtAL2V6ec72C0F+xguP8Z8NCAZpTPitjcJDoNAXK5wCDLOUzciA4oCG1eBz/?=
 =?us-ascii?Q?BG5hki1ODh5F4KekZSqKKrv+rHopt0yWugjrfBNXAIOvRfZXNskjDB9iZRLI?=
 =?us-ascii?Q?JOj4OxUcd9G+Mni7SxxYYsEhr4Maj6gSKCEYY7eAHsq8eHHAcTBwWRSlMnb2?=
 =?us-ascii?Q?J2/8WfNuzw4NqkNynIk+Bz88QO6zVpH45rzKBfNWg0nDR0p8vfZeaJrSEREV?=
 =?us-ascii?Q?NSmOyK/vCAaBjEc/oCjrHxj6lo4Kot63fy5D70h3u83u5Bm7pHVVoMjNi0NJ?=
 =?us-ascii?Q?fsBh5hHfnFOb2TpbnKbI6jTuVI8E6Pc7PcaaYRr/tKupw4ody5S2SZLIPf/5?=
 =?us-ascii?Q?znhY+2er9/4H0uCcoDPcY3hMo+Fn92n5CKEU5ExBSr5t+Zcqz2uiHGz1dtvs?=
 =?us-ascii?Q?3uklA6oOQu/g8qnM4qcfCRlkK0jZHwlCpKKHfsbIxXmiAanBq7JPiZ+ZjOpf?=
 =?us-ascii?Q?JhoTIBQCvm4O9MQLkpIfBPfeiwfKVdYsdhJhpBN8zf4LhLja+LyB534D79cx?=
 =?us-ascii?Q?rRTq9zq9bfFCqleSUs4M2+U6dh80D3pvtCPUJj1AhI1XhiQyMHxLN+SZTjQD?=
 =?us-ascii?Q?t91Mxioft53crMSq4lR8KN9gggygHHdsVbDSCsTMgNvz9BJ6QgDaXAGs7SxI?=
 =?us-ascii?Q?SGTDQ8K5DyaUM86PkQi076bBfhL04EPpPIXXRfmEuMZHw1UxMAziYEpkI/Hb?=
 =?us-ascii?Q?amtOvAddRFz+YNW3Z//qRYhvvU+wegIipowQ9OW7xJyKEMLv2ChHmUJvgPjt?=
 =?us-ascii?Q?20Fmqzpv1ogcpBTcVJgK2xLFRJymsaAj8/q4KqnqX/KKc4iUCtiE6eC7ne4b?=
 =?us-ascii?Q?tn0RGp7ujVJGaCiAbgtERdikJRsB1nxm2/XVoHYHoCUGFgH/FeWQd5eTI1l8?=
 =?us-ascii?Q?VGbF1NNHRJS6WUTbiR2kl+SmdxsixFnk94m/oTo+Hvo2wY0ICREDElS2/1ii?=
 =?us-ascii?Q?iUUK3mj/EnCP6+n5AdOo0zdWO+KnRlI8K2MQvCFLoYL6zdRmVyJ5nTDV6EOl?=
 =?us-ascii?Q?tka0GQoeDTU2KhGiwYeY/YBByONQBZkZkfDaE9DJpnVxmoCxRL7Di/wjOKL5?=
 =?us-ascii?Q?0nw4dA7jo/NmL7SL+5yk2CYe+ayiReA8YTQiBm96bz+ChAsH3c/0f8/O/Dy5?=
 =?us-ascii?Q?IJvNH5t5Xpjdz0r4dm6yS9sDJ19L9v4mWvpx9dbpqLeIxQGgebWZqK4LZuBp?=
 =?us-ascii?Q?9DNLDTsCJzCUT8R8bQC42AR4t5XWtl2oe7PGWeJBFCjWTWpmE7FnfeEojSxV?=
 =?us-ascii?Q?vQWOnK7eWxMF98Oyy9IGyZRdyBq6Lmn1cNnULkbbkw/Wxqvs6IGjOKt8GqSI?=
 =?us-ascii?Q?RM//NTKTuzQIawPVKLgzAU0drA7sVOhkx3DIWFejxK6iKzDCLHcpaQU8tI8y?=
 =?us-ascii?Q?Oc9exX+2L8rFl3GzziXJRvoCppr92Bq3Cpr7Fqkp/FWw2puHuwc7ueYStlEA?=
 =?us-ascii?Q?uDcZElyOzJt8p+MUISjeSSE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f24d421-65b9-41ae-ad6a-08dccb559441
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:46:00.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsK8Py5cLT/tDttzsSEWoIw82Sg/z+nt6JKrVLBotZqbdxRqofPmFqRSZm2XbIApjpjPGaU2a7zYvRuFl2CT/1f71WS83XhadVjjTSWO9CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0597

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
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 359 ++++++++++++++++++
 3 files changed, 371 insertions(+)
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
index 000000000000..f1bd2d9d585b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
@@ -0,0 +1,359 @@
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
+
+	chosen {
+		stdout-path = &uart2;
+	};
+	
+	gpio-leds {
+	        compatible = "gpio-leds";
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


