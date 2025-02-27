Return-Path: <linux-kernel+bounces-536218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6635A47CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D913A033B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33B22B8A9;
	Thu, 27 Feb 2025 12:06:29 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10522C32D;
	Thu, 27 Feb 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657989; cv=fail; b=buskAP4/Z6JtnpSsKJBoeodrOH3MN+8VjxEMxtbRBNOi+GEoE6nZZPBfUyjv3PN7/pTMh0I07gBQfMkBi4yDWecwiRlqsZZPhd38SYygqc9XGUNyDqxorc6C7W2fHp6ilSNPzgvxWFhlOhQy0Dg1S0/CON6PdqGlzxd+jHWCgm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657989; c=relaxed/simple;
	bh=d0/7uNbq1x9JWcd6Kq7Sty0J0pz1f5vwim1AkpW9irw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ETzKbZ13Dh3e1Ad0AGgaUYKizpqP/HACx+x/MV0uGIOdMkysTEsok5yjMsU9Al3ETRxYP5OhorX0wrdN3rHWp8LfSIWU5wl8povXwN5ZEwSxohoGINWVs9aFt7t1NSGQZ7eaBV01FXF4cNClHD6bWK2knt58sMFEBU5ldHHPkAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUCmvqtK1r4pZjxq1rzy9NyVvAVvAmyOsMbQuiPfgVaxfeYDtxdkNJscZTLHZ03wq8Th1QNPCNDSYPbsiZ5rtv07/lzpk4dqy8zf8qwPOkNw739supIwWaqOLocPj+eiNgdwSmvM17K/6hFuSumYih1m7dZWn9w5M7bj3I7fuy5md8WruQIFMFp9loLwkYUuho9zZllpM88y8iUKlimBVOxef3Sqowf5YO1r10Qi6i0fv26hMBxzZVO9mkmhiNGLOhpbvqUtS3L8MXSqYCdvqYRv8+SPwSkhAZ1BbW8qHMKxn6bCW8W0R+mKjLPZE4umsxnFgaWVhIxXGK0opX56eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIctAosM0FHAL2lrsPDZJsgydsMBBLaQN0rTC6oieAI=;
 b=bX5at//DXaNwcjC+lKUyTNoBSXrhK6ThSwOp98SlZxJnidTK4zIL7cBeL2UMC9jpBJYLLwL5DPWDCMyrXo7njLxRXJbBn1G8XIWplT2x8m32kuJYTVoLKWX7+v7tDOefEnVDLidgwf3CApMZuhGj6SWXOHecpmka52ng5uhyQ/+BwU7r+2iwrJYTb+EseWdhsF1LpoCFSu7Xbm3nTCeTr+Myd6P8cW1MzOSzrmFu+FTKp1OXAQtQRDapNFl+W15SbEGxWiGUOYzItPBRn3v/oK6OJg/tGHCG0oEOF1fsZxstB/OEP+hZXs/EEXL/BeUHKYliE7sUCyMMaBENbUXHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31) by
 SEZPR06MB6744.apcprd06.prod.outlook.com (2603:1096:101:17f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Thu, 27 Feb 2025 12:06:21 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:be:cafe::12) by SG3P274CA0019.outlook.office365.com
 (2603:1096:4:be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Thu,
 27 Feb 2025 12:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 12:06:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8F1F941604E4;
	Thu, 27 Feb 2025 20:06:19 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v3 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Date: Thu, 27 Feb 2025 20:06:13 +0800
Message-Id: <20250227120619.1741431-1-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEZPR06MB6744:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c289c89-46e3-48c0-4161-08dd572725b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0KPmqssaIsx3x4TA5eG9hLE8rexJzZivcPSuEXBC35rBZyzMBYza5jXS1i4?=
 =?us-ascii?Q?W/1APyGL3ChQF/5vmo9FMqd5J8hAFryF5374JuYFrp+ppqTaQx3NHJwe5Uap?=
 =?us-ascii?Q?0tlcrEQQqAGzGuZDII6AN+572JmneYF3e8b7NzuENFaT1+XKPlQKIFf1/tAX?=
 =?us-ascii?Q?2RTQu7IZ6KivaFweOY12pCh7mtFPp4LbNadKuAOxqHtkDSIY5v1Ze8m7OzRs?=
 =?us-ascii?Q?mM/e6aDKrJ5vnSQH70YgfKtSR5khAmTSTGCXh+16NgOolp8PvOAU/eg7b91M?=
 =?us-ascii?Q?N6vqkmmyVCrd8UsyFD/gDZPtVdpu7sD1mE3xxPyMO+O84a9bFWcxXaTqFol2?=
 =?us-ascii?Q?0fz8sOIrY5gsIK8ScyF2ZoGRx0Kn0FDjH0RBEkaKoNAUXgGdybIhExC3i6I4?=
 =?us-ascii?Q?inkyTf5hefMsL8Nul0CBPBmXjGlc7nShbqlAjSh1/SkZqzawY6fSXXKdnxBA?=
 =?us-ascii?Q?SznT3Knf3fbP4V8dU946f+u+SS0ZtSR+OUD3LEMQi3HWt0MDRJYBy8LjBQRE?=
 =?us-ascii?Q?Ba1S77oIUhxuDicbmrLYad/YTjzWebD8EHu/1nYtJGu42/t7D8L/gI6sTCPF?=
 =?us-ascii?Q?tRJMYjCM0KASMA1tTzJ1VZmjIDttiqELlWg+Xo9bpbR0f5LUxr7JK+KZDL3W?=
 =?us-ascii?Q?GmSJrGrWPgoKlEcGrhvo8NyMCiAvF6gEz+ynSKqryIX66t+iPE0jr5/im8cd?=
 =?us-ascii?Q?gj5Hu2oESgsfVTkHrngtDvl1APnhID0Ntnf7DQxue3louPZRuLj2y8wzh3IG?=
 =?us-ascii?Q?ceMqB6QUYkerQse5MO/eOii1QpylTXNnifm8kjxbyULfm8fQehbZC5Xld35W?=
 =?us-ascii?Q?9M5BhYqjg/SRjMUVSMV8Hd6qjPtObq3WRCTgjMN73vjAaBr8KEe1MkUMWzPI?=
 =?us-ascii?Q?FgLoAvVY5JtIw5aVTuIBHtzh12W1KEeH39/qx2iAs2gNedTuL9se+8cb96QV?=
 =?us-ascii?Q?iQTVDDPxemFOdiM/gHE2bn9YBG1ZU4ZDhueHadNimZsd/d1B5C8tInmTchEX?=
 =?us-ascii?Q?5+v+vIOGgZli3NRyYAkmtX0h7Yfn/yF7UP8+Y303KSKQM9Kdt69abDxTRkz8?=
 =?us-ascii?Q?iDJKhZmY19bXoUjQd/lah7hlHjUag6nd/bgqOvfO8ZApJPRc1zxL3As3Ay+f?=
 =?us-ascii?Q?agciuhnWKlTvF4IoI8eIAKPND30f/IiluWlc6OQeaBZKjnhzxtXKpnBS+BTj?=
 =?us-ascii?Q?vyVnN1vAh+VZkYuS0RReCdjl+CvEuH9g7aMY+d+RlLqH7gIDuiMv4qZl1/Ba?=
 =?us-ascii?Q?0TE1hmAWxcJ7V8BHEgbuzeCZdHw3LcyATV/f88FDx1Nlzjt92lArrLqLpKfK?=
 =?us-ascii?Q?wic21o+ZFW8ziu8//mnPJmNU6xULHw3jHVVRKOKLbisoEOoZJ04KR5fj1MNT?=
 =?us-ascii?Q?POKGqv6OYi3eSovWGRaJCSCB3waaORZgqbxwNy5SuIQkLHvvuw2B4CzrxACY?=
 =?us-ascii?Q?67q4mPLdBluh751v5RdpRrtZ2rU5ZL4C?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:06:20.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c289c89-46e3-48c0-4161-08dd572725b4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6744

Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
Orion O6 is the world's first open source Arm V9 Motherboard built by
Radxa. You could find brief introduction for SoC and related boards at:
https://radxa.com/products/orion/o6#overview

In this series, we add initial SoC and board support for Kernel building.
Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
Patch 3: add related maintainter entry
Patch 4-5: add Arm64 build support
Patch 6: add initial dts support for SoC and Orion O6 board

To run upstream kernel at Orion O6 board, you need to use BIOS
released by Radxa:
https://docs.radxa.com/en/orion/o6/bios/install-bios

Changes for v3:
- Patch 1: Add Krzysztof Kozlowski's Acked-by Tag
- Patch 2: Add Krzysztof Kozlowski's Reviewed-by Tag
- Patch 6: Fix two dts coding sytle issues

Changes for v2:
- Pass dts build check with below commands:
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=vendor-prefixes.yaml
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
- Re-order the patch set, and move vendor-perfixes to the 1st patch.
- Patch 4: Ordered Kconfig config entry by alpha-numerically
- Patch 5: Corrects the Ack tag's name
- Patch 6: see below.
1) Corrects the SoF tag's name
2) Fix several coding sytle issues
3) move linux,cma node to dts file
4) delete memory node, memory size is passed by firmware
5) delete uart2 node which will be added in future patches
6) Improve for pmu and cpu node to stands for more specific cpu model
7) Improve the timer node and add hypervisor virtual timer irq

Fugang Duan (1):
  arm64: Kconfig: add ARCH_CIX for cix silicons

Peter Chen (5):
  dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
  dt-bindings: arm: add CIX P1 (SKY1) SoC
  MAINTAINERS: Add CIX SoC maintainer entry
  arm64: defconfig: Enable CIX SoC
  arm64: dts: cix: add initial CIX P1(SKY1) dts support

 .../devicetree/bindings/arm/cix.yaml          |  26 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cix/Makefile              |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  26 +++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 216 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

-- 
2.25.1


