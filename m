Return-Path: <linux-kernel+bounces-302296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92EC95FC40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8A81C22647
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AF19D8BD;
	Mon, 26 Aug 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YwPkNiDk"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53721199392;
	Mon, 26 Aug 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709583; cv=none; b=TN4M95jsrnEaOGs5vcnmhixBT5JpIK1A75SjwmayTgnnj0yUV70sDpTJoyx9COwy1B8+fzQ70iFxFzArI0d78f6X1g5SQx7F8sC2GEgX1CaXZ4DURcF0oA7nPqDAUkUEuZ8qwgUY+SVl3sV1VtD4UUkZF0NDhD0P2kowfsL+4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709583; c=relaxed/simple;
	bh=c+vETQmbAaueA+hLH6yRpN8JE3WegH/Cn98FsewdFOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z79SXf7VSHboM7fikedIOl0jD1PdnNxCaue9wXEzeu9onxrrf5Sc8cvetcQ8wXI7enjsqatKSnfZld0O7s5pejwjn2FxcEEFj6yp+8g9DpXCN2olYL8TbSMBP9xtnEy27Z2isTsBsT/KLluXyiWx43mxjRFmkW79EH3uFHR4tZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YwPkNiDk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 172FD25065;
	Mon, 26 Aug 2024 23:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709578;
	bh=Y6SBDzFquVWsPY1lMx9z0fEMhXiSLxw9RPsKlk+gYHE=; h=From:To:Subject;
	b=YwPkNiDkLzHstFIFTpd0vni25qwybAiM5Lbw4+T9m43gwiOysERiaugEEBJIF5u3W
	 8tXPHNR2EL7UNgjO+hKwB9Vin+Pf0fYVfKhfzVJZafKfmJYYV5WV8s03Teha7+l1KW
	 hvuDCCgrk8PLu1BAO3Eaf8jH0XqVJgN9FV0S2kZ2r6hf/qNRlm1t9ri2B/pyOPBRur
	 MMGl8CNy35C0Ll9jKPZTGsanYDghdAYTnTlUhk8L17GkQsF1HliB+ozVI91pV0RM9x
	 Mn10f5l2xjI3raEyXLhs+A+p4lkHSKzITThhF7uXDRIBoqqjnmZXyJFdWo59cmRRTX
	 ghad59uaDSqgg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] arm64: dts: colibri-imx8x: Add fxl6408 gpio expander
Date: Mon, 26 Aug 2024 23:59:15 +0200
Message-Id: <20240826215922.13225-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fxl6408 gpio expander, this is required for Wi-Fi, Bluetooth and USB
functionalities.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index c7f0dfe7b162..aa9c45c290b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -108,6 +108,21 @@ touchscreen@2c {
 		adi,conversion-interval = /bits/ 8 <255>;
 		status = "disabled";
 	};
+
+	gpio_expander_43: gpio@43 {
+		compatible = "fcs,fxl6408";
+		reg = <0x43>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "Wi-Fi_W_DISABLE",
+				  "Wi-Fi_WKUP_WLAN",
+				  "PWR_EN_+V3.3_WiFi_N",
+				  "PCIe_REF_CLK_EN",
+				  "USB_RESET_N",
+				  "USB_BYPASS_N",
+				  "Wi-Fi_PDn",
+				  "Wi-Fi_WKUP_BT";
+	};
 };
 
 /* TODO i2c lvds0 accessible on FFC (X2) */
-- 
2.39.2


