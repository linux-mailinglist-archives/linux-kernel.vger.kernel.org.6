Return-Path: <linux-kernel+bounces-416767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90D9D49F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470FF1F217E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31C1CD1E2;
	Thu, 21 Nov 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tQDJc872"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3D1C9DC5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181092; cv=none; b=c4PeeZO//VjDxRmjGiUh3QwPx4Jb55l0JX5KpDxCETJ+99O+ZZBgi+xnt9pdo8wCmeYUopKuV5oqyAKfY5iLBIrBjrk/dC1w3GuSguUIdqBA/J2n7pIYPTUqIvz31GuctRVlqtIr1E5849zG1HnLQSQ7AF/+T6wCi/B+lR8BOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181092; c=relaxed/simple;
	bh=hTZs9u0Oqdf1I9PjVZl9bFYDm54NofKT7IeYsH2t1xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqk4bL0/+Q3gyZi/R6JLY2QaUJaNQ3gxK7u9lkpqlRwuU6hwbs6xfwBQ0mwqRGSaf075GybzFJg2E/D/+Ztmyz9FxrLYdssB7rNaOl/gdT7lUEvrHLR5D5oJixOwcfnfPyzOQV9Y7+tFKylzOysnepgL4B2DypmQ53CKIAj1Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tQDJc872; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732181090; x=1763717090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTZs9u0Oqdf1I9PjVZl9bFYDm54NofKT7IeYsH2t1xw=;
  b=tQDJc872HWXWqiP1D/WzYcVyBdofHwHxJeT0mthikYpR847gUW9hjahB
   8lbJ12tF4KCSjvZlOvxzlcix/NvH8pzV7qaRwL2EPKdQf5PFvBMt/bjbt
   enSw741Whi6UxyMWQSjEoCqYtzROKbf8wmewhGYopFKHdHI/Z+6fy31su
   QkzzJW/WQMcSZJy9z/tBoC7t6aB3RlOXzJgQ0a7/8XwEZLNBb37Uowig4
   Wudbtd5ahxF3763qmGDfz7+stlP3Wl7uarLV+dgcISYQjfMPauEWjTgLg
   faCovnrVGe8ltUMJ4TZpeLxFuEPjSbo/RJ4Z4FZopOiej6IDhIvzVc7o9
   A==;
X-CSE-ConnectionGUID: wS72ZE3TTRmRyzdG8hxnTQ==
X-CSE-MsgGUID: aalNNPKeSoqk3SayxHhJFA==
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="202047025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2024 02:23:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Nov 2024 02:23:08 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 21 Nov 2024 02:23:04 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, Dharma Balasubiramani
	<dharma.b@microchip.com>
Subject: [PATCH 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for LVDS display
Date: Thu, 21 Nov 2024 14:53:07 +0530
Message-ID: <20241121092308.130328-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121092308.130328-1-manikandan.m@microchip.com>
References: <20241121092308.130328-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The XLCDC IP supports DSI, parallel RGB and LVDS Display.
sys_clk(Generic clock) is used for DSI and Parallel RGB displays;
And LVDS PLL is used with LVDS displays.
obtain anyone of the clocks for the LCD to operate

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c       | 16 ++++++++++++++--
 include/linux/mfd/atmel-hlcdc.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 4c4e35d404f3..60b0b766459e 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -108,10 +108,22 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 		return PTR_ERR(hlcdc->periph_clk);
 	}
 
+	/*
+	 * Obtain one of the main clocks (GCK / LVDS PLL) required by the
+	 * LCD to function,
+	 * GCK for Parallel RGB and MIPI displays;
+	 * LVDS PLL for LVDS displays.
+	 */
+	hlcdc->sys_clk = NULL;
+	hlcdc->lvds_pll_clk = NULL;
 	hlcdc->sys_clk = devm_clk_get(dev, "sys_clk");
 	if (IS_ERR(hlcdc->sys_clk)) {
-		dev_err(dev, "failed to get system clock\n");
-		return PTR_ERR(hlcdc->sys_clk);
+		dev_dbg(dev, "failed to get system clock\n");
+		hlcdc->lvds_pll_clk = devm_clk_get(dev, "lvds_pll_clk");
+		if (IS_ERR(hlcdc->lvds_pll_clk)) {
+			dev_err(dev, "failed to get LVDS PLL clock\n");
+			return PTR_ERR(hlcdc->lvds_pll_clk);
+		}
 	}
 
 	hlcdc->slow_clk = devm_clk_get(dev, "slow_clk");
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 80d675a03b39..07c2081867fd 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -75,6 +75,7 @@
  */
 struct atmel_hlcdc {
 	struct regmap *regmap;
+	struct clk *lvds_pll_clk;
 	struct clk *periph_clk;
 	struct clk *sys_clk;
 	struct clk *slow_clk;
-- 
2.25.1


