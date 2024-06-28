Return-Path: <linux-kernel+bounces-234181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCE91C35F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A92B23413
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACE1CB307;
	Fri, 28 Jun 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nfUgNvO7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9E1C68AE;
	Fri, 28 Jun 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591027; cv=none; b=FWXFMkvpFcRaQaCy1I6dr4sZGbpQ47AOc7pFcvMO8ozz/YrG02nUz0nZF7xF29YKIH9y1pxKdJ1NzINuoo30MlSnSXN7GxD//oNPzkGS2QrkMur6qVhOUjSCFDfZeH1Bu/IvYUSx7WLVpFTYsR87ObUtIcnwKskfExpIqgE314A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591027; c=relaxed/simple;
	bh=9qSpRLCuKaFUBRxqlx83vNUsdIclaeD6SVNh5D8SI2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3gqHvcRtHJqKQSM6A84VZGMbskwo5br2rnqo9Ji2UKZr/DGwR7S0lbc+yVuODVShCEMP1fz1gEQdf4Cr2B6sI6Bw4jE/H/jesYTJfTabY+mmQtB/Os2FGM0xXCXnrFZfio91alfuhGOmP3rUh0cDWy5DmDvMwZoORGRFPEg/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nfUgNvO7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4884720004;
	Fri, 28 Jun 2024 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719591022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1b52fT1/2Kf4dSU9w6f3MSFKH/CzmEoTrYMNrGf0Tc=;
	b=nfUgNvO74o4rB2rKFhFtbWty3CkdRDypJRDu7F+bLZaQOReHGLtDbuj0+FD1+1MGLXxhvy
	7O/yNeDsoUioVH4CgbomF2K/7ybJnQn5v7dflAuWXGps0SaG5fLFIMdAoAshdl7cgW0LSp
	shyQhfITy/+8AX1L621SHRRfT1Y8JZ/jWZm4iRegaDyCCG5P+lCbf1Yb00dmHgAO4PiRla
	VRX09ylBwsO+Lw9Jyn7KsVOZUpVwsksVY4B3QmMFSjmrcaytFz3C2J3rftEblgjNNnPeQf
	W+XLLT0TsNXJCpdIYdiBp/k9Sys1VABmue95vHyDo7oC3T2rLBanvhvVBI5q0w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 28 Jun 2024 18:10:08 +0200
Subject: [PATCH 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H clock
 indexes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mbly-clk-v1-2-edb1e29ea4c1@bootlin.com>
References: <20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com>
In-Reply-To: <20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

Add #defines for Mobileye EyeQ6L and EyeQ6H SoC clocks.

Constant prefixes are:
 - EQ6LC_PLL_: EyeQ6L clock PLLs
 - EQ6HC_SOUTH_PLL_: EyeQ6H south OLB PLLs
 - EQ6HC_SOUTH_DIV_: EyeQ6H south OLB divider clocks
 - EQ6HC_ACC_PLL_: EyeQ6H accelerator OLB PLLs

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


