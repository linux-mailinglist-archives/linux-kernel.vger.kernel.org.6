Return-Path: <linux-kernel+bounces-416769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C689D49F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51AEB24567
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01041CFEC0;
	Thu, 21 Nov 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qn4P0HLX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A216F288
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181094; cv=none; b=HMy7tFDDd//ms3GheQJFwLYJjVGDtDjeL7JIae+licE13+9huigkzSvZXpL/RKG6f/LuO99gz9SO2CP+Eosfn0VfUGtPuKRLYwxNE4yQW5VW0ATlRdP1zCAwfnUZsgwqHujo7o2vjO4f83hO5BG6GQOaGtU86QKQj8CkHrpId6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181094; c=relaxed/simple;
	bh=nxKf5QOaOvMz6pxHfw4grQb5c34JrR+fnuNyXv/1n9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK123m5y1qk7/ijc1Fy5ASy/Cck5Uy7MmOehRXrt2zMOYdbRmKEuJJ2hC8GufJ7zUZhkq8U5CCMQeKoGrvU3LT14bNPAo+NwRXKyP9v8muPSomNOeOZj/ww4ROqlOWKIDirIANmkQ4gB/eRdLrDgsiIo1Gsq8w5Wus+hn+xkr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qn4P0HLX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732181092; x=1763717092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxKf5QOaOvMz6pxHfw4grQb5c34JrR+fnuNyXv/1n9E=;
  b=qn4P0HLXVeJ8xQO4OuWAcZbMVnkyu3ibNepHScnI5xTFcY0sQs3pVXs7
   UvB6yYJN5vKdL57xJgmhooo6r+RqDu/LvFb3OxZHOoEE2OMHJi+lqyMsZ
   AfnqlVcFQH2nUFWM2JvUUY1t4gitiwg3E+BIj53truXLmcVDQCA0xMA62
   5uFDY4TgOZ6kZTmdjx3siEp+OgW0xW3eub6gCysP68DCEHpMRr6QhcKib
   Mooh+U1t3xFLpXFYdSeD7IzHqPmRUn5cGADMbREAogwqIcqpE8CnAYVuq
   9Thf/FhIDM//d6pbXw/WloKiBg/ZQrBUz4cNaV4+V6L+wjjHMlit4/lkl
   g==;
X-CSE-ConnectionGUID: wS72ZE3TTRmRyzdG8hxnTQ==
X-CSE-MsgGUID: NcTGc9clQXmwz210lj1F0Q==
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="202047029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2024 02:23:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Nov 2024 02:23:15 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 21 Nov 2024 02:23:11 -0700
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
Subject: [PATCH 3/3] drm: atmel-hlcdc: set LVDS PLL clock rate for LVDS Displays
Date: Thu, 21 Nov 2024 14:53:08 +0530
Message-ID: <20241121092308.130328-3-manikandan.m@microchip.com>
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

From: Dharma Balasubiramani <dharma.b@microchip.com>

The LVDS PLL clock is 7x the Panel Pixel clock.
When using LVDS displays, the LVDS PLL clock rate is set using the
panel pixel clock, this skips the usage of 'assigned-clock-rates'
DT property for lvds_pll_clk clock for LCD node.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0e709047369a..d11040d5cc5f 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -99,9 +99,15 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		drm_connector_list_iter_end(&iter);
 	}
 
-	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
-	if (ret)
-		return;
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+		if (ret)
+			return;
+	} else {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+		if (ret)
+			return;
+	}
 
 	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
 	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
@@ -186,7 +192,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
 			   cfg);
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	if (crtc->dc->hlcdc->lvds_pll_clk)
+		clk_disable_unprepare(crtc->dc->hlcdc->lvds_pll_clk);
+	else
+		clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 }
 
 static enum drm_mode_status
@@ -242,7 +251,11 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 				    10, 1000))
 		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	if (crtc->dc->hlcdc->lvds_pll_clk)
+		clk_disable_unprepare(crtc->dc->hlcdc->lvds_pll_clk);
+	else
+		clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+
 	pinctrl_pm_select_sleep_state(dev->dev);
 
 	pm_runtime_allow(dev->dev);
@@ -255,15 +268,38 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 {
 	struct drm_device *dev = c->dev;
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+	struct drm_display_mode *adj = &c->state->adjusted_mode;
 	struct regmap *regmap = crtc->dc->hlcdc->regmap;
 	unsigned int status;
+	int ret;
 
 	pm_runtime_get_sync(dev->dev);
 
 	pm_runtime_forbid(dev->dev);
 
 	pinctrl_pm_select_default_state(dev->dev);
-	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		/*
+		 * When using LVDS displays, fetch the pixel clock from the panel
+		 * and set the LVDS PLL clock rate.
+		 * As per the datasheet, LVDS PLL clock is 7x the pixel clock.
+		 */
+		ret = clk_set_rate(crtc->dc->hlcdc->lvds_pll_clk,
+				   (adj->clock * 7 * 1000));
+		if (ret) {
+			dev_err(dev->dev, "Failed to set LVDS PLL clk rate: %d\n", ret);
+			return;
+		}
+
+		ret = clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+		if (ret)
+			return;
+	} else {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+		if (ret)
+			return;
+	}
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
-- 
2.25.1


