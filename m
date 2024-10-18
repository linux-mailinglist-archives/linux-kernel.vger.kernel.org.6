Return-Path: <linux-kernel+bounces-371316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D199A3994
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E353F1F26500
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD7191F67;
	Fri, 18 Oct 2024 09:11:10 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2100.outbound.protection.outlook.com [40.107.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C21917F9;
	Fri, 18 Oct 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242669; cv=fail; b=gKaDVXKCzDQC/tIVtTtsc2oZa/PwxV6g5cLCRZlwT09bWtXY7BmepT0jLQVpm1/s8n7jA92dBrpmrYdTC0GOb6DE3OS+CHu8jlcleswDgeQqO5ennJUCJHlI/L9aS8xhLt4R74zD+8XicxtZpaeH2fG1q4ICzghU7uNGhOelyJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242669; c=relaxed/simple;
	bh=1AtbmaB9YtN6tWPvrJNn4jZvXfwc/2AQlqA8fztdLAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUYpUTHKFpH+l4YWZvyMuS+jLYfAZ/uWHN8gh4A00lY8wYWjQDqUjNeYfC4XiEaMuSaDLraAVAD0sJj+bLPUGKIIAX9EKQ7YyTWVzjguZFPsMUjLi7lSr2dcGWyGwpg9xhZKdE0bWatLiOEmwKO9fhTaFY9RYxVHNfuWe3INE/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/Jd1kgze5BcK7ApS6nQSkrZPaBl11xQ10/oTm5RR57UkjTPRR4yrnTE30zTolnM+BsYX5NK/WgddgNVqSWjW06mRWJAzkvu7AXhlv09J224cAFIhTvwJ6gCnEecPPkvu4iM/knhzxifJ9ZCRdGPdVs9+VUgl5FpuBXDrQritHXBtOLlv8KmVVTYi+wezMWW3IjfDnbl9ro27OowW7Zjbtb2ft2r9DkwUFmt23QyeJI/wWKa8k2ay7HAbYb5t8n9KZz2g6Y/o7wUFki5cUzBzugtfi7RgwmsTlNnUAPfHC2iV/3Zs+76y9tOmuBZWwwGA9hN8SQJCnEA48fLs8ymyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epMrZ5tR/6ThHO6AHytGmhU12ddcUJdsLYl5U1JIsfs=;
 b=yvmjr7/I2otQzvqqVnW6R0FmBJIVWM0RLvHEDHPCsQMTsGhX4+4rMpy0lkWoC8NewBcMD6BYXqpFxmEd0ZCKdaZg6ccVSg2zQ/q2FAWF+/XXFLbrzqn2Ntfm7bqHgxusxWvmAUOacFGUquM1HEuQH4akzfjq/RSJySf0n3dJg21469WBsDAVsldTIxy/ckxBSyCsHmvXA6d+Nwx/Y3viGAOh8BsPvZRsfUY1dBqZqewzgznap70MJ9tMcYrSAUAP8xRdTkdBzScswadWACMBowdPWMvishiaKmgi+SOgm6TJkhfTWFr0Smvnm/bFYe/yqt1t90scsV2ALpZJGIQfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0738.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 09:11:03 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:11:03 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
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
Subject: [PATCH 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Fri, 18 Oct 2024 14:39:27 +0530
Message-ID: <20241018091023.29286-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e432c67-21ce-4fb5-6710-08dcef54cab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqoshupgM6jtrMybG1agIoVXSa3xIDTvkziGCpNabDOjcQlAGmtM/CMAjSFZ?=
 =?us-ascii?Q?BMZF5XuyxlTyVL5to8+Y1gUR5oZzzXngJ7o2ndMDI8qgVZ721cFji6AVKlPB?=
 =?us-ascii?Q?07GU0M56rGEQYA67ljzAap3+iYeqT3v7++5yrk3OLnwgb0x1DLWM7SZSfvQv?=
 =?us-ascii?Q?qGOtkowmJtV6iDpyNue5aTFYjbHVkJ0Wk7lZXL4v3+7c/HAyzd34vJLzE46P?=
 =?us-ascii?Q?FlD5bs67kBCvq2P4Ep4g5XI5pkaLzdr7B60iFY1FoEVOv+1gfE7P24Y4dH0F?=
 =?us-ascii?Q?YuwIdN+R1cjfBXCLpD0U/D0BTsSU3giZho/acuiwqeUoPGIbEgzfExhgt4bq?=
 =?us-ascii?Q?9bu17fxiiuRlYN8mq2v/OW/gDtxH6XiS0wHXl1BeSNsfQpsi0zJe0b06qAEs?=
 =?us-ascii?Q?n/E4Hc84u4tbIavaHgV90g/TqZDe0Nxd0vaOhFGG9h1zqdOHAD/OYfrPZ7v5?=
 =?us-ascii?Q?2UKwtsMxoAwB6XVa5Y+oM6amBXSc4ER29PnO01zSs9FfP8fLqCKWCHFDxBCh?=
 =?us-ascii?Q?6AqWAOa86cws9Of2ACm+xeh6nk1MlAnpJADog0TZu0DhiUUm6VJWf+QNZAxm?=
 =?us-ascii?Q?8/x8pYLWHxD2pPvbW2hrr59QzrUpKFbklc1M21ljV3rqxSNc28OsLkFAPoJm?=
 =?us-ascii?Q?AUGXvVy/7tFsP6AUn3J5bOP63/odXpyVHseB+B6sYE7VYd5DxjrJ5yQiFvv9?=
 =?us-ascii?Q?2eZ53paDeuD8yJ9bzUbk03a9X8ILQIcLrNmkVYT7O3JGXxD6iOrX+Ymj8OXJ?=
 =?us-ascii?Q?wb0eUtv+mxVJLZ+s8Pof9T1EDipsv8hUXqLGbZ3ccgSHsViLTapGgOl2EiaZ?=
 =?us-ascii?Q?0kS5YyApjHeG1Q3vZE3TSbfk/Ql6WXzNSUUhcJq33l9wmfioo4rh+dyj1814?=
 =?us-ascii?Q?jZL4A3kFsOfD+X0AePZnttCJRGjEswg4p9/7gdsX6WViJaK5nuLnWZyUfv5Q?=
 =?us-ascii?Q?/eFFidJX/eNW23IxHmopmwnCxKi1CP7aPuDFiUIbWPLoHjez9DAsMOl7Se7t?=
 =?us-ascii?Q?ZBchWAc4vaC4UrhYSV52+kBOHrKc9sC5QijrTBgNf4rqqG40F4CX7ZHVrl0O?=
 =?us-ascii?Q?fzYYy28rpY1/rH/tfYsIQGitjXmMd367ZcZziqIm6vliRehDcTfMNf+fzer3?=
 =?us-ascii?Q?biwcwcXM8CxO8cR8fjmT2jOh3O5/5HQb/393x9x79vwCDUJqKP5edXjRw76Q?=
 =?us-ascii?Q?D43AmgDQrCdNs1SrY3QTnH6juyHGUxWeEDuiR0vjCXQMhFhmmF7UV3kt4FwB?=
 =?us-ascii?Q?Az6UzAItMezYRc7lE/WBVJSO6Ln3AwsZdpWop4hj4A68XJS+iU87W/GNd+2y?=
 =?us-ascii?Q?9Ck8elcYX/x//Nx4/o6rANV7jimY15FYl+mWCioqWUbcOQtD9IwhJpxQ81vu?=
 =?us-ascii?Q?vqBNhes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mNshM7MOFd00e7nZtLBaaAb0jGESqS0pbpFZsu7s/ecLLpy7u596kFMLjnf4?=
 =?us-ascii?Q?huhbbCva/gcMsLzR5xD63MieKaHeH9kBql11xVM6MMRCb3VMWt+Dbqvpws28?=
 =?us-ascii?Q?6Kag0AXLPZ4e2jg2NdzJra0V5jiRrFJ5iug76cdHLnKoxMeOKYGR4lsKLSry?=
 =?us-ascii?Q?ooQfCWN4gZ7bYLRfvORDWstEU/pn+5i83uYvJ0hwGH+TrbSy+L6eQWQP88ot?=
 =?us-ascii?Q?z3pJlBxm/t2A52dDMtwFxgFv5wTzpPlE0lMKvsiuaxywxnriunrwAJTUdscM?=
 =?us-ascii?Q?Oa/w0FzjFBxhWjxVGQQX8o+9zLDvj9veC9L1fQ0dP/BgCnO6FOUmj0r9+yWX?=
 =?us-ascii?Q?Qvd3Yh9ti/zTDfO2IlmrKAitc+8Q1J1UMqTSwv/HYfyXtMLKSHfg1Tf55L3X?=
 =?us-ascii?Q?26QFK9PTCzmnvt755DERG53rl1GousfvwMasqeG6JM9WQfu/g/26jQ6n/ljx?=
 =?us-ascii?Q?d1pwXPyDHAjv+q2R7ZpMjRngd0mMAuGQw1saYHoiCmkFkait1R1ZEVq1l0sf?=
 =?us-ascii?Q?Utos0kwUl/xDoyQOF49b2OYqwwW0+cWYnHJN3q1QQRP157E7/np3ciuEm1XM?=
 =?us-ascii?Q?Vcjlt21bdgNg5jnHMh1KU1WvFfwS7fAqq7EfgQRGfaXlUjrQRexyFzj89GOh?=
 =?us-ascii?Q?d0IyP4+4CvqfkN39U4gpK6MYqFi8ax8TWEoyt1MMcFYMJG1oT3iP6xlgwDr1?=
 =?us-ascii?Q?eRAiLDBeagEO9DTBbqobdCvFVS0JrLdI6FTuaXDMrjNOpstNSFQMANfYD9xm?=
 =?us-ascii?Q?gDZ+eWHSKeqwXMOhAJuYKY5ASe3Fm2AMYb2dU2ZizVbiV/9J4LybwcricpN0?=
 =?us-ascii?Q?xLs8BdV/8K6b87M+k4KM9YddAMlbul6TQp7uUV0HfcWwvsX5XMHICzbBuwqM?=
 =?us-ascii?Q?rN8lpOUU350/QvQh+rh5Vhtk2mmf43WUxtiZdo63WjJnYoHaaVFuRySuiv7C?=
 =?us-ascii?Q?jhgNYh75IWC+R4lqEJcv4XWQ020x5ni+Indz5WmB09ZgPMLyS6AEkONUKeJX?=
 =?us-ascii?Q?dco+LBd6tNRaCfFKBxamIkwWxHJvEbYs/BWuWI5+Q5khk9PJyMlMUwUh9wsj?=
 =?us-ascii?Q?pqDRDHuhK3zV9ZHDrAOVopiWNIekq6wTSfr6b6yEMh4jg1SS9diCCimCZV6y?=
 =?us-ascii?Q?vKLBEpwH3rr2EHr4GEmegZDFgosefczsBV5RGrUOgbJhUnyR2JhSGQeIznte?=
 =?us-ascii?Q?PB8kElfto/gJPf2c456SQkedKR7Sf3WVih7opVHi15tbLRF6dp3Oqmi9w1OA?=
 =?us-ascii?Q?ZIlVlIk42OX2FYyxMFR5OffUqtuyTQdxJ/NB9DIqlgOccWvMGEDgojT/87p1?=
 =?us-ascii?Q?m4s2Vi5IYL7MHw1yaGljnKo1xuk5KK6D7UsapfZN2m0z+bj2KDK1GdAr8xoo?=
 =?us-ascii?Q?neQ05BOgIUsmEZajs18M3c50Wbbkm94T529in9fFqm13Z00JFGeVVWeu2xah?=
 =?us-ascii?Q?/4Y0VWEFGFwLpADstl4kCuu62PlPpeTbjTxEhGapCgg/Tenh9XiJf2CTyENN?=
 =?us-ascii?Q?ELrXInBAq4epRorl8xofo+f2DurugAORNk5HMPTgFtym9an9YvKQWVig4OCm?=
 =?us-ascii?Q?d6OqRZUGxPOVZx3rx34iF/vway42IPHAtfX6N2SdxT0LmGixTHA2mV25cnUw?=
 =?us-ascii?Q?5bnMX0iRVBA+m/Kb1aWx/iE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e432c67-21ce-4fb5-6710-08dcef54cab8
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:11:03.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4DozVZSLCeRtP1kGk/k60BmruYSCcXV5PeuJodNwy0SWcVnb3Rax8kTb7btqy9JZy+nGnQ9Td/oEu0X1bgu+pW1gPe/pRBz5/s6BXs+YeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0738

Adds the DTSI file for the Nitrogen8MP SMARC System on Module which
is delivered with the Nitrogen8MP Universal SMARC Carrier Board.

Initial support includes:
- Serial console
- eMMC
- SD card

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 349 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 3 files changed, 367 insertions(+)
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
index 000000000000..89f820ddad54
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
@@ -0,0 +1,349 @@
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
+        model = "Boundary Device Nitrogen8MP SMARC SoM";
+        compatible = "boundary,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";
+
+	chosen {
+        	stdout-path = &uart2;
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
+        clock-frequency = <400000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2c1>;
+        status = "okay";
+
+        pmic@25 {
+                compatible = "nxp,pca9450c";
+                reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+
+                regulators {
+                        buck1: BUCK1 {
+                                regulator-name = "BUCK1";
+                                regulator-min-microvolt = <600000>;
+                                regulator-max-microvolt = <2187500>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                                regulator-ramp-delay = <3125>;
+                        };
+
+                        buck2: BUCK2 {
+                                regulator-name = "BUCK2";
+                                regulator-min-microvolt = <600000>;
+                                regulator-max-microvolt = <2187500>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                                regulator-ramp-delay = <3125>;
+                                nxp,dvs-run-voltage = <950000>;
+                                nxp,dvs-standby-voltage = <850000>;
+                        };
+
+                        buck4: BUCK4 {
+                                regulator-name = "BUCK4";
+                                regulator-min-microvolt = <600000>;
+                                regulator-max-microvolt = <3400000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        buck5: BUCK5 {
+                                regulator-name = "BUCK5";
+                                regulator-min-microvolt = <600000>;
+                                regulator-max-microvolt = <3400000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        buck6: BUCK6 {
+                                regulator-name = "BUCK6";
+                                regulator-min-microvolt = <600000>;
+                                regulator-max-microvolt = <3400000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        ldo1: LDO1 {
+                                regulator-name = "LDO1";
+                                regulator-min-microvolt = <1600000>;
+                                regulator-max-microvolt = <3300000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        ldo2: LDO2 {
+                                regulator-name = "LDO2";
+                                regulator-min-microvolt = <800000>;
+                                regulator-max-microvolt = <1150000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        ldo3: LDO3 {
+                                regulator-name = "LDO3";
+                                regulator-min-microvolt = <800000>;
+                                regulator-max-microvolt = <3300000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        ldo4: LDO4 {
+                                regulator-name = "LDO4";
+                                regulator-min-microvolt = <800000>;
+                                regulator-max-microvolt = <3300000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+
+                        ldo5: LDO5 {
+                                regulator-name = "LDO5";
+                                regulator-min-microvolt = <1800000>;
+                                regulator-max-microvolt = <3300000>;
+                                regulator-boot-on;
+                                regulator-always-on;
+                        };
+                };
+        };
+};
+
+&i2c6 {
+        clock-frequency = <100000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2c6>;
+        status = "okay";
+
+	mcp23018: gpio@20 {
+	        compatible = "microchip,mcp23018";
+	        gpio-controller;
+	        #gpio-cells = <0x2>;
+	        reg = <0x20>;
+	        interrupts-extended = <&gpio4 22 IRQ_TYPE_LEVEL_LOW>;
+	        interrupt-controller;
+	        #interrupt-cells = <0x2>;
+	        microchip,irq-mirror;
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_mcp23018>;
+	        reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
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
+/* eMMC */
+&usdhc1 {
+        pinctrl-names = "default", "state_100mhz", "state_200mhz";
+        pinctrl-0 = <&pinctrl_usdhc1>;
+        pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+        pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+        bus-width = <8>;
+        non-removable;
+        status = "okay";
+};
+
+/* SD-card */
+&usdhc2 {
+        pinctrl-names = "default", "state_100mhz", "state_200mhz";
+        pinctrl-0 = <&pinctrl_usdhc2>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+        vmmc-supply = <&reg_usdhc2_vmmc>;
+        bus-width = <4>;
+        status = "okay";
+};
+
+&wdog1 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_wdog>;
+        fsl,ext-reset-output;
+        status = "okay";
+};
+	
+&iomuxc {
+
+	pinctrl_gpio_led: gpioledgrp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10                     	0x19
+	        >;
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
+	        fsl,pins = <
+	                MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL            			0x400001c3
+	                MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA                 		0x400001c3
+	        >;
+	};
+	
+	pinctrl_mcp23018: mcp23018grp {
+	        fsl,pins = <
+        	        MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22            			0x1c0
+                	MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27             			0x100
+        	>;
+	};
+	
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14				0x1c0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+	        fsl,pins = <
+	                MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX                            0x40
+	                MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX                            0x40
+	        >;
+	};
+        
+        pinctrl_usdhc1: usdhc1grp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x10
+                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x150
+                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x150
+                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x150
+                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x150
+                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x150
+                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x150
+                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x150
+                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x150
+                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x150
+                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x10
+                        MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B 			0x140
+                >;
+        };
+
+        pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x14
+                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x154
+                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x154
+                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x154
+                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x154
+                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x154
+                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x154
+                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x154
+                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x154
+                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x154
+                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x14
+                >;
+        };
+
+        pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x12
+                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x152
+                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x152
+                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x152
+                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x152
+                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x152
+                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x152
+                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x152
+                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x152
+                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x152
+                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x12
+                >;
+        };
+
+	pinctrl_usdhc2: usdhc2grp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x190
+                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d0
+                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d0
+                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d0
+                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d0
+                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d0
+                >;
+        };
+
+        pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x194
+                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d4
+                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d4
+                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d4
+                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d4
+                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d4
+                >;
+        };
+
+        pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+                fsl,pins = <
+                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x196
+                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d6
+                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d6
+                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d6
+                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d6
+                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d6
+                >;
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


