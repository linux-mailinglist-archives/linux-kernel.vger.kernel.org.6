Return-Path: <linux-kernel+bounces-515259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ADAA36290
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9883B317F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76355267F54;
	Fri, 14 Feb 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDqtJGSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD63267B97;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548664; cv=none; b=I5EaqW03kPbrG1adVOK4IXdAQv/I/bnms8jjFYmlJETM6Lj4fZgjplc+aaVsnVdcryOtu8nJW22ya9+IiN/sCU4pkLUs24cynACvCSAESidLyWpwfZLFU0UyrjSbm7WdtMQfv1CSdyGiaAlDE5krDCjUdpcSf0vUi/LW/y9Nczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548664; c=relaxed/simple;
	bh=ouGwZqg89Trumuly9HFKbyX2Azi15niqMZRJjzo2/Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZsfvNTzCPZ10GcgoxZZNpGUJaYSrFsuDp0xf9wFdIpvbVoE/wO6fjdBSlKzViVUSsE8Y0rEjBR+TFn2Ft0XFnYOLG5/Al1RNhd033cnyQGpjDwLAwekKKS5pHoPHIMomd0o97hzY2j+gyM1jn9syFNvwDdxllbNMuvx6ipig6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDqtJGSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15CF2C4CEDF;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548664;
	bh=ouGwZqg89Trumuly9HFKbyX2Azi15niqMZRJjzo2/Bs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RDqtJGSPkrmeGflKtkQMo/zH7ZK0OYdGlEQRr5Uo5qW3B7nMjM3iSBVn1T8fONFtG
	 WUPseyY/S2OKmncvVotPcVH1gzek4Vmqo0dZAezu88RJuzRVB3/jooJJbmYspHZ/FG
	 UR+0Pey5UX8+nY8jyuEMprO+8Kma2p8J2Tw4v7NXewhxpD+4L5vwhwvIu7sT6UxqFR
	 k7+y0YZdKgEbwsUgMH4np0lxjeCJipshsZIJPrIXLQ5CHWloWQy5U43aG71ptilc47
	 r/TDicEvThmDLH/qNi++neVBLlqh5WoOvDob+jWq09fGesXO21TNPJVyPEoXw4b1ve
	 WXOWH8i4SLrNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA77C021A4;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 14 Feb 2025 16:57:42 +0100
Subject: [PATCH 1/2] arm64: dts: imx8mm: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-pinctrl_defines-v1-1-fbc86a42ef3c@gocontroll.com>
References: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
In-Reply-To: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739548663; l=1502;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=xlMEruvPgyFBPz+wMGaLrdnLbqgaiStmZr5qOyP3uC0=;
 b=61kNMtfKPg3m9bDu0G1jq+xNlQh5OuZTSq5FjcNSJ0ZR/3PFj4GclVsunSHeRBmuQn3E9tLV3
 aF89iBwbHtTBckycY2S0sHRFG81+G2hLWnLIuTKWLwEblWa53X601/5
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
register is written in the dts, these values are not obvious. Add defines
which describe the fields of this register which can be or-ed together to
produce readable settings.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index b1f11098d248ed5fc8ac42daed808beebe3bf7bc..b231d5968d07d1e135963b714c3fe80ddd8641ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -6,6 +6,33 @@
 #ifndef __DTS_IMX8MM_PINFUNC_H
 #define __DTS_IMX8MM_PINFUNC_H
 
+//Drive Strength
+#define MX8MM_DSE_X1 0x0
+#define MX8MM_DSE_X2 0x4
+#define MX8MM_DSE_X4 0x2
+#define MX8MM_DSE_X6 0x6
+
+//Slew Rate
+#define MX8MM_FSEL_FAST 0x10
+#define MX8MM_FSEL_SLOW 0x0
+
+//Open Drain
+#define MX8MM_ODE_ENABLE 0x20
+#define MX8MM_ODE_DISABLE 0x0
+
+#define MX8MM_PULL_DOWN 0x0
+#define MX8MM_PULL_UP 0x40
+
+//Hysteresis
+#define MX8MM_HYS_CMOS 0x0
+#define MX8MM_HYS_SCHMITT 0x80
+
+#define MX8MM_PULL_ENABLE 0x100
+#define MX8MM_PULL_DISABLE 0x0
+
+//?
+#define MX8MM_MYSTERY_BIT 0x40000000
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.48.1



