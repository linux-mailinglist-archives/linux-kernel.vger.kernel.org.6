Return-Path: <linux-kernel+bounces-518896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7467A395F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334A517068E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310723F273;
	Tue, 18 Feb 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePsMIOC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BEE23C8D0;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867962; cv=none; b=u0V3wVRjUa6AMevGywubdblWFMTjwz4iPuZVGMrYiUsS2QAe+bR5gsmJGi4Ium6ITpI3GLl3LJSP8W2yK/YtBVP1nWIdkLpwaWg3q8id2sEhmu6OYGca3KQtpB6WQSlJKylPXe8StSv20bcCFJPX8oHeSUktPVb7+HZykbFQOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867962; c=relaxed/simple;
	bh=Gy9nsuCf3htO82U+zSkGjYn4dRyosjBjhXa5Aa13C6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maNwD6vYq+4bQ1vupPq29bQByy3SyI8Id/6Bt6QjjTy4ZQWXUsLfO3yuq3qemug3jV/UxEMJEZPm5S/IZ8cNLpCKdNBYgN97ZeeSPTxRmkSjNC5A0nT1JW7sqBeKgDQ4MyI+bA4kW6zIiidX5xvUVjF16l9Qi2+hvZui62oXlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePsMIOC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93CD7C4CEE8;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739867961;
	bh=Gy9nsuCf3htO82U+zSkGjYn4dRyosjBjhXa5Aa13C6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ePsMIOC80/SK1zxGxx4G6UXRkb4O/zWbk4sznSjOUveHiqD4SKY60DtHbPQuZpFt2
	 F8H/nCXk9uNFpaEIQfTtAz53Yag/c8xO6BTgPj5BvO2wMujTt44o6N9jW1sNudip1J
	 cALJ48SVQZfsqmhqLWrGgJKNJqK3aW3h7i5+Qd5KDSPnM930+p/LpB0A7fh5wV8KQt
	 3FKVw9Ip7zEJSVhbCQZaaq97CBpWxtwilkwtYNqdqTkhjMtd3eeoWHl2GmN7ZFBj4K
	 agBbpnmNCKbmcXr7+Y/74yUqonRmEHnEuyWjeRs4RphXvHRKsZ8YwgiXsGyqmsugB/
	 gByhKbLttaC+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD96C021AD;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 18 Feb 2025 09:39:16 +0100
Subject: [PATCH v2 1/2] arm64: dts: imx8mm: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pinctrl_defines-v2-1-c554cad0e1d2@gocontroll.com>
References: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
In-Reply-To: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739867960; l=1515;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=yjNbAWHLu3XXaI0KgZJRRyT6zjDPbGIjjNo7caofJsc=;
 b=oHxxo9a6aS+p0LMiv1qxKq7p8JB5DEv7d8Inj/qw+mIItQ0kBzViKPDU+v0MQd48tJir8l24B
 Q4U67GyWY59DIbtNqH2f52twxZCESPgvlWZM0H2WMOJxQtZCpQ3ZuGD
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
index b1f11098d248ed5fc8ac42daed808beebe3bf7bc..127fed81bafdd1baee57a02e5be2deb2462e01a2 100644
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
+//SION force input mode
+#define MX8MM_SION 0x40000000
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.48.1



