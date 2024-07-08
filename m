Return-Path: <linux-kernel+bounces-244143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D9929FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99731B25EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF87711B;
	Mon,  8 Jul 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="henPcDD/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B776F2E9;
	Mon,  8 Jul 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432657; cv=none; b=RkPKQm5l/BEmPUQNDHuCUTHxwMU0fz514oMRs4D6j2PjCOs/9FNk1HQaaPDsJLSxK1+U1bTiynFZiahsO43LmSRc8R1cC9qSXToeFgBuQ+pEHXSsIdIjmnhGghwLBFAu45D9g4gETiLcpg99f2BYgEQr9kvDAp+ZIm3koFG+N8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432657; c=relaxed/simple;
	bh=WtGnHZZ+RLi3ObKl8onh0tBYRgZkXH7SUIfhPKJ46EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK+epZRC9oEIWFKn3z/3jwdQ5Ztv8fejdAagntp0SaBWQiJyWDuBJ+GkP9+Sh/MqhnxbcvxulKj3kp7YOZV/wFsSNI9fUst1BtUVFmG9UvpnMkDZPECWGUd9owSu8PLl5cAvFO2wkQbHta571f6mMvqTXBN5iksePEQqVO2UAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=henPcDD/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 691BB1C0009;
	Mon,  8 Jul 2024 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720432652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRcR8zDM+0q/eOEPboWIYCWFm9lgVjfqj9jKDcJMYSY=;
	b=henPcDD/Xx6WcGlk6MF4G5sbJgkvt29+NBJFjoPsuUtuMVET2sPMlZ5JCVa1qwuW4ftZBF
	SZc82/1nFU4Z/iS9+TCysXY0lfRwzeMQ/O26mqGxs5yccW1buzl/mps8r7dPpvdBsNue9Q
	8k+dHIPbUGCE6SB1dEr0SVGA+JmZDjKV59sn05a0U71fipOEb1SFUCmQi/74cPVrSUrpmi
	mo7iAspCsTvG5EVg03+82N1/3odeNADfctgcit+Oors9G+geM144zAEaAMOIrF1sD6JN2z
	biGFsiDlPc0o2l/FhWGNfMTHk5rYJJ4swvtqN15xaENQSQvFXtXyjd414hZv0Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 08 Jul 2024 11:56:32 +0200
Subject: [PATCH v3 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H
 clock indexes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-mbly-clk-v3-2-f3fa1ee28fed@bootlin.com>
References: <20240708-mbly-clk-v3-0-f3fa1ee28fed@bootlin.com>
In-Reply-To: <20240708-mbly-clk-v3-0-f3fa1ee28fed@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add #defines for Mobileye EyeQ6L and EyeQ6H SoC clocks.

Constant prefixes are:
 - EQ6LC_PLL_: EyeQ6L clock PLLs
 - EQ6HC_SOUTH_PLL_: EyeQ6H south OLB PLLs
 - EQ6HC_SOUTH_DIV_: EyeQ6H south OLB divider clocks
 - EQ6HC_ACC_PLL_: EyeQ6H accelerator OLB PLLs

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/dt-bindings/clock/mobileye,eyeq5-clk.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
index 26d8930335e4..b433c1772c28 100644
--- a/include/dt-bindings/clock/mobileye,eyeq5-clk.h
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -19,4 +19,25 @@
 
 #define EQ5C_DIV_OSPI	10
 
+#define EQ6LC_PLL_DDR		0
+#define EQ6LC_PLL_CPU		1
+#define EQ6LC_PLL_PER		2
+#define EQ6LC_PLL_VDI		3
+
+#define EQ6HC_SOUTH_PLL_VDI		0
+#define EQ6HC_SOUTH_PLL_PCIE		1
+#define EQ6HC_SOUTH_PLL_PER		2
+#define EQ6HC_SOUTH_PLL_ISP		3
+
+#define EQ6HC_SOUTH_DIV_EMMC		4
+#define EQ6HC_SOUTH_DIV_OSPI_REF	5
+#define EQ6HC_SOUTH_DIV_OSPI_SYS	6
+#define EQ6HC_SOUTH_DIV_TSU		7
+
+#define EQ6HC_ACC_PLL_XNN		0
+#define EQ6HC_ACC_PLL_VMP		1
+#define EQ6HC_ACC_PLL_PMA		2
+#define EQ6HC_ACC_PLL_MPC		3
+#define EQ6HC_ACC_PLL_NOC		4
+
 #endif

-- 
2.45.2


