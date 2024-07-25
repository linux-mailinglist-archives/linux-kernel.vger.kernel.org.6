Return-Path: <linux-kernel+bounces-262160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495493C1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362A31C21CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917C19D060;
	Thu, 25 Jul 2024 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HzNXomxE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19B19A28F;
	Thu, 25 Jul 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909841; cv=none; b=nJHLhboMspFCo47UxrUnl9U6cxDJjBrHCGqBPDqJ3qIB7NPAfnu3YPOUB0RsoQYpmiDrPNcvGWLjJ3h8niWIdtfOI8ssNIX4SnNY1wfwuM1aimHT2eAwQmaqIxfHtEf0NTvOHlXaF4YDbg/aBfJRC8NsEodqySWelo/FAfG13X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909841; c=relaxed/simple;
	bh=i0qWcHLWcqk1AjPXzPRXDsRBnnrI+QNsbbcnxjTLuIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxvvoZRxBtCbN7d9XprobvsVrFugPOqOXObHR2XEaRivr2xRwGZjBfChOZ2hNIBajO0pMSVyQFoCvHj6su0pTTJEaEWKeEN5dJ+psa8EqaOOirEh7c4kfTkMDgJ+Ul6Hu7iBSi1EEDRPzz31+pc5xNjvN2wRinlKnWh4+Hr8UJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HzNXomxE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909840; x=1753445840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0qWcHLWcqk1AjPXzPRXDsRBnnrI+QNsbbcnxjTLuIk=;
  b=HzNXomxEeaNil6CMwR1+KO9+W6gmDR3QABDYxNPd9o0wtKb5lVRLwZ4R
   0UFkLnxmN7B1XiMwX/tq1fTRDHj0TKJ8HJjI8yG2nHxKUagW8hlgTAcfR
   ITTP4LlfQPsUj8bgsBKrVeh2jnPaXzjz+NmcHSboHTIsFVBmI0+zBbTkw
   ZTrVozFHzSAmRfFpR+ZTTZFYvSIGYz+oiEyRVDSrZMLbHWNBWxwOrPtUX
   rp+eRZ931JBNKdynnFYDRzM7PftJCQb8LUiIOye1BXBU75gtHfZN/Cz+5
   BQMac28VHlBU/9jJgVEf1dApcBHZPATVFsfPNqwqwMeu0pL4hZhZMaw8I
   Q==;
X-CSE-ConnectionGUID: FjEJXt1iShuJypsmHj+1Bw==
X-CSE-MsgGUID: 6LYUND7xQ+K1a4QKGbHEuw==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29650440"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:57 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:55 -0700
From: <pierre-henry.moussay@microchip.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH 15/17] dt-bindings: clk: microchip: Add Microchip PIC64GX host binding
Date: Thu, 25 Jul 2024 13:16:07 +0100
Message-ID: <20240725121609.13101-16-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Add device tree bindings for the Microchip PIC64GX system
clock controller

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../clock/microchip,pic64gx-clock.h           | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/clock/microchip,pic64gx-clock.h

diff --git a/include/dt-bindings/clock/microchip,pic64gx-clock.h b/include/dt-bindings/clock/microchip,pic64gx-clock.h
new file mode 100644
index 000000000000..91687c9da516
--- /dev/null
+++ b/include/dt-bindings/clock/microchip,pic64gx-clock.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Daire McNamara,<daire.mcnamara@microchip.com>
+ * Copyright (C) 2024 Microchip Technology Inc.  All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_
+#define _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_
+
+#define CLK_CPU		0
+#define CLK_AXI		1
+#define CLK_AHB		2
+
+#define CLK_ENVM	3
+#define CLK_MAC0	4
+#define CLK_MAC1	5
+#define CLK_MMC		6
+#define CLK_TIMER	7
+#define CLK_MMUART0	8
+#define CLK_MMUART1	9
+#define CLK_MMUART2	10
+#define CLK_MMUART3	11
+#define CLK_MMUART4	12
+#define CLK_SPI0	13
+#define CLK_SPI1	14
+#define CLK_I2C0	15
+#define CLK_I2C1	16
+#define CLK_CAN0	17
+#define CLK_CAN1	18
+#define CLK_USB		19
+#define CLK_RESERVED	20
+#define CLK_RTC		21
+#define CLK_QSPI	22
+#define CLK_GPIO0	23
+#define CLK_GPIO1	24
+#define CLK_GPIO2	25
+#define CLK_DDRC	26
+#define CLK_FIC0	27
+#define CLK_FIC1	28
+#define CLK_FIC2	29
+#define CLK_FIC3	30
+#define CLK_ATHENA	31
+#define CLK_CFM		32
+
+#define CLK_RTCREF	33
+#define CLK_MSSPLL	34
+#define CLK_MSSPLL0	34
+#define CLK_MSSPLL1	35
+#define CLK_MSSPLL2	36
+#define CLK_MSSPLL3	37
+/* 38 is reserved for MSS PLL internals */
+
+/* Clock Conditioning Circuitry Clock IDs */
+
+#define CLK_CCC_PLL0		0
+#define CLK_CCC_PLL1		1
+#define CLK_CCC_DLL0		2
+#define CLK_CCC_DLL1		3
+
+#define CLK_CCC_PLL0_OUT0	4
+#define CLK_CCC_PLL0_OUT1	5
+#define CLK_CCC_PLL0_OUT2	6
+#define CLK_CCC_PLL0_OUT3	7
+
+#define CLK_CCC_PLL1_OUT0	8
+#define CLK_CCC_PLL1_OUT1	9
+#define CLK_CCC_PLL1_OUT2	10
+#define CLK_CCC_PLL1_OUT3	11
+
+#define CLK_CCC_DLL0_OUT0	12
+#define CLK_CCC_DLL0_OUT1	13
+
+#define CLK_CCC_DLL1_OUT0	14
+#define CLK_CCC_DLL1_OUT1	15
+
+#endif	/* _DT_BINDINGS_CLK_MICROCHIP_PIC64GX_H_ */
-- 
2.30.2


