Return-Path: <linux-kernel+bounces-546121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EFA4F69E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A79E16E922
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241EB1E04AC;
	Wed,  5 Mar 2025 05:38:35 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA781A4F09;
	Wed,  5 Mar 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153114; cv=fail; b=CWF9red3/KPz+YCwQ0kYZa8pmzHfq8f0/c9tXmQz40b2WpmRwkmsm2LkvT/t6AWWo31JPpw6zasObLkDzebx5yhFlovD4uSHSNaLIfh2vVqiPfu0wcyAYvIMoCx/+4HpuzLiXqDCTJ6QCA2782eCnncdS7xq/3Wsn7mwPesNS24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153114; c=relaxed/simple;
	bh=HSylkimeiP3o9MSp17BR8+J2PxDr6qbsxC2Q5dM2wiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R4ASQZIWL7gCrEXhdS9L6mwugLIH07mbilZBbMdglc7RcIjX/Ks1Ggq3z2QOck3X+q3Voye1BrkVtoQTGXySVuVzBm/5RPKwcfK+p6d7fF3lv1n8TNy8SgbTlXv8jHBA7IHF2mrGcDiM7SdTjCI1dSyI43N6LNz0YSxKQCi7dbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN2TZIEzkiw8/nrJwI54RfrPVfdIOJIQarDVkFfc+QmllLDT5RCfUQOIy6OFL1kx58Hn6kcRpVD6Zwra0FII8YwQMEA/e0UfqL9nqUzd5AYTiJl3VGsaGPUdiZAD6GJBAzqYWAIdHhst9cvmerzC7niyu1cXQcA7q+CDrEXiclXFGShvIUwYWn4P3OT5nwvEbaxL2SfMzGANDBgPlBvxA//8wknWBH+LCnnhkyirAaVESIVRo476e0EUe0pvurWWb5IGqcMIptbB+Y47JPlxaGcnvAoTJ16gyVe0n6yUAj/u9+hwcEK6t57FxzVqI73YznNTU3t4RP1LZD14Gnyfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1Ouylw2UjDOFcG+xnxTvLEIk8YorvQxpnrkJSuOf7E=;
 b=hGiJcCBjHVhyaYQ5U7y16VNN9QGxScR0dhHlBvfiz0zowzPnkmPpA0esJo7f8xWsXmuE2b5Hn7tw/3AsYIYDKmLeGr9DULl+18py3q7uwPaZtYQ1pfxudQvhczr+d31gMALHmzNDMpr17ddkQjuAhUbMXnAIQ/mTGhWwQGFd8nyHhgpKfUjvaXJn4IhAe29gvyr1VcSykv2BA7+HAFv3bM/L3K2ICfziBFWnCLs4T6Sc0mKtC6EaAgRX3oSkkQlspMdoaKIrPMdg8vcjAx53I4ydmiDqEhmpTfK6M//tywdzx9fRQL9QAYwNk7M/FpUMZ0mSP+yXf5KQRtTAfS6Y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::14) by SG2PR06MB5214.apcprd06.prod.outlook.com
 (2603:1096:4:1d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 05:38:25 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:57:cafe::7c) by PS2PR01CA0050.outlook.office365.com
 (2603:1096:300:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:24 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 85BF841604E7;
	Wed,  5 Mar 2025 13:38:23 +0800 (CST)
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
Subject: [PATCH v4 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Date: Wed,  5 Mar 2025 13:38:17 +0800
Message-Id: <20250305053823.2048217-1-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SG2PR06MB5214:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 357ded1d-1153-45f1-3d21-08dd5ba7f2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8rHD04Sp5l6z/hfdRnCnyFPhPIcdXUb/eixiEdi9bGs9ryJXLAgQ4/6PUizR?=
 =?us-ascii?Q?lrlVHV7vPSfhP11BoYal9y582EssqtIlb9bBEmrVymIO6sYHRm7rCQ2fZi0w?=
 =?us-ascii?Q?z0dOmRnhBWiotofDi2FJLVWXFKbhL5jZY1KHIFaTzYA9df/k8wk4ZtMG/St3?=
 =?us-ascii?Q?EkuGExa8XuUEyfDWAkpRRtegNAcfKyxwiKUFU8bUts/lbtArsvoDFbXgpDzH?=
 =?us-ascii?Q?bBxjF9fPB8CRO/cVGenuiMWartIK/9xhQn0Nzuq/YlbhwFsbeh/28bjnl69k?=
 =?us-ascii?Q?TBt0BHw76EtIkXStHPNR8r8ovHPtvVHOj7rBetR/bCEyoNwa0AKFvXfKrYLb?=
 =?us-ascii?Q?2afK9ZMMr4DBtMd5CimnTGYaTlHZX0tqc/J1Cumgd5+4Y1hrtYsfC01Mvd14?=
 =?us-ascii?Q?QPApQ9+TsoYUoEX47UUEvEedqC3xov4kCsqnZPhXrSUp3kOKxfUuBKyCs2gi?=
 =?us-ascii?Q?yLZSVt/3imzx64AOz1juofw6axSCY6aLLtLQAWyLp1GIq1SQWYArmuW4sBai?=
 =?us-ascii?Q?rrtNOomy6cgF4Jrsp9rL87KNNg2zPIXJRByK7+wbAXDZa5+OOAKg6M0RwTss?=
 =?us-ascii?Q?XSQmwHXGSQNaOHlGyMnnF/bBAXFZiyYb0IaY8jdp8ZTPW3pvPKIadvYsbm79?=
 =?us-ascii?Q?vYVgztYSOPDGFYrYe6L55e3GP7n4Srj4AWFP48M4X6kEeztBgfGmlyuZMYqu?=
 =?us-ascii?Q?2CGHsoQmb6Vee620hRqOBq44Vcoxf5Zs4w7tOAKrnoC9u107AP/7vyxuK99g?=
 =?us-ascii?Q?KGOvOKXfzbB0ijlgKftq8SqN3JVtgb9LjlDNjBmFRu8QII7saoO1yGa+bG4a?=
 =?us-ascii?Q?FsTUh9uDEmUk1ITApkGGIuXyItrtXUD5msxsLF6g+S+joTYshh4+1+wHtu4Q?=
 =?us-ascii?Q?cDOd4sdR8oobKv+rI3/fGmF4tZTnm3W7VvlKs2bMjXdzZD5lkvMVl8dR9teb?=
 =?us-ascii?Q?rA0oAHhe9BfqAPq2zs2m19zGlBto0IGrxAxjM0kbd4tYWIkayhA2BPqoh7Mq?=
 =?us-ascii?Q?+4X42hZuGUsoivZgy8sBY1hsuffXqMECkc29D5GqIO/DCgDArKvcXJ2doTVI?=
 =?us-ascii?Q?s1wpFhIKDu8CI9ab2Q15/4uHX6zABu+/+bh4r7yw5L2lA/nkzwbI1mDdUIym?=
 =?us-ascii?Q?IMIAWfPNgb4zXU7bfRnelu60BVbdQBvX24ZLPVhzyXJGZDgAXiU+YaHzbwyI?=
 =?us-ascii?Q?eAkAKe+n65VqwDHcTRNjAhpGkgh93Bl/tgKnft4P559D87XY1LiWydXQlWx9?=
 =?us-ascii?Q?Vo2rAmJKcx6PWUV0X+QW+IkRc72DMCzVNgFx5w2ntWOS2z+YM7GI0nY4Rhfo?=
 =?us-ascii?Q?8+uBCDLlwmH+d7p0U4VLQ/F4ybLSGIK4KDS1YQfK3ciWDNek6NvabpO3fFjK?=
 =?us-ascii?Q?RVxuR8c98OlNK+nX779F0OJsBOjOWKR36GAxi4qQx6EOqnUdCB54cyNp7FLF?=
 =?us-ascii?Q?4U6VurHB0i4amA8t8VexzMUrFAwi34U6?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:24.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ded1d-1153-45f1-3d21-08dd5ba7f2cb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5214

Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
Orion O6 is the world's first open source Arm V9 Motherboard built by
Radxa. You could find brief introduction for SoC and related boards at:
https://radxa.com/products/orion/o6#overview

In this series, we add initial SoC and board support for Kernel building.
Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
Patch 3: add related maintainers entry
Patch 4-5: add Arm64 build support
Patch 6: add initial dts support for SoC and Orion O6 board

To run upstream kernel at Orion O6 board, you need to use BIOS
released by Radxa:
https://docs.radxa.com/en/orion/o6/bios/install-bios

Changes for v4:
- Move add MAINTAINERS entry patch to the last, and add two dts files entry in it. 
- Add three Krzysztof Kozlowski's Reviewed-by Tags
- For sky1.dtsi, makes below changes:
	- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
	get its handle
	- Remove gic-v3's #redistributor-regions and redistributor-stride properties
	- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
	- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
	- Remove timer's clock frequency due to firmware has already set it

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
  arm64: defconfig: Enable CIX SoC
  arm64: dts: cix: add initial CIX P1(SKY1) dts support
  MAINTAINERS: Add CIX SoC maintainer entry

 .../devicetree/bindings/arm/cix.yaml          |  26 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  10 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cix/Makefile              |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  26 ++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 222 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

-- 
2.25.1


