Return-Path: <linux-kernel+bounces-302301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D795FC59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E501C224C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23419EEB0;
	Mon, 26 Aug 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XDJ3HRc7"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD419DF42;
	Mon, 26 Aug 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709587; cv=none; b=Splep0mhZrLMKxbCL7ddCPe8lgJfNkUaNU/yK7PKrUlb/6C2UxiwBroqn7APVOTdQ7aNgblofQ4YGiFKgJR8FvA6NtrywruaSYqFd/wXkbBp3Ss81JzTWZCMZN+B+44xtIPpGtlPHY4oqvYfXekq+D0zC2aY//IhMdJSbrg9A6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709587; c=relaxed/simple;
	bh=wtKZOyebMl2b3YJZkI5Q3LKJP6LpV3duZC2sj4V5Mx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZj1DhHtRYWe0S1m9lm91e2Q4lSqO6Gou29q6w3rxzJjf7OUwI1Zz4zxTqu7yd8BHzUa1KDdLb3r0qxoiYHbsalsoIn/fC4eKgA7HhaObBwSfo9nyPM49cM0krcakOA7QL0UALTsCuTARQbpsR8u4vRxUFHUmbGuIYI5wnbPGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XDJ3HRc7; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A5C0D2507A;
	Mon, 26 Aug 2024 23:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709582;
	bh=SDG2/Gs74zsbXlc1LkgedRkmMLU/OqYN0TCFF8ojvrI=; h=From:To:Subject;
	b=XDJ3HRc7pisfH/tnnEYXxfghttI3aMlXzuqKns38q+C769ZWj/kkSQjYMY682ewav
	 u3hT1Zizs5kdEozgCGUZYMLxgRtOwBgD7JluWGGWcruJQF7FYMpFPAgEKQJtRbvilj
	 ShYHfKYXo+ZAj1zilp2o/v/KJ0KQrR1/VdqIIZm7FlO0HMdPDcpsaD2wHraq8iSCVf
	 izQLrUoAQ28x+xKJ9tgts1FrOx58zzFceb0HS89dvwkxQwlvs6dKKlLK0wzTwA7DY4
	 n9QF0v3c2sc8OMpWMsUr8OcczvhpnafYz+k4AyyghE0FgiiqM+zZUnUUuMGQaXv6oB
	 mwhlNogXYJu+g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 09/10] arm64: dts: colibri-imx8x: Add 50mhz clock for eth
Date: Mon, 26 Aug 2024 23:59:21 +0200
Message-Id: <20240826215922.13225-10-francesco@dolcini.it>
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

From: Philippe Schenker <philippe.schenker@toradex.com>

Change enet0_lpcg to get the clock value needed in Colibri-iMX8X for
100mbps ethernet.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 9cd4383e9298..75259e8d48a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -106,6 +106,21 @@ &cpu_crit0 {
 	type = "critical";
 };
 
+&enet0_lpcg {
+	clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
+		 <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
+		 <&conn_axi_clk>,
+		 <&clk IMX_SC_R_ENET_0 IMX_SC_C_DISABLE_50>,
+		 <&conn_ipg_clk>,
+		 <&conn_ipg_clk>;
+	clock-output-names = "enet0_lpcg_timer_clk",
+			     "enet0_lpcg_txc_sampling_clk",
+			     "enet0_lpcg_ahb_clk",
+			     "enet0_lpcg_ref_50mhz_clk",
+			     "enet0_lpcg_ipg_clk",
+			     "enet0_lpcg_ipg_s_clk";
+};
+
 /* TODO flexcan1 - 3 */
 
 /* TODO GPU */
-- 
2.39.2


