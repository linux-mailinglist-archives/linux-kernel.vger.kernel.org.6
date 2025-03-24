Return-Path: <linux-kernel+bounces-573199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E2A6D42D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF6F3A8A99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CD199E84;
	Mon, 24 Mar 2025 06:24:30 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023141.outbound.protection.outlook.com [40.107.44.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3D18DB20;
	Mon, 24 Mar 2025 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797469; cv=fail; b=UHssQ6XNHJtvPr6LNMskIARIIJnX56/+s1Th0vG4Oh80iJh1FMFqijEKkL2Ziym0mo4dAE+9YPiFuDWRARQ5mv4dUr9TD/KlxRRfZADqrxoj+f8trSPP4OI5dwWWi6JvMhC1NxL36EaJwSAeyevx0jaaBdHiNaac5bJI+RK6QUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797469; c=relaxed/simple;
	bh=ymQI8cPUQn47cdAOLopKjjg51uqV8bjHaUQ//zGNXdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rnzz3HYxUMRMebqmoNxGzyaNbkB9L8tWSZjsebXtYTUxgFh/VVL+Ifkme0As5VuUvI1mexYn6BG0egl7IM5YbKGhAwkKjwz1fZrPUAoqzuIociEEhF7azwvnjCd2soB0/RTTcQTYEpG9hlFHyJWJtG70xc5enuXFk1ioHBHETT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMXucw8aVF/5eU4brfY8nV2qjvAMVipbZafRKT07RjxqeSe1ltYsmlnIUngY5tI7ZJntsIALGlSBb/Z2umvEko51S8PYD419zCXjS9XYXPEekvwSndXfIeC3gYh1QLiaaLmi00qAUM8HUivocwJYb4u7lJjGRNTn+vokAP8Yj0MunAfJdl43l+9wv77K5kWtzxGhCSpeKDniwz+4f8/jafCBH9pfnRbZFdum8xMPAW17zKrULqAdPwlVofKMrzFiz/21HKMNy2PhfeBVlfaJ0VLYrNjlwGhbx+wKCErhMT14oIxMCyQG9BG7Poefw3jc40hYDkkfEtMW7SdEzn+wtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdJHRxBpO8PebhNgftWSwgenqujLLnksqsiwGrzKbN4=;
 b=GXjAkuvmyGRtQt1gW4hkzplGoVlXwyY6WXtAW+DoNUlKCoiy52Z6e0YBzt6JkkmPT3ZWKJuKsvew4wLD6Y5ppTOdhNJI3rU0rWzk2NbLH7+7R4KsN2x/UnQD7fa9xJ9nEgOQkxCOzn7GHPPV1woLMbT8dNkpKrwem3RCzZE7txwf7jOrJ8ioHsql3KhM5KtWu7Z2II2Yt6DmOtTLiIMOeIj2QLjwpS9QyeZRf06uCAMk9dVZSsFLOS2B/DIwx9Yo2AKJmifso6v7Nju/S+rCIshzdY0oNH6VXuusBi8bQzKqP/zb83JAWr+5fthJB7X256mg1MD4Lp24OpDaD9nW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0117.KORP216.PROD.OUTLOOK.COM (2603:1096:101::14) by
 KL1PR0601MB5862.apcprd06.prod.outlook.com (2603:1096:820:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:24:24 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:101:0:cafe::92) by SL2P216CA0117.outlook.office365.com
 (2603:1096:101::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 06:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 06:24:23 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E2B1D4160CA7;
	Mon, 24 Mar 2025 14:24:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@kernel.org,
	robh@kernel.org,
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
	maz@kernel.org,
	kajetan.puchalski@arm.com,
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v5 5/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Date: Mon, 24 Mar 2025 14:24:19 +0800
Message-Id: <20250324062420.360289-6-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324062420.360289-1-peter.chen@cixtech.com>
References: <20250324062420.360289-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR0601MB5862:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d0856db-b715-453e-ab13-08dd6a9c8541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?28PrY4bsJ/BeAZutm9YTD89OcZXiPRO1waWUc8Y/LcxnxnIgBCt8QnxYvA1g?=
 =?us-ascii?Q?KogoVFSgvoXBup6rFQfngKH0iUJusak0fauz8zv5EH7yOTlQSaiwv5Ba8P6e?=
 =?us-ascii?Q?ggNsBTVO4ExPEswDyNF8aCPbAlBJMHhlxLsxCy3pHJJ7CSFkUeAkltylhKJh?=
 =?us-ascii?Q?XaQOLX77bjNkR3ybX/oq9m2qykKXZfyjbHhA8YKM8OS7LJuRC1Ecnp9HBDXy?=
 =?us-ascii?Q?ACp40P+eWCulpeaF7Uvh4DoUBH5M9h/1o0ebpFNUzXFzvBK7gzuYMiFpyMR4?=
 =?us-ascii?Q?39Cgg3jQ8zgrq7TJbyDW61g4k7YDlWo8oiMJQlbIwtDWzBTYaX2OeQORMvTJ?=
 =?us-ascii?Q?vGOA4sgAQVS4AI3PElAg1xRpW+lTwyd08SWQy9HqCIoTlM2bZp4NKVeXxs8Y?=
 =?us-ascii?Q?GmvAc3Annly5Y+WpsATR6zJnw7Wpm8eA2DqII5X20hV9aveXlG4ctRmZCpui?=
 =?us-ascii?Q?5TLxzC5YYys/zP8hqItaRHUlsZDSEVfjMx1pqM4tI7BQ37OtVs/qsFihhsfL?=
 =?us-ascii?Q?UBf21XOrHCh6avIqYi9KI3KUbb1N1dWYEuZSs67XYAQiQ+9Nk4aCMHB8FkiV?=
 =?us-ascii?Q?VoW89RL3y4PqvkW0JoK+fq+3u0KTQZ0tedcDpdPnYgv6xDFwL2s3jImfxL9A?=
 =?us-ascii?Q?+u2ouHnprLCeor2ErfgpC/6NE78ZLNsF7GAMzQO3unBAnAQcH5RvxBmHiA9p?=
 =?us-ascii?Q?6iYZ0FcjsYo5UKXQh9KmoJ45aSXyNt2DXRWCgZUTXpLIx/iC2E02VudDHV//?=
 =?us-ascii?Q?QMBhMUgTjadwncdzu/NB+a3cXDtz7P2K5bFY7YYNhOFytVU+lLgOQSLnfKSZ?=
 =?us-ascii?Q?sz2F4z3lNryznAnBKI5YD3pNoVisOLry39ww90fMVhtb6RoPh3kUi8EXNwTH?=
 =?us-ascii?Q?ci/6QbmlWWfLEZWv7cAmg/YUtMUS8AwhQWskXZ6Z9D066dMPmUKUgyiUCZRe?=
 =?us-ascii?Q?39w5FPIgqspy6uOoRNHn2lkirZzBfcqc/B7Mxdr4dihSEutf4y14oUEcj/21?=
 =?us-ascii?Q?ni7wRipv/vZlS2kGq+7+NWruwLwRbcFxb8LbFxdUcTekqe2wtumRtOychwqD?=
 =?us-ascii?Q?BwuxKn37uQXX/kW4D8DB/GUgccGcv3cTdCdLmdhgli17RZoZS5IFaGzPZR15?=
 =?us-ascii?Q?CkY7VJKWoI/XBmsnOeCbjoLr/Dy2mPgi/+BGQr483TIWvGv0hQdahZUDSNa8?=
 =?us-ascii?Q?PhNmRBaSSQ+vnTxOfTQ4aGQJKaovgOE1Nj6LbxRqnbrRNcLbgEnQkfD6q7zm?=
 =?us-ascii?Q?8qbSf4HuGseTno8wvAu0/4ngv6adVl5Eyn6zx+Ch1jozl3YPYstqTJ4plL4/?=
 =?us-ascii?Q?EhtAZALJjHINAQ4Hd9MmXNQGhvujytsAc1CNsVHPiMMgX4YACIP/iOicpgaJ?=
 =?us-ascii?Q?Put59bBhszwSuAWZN1w4kV10h2lnGDk/+BSFXU+C16g/wMPsc1QF/gp0xN9X?=
 =?us-ascii?Q?NbKlX2p2E/8=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:24:23.7250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0856db-b715-453e-ab13-08dd6a9c8541
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5862

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is open source motherboard launched by Radxa.
See below for detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v5:
- Delete pmu-spe node which need to refine, and add it in future

Changes for v4:
- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
get its handle
- Remove gic-v3's #redistributor-regions and redistributor-stride properties
- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
- Remove timer's clock frequency due to firmware has already set it
- Add Krzysztof Kozlowski's reviewed-by

Changes for v3:
- Fix two dts coding sytle issues 

Changes for v2:
- Corrects the SoF tag's name
- Fix several coding sytle issues
- move linux,cma node to dts file
- delete memory node, memory size is passed by firmware
- delete uart2 node which will be added in future patches
- Improve for pmu and cpu node to stands for more specific cpu model
- Improve the timer node and add hypervisor virtual timer irq
- Pass "make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb"

 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/cix/Makefile          |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  26 +++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 217 ++++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..8e7ccd0027bd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -13,6 +13,7 @@ subdir-y += bitmain
 subdir-y += blaize
 subdir-y += broadcom
 subdir-y += cavium
+subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cix/Makefile b/arch/arm64/boot/dts/cix/Makefile
new file mode 100644
index 000000000000..ed3713982012
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CIX) += sky1-orion-o6.dtb
diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
new file mode 100644
index 000000000000..78f4fcd87216
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "sky1.dtsi"
+/ {
+	model = "Radxa Orion O6";
+	compatible = "radxa,orion-o6", "cix,sky1";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
new file mode 100644
index 000000000000..5bfeeea454e0
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x200>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x300>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu4: cpu@400 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x400>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu5: cpu@500 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x500>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu6: cpu@600 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x600>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x700>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu8: cpu@800 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x800>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu9: cpu@900 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x900>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu10: cpu@a00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xa00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu11: cpu@b00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xb00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
+				core7 {
+					cpu = <&cpu7>;
+				};
+				core8 {
+					cpu = <&cpu8>;
+				};
+				core9 {
+					cpu = <&cpu9>;
+				};
+				core10 {
+					cpu = <&cpu10>;
+				};
+				core11 {
+					cpu = <&cpu11>;
+				};
+			};
+		};
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition0>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0 0 0 0 0x20 0>;
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@e010000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW 0>;
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: msi-controller@e050000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x0e050000 0x0 0x30000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+
+			ppi-partitions {
+				ppi_partition0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				ppi_partition1: interrupt-partition-1 {
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7 &cpu8 &cpu9 &cpu10 &cpu11>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};
-- 
2.25.1


