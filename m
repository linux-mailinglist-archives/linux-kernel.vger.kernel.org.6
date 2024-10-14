Return-Path: <linux-kernel+bounces-363303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7399C03B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D4E282FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBE13DDB5;
	Mon, 14 Oct 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iqP6dHtU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F71A270
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888449; cv=none; b=GQ90/73E5htDgXceVMLIkIHzt1BKrIKZcrLBiOz7fVN5OQkqFpX1a4HOke1J/60rIdm9xnb8f0Ogm8D2BzzYvXLNv5EepcEDLUXa7hfKRQq2gHlrenyNxgGLezAnUeT3Ov70uTXzB7mn7IrVWclefwFLC/jsnyeFVaXr4CiceYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888449; c=relaxed/simple;
	bh=04XYqrmnQ48BCQSPqaTd5Q1NXgx8uEeVrzQkfizNtcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtBRehlPGeLqx8FVnY44PGG5u4zS+wUODOg22Z2/lAT9iDDmJgfvFHaLoEVNYlTSWA0lwm8+G0bNiI5w+bpa6F2p6rOKaaIIDVb7Yej1M7vvBEfjPx/HJfd100S980QgEQj+Hddj541LHcXblgqpMNGivxC0w/ePq6h6xIzf0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iqP6dHtU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728888447; x=1760424447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=04XYqrmnQ48BCQSPqaTd5Q1NXgx8uEeVrzQkfizNtcM=;
  b=iqP6dHtUBtrsmZps8CVoBX6LgZuKOoJ/Zwjs4fzvCL4YHQdRwTpvDRtH
   /zDYLEarunQqIlw6fgzdWaHUGjm1BuAa4ESsb+23wJ6HwFIbU8bxXh7TA
   d+vHNRIaISX7WUB3Tk8aKixMkr6wnUPHVZ5bseCbFS2HxUCTYn5pGG1hM
   anznH5mV56vH0Hlj7b1bOyrT+HIHwWlUSmXfeTH5Kp8jpEKpz4K/DJpqm
   cw8YKPMYIViRnR/nEVsVrs/1nqo8a0qgS1vymZzQni/1ZiRyAO+Biv7dy
   SdCqoLExaHgACwxjfMJYFqxJiDa0b8kT6eaqittS/QF9aRRGS8FYB+OxE
   g==;
X-CSE-ConnectionGUID: 4xBlmyQHTkm/61W9c+bOkQ==
X-CSE-MsgGUID: nU2/czUjSwu/VSmxBYrk6Q==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32772256"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2024 23:47:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 13 Oct 2024 23:46:54 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 13 Oct 2024 23:46:49 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH] drm: atmel-hlcdc: update the LCDC_ATTRE register in plane atomic_disable
Date: Mon, 14 Oct 2024 12:16:44 +0530
Message-ID: <20241014064644.292943-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

update the LCDC_ATTRE register in drm plane atomic_disable to handle
the configuration changes of each layer when a plane is disabled.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  3 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index e1a0bb24b511..53d47f01db0b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -378,7 +378,8 @@ struct atmel_lcdc_dc_ops {
 	void (*lcdc_update_buffers)(struct atmel_hlcdc_plane *plane,
 				    struct atmel_hlcdc_plane_state *state,
 				    u32 sr, int i);
-	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane);
+	void (*lcdc_atomic_disable)(struct atmel_hlcdc_plane *plane,
+				    struct atmel_hlcdc_dc *dc);
 	void (*lcdc_update_general_settings)(struct atmel_hlcdc_plane *plane,
 					     struct atmel_hlcdc_plane_state *state);
 	void (*lcdc_atomic_update)(struct atmel_hlcdc_plane *plane,
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4a7ba0918eca..4bcaf2cd7672 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -816,7 +816,8 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 	return 0;
 }
 
-static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
+static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane,
+				       struct atmel_hlcdc_dc *dc)
 {
 	/* Disable interrupts */
 	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
@@ -832,7 +833,8 @@ static void atmel_hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
 	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
 }
 
-static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
+static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane,
+				       struct atmel_hlcdc_dc *dc)
 {
 	/* Disable interrupts */
 	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IDR,
@@ -842,6 +844,15 @@ static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
 	atmel_hlcdc_layer_write_reg(&plane->layer,
 				    ATMEL_XLCDC_LAYER_ENR, 0);
 
+	/*
+	 * Updating XLCDC_xxxCFGx, XLCDC_xxxFBA and XLCDC_xxxEN,
+	 * (where xxx indicates each layer) requires writing one to the
+	 * Update Attribute field for each layer in LCDC_ATTRE register for SAM9X7.
+	 */
+	regmap_write(dc->hlcdc->regmap, ATMEL_XLCDC_ATTRE, ATMEL_XLCDC_BASE_UPDATE |
+		     ATMEL_XLCDC_OVR1_UPDATE | ATMEL_XLCDC_OVR3_UPDATE |
+		     ATMEL_XLCDC_HEO_UPDATE);
+
 	/* Clear all pending interrupts */
 	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
 }
@@ -852,7 +863,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
 	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
 	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
 
-	dc->desc->ops->lcdc_atomic_disable(plane);
+	dc->desc->ops->lcdc_atomic_disable(plane, dc);
 }
 
 static void atmel_hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
-- 
2.25.1


