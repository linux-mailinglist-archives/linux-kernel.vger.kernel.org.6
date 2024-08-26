Return-Path: <linux-kernel+bounces-302325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819895FC98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FF1F227F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CF19D8B8;
	Mon, 26 Aug 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lD+g1uvp"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9C199EB2;
	Mon, 26 Aug 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710550; cv=none; b=DmqvRZ241bEGp4hRpdY0Qo+LLwfD+yfTHtll4nrYuAIb6WbpelRpzGfZrUGwzq4haxSohH1KHllV2/P4hVc1JiaFXezzwhpCodcieUmgQCXGO5UHOAHZtRCPooWGAUO53XZpRvJrTD1Ji+ZoOborr6pkCXHujuLxs4lD7jBbiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710550; c=relaxed/simple;
	bh=8zc6eTLgDJTETrIfUkURRl0Y/PHxa9+uwpqhEyvE8CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHkOh4Dblj0oCrIph/8uy/L+JaTshcmXCxOaAVTDJniA+hObYcOCA5MNH7by7kL4FworyYYruE+3PfwRThoaHnLlvhq8Gb1OO1loaDhtjF9eTSszB/B6P5oZF2Zg6eFyh0mAzufTgwK+NIBhQKzxJHNYanNnHvRt5UWSw00b2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lD+g1uvp; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ACE7F1FAC7;
	Tue, 27 Aug 2024 00:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724710547;
	bh=Z79WcgwrkaS4O3mbowHc85Qc5rTcXPBV1a1hHicu+jw=; h=From:To:Subject;
	b=lD+g1uvpNNXIgZ0FsvZzUseq8KXPFM/GCbWx+ZRPe8A98XYuiuwAMuhRiiwOEbbuI
	 OU7YWzBETzTfhG9hB01Xj/HwCmw5pOE/jMbZZduEot3PiS65hUxjzQSGTxZQSC6SNd
	 FmgdUiDoO8RfOfa3NXXD+qJz0nWzw7Ds2LfNB1P5NZUDq5KUhgLATOTzo7mGPko4xM
	 wBpmRhG0ykDSQQQrwRLaMfJUmOwH9++unBFXiTVyNrWqPgCDII0njyg0mcKhorKoIz
	 6lTaaQWK61EbvsvoogZWHsB4808WXLj9aLeRSOTgPH3qumoQQlF997+2ytnhdVgDmq
	 N/1tYib7UEiEA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/5] arm: dts: imx8qm: Remove adma pwm
Date: Tue, 27 Aug 2024 00:15:37 +0200
Message-Id: <20240826221541.15669-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>
References: <20240826221541.15669-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

There is no adma pwm on iMX8QM, so remove it from the DT. When enabled,
this cause warnings on resource partition ownership check by U-Boot
that receives messages from SCU firmware saying that these resources are
not owned:

Booting using the fdt blob at 0x9d400000
Loading Device Tree to 00000000fd622000, end 00000000fd66efff ... OK
Disable pwm@5a190000 rsrc 188 not owned
Disable clock-controller@5a590000 rsrc 188 not owned

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index aa9f28c4431d..d4856b8590e0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -4,6 +4,9 @@
  *	Dong Aisheng <aisheng.dong@nxp.com>
  */
 
+/delete-node/ &adma_pwm;
+/delete-node/ &adma_pwm_lpcg;
+
 &dma_subsys {
 	uart4_lpcg: clock-controller@5a4a0000 {
 		compatible = "fsl,imx8qxp-lpcg";
-- 
2.39.2


