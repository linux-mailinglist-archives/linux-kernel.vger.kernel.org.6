Return-Path: <linux-kernel+bounces-421471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D29D8BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EDEB2B687
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3C1B87E6;
	Mon, 25 Nov 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mOS9iQVK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7E1B85C2;
	Mon, 25 Nov 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557542; cv=none; b=VxnbsKI6EM3dFZPYx6JbjH+4bxxXrkMkMdXHHry4TB16RnpoouupsvQOMKfENbBtuL0IwXQTDdD8U4WN6uJJNWhG0dHka1BTB6QCIgF+4SZ3b/+2mZPm8QRg7YAwDu+bxvrfStO8aBjE1UN5l9b/F6MaRLU19Nfm1yh0o59INQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557542; c=relaxed/simple;
	bh=xWSs+CCHo2cnkHp+YQIYQ9pyFy661acsmyXS6RC2uDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqBIcwauQGUcXwV+Gvuy3B8eR9+4HRzW6P9OB5IJRBhk/T3BgWsJVZHaU2eW46YoeNPJ6VQvzKn6Xo/61ZPBG1Zwrfj6/NOxeSb6L1MYDmv/9qDPGxh7GE9d5B6LuCnMp2iGmDWkBBckBcg7r3vOOgolp831yxHExAh+z60kZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mOS9iQVK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732557540; x=1764093540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xWSs+CCHo2cnkHp+YQIYQ9pyFy661acsmyXS6RC2uDQ=;
  b=mOS9iQVKBr6x6XAAihtsG9J262ZY6qgazGKHRdzYfeTu8y7Gi0dPupUF
   1RiCtfnGM9Nm6expTO9r93X8OWriIxwF7YJJ0CBUeAJaYp3AWBKfsRexi
   bsPCNjGwXtQZ+7TXBspRXjBgHkfxY6sdmq1v9iBgHVAILqweKuFoJ9VcS
   p7JnIKVo2hfKpyES8TNMsqmsiGQJELB5/UEc5yVEaC1YWdyXl3syOB9rR
   WziHZpQQm6R5EMWRGyCJRVmmlWwXbSc57HosoVj7QHZWXMUEGdnJATuRK
   TfGPL3OMKD4bCCd2BQyxPhtUClXmfStisvDTv/j14c88JB8/QRcQqKGEQ
   A==;
X-CSE-ConnectionGUID: QcIy3zy5RLCJ7zVSqoxwVg==
X-CSE-MsgGUID: dGxu753KRwqgAnyAephq7g==
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="38361996"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2024 10:58:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Nov 2024 10:58:38 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 25 Nov 2024 10:58:35 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<ycliang@andestech.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<peterlin@andestech.com>, <samuel.holland@sifive.com>,
	<conor.dooley@microchip.com>, <alexghiti@rivosinc.com>,
	<ruanjinjie@huawei.com>, <takakura@valinux.co.jp>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 1/4] riscv: sbi: vendorid_list: Add Microchip Technology to the vendor list
Date: Mon, 25 Nov 2024 17:58:15 +0000
Message-ID: <20241125175818.213108-2-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
References: <20241125175818.213108-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add Microchip Technology to the RISC-V vendor list.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 2f2bb0c84f9a..a5150cdf34d8 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -6,6 +6,7 @@
 #define ASM_VENDOR_LIST_H
 
 #define ANDES_VENDOR_ID		0x31e
+#define MICROCHIP_VENDOR_ID	0x029
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
-- 
2.34.1


