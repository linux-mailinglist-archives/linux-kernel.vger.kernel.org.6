Return-Path: <linux-kernel+bounces-350701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E099082B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701C11C209B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C441E3DEA;
	Fri,  4 Oct 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DbEnlfFE"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ACB172798;
	Fri,  4 Oct 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056739; cv=none; b=ptSW4D2XsCaG5mMnMX/D5QnlkzwUoSorBYLph7mbiECPDhvxOYCfr5axjcM6+ThiXRBQiSW51e8rzO+5rKr01xsaJFRDzu7+KT4WmURodsPABaMzS93Y2yXhUmq/2zReUMoi1tm8nXkOqe2GZ19R9Wt1cpMQfrDVnbHquQ87IuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056739; c=relaxed/simple;
	bh=a+GhVF9XnM+5PTO1PiRr7D5iq0IWNeHoj9XGvVFvYhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKIWrjOu1bwHawelO2ChHQ1Rogzzb84iPBsjGrbZDCUdjEScZl6olzcgqm/2xI70C9G3xpuP9FFfnHtP0BgiwQuwLJweZ//DJaoNWAj4QYwnk3Nv3sYpxcIqM5B6N7e3PXG4LuHm2MH3GPYQbG9PfZEXx37+A2s1guE88xEL5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DbEnlfFE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 636CCFF80C;
	Fri,  4 Oct 2024 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728056735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/s4iZzlbaL8nP8tepYmpRbgyBTSIF3QZF6iySKFSVM=;
	b=DbEnlfFEIyHO2dhDRaj5Hg3IQoJuCsCf99yC3RmKZkmp14O9kiIN1Q+3Y4lN4KhgFylYKi
	238DnmhVy8QWkp27DCU6NrNQ2nioV+7ETjXPc3qCoppjjNyf4ZAVeoA3E5NmSk1ucKCp0k
	HExHz2J7BPEveoQy/eDoKMbRXpaor1v1XdK2SwopxGtB+XX7YuTRzyy3HYYCXtqhepYQN1
	1hi+H0PQ48zUzD3ZbaV3FRvCa3VgL4izE7a4x2jZdXhekplx0tu0mg9yHz8WLn50ZQyNeO
	XNVloGJprwjrANS+PGwO+rm3tlo5GJt2SA8aBnlPrYWrJ28H+W2bwhARFG2q6w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 04 Oct 2024 17:45:34 +0200
Subject: [PATCH v4 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H
 clock indexes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241004-mbly-clk-v4-2-c72c2e348e1f@bootlin.com>
References: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
In-Reply-To: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
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


