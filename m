Return-Path: <linux-kernel+bounces-263137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA793D192
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7552818DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F218178CF2;
	Fri, 26 Jul 2024 11:05:12 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1D14277;
	Fri, 26 Jul 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991912; cv=none; b=esOSl9Ip15TSS64g85HvqkVy0V+2vDXOI/sjLxJtEfF0do7tzQMxnPjJbaPG7DMkKWFc2o+zjfmzXfEurLIof/tjaIaIgBOjVaLixU/mIXrgqGOTV77LpV8EFu128g55FSUM+u4e5U2iJoWv3li7PDaNb5SyD8D+v4f9w0Ie/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991912; c=relaxed/simple;
	bh=t4NsvVg1Gv795Pe/g9tN705vAhz3rbG3/WX1Q3qQQjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU7REP6BBGsKE2JOTcVbxiuAchWVbQwVp8y+o66ZCVVBSa725c4dgizeEOhVF3oRjWGVfxLEViiLTxYaauy4bQ5EDuSCal6SI5Q6zGkDTh3mZzMHucU5D3yit6ii9hgxwOrBhu5e6gfosJ4Y2tBxMVpZaIbtPMHCxXGH5H8olBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 26 Jul
 2024 19:04:00 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 26 Jul 2024 19:04:00 +0800
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
Subject: [PATCH v1 04/10] dt-bindings: reset: ast2700: Add binding for ASPEED AST2700 Reset
Date: Fri, 26 Jul 2024 19:03:49 +0800
Message-ID: <20240726110355.2181563-5-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
 .../dt-bindings/reset/aspeed,ast2700-reset.h  | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

diff --git a/include/dt-bindings/reset/aspeed,ast2700-reset.h b/include/dt-bindings/reset/aspeed,ast2700-reset.h
new file mode 100644
index 000000000000..704cdaac3fdc
--- /dev/null
+++ b/include/dt-bindings/reset/aspeed,ast2700-reset.h
@@ -0,0 +1,126 @@
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
+#define SCU0_RESET_SDRAM		(0)
+#define SCU0_RESET_DDRPHY		(1)
+#define SCU0_RESET_RSA		(2)
+#define SCU0_RESET_SHA3		(3)
+#define SCU0_RESET_HACE		(4)
+#define SCU0_RESET_SOC		(5)
+#define SCU0_RESET_VIDEO		(6)
+#define SCU0_RESET_2D			(7)
+#define SCU0_RESET_PCIS		(8)
+#define SCU0_RESET_RVAS0		(9)
+#define SCU0_RESET_RVAS1		(10)
+#define SCU0_RESET_SM3		(11)
+#define SCU0_RESET_SM4		(12)
+#define SCU0_RESET_CRT0		(13)
+#define SCU0_RESET_ECC		(14)
+#define SCU0_RESET_DP_PCI		(15)
+#define SCU0_RESET_UFS		(16)
+#define SCU0_RESET_EMMC		(17)
+#define SCU0_RESET_PCIE1RST		(18)
+#define SCU0_RESET_PCIE1RSTOE		(19)
+#define SCU0_RESET_PCIE0RST		(20)
+#define SCU0_RESET_PCIE0RSTOE		(21)
+#define SCU0_RESET_JTAG0		(22)
+#define SCU0_RESET_MCTP0		(23)
+#define SCU0_RESET_MCTP1		(24)
+#define SCU0_RESET_XDMA0		(25)
+#define SCU0_RESET_XDMA1		(26)
+#define SCU0_RESET_H2X1		(27)
+#define SCU0_RESET_DP			(28)
+#define SCU0_RESET_DP_MCU		(29)
+#define SCU0_RESET_GP_MCU		(30)
+#define SCU0_RESET_H2X0		(31)
+#define SCU0_RESET_P0_VHUB2		(32)
+#define SCU0_RESET_P0_PHY3		(33)
+#define SCU0_RESET_P0_XHCI		(34)
+#define SCU0_RESET_P1_VHUB2		(35)
+#define SCU0_RESET_P1_PHY3		(36)
+#define SCU0_RESET_P1_XHCI		(37)
+#define SCU0_RESET_P0_USB2		(38)
+#define SCU0_RESET_P1_USB2		(39)
+#define SCU0_RESET_USB11		(40)
+#define SCU0_RESET_RESERVED		(41)
+#define SCU0_RESET_E2M0		(42)
+#define SCU0_RESET_E2M1		(43)
+
+#define SOC0_RESET_NUMS		(SCU0_RESET_E2M1 + 1)
+
+/* SOC1 */
+#define SCU1_RESET_LPC0		(0)
+#define SCU1_RESET_LPC1		(1)
+#define SCU1_RESET_MII		(2)
+#define SCU1_RESET_PECI		(3)
+#define SCU1_RESET_PWM		(4)
+#define SCU1_RESET_MAC0		(5)
+#define SCU1_RESET_MAC1		(6)
+#define SCU1_RESET_MAC2		(7)
+#define SCU1_RESET_ADC		(8)
+#define SCU1_RESET_SD			(9)
+#define SCU1_RESET_ESPI0		(10)
+#define SCU1_RESET_ESPI1		(11)
+#define SCU1_RESET_JTAG1		(12)
+#define SCU1_RESET_SPI0		(13)
+#define SCU1_RESET_SPI1		(14)
+#define SCU1_RESET_SPI2		(15)
+#define SCU1_RESET_I3C0		(16)
+#define SCU1_RESET_I3C1		(17)
+#define SCU1_RESET_I3C2		(18)
+#define SCU1_RESET_I3C3		(19)
+#define SCU1_RESET_I3C4		(20)
+#define SCU1_RESET_I3C5		(21)
+#define SCU1_RESET_I3C6		(22)
+#define SCU1_RESET_I3C7		(23)
+#define SCU1_RESET_I3C8		(24)
+#define SCU1_RESET_I3C9		(25)
+#define SCU1_RESET_I3C10		(26)
+#define SCU1_RESET_I3C11		(27)
+#define SCU1_RESET_I3C12		(28)
+#define SCU1_RESET_I3C13		(29)
+#define SCU1_RESET_I3C14		(30)
+#define SCU1_RESET_I3C15		(31)
+/* reserved 32 */
+#define SCU1_RESET_IOMCU		(33)
+#define SCU1_RESET_H2A_SPI1		(34)
+#define SCU1_RESET_H2A_SPI2		(35)
+#define SCU1_RESET_UART0		(36)
+#define SCU1_RESET_UART1		(37)
+#define SCU1_RESET_UART2		(38)
+#define SCU1_RESET_UART3		(39)
+#define SCU1_RESET_I2C_FILTER		(40)
+#define SCU1_RESET_CALIPTRA		(41)
+/* reserved 42:43 */
+#define SCU1_RESET_FSI		(44)
+#define SCU1_RESET_CAN		(45)
+#define SCU1_RESET_MCTP		(46)
+#define SCU1_RESET_I2C		(47)
+#define SCU1_RESET_UART6		(48)
+#define SCU1_RESET_UART7		(49)
+#define SCU1_RESET_UART8		(50)
+#define SCU1_RESET_UART9		(51)
+#define SCU1_RESET_LTPI		(52)
+#define SCU1_RESET_VGAL		(53)
+#define SCU1_RESET_LTPI1		(54)
+#define SCU1_RESET_ACE		(55)
+#define SCU1_RESET_E2M2		(56)
+#define SCU1_RESET_UHCI		(57)
+#define SCU1_RESET_PORTC_USB2H	(58)
+#define SCU1_RESET_PORTC_USB2V	(59)
+#define SCU1_RESET_PORTD_USB2H	(60)
+#define SCU1_RESET_PORTD_USB2V	(61)
+#define SCU1_RESET_H2X2		(62)
+#define SCU1_RESET_I3CDMA             (63)
+
+#define SOC1_RESET_NUMS		(SCU1_RESET_I3CDMA + 1)
+
+#endif  /* _MACH_ASPEED_AST2700_RESET_H_ */
-- 
2.34.1


