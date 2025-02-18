Return-Path: <linux-kernel+bounces-518898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF28A395C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E5B188AC40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394C23F276;
	Tue, 18 Feb 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkrPfXlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6A23C8CE;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867962; cv=none; b=MjVu/fHr+rabeU41yDcUWapvjcl6WoxBLd7mwOHsg/NILvjo7JCwZ27QMvgfTYOe2fO2o3DsjV5R+IT2gu4XBr3XKePngl78DNYOFQeriWhHCArKRwAuNGjk7Onf0X5DecT5IjskKxgVbXDfkiPmZtWwLwEeGR3TyKOqm2MMydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867962; c=relaxed/simple;
	bh=CkqtmZB5KHiM8Aan+wuXyPLm1TSBQV9Yte8CU6LzQw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9OUQghqoKgXahTOTBnEgpuiKWfz2XldWAI6OM6hPSO0wrzt+Cq1BR6OdLi4jIduULmCNZCAo64OhDaLAGKXVt2kYRg0J4AzyWlM/84SfNAv12PnOA/4r6HLhxxhLaoQX6rY5+K5jU1lFacXp1Ly67gCTSY/SKgYo/QhUN+MUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkrPfXlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0B82C4CEEB;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739867961;
	bh=CkqtmZB5KHiM8Aan+wuXyPLm1TSBQV9Yte8CU6LzQw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OkrPfXlbrZHvT4fnEvEjo1f03AypPIA2NnTQb0rNTS0esw5/ouJr5FX0zohyg+mM8
	 dPJXagt/PEf1FbEii+djO8ASfkH943vlvnWMc/oFEw0j+2jsAKEob2z/kGAjQsAKgu
	 atJBOalnb0nEwrwZq3Mvt1daWlq+dBq4JtF85wD7tuUTtmGTiPl4ne6xq1H8GoTPM/
	 fZ9bd9SZ2zw3R9CxkqtnYLlkGP8Oyn5fTtuvxGL54ijS6q/N+RxY8j8ZVR9K9b4x22
	 9hXt8sM0rslksxeej3srcNFy/mgrrMcRQPRJAz7MH0wlZDKcY8TsErvC5IyhzHcWGh
	 nkDtOSsjzh3YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ABC021AE;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 18 Feb 2025 09:39:17 +0100
Subject: [PATCH v2 2/2] arm64: dts: imx8mp: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pinctrl_defines-v2-2-c554cad0e1d2@gocontroll.com>
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
 bh=5o/01a3GvB0utNsHA+384AEa62ZGgZhPhm6w4ssVfvg=;
 b=5S7R4X0KQnDtwEkwv2tZ3clrwtU9FdxQ4JwYBH20UV2i00v7wYXCOZdmDXULpIgWrH+A8Anzf
 JISjWyIH07dD+70RNDJRsyHlVq6Ha/KUrmF8KAoAoCo0aH+bTX9HyEj
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
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
index 0fef066471ba607be02d0ab15da5a048a8a213a7..0927ed11ec687d5b273c4a4a6455e8d81468f676 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
@@ -6,6 +6,33 @@
 #ifndef __DTS_IMX8MP_PINFUNC_H
 #define __DTS_IMX8MP_PINFUNC_H
 
+//Drive Strength
+#define MX8MP_DSE_X1 0x0
+#define MX8MP_DSE_X2 0x4
+#define MX8MP_DSE_X4 0x2
+#define MX8MP_DSE_X6 0x6
+
+//Slew Rate
+#define MX8MP_FSEL_FAST 0x10
+#define MX8MP_FSEL_SLOW 0x0
+
+//Open Drain
+#define MX8MP_ODE_ENABLE 0x20
+#define MX8MP_ODE_DISABLE 0x0
+
+#define MX8MP_PULL_DOWN 0x0
+#define MX8MP_PULL_UP 0x40
+
+//Hysteresis
+#define MX8MP_HYS_CMOS 0x0
+#define MX8MP_HYS_SCHMITT 0x80
+
+#define MX8MP_PULL_ENABLE 0x100
+#define MX8MP_PULL_DISABLE 0x0
+
+//SION force input mode
+#define MX8MP_SION 0x40000000
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.48.1



