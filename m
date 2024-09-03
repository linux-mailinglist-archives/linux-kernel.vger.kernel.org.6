Return-Path: <linux-kernel+bounces-312579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8B969868
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969421F24549
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA81A303F;
	Tue,  3 Sep 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LJLSax9Z"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F219F431;
	Tue,  3 Sep 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354772; cv=none; b=In0Ql/8LCIbWyAMp0J7h1uoqbAKmpcuxVLJsyQ3yG0CtnSUzYLIFxQSSo3fDV9ZS3KbU8B86OyGXGCK+VCUId5ZICeRJHEDDQLGwsooY+2lACtfG6TaZO07IknOHBtQyyfVko75V8gdQTF7OTgslmgqzw+HJ1E2EF+3sULvu2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354772; c=relaxed/simple;
	bh=DTyOOLobd/qKf1bdjtAvL1jz9VeMDe3J9jwHjqeSG10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/jHDGSjAP+D1v19kGwjQMY3guX/b8lvytS0sKmnfvvKsCAQR2JQknlqQCWRzvofNBsKvkGQheBYW2KeJVmnyjxlQDzUdpWrTqbqjLplg8ylBHF2z0Hc64ocYXf8II9KOXoC072G4Su4Xg3cJhKHWz9Mpa9xxO+zWOjdo8L/4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LJLSax9Z; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 847F922A39;
	Tue,  3 Sep 2024 11:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725354763;
	bh=4IAA5pozI9ILYkiY09FMGfATfDyNogcWu3oVJJXEUNE=; h=From:To:Subject;
	b=LJLSax9Z6UAVI3aux3PhDbJ2y2ZHkussnboVaEh+Mw14W/c7rhkEqK/OHkIAx/lU2
	 FALYncdafJmcCA4oSPlkpQEfc9t0L/TEjs6Hj4GkO7TGTQiKw2ChtdX+jKJnCXWJeu
	 3N8k02E8c37VfTJrPqRJG6SGO4/uWU3PbYlARmfLhw0inaRwFN0GyLWQaQnhQCYT8I
	 zFPOmkeXlUr3d85D9ZPhOk5PulbecDLbQPyr8b5N1H09doSQBA5gV5VVS+WsMEqH2K
	 Ncb1WY06hoh9AG5S333RISP34GC43Y/OavNENdm0AN0nQr0WEbwxYfVf0RX5qsBgMb
	 8bUSinCSFMFHg==
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
Subject: [PATCH v2 1/5] arm: dts: imx8qm: Remove adma pwm
Date: Tue,  3 Sep 2024 11:12:27 +0200
Message-Id: <20240903091231.20035-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903091231.20035-1-francesco@dolcini.it>
References: <20240903091231.20035-1-francesco@dolcini.it>
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
v2: no changes
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


