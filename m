Return-Path: <linux-kernel+bounces-546048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8CA4F589
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC80B1890F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F321953BD;
	Wed,  5 Mar 2025 03:44:51 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6B192D66
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146291; cv=none; b=VyRmTrlZwLC9EJ1KtqKVJZvsufrgGYu6k6OMhTLRashgTTAcCNf5AbbgpW/DZDp75P0aUo9aB9sCdq090VFrk3RLF5Gc2SXxhLgUOiuagX5Ct2Bsu4BUexIj2RrDEXQe+7ZMf4Mt5O1N4sP4CRq9ysEzf3BPgyvGESY1leh8VEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146291; c=relaxed/simple;
	bh=Kxw5q7MmoTFUeL04KoNKBYZ1TdMikpytf6XZ/pIbaeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gq3apYPY7aIVGAD/AiWBRKreC3YQX3T8kaD46kE5G9ZOJlEilVFcwu9m6sIcAhvxFR4qK0gZSwKlt0L1OeBHIUz6NeP6cH03SRR6iSyTNkgoj2BMn7asLNC/Sqv0+IitT2g4CVKQyU+FnXcFuBL7E+URo1qsMy21pKDipHDZbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 5253643h021869
	for <linux-kernel@vger.kernel.org>; Wed, 5 Mar 2025 11:06:04 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 52535S3d021717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 11:05:28 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 5 Mar 2025
 11:05:28 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH] riscv: add Andes SoC family Kconfig support
Date: Wed, 5 Mar 2025 11:05:26 +0800
Message-ID: <20250305030526.1986062-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5253643h021869

The first SoC in the Andes series is QiLai. It includes a high-performance
quad-core RISC-V AX45MP cluster and one NX27V vector processor.

For further information, refer to [1].

[1] https://www.andestech.com/en/products-solutions/andeshape-platforms/qilai-chip/

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 arch/riscv/Kconfig.errata | 2 +-
 arch/riscv/Kconfig.socs   | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index e318119d570d..be76883704a6 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -12,7 +12,7 @@ config ERRATA_ANDES
 
 config ERRATA_ANDES_CMO
 	bool "Apply Andes cache management errata"
-	depends on ERRATA_ANDES && ARCH_R9A07G043
+	depends on ERRATA_ANDES && (ARCH_R9A07G043 || ARCH_ANDES)
 	select RISCV_DMA_NONCOHERENT
 	default y
 	help
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1916cf7ba450..b89b6e0d1bc9 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,14 @@
 menu "SoC selection"
 
+config ARCH_ANDES
+	bool "Andes SoCs"
+	depends on MMU && !XIP_KERNEL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
+	select AX45MP_L2_CACHE
+	help
+	  This enables support for Andes SoC platform hardware.
+
 config ARCH_MICROCHIP_POLARFIRE
 	def_bool ARCH_MICROCHIP
 
-- 
2.34.1


