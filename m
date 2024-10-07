Return-Path: <linux-kernel+bounces-353433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0388992DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47980283BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0C1D47DC;
	Mon,  7 Oct 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UeoRDDm7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B791D4159;
	Mon,  7 Oct 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308971; cv=none; b=LZlXYxJknBRJu6p7k24sfT+GGx0swFODicSlRhgkp1jjPDMBwrs4rHA7qIFVlXi5RAKXqQT19aYhL9o/qw9eogCEQZbSOIZsY1QgMSgOWPxsHeSMPVMfZabtxAXcAOIgMIeERT6hcfLa/AyffOnFQnZfzByCW2BueNCgIPWA9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308971; c=relaxed/simple;
	bh=a+GhVF9XnM+5PTO1PiRr7D5iq0IWNeHoj9XGvVFvYhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INsRHPw0W8P8a4NuBLx0enAn0m48jO/YtiKuqtEv9U9Pir/+0TGEHCGl71A1dmWhwLPzXkliFwPfLeMjULguAzwxaivdZX7zWZCrxZSQ25t8m76likD2x6IFUPgwGuyvx22Q50Mdy8GnWZzQj6yMCWI18N8w+pBl+ORxYb/38nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UeoRDDm7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A80CE1C000E;
	Mon,  7 Oct 2024 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728308962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/s4iZzlbaL8nP8tepYmpRbgyBTSIF3QZF6iySKFSVM=;
	b=UeoRDDm7TCChP4N8Am7HO0ZPlGne91ytjnwaEfIB2n5KMgFhEpane4mX/ex6mHOEqaoEja
	cdwHVusCSFSo683p81V3L4e+8Gn77Eis+9S0HB4VqXK345IVkifDa/h9ezphHFXfkyYp+k
	ZB5/hB3YJQwxz0km43mlB9loZu63UQVeJzFzfW50mKGnFjCQ/XeNwAJdZOxRwakL4Eidmq
	34ufBnPtr4gjkFA5BynQuKMrvnWSz9WivPFYHqvu3EvsRO984+smUDceS+Mit88DC+Gw/m
	lBkhcAhmqw9hRDC/YNu59SMm8qDsa8664JZL3rajP1Fs3J0ALc/IoOkw1hClrg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 07 Oct 2024 15:49:17 +0200
Subject: [PATCH v5 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H
 clock indexes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-mbly-clk-v5-2-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
In-Reply-To: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
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
index 26d8930335e4b113a74f47575957e39163f02766..b433c1772c28fae818b3a6ba428d1f89000f9206 100644
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
2.46.2


