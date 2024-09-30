Return-Path: <linux-kernel+bounces-343749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DB989F04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D449E1C2237C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A451922D0;
	Mon, 30 Sep 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wwDvmPPx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030918CC1E;
	Mon, 30 Sep 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690185; cv=none; b=tfrQwoCDajLFbXGSjy2zlX/ldgzdujch/woBdP+5STMLSs9z/3p556/wW7nJhNAfxBIe+Ef7v8uYTshm6SlkHbVhnO/RMQhYDYVCCFFpBQLjeVEJxyNDF/e5L1qWBuQ4tAfdS2o66Vpug8v/UHDMiUlBdQ6T1uYdH44Z1pDNfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690185; c=relaxed/simple;
	bh=VnYhiKqEKDEMV+fEe2vy3iLrZ4s2UszPQqt9ym5foD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf3Vpwkiwaba5GNsZI4jJf0/An6gg/zI3egOySpmcqokWsVp6/Vem1L/jWOp2QZGb7tf2em+GGld3A5GA2mMl0/G7QYnOZGPYSk2OQvVJefEKrmWSO7M51A6TJl35y57EtOCCvZoqSGIU41E2rHl+sGfvfyv4SwC+9iYPfoA9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wwDvmPPx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690184; x=1759226184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VnYhiKqEKDEMV+fEe2vy3iLrZ4s2UszPQqt9ym5foD8=;
  b=wwDvmPPxipH5yMVZKdrhMw3q35o9HuODbEzeubY1DIZhgP1WLUizA9n0
   cl+UsOCG68f6BwUSujpwM/VWqSMJXxvg6+Y0qG1tWIgz1r4lMJUlCFcza
   2T50qSHVIGPbZfHJGvgpvh3Z/tn2xQhET6VylV7cI/JUDu4m5UOHTmOu+
   FVRjpggfVPdNCDVMYzIKky2Bb1GPVB0gsR3C0PopEyIB1kNKBjcQnvtr/
   0TGEC/FToIkZODE0XbJDYGZzGptXnJXEnLG9ttD06vPiH3oSphy04DBsP
   TzsAZr57a74PlWBWU0xthDToqm4F3igx3RasC68LNyZXZ6niggmZ7wZxb
   Q==;
X-CSE-ConnectionGUID: 05QWoWIkRFGrt6egQKNmgw==
X-CSE-MsgGUID: lLD75AxwRaGK1prnAD8u1g==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32388030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:56:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:58 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:56 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Paul Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 20/20] riscv: dts: microchip: remove POLARFIRE mention in Makefile
Date: Mon, 30 Sep 2024 10:54:49 +0100
Message-ID: <20240930095449.1813195-21-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Substitute user hidden CONFIG_ARCH_MICROCHIP_POLARFIRE by user visible
CONFIG_ARCH_MICROCHIP.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 806f80424d49..06ef63d8fad2 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
-dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-m100pfsevp.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-polarberry.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-sev-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP) += mpfs-tysom-m.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP) += pic64gx-curiosity-kit.dtb
-- 
2.30.2


