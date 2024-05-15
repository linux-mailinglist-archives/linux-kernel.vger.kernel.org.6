Return-Path: <linux-kernel+bounces-179455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122268C601E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DB01C2220E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB839FFE;
	Wed, 15 May 2024 05:18:34 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2107.outbound.protection.partner.outlook.cn [139.219.17.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60183B78D;
	Wed, 15 May 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750313; cv=fail; b=hDPsB4r4x6jnN1antga1iY31Ud9wNzNu+Wz1Rzyia+bA8jydTr9xD6UjrubNCaFRJ38zLIq/XU5Qa9H3fMYG2lRVdgWHI6x8fx6DlmRQTKsqQO7kt+w2f/tOk121uIDI19GQSsVmOP7/cvOFyLzObO93DfKPeU4wY+1+iBPs3d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750313; c=relaxed/simple;
	bh=gip4SqrVq7cW6x0pnhINt0jSYTtKgEJ3SW+mpphs1uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFOz5B9QB7QQTU8KsX8ew7kYHRPD8Gsa/vRh2VBRaMwDOUXxX+iF0Z+4Syx7Q4Y8ent66I1UKF7ykPDwQk52drVDx7HQ/9DStZhT6uHeV98VXktOJ+43HKHBwYs0PMCdDkXsLWEohX5gQ5INtiBXuwPoFnrDYFvZaYcZMQOOJ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9k37avtRSQu3ErfdTE5evcc1p026B8Tfo5J9EyCymY8Mfgyw+XUWc2xvS4xtumzgIBiOZdmi1UFi0BkBDwB6CMJ5PqBUbq5OLkUqc+0cgaSAalP+koeo5dYgL7soq2G54qIBUzZwCFG4k7IKPI3sOaekf5G2XepCVBtSEgEFmKc43D+6SS4SR6ELYLR58RrAKX6E4x0o+sIpa9hmMwVDGUTVDIKSCJdTV/JZt23+aTPvTboYyBeWoPP3Xear0dL9uj2CXjYHyYdISD8ED2OBaStWk73QQTsqgDcgbVu91ckDuILT2hL7dDKXBpHk6pc87xlDA9+rULX0G/ADUvqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eevb188hiDYHB6pL10t94LTiewvQ4+f2VyfERGf4yH8=;
 b=nEP6N+S4Lp20iaKgHFKOO32PIkGk+mhYqhwZBv7JGX+UqeGziJyyf5Gzxe00huOl6uwnifwkx9lvG/x+La616Zb7C1Jk1O3bb9regyxGmlMh2EI07OFp7H4Agbf0q9OCgRbaMdewaItu/zz2Csw5AOIUlb13l9hushQloaOus4KCQD7ymrFytYL8yE1eCciIDO2mELA/roBNdaN4c8n5RdzAeTGC9ZCK/UwcryjkVDvUDXCbe88ibjT7naCoTdmekIpXIi+8vDFuOBO0ofhp5QNV+uZdOCG429h4nHSTBUqXu3FTU2cJttWXnHA4w63RYkOIXezA6GvsBorfAqqUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0859.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 15 May
 2024 05:03:36 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 15 May 2024
 05:03:36 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/2 RESEND] cache: Add StarFive StarLink cache management
Date: Wed, 15 May 2024 13:02:52 +0800
Message-Id: <20240515050253.38061-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
References: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: e38d52b4-a3f7-4b6c-d02a-08dc749c6078
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+5TVFDgXFcAHF5pRJidX+4Vu+otWuUsh+Aln5EBJL4S4Dx2KzJrC9IFFfP9LyzbSb+Z7UHah3ZAHXZD1QDiiv+v277VqlQsYp2pLhdGWKTJU9VZORZ7k/zjPDYFfsOIusA8OCOosKRw+bglJrNz4X03GIUsMveElUIlV/ccmJL5O9qw7PxxCiaNoHo5Us8qOjFqW71jnllIc4tk3u2xpRt3cNxmEQnT4PgfIKBiC2i6tWe0ltBPQwkdpSUfWZuduFNmuXjcoCZJN4ZoV6SiXbhUP9b0BzULUWGm1vGs3VM7fHW7fYjq2OoeKtt0QV1zMQBEhszGW42eKBZ/xKNgpvXoerY/iQpT8q0a3R22yA3kH55oENreF4ERwSfdJT2N98jIhdx2SjQEZcoRI1hJ3mTEsQJS/O2NSJxcY3fxxQE2N+ZFsC/vpA/28G2+puPCLhQYgkLiVw1wdE03larjani/7lXgQsa6YyUGgAQcY9YpXga5JVwqSiXhdOigzPW0wz9TdppOVN+HPXKEBOAtU8kJCWMsi92rFW38AHqIeLZ/Z8xyQBETBylV5X1vcGWaK2YzHW+80vLbYV2gw74O0Xf7euSuC0zJACvxokZ+PbXwwPlgl8z7DctVV0rcfwdwAuMQ+qmKXAFquDN/lfTrFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88a+I+tKohGVZBReycaRx4dEMzAilpi+tYrgyHClBlcertRZ3d3uhY8zDq+U?=
 =?us-ascii?Q?Tzo5T/J6uqh6o4lVFCCgJ+bMZqjY5bSDDuON33C78blxf+vDHETlIeRRyyc9?=
 =?us-ascii?Q?T/Im4rbfw0nC8XwM4/8Qwmkm7At15AGmBregYqbSmzSYOXMjoaxKChlRZrpa?=
 =?us-ascii?Q?bul6VhZ7sml3UQ9Mvty+z7ZQtwp7QjJPNkknqqqV82STP6vJQSyZ4n0oe+J9?=
 =?us-ascii?Q?AuXK65iililn7lIXdHD2Dt+K3Jr8AvpqyIBTOgJZlRcHAkxXW6gGroaqSaNL?=
 =?us-ascii?Q?n9WiMmx+LPl8iz+2Swy4e2TdLzLJcCoutH05hEWbf8PfHDGf7LQGG9jd5pBg?=
 =?us-ascii?Q?pVvBfS/97sa++f8gdAxQroq9giG17GHtmEob2be6K9fXprG7SQ4YF9ayslTu?=
 =?us-ascii?Q?d0jFUs/FEylgz4ssvl7lBGPPja0BVlrLeAiqhKUsg8JUwZ5dqp9pRTXagVYw?=
 =?us-ascii?Q?uK+TfdatUjabrr/9Iw9SmuhyLoapq5M+4jriZWQsJiTzoQxRZUPP80Kx+gxc?=
 =?us-ascii?Q?P6F5Ph5qdeEm3eAhw1QJKWsYEVeU1V7GijUx1V4BitX+z+7tdaT42I0bcjfr?=
 =?us-ascii?Q?6uHhCiSJKsxaqjf6lt+ALawhLt8QblAlD1WEsqMgNoWmaOmuCBXzFGcx6lwy?=
 =?us-ascii?Q?5yxTu/WHOT2qv5WbBt/J4QT2/fVPD+ePyuOGE5uQDAQtaTQqsvKbtJDB4VEZ?=
 =?us-ascii?Q?1Tw5j6ZGemxSzNU+P/i5vVIY0GA4EQW2mvS7twIOSn38gBXWqSTKdW7u+fVv?=
 =?us-ascii?Q?EUPZXFDEgprJr9DYENpOtEOzxM1dzbyGkuQ/8X4I/xD+pkxrrBB1L8IYSkcZ?=
 =?us-ascii?Q?BJM83cffp7B4Hz+wmRawUhrOK3MiTV2f5HEZDrh/sxP2z6KfEeNrblBqKj7l?=
 =?us-ascii?Q?mjn9TYAuYBpvGl/66rPeLBO0GV/Yb2rAi0Oy+KRYwSEPN/pEwHHs5EvQUWEj?=
 =?us-ascii?Q?o/O1SWX/6eSM2/Itky/2lqmGI1JMWkw+a3cI3cLca78T+JJSDDK4BKTNRD8D?=
 =?us-ascii?Q?o1ZCxVGw7NzPqrM+jSqdHR/6PmoXih2VkeKCoDORpztn2fRLRB57ZMinssIs?=
 =?us-ascii?Q?AZ2EkPz/842hFnmS2NmGn+7uk0/uwc7FgtLeG/SPkaHNmxSvBMTO1D9C5IZU?=
 =?us-ascii?Q?t8p5UoSk2L4Z5tyJk7qcPJGPumuntVMeryUERu7x/+jFZ6ZDX6sakaBQAU/O?=
 =?us-ascii?Q?5x/c7N+dyYSS7MmcUEGxKc7rKiT0LnmlfPSACv8yd5VtWAagMxomzm7n5Lqz?=
 =?us-ascii?Q?zQm8pG0pHpRTIrTk6yf8WkNYkpxqdKp+X1aXRzwd3Yb/WnTl1x3zEUk6hG0y?=
 =?us-ascii?Q?lL1pF6DbesLNiG7JrFhaHOp921nAPNf4hm96kxzt/870GRDj01ULkFXE96RP?=
 =?us-ascii?Q?eH+wdZvofsfu+dl0UShoGGZ+klqr3aEymk0wfvLT8f+0xB3QDpAUGMPMJBIp?=
 =?us-ascii?Q?3o03jFJXyUa74m9uGX65iMgjw01zXVnA1F6hvQPM+7+Yp98ndARorsR6Yozj?=
 =?us-ascii?Q?u4UvBFYKQQVhdHl91CKVVS3nsrt19ct25fLFUi9SByvEkUTwPbQ2YcoNUfxq?=
 =?us-ascii?Q?GeYO1CaG/cM3ej9s+XDFDoZkG0sj6POveUqNLIwbjG/Q4NAG/Q4EQiiezodr?=
 =?us-ascii?Q?vlT9kIyMsntg2tOHAWx6zAU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38d52b4-a3f7-4b6c-d02a-08dc749c6078
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 05:03:36.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWvlMVI0psMId/yhlZM86YISN+uwpoUE+QcfkHaFa7dGZbXBkY8k3Kbk3BE8neDVfBhPcRNSosuA+WjjdDl3yB6jPq7YuwIiHSRwPSHrRqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0859

Add StarFive Starlink cache management driver.
The driver enables RISC-V non-standard cache
operation on SoC that does not support Zicbom
extension instructions.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cache/Kconfig                   |   9 ++
 drivers/cache/Makefile                  |   5 +-
 drivers/cache/starfive_starlink_cache.c | 130 ++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cache/starfive_starlink_cache.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..94abd8f632a7 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -14,4 +14,13 @@ config SIFIVE_CCACHE
 	help
 	  Support for the composable cache controller on SiFive platforms.

+config STARFIVE_STARLINK_CACHE
+	bool "StarFive StarLink Cache controller"
+	depends on RISCV
+	depends on ARCH_STARFIVE
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
+	help
+	  Support for the StarLink cache controller IP from StarFive.
+
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 7657cff3bd6c..55c5e851034d 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0

-obj-$(CONFIG_AX45MP_L2_CACHE)	+= ax45mp_cache.o
-obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
+obj-$(CONFIG_AX45MP_L2_CACHE)		+= ax45mp_cache.o
+obj-$(CONFIG_SIFIVE_CCACHE)		+= sifive_ccache.o
+obj-$(CONFIG_STARFIVE_STARLINK_CACHE)	+= starfive_starlink_cache.o
diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
new file mode 100644
index 000000000000..24c7d078ca22
--- /dev/null
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Management Operations for StarFive's Starlink cache controller
+ *
+ * Copyright (C) 2024 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cacheflush.h>
+#include <linux/iopoll.h>
+#include <linux/of_address.h>
+
+#include <asm/dma-noncoherent.h>
+
+#define STARLINK_CACHE_FLUSH_START_ADDR			0x0
+#define STARLINK_CACHE_FLUSH_END_ADDR			0x8
+#define STARLINK_CACHE_FLUSH_CTL			0x10
+#define STARLINK_CACHE_ALIGN				0x40
+
+#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
+#define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
+#define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
+
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE	0
+#define STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE	1
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED		2
+#define STARLINK_CACHE_FLUSH_POLL_DELAY_US		1
+#define STARLINK_CACHE_FLUSH_TIMEOUT_US			5000000
+
+static void __iomem *starlink_cache_base;
+
+static void starlink_cache_flush_complete(void)
+{
+	volatile void __iomem *ctl = starlink_cache_base + STARLINK_CACHE_FLUSH_CTL;
+	u64 v;
+	int ret;
+
+	ret = readq_poll_timeout_atomic(ctl, v, !(v & STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK),
+					STARLINK_CACHE_FLUSH_POLL_DELAY_US,
+					STARLINK_CACHE_FLUSH_TIMEOUT_US);
+	if (ret)
+		WARN(1, "StarFive Starlink cache flush operation timeout\n");
+}
+
+static void starlink_cache_dma_cache_wback(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+			  STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE),
+	       starlink_cache_base + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static const struct riscv_nonstd_cache_ops starlink_cache_ops = {
+	.wback = &starlink_cache_dma_cache_wback,
+	.inv = &starlink_cache_dma_cache_invalidate,
+	.wback_inv = &starlink_cache_dma_cache_wback_inv,
+};
+
+static const struct of_device_id starlink_cache_ids[] = {
+	{ .compatible = "starfive,jh8100-starlink-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init starlink_cache_init(void)
+{
+	struct device_node *np;
+	u32 block_size;
+	int ret;
+
+	np = of_find_matching_node(NULL, starlink_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_property_read_u32(np, "cache-block-size", &block_size);
+	if (ret)
+		return ret;
+
+	if (block_size % STARLINK_CACHE_ALIGN)
+		return -EINVAL;
+
+	starlink_cache_base = of_iomap(np, 0);
+	if (!starlink_cache_base)
+		return -ENOMEM;
+
+	riscv_cbom_block_size = block_size;
+	riscv_noncoherent_supported();
+	riscv_noncoherent_register_cache_ops(&starlink_cache_ops);
+
+	return 0;
+}
+arch_initcall(starlink_cache_init);
--
2.25.1

