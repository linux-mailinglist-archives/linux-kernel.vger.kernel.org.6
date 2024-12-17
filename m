Return-Path: <linux-kernel+bounces-449106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31C9F49EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E46162EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CC1F2C4B;
	Tue, 17 Dec 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gxrymfn4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86401F1302;
	Tue, 17 Dec 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435108; cv=none; b=ddD+NDBwLcKI5zNIzdpxUIOa4sv7bvNDsonOhlKUEBj2GiQMFJv5Lx7/WNTF2hiz9YGL2LAEhqrFT1FS/fAulEiRxzJJo1++gU4nbUnrSUp4eMKCXRQQ7giBHeolWMrSFEFHTzAachvrakqcO9ves/k5Ajn5TEA5Bg7dJPtncYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435108; c=relaxed/simple;
	bh=z6u/32qG+4VOxWxyQMcxtikghEw3g/GuPpIgKl24hiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNcdaZ/Yvn0IGzUaqQPjaEtvqs05J76NDK78gnye5dF4EJNoaFMMmBelycrotvZybIAy0xFOK4E/sBlw6Lin9r8N3qDFwx+2jAe24wa7wppHZFXVJxRPIXUfcDmG3YqYhzqhpJB2kmGz1mEopbMBbn01sojrgbOG56EwyD/VEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gxrymfn4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734435106; x=1765971106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6u/32qG+4VOxWxyQMcxtikghEw3g/GuPpIgKl24hiQ=;
  b=gxrymfn4XqwcWKQ3Q8u95M1aJF/yWz4YJ/PvhzHMWeOlL4t1dTyu++gs
   bRzVdQ1i3IbGq3HBVj1XTimzcZJYZWkFr2RRzTSjPh+rqMvnCYETHHFhD
   2hmD3DWW3EfRJP84XY4zjLMWFqjOoD2gQU8JlLDmkJ3Ix5Oqy/AbcOZLy
   /MuVgfcWWOU46GtsbplA4QtLySw+Uo2/kL4pYT0K7swadkB0wVQs/4noB
   L8/ukKY1ewEjmg1faJOvr88XhOstfGWS2CU6W0N1GUrvMooQ555XWapxC
   8tp58xvXO049ifSXFM1ve3h7wiXf488tPsSY5ux51gczJ6frK5Cw/kWn+
   g==;
X-CSE-ConnectionGUID: AFXRsVMVRgWVCl8fi3oPIQ==
X-CSE-MsgGUID: i8TL+rXOSa2GoTqCUNnINQ==
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="39361181"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 04:31:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Dec 2024 04:31:11 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Dec 2024 04:31:09 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v6 2/4] riscv: export __cpuid_to_hartid_map
Date: Tue, 17 Dec 2024 11:31:32 +0000
Message-ID: <20241217113134.3508333-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
References: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

EXPORT_SYMBOL_GPL() is missing for __cpuid_to_hartid_map array.
Export this symbol to allow drivers compiled as modules to use
cpuid_to_hartid_map().

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c180a647a30e..d58b5e751286 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -43,6 +43,7 @@ enum ipi_message_type {
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
+EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
 
 void __init smp_setup_processor_id(void)
 {
-- 
2.34.1


