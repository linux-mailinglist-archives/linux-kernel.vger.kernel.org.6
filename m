Return-Path: <linux-kernel+bounces-272337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB86A945A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC21F21EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CDB1D415A;
	Fri,  2 Aug 2024 09:06:07 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D241D2F79;
	Fri,  2 Aug 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589567; cv=none; b=QDcXUyhuIzLaL56pytTqhQ/VUi9Yb0ayXWCGJ4KbvWuOkcZuJ7v0XwHbYfKSdH13HTlXpUsQ8AZcfcV/7aVdkj7NqOwhcMfKhDVKl+3yehKRkGsoex5N0WkZCwH7rCsPjONxRDMKDxuGA9laE/D8rlHv2xz0l/bQcbpKVcvhCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589567; c=relaxed/simple;
	bh=Pbl3lKvxSHr9nfVeF9qCiSny9WXR8WxX0z3gtMVkft0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqW8LrgvB/3G0kh2UIR1KV6w5LRp0QAMHX8So6oLfe/gd2LNX+ACayhkbe7BJbfM7jkP4zd3Cl0yOBQo5XgytH11f86PiQJRxkvX4xal38lfV5xuQuJKuvKOB41pb3TbmCXAmTCWP2mvMxkiltZPUQblofJYvsNKhU2yR42Zm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 2 Aug
 2024 17:05:51 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 2 Aug 2024 17:05:51 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 2/9] dt-bindings: reset: ast2700: Add ASPEED AST27xx Reset schema
Date: Fri, 2 Aug 2024 17:05:37 +0800
Message-ID: <20240802090544.2741206-4-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add Reset schema for AST2700.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../dt-bindings/reset/aspeed,ast2700-reset.h  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

diff --git a/include/dt-bindings/reset/aspeed,ast2700-reset.h b/include/dt-bindings/reset/aspeed,ast2700-reset.h
new file mode 100644
index 000000000000..c75653c1bbf3
--- /dev/null
+++ b/include/dt-bindings/reset/aspeed,ast2700-reset.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Device Tree binding constants for AST2700 reset controller.
+ *
+ * Copyright (c) 2023 Aspeed Technology Inc.
+ */
+
+#ifndef _MACH_ASPEED_AST2700_RESET_H_
+#define _MACH_ASPEED_AST2700_RESET_H_
+
+/* SOC0 */
+#define SCU0_RESET_SDRAM	(0)
+#define SCU0_RESET_DDRPHY	(1)
+#define SCU0_RESET_RSA		(2)
+#define SCU0_RESET_SHA3	(3)
+#define SCU0_RESET_HACE	(4)
+#define SCU0_RESET_SOC		(5)
+#define SCU0_RESET_VIDEO	(6)
+#define SCU0_RESET_2D		(7)
+#define SCU0_RESET_PCIS	(8)
+#define SCU0_RESET_RVAS0	(9)
+#define SCU0_RESET_RVAS1	(10)
+#define SCU0_RESET_SM3		(11)
+#define SCU0_RESET_SM4		(12)
+#define SCU0_RESET_CRT0	(13)
+#define SCU0_RESET_ECC		(14)
+#define SCU0_RESET_DP_PCI	(15)
+#define SCU0_RESET_UFS		(16)
+#define SCU0_RESET_EMMC	(17)
+#define SCU0_RESET_PCIE1RST	(18)
+#define SCU0_RESET_PCIE1RSTOE	(19)
+#define SCU0_RESET_PCIE0RST	(20)
+#define SCU0_RESET_PCIE0RSTOE	(21)
+#define SCU0_RESET_JTAG	(22)
+#define SCU0_RESET_MCTP0	(23)
+#define SCU0_RESET_MCTP1	(24)
+#define SCU0_RESET_XDMA0	(25)
+#define SCU0_RESET_XDMA1	(26)
+#define SCU0_RESET_H2X1	(27)
+#define SCU0_RESET_DP		(28)
+#define SCU0_RESET_DP_MCU	(29)
+#define SCU0_RESET_SSP		(30)
+#define SCU0_RESET_H2X0	(31)
+#define SCU0_RESET_PORTA_VHUB1	(32)
+#define SCU0_RESET_PORTA_PHY3	(33)
+#define SCU0_RESET_PORTA_XHCI	(34)
+#define SCU0_RESET_PORTB_VHUB1	(35)
+#define SCU0_RESET_PORTB_PHY3	(36)
+#define SCU0_RESET_PORTB_XHCI	(37)
+#define SCU0_RESET_PORTA_EHCI	(38)
+#define SCU0_RESET_PORTA_VHUB0	(38)
+#define SCU0_RESET_PORTB_EHCI	(39)
+#define SCU0_RESET_PORTB_VHUB0	(39)
+#define SCU0_RESET_UHCI	(40)
+#define SCU0_RESET_TSP		(41)
+#define SCU0_RESET_E2M0	(42)
+#define SCU0_RESET_E2M1	(43)
+#define SCU0_RESET_VLINK	(44)
+
+#define SOC0_RESET_NUMS	(SCU0_RESET_VLINK + 1)
+
+/* SOC1 */
+#define SCU1_RESET_LPC0	(0)
+#define SCU1_RESET_LPC1	(1)
+#define SCU1_RESET_MII		(2)
+#define SCU1_RESET_PECI	(3)
+#define SCU1_RESET_PWM		(4)
+#define SCU1_RESET_MAC0	(5)
+#define SCU1_RESET_MAC1	(6)
+#define SCU1_RESET_MAC2	(7)
+#define SCU1_RESET_ADC		(8)
+#define SCU1_RESET_SD		(9)
+#define SCU1_RESET_ESPI0	(10)
+#define SCU1_RESET_ESPI1	(11)
+#define SCU1_RESET_JTAG1	(12)
+#define SCU1_RESET_SPI0	(13)
+#define SCU1_RESET_SPI1	(14)
+#define SCU1_RESET_SPI2	(15)
+#define SCU1_RESET_I3C0	(16)
+#define SCU1_RESET_I3C1	(17)
+#define SCU1_RESET_I3C2	(18)
+#define SCU1_RESET_I3C3	(19)
+#define SCU1_RESET_I3C4	(20)
+#define SCU1_RESET_I3C5	(21)
+#define SCU1_RESET_I3C6	(22)
+#define SCU1_RESET_I3C7	(23)
+#define SCU1_RESET_I3C8	(24)
+#define SCU1_RESET_I3C9	(25)
+#define SCU1_RESET_I3C10	(26)
+#define SCU1_RESET_I3C11	(27)
+#define SCU1_RESET_I3C12	(28)
+#define SCU1_RESET_I3C13	(29)
+#define SCU1_RESET_I3C14	(30)
+#define SCU1_RESET_I3C15	(31)
+#define SCU1_RESET_I3C15	(31)
+#define SCU1_RESET_MCU0	(32)
+#define SCU1_RESET_MCU1	(33)
+#define SCU1_RESET_H2A_SPI1	(34)
+#define SCU1_RESET_H2A_SPI2	(35)
+#define SCU1_RESET_UART0	(36)
+#define SCU1_RESET_UART1	(37)
+#define SCU1_RESET_UART2	(38)
+#define SCU1_RESET_UART3	(39)
+#define SCU1_RESET_I2C_FILTER	(40)
+#define SCU1_RESET_CALIPTRA	(41)
+#define SCU1_RESET_XDMA	(42)
+/* reserved 43 */
+#define SCU1_RESET_FSI		(44)
+#define SCU1_RESET_CAN		(45)
+#define SCU1_RESET_MCTP	(46)
+#define SCU1_RESET_I2C		(47)
+#define SCU1_RESET_UART6	(48)
+#define SCU1_RESET_UART7	(49)
+#define SCU1_RESET_UART8	(50)
+#define SCU1_RESET_UART9	(51)
+#define SCU1_RESET_LTPI	(52)
+#define SCU1_RESET_VGAL	(53)
+#define SCU1_RESET_LTPI1	(54)
+#define SCU1_RESET_ACE		(55)
+#define SCU1_RESET_E2M		(56)
+#define SCU1_RESET_UHCI	(57)
+#define SCU1_RESET_PORTC_EHCI	(58)
+#define SCU1_RESET_PORTC_VHUB	(59)
+#define SCU1_RESET_PORTD_EHCI	(60)
+#define SCU1_RESET_PORTD_VHUB	(61)
+#define SCU1_RESET_H2X		(62)
+#define SCU1_RESET_I3CDMA	(63)
+#define SCU1_RESET_PCIE2RST	(64)
+
+#define SOC1_RESET_NUMS	(SCU1_RESET_PCIE2RST + 1)
+
+#endif  /* _MACH_ASPEED_AST2700_RESET_H_ */
-- 
2.34.1


