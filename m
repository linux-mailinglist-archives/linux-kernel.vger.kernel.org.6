Return-Path: <linux-kernel+bounces-515257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78048A36279
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36A37A44F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773B267F46;
	Fri, 14 Feb 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myC+aGHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531992676FB;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548664; cv=none; b=knCiuPRZLVYSWt3qMo8hyKgYjd6AdvqRBmE2Fi6J82/pgAwUi0pFq8Gd36yFKiA96bIPF9ZOG50FWfKQNJ0KKM3IOAMhCrmYEfFk2k0m5jkeBK/lMF7jWA3xERCJIb0nElju6D7qkJ1+9glXoSiPuxOY7NPx0OAV1yW4QQBykNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548664; c=relaxed/simple;
	bh=X0Agohr9oHi/ZUCQ/VQiX7OEwANKVniqV1xfW9Qd7X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTSm4SkX+Tis9vMyQgReI4hjb9C5N7RHlmdkvvfEVoOFcrAmMByhc7rHSmqU5tTiPSyMGH8szoFb9ZiyXkiVyiJtOygOQCq12m+IK5m5MzB8JP1kwUcog+ge/OFpLckgyC6WsQfSWJjIlH1HexWObLA8GOZ1l5RNC8RKfburDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myC+aGHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28EC5C4CEE8;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548664;
	bh=X0Agohr9oHi/ZUCQ/VQiX7OEwANKVniqV1xfW9Qd7X4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=myC+aGHJFXJYhoW6N7qwAagawL3e9GbNV89ndpmC2wVQHyuCOTxQ9KbQPJtA1Ew8Y
	 5plFExN7VqBOS9di6nmwjIlQ15sl7cn1EVWWaeeABbGSnWGKH91rXX8ghRbVXdG1/p
	 ivXo8IV6OhwW8QN7XmcUjIU032V/6A2z+vQQMLQNHY8MaVUUFnr8hsr7dZaj6/9rFB
	 sKNk30G91qY+6hCzJA7WRQY2NZUzshDCk5p/SlOHKypdYSXFftTfucAYoP0D+sJdBx
	 NNCDVYxq9LMS+Qhc9Qhdq9akZaI1JE/0sHw+PxZdg/NztFq815UALC/EP/4TiCcQh8
	 h4vVx/2MbkEzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3CEC021A6;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 14 Feb 2025 16:57:43 +0100
Subject: [PATCH 2/2] arm64: dts: imx8mp: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-pinctrl_defines-v1-2-fbc86a42ef3c@gocontroll.com>
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
 bh=9sf7EGiqWWtALwUaK5VfgvYXRabE7bq8Almx6FlUGXc=;
 b=NfAzhM23mmmdlp9seKZ09vzSHp9Dlr7kU0pa6Xix3xCZgpVid9kH2jgqY3/UJ/cmc+42H5g5/
 5ErsfYmMERyDOX8UgLGcekAw8ykxaF1FNltNKLVwIJPfhHaSXcqk3rU
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
index 0fef066471ba607be02d0ab15da5a048a8a213a7..8d4d621ad22165ca6c92499b273ec4178780c475 100644
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
+//?
+#define MX8MP_MYSTERY_BIT 0x40000000
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.48.1



