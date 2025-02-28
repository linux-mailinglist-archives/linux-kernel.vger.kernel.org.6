Return-Path: <linux-kernel+bounces-538782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8558BA49D01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14AA1898099
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF127290C;
	Fri, 28 Feb 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yhFJR7lk"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924826E17A;
	Fri, 28 Feb 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755644; cv=none; b=mNjeClNjBuPLx5jgctMONQEjYn/ieT/Hshduq5nWJ98+7x+LTxL0t97EUNhbBoCLr7RtV2udaZceZ4ixF1QJIuc7luJqOAlwBF6+P7OYqXvE7wlnbfP2ePkICd2ROEsNbgTaDEOLE0MHPetbkWfhEfXLU0uU4MORq/tDUEi6lI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755644; c=relaxed/simple;
	bh=O1NrZ81ubMGOuyJdbDDnnY5m6XONHhVPmqcZNIo8M3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsnMZ38PmiIvaFDtV06mLEBAa8pDm+QRd1KTU+I1yU1ScyaJMT3Ns29f9mlH+lexKGG7+5m9ZCPp84GY9K60E9m1BhGUfwl6oqD3TGm6Gt9WsyfoZjBHiLZbyUH2sWcSgGDdLawRNfQJeqS4k5m3EOp5MbuZKVnpaBG9ohYKFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yhFJR7lk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A3C151F983;
	Fri, 28 Feb 2025 16:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740755641;
	bh=Swk7BV1GveQhBWA5phfXY133aeK5lckY/5jFPBjzJ4I=; h=From:To:Subject;
	b=yhFJR7lkk+SRxRNq5ZgFavLKmhdiDRpXCp9/w7N9LZ6OyK619X97f7JaGPhjweZEC
	 Z6jAvcNuk/7RKwLnU17NiY1zVpFAygG9mt73GW+UekG+S2rHjFV5EkwbsTURl4dRog
	 IrsW+5xRq9y1h1TUpgqikpR+1SlXWjiYtDDx320zcKWExQzNVVLsk6p0eo0IxZZIcu
	 F8NBHH69Qkz8RpsbvGiOol1i3MuTXqemfEysSZwV6saLIkN3zYvzKb/eBOGhRIeRv1
	 o9qqxCcpEQ85QUsF1WM/qlxjDekNwN0mktiSPGM/0GV5g3yUC6Mlnb3XSOnJWw+f+o
	 aN3eLr3UXg/Nw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Agner <stefan@agner.ch>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] ARM: dts: vf610-colibri: Remove compatible from SoM dtsi
Date: Fri, 28 Feb 2025 16:13:52 +0100
Message-Id: <20250228151352.91768-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228151352.91768-1-francesco@dolcini.it>
References: <20250228151352.91768-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The SoM cannot be used standalone, this compatible is invalid and it is
always overwritten when this .dtsi file is included, remove it
therefore.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: new patch
---
 arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi b/arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi
index 607cec2df861..20aed3946214 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi
@@ -8,7 +8,6 @@
 
 / {
 	model = "Toradex Colibri VF61 COM";
-	compatible = "toradex,vf610-colibri_vf61", "fsl,vf610";
 
 	memory@80000000 {
 		device_type = "memory";
-- 
2.39.5


