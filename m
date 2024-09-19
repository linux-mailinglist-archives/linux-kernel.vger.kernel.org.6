Return-Path: <linux-kernel+bounces-333306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC3897C6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CAE1F21AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC1199243;
	Thu, 19 Sep 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eDIQrevV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82018B480;
	Thu, 19 Sep 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737379; cv=none; b=Ngvw+uxsw4Vb0JloKbcyK7xQUSmFX8FRdN4rU4DW4zTuvpJOvthxoHQjKJq66nUiAjw01CxF80l4aqjfeGlVdFAMU1m9MnkEXzTCosDUPbzfZ/eiiBehXELR8qegVYuKNRw/w3uI0N7awcCXfM2/q8AP+JyPyGqkOAsprEboUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737379; c=relaxed/simple;
	bh=NPcZIJk+LJa9EH76yxEJGbJKeWBB8KPoIR8ctK5lxLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEeZUkr0170N2GHd3XYxTz3lrcpXCb0qv1bxPHRPFJkZBcH7U/8N4kLrVAjEIfaxUUaYJas33egaWWHniovu1ulnHQ2Dh22cPzDJ1A3xJilIgp1YzmZSDzr8uWBB+Ct1CG8zvq8xf0YIB40g5ja4lsaVz/5XYYZ0aRO1o9cKcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eDIQrevV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726737377; x=1758273377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPcZIJk+LJa9EH76yxEJGbJKeWBB8KPoIR8ctK5lxLM=;
  b=eDIQrevV5Bbk1hj9y1DEvDWyZHLG6wGCf2rJgPSB/OPxKzioKGQgBrUQ
   ac6pQ89wRTnRFXh8Koio+Yy0Ohr+RPP0Bg3vNiO6PnRZJtVWh7VvAvPwm
   TQySJfsZyHT58wUKJUnjM4hRvrN9w56V1vFArpVubHWdrSwdksH+fHkQt
   AjNM1G5+wKzZniZep/w0cNuyKYdo+3NsbK8IQzxZn6a9RDmZeyywxNIYu
   H9sYJuBpUIJtp8+OFeiH+6yCI8eJh9P8kPNUBBJK0+62GfT7sHXLo12TI
   N873Dja+JEBcd7ONhzjkc1fFqN0CNQAsWWR/ncLBt4wSJ4ko/Ywd3kzP5
   Q==;
X-CSE-ConnectionGUID: 3OxAPMVERyGxmKW6ID2HbQ==
X-CSE-MsgGUID: uOPboF8ARLC6BjUNR42z2A==
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="31861842"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2024 02:16:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Sep 2024 02:16:03 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Sep 2024 02:15:58 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, Dharma Balasubiramani
	<dharma.b@microchip.com>
Subject: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS Display panel
Date: Thu, 19 Sep 2024 14:45:48 +0530
Message-ID: <20240919091548.430285-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919091548.430285-1-manikandan.m@microchip.com>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
Display module with LVDS interface.The panel uses the Sitronix
ST7262 800x480 Display driver

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
changes in v2:
- replace microchip,ac69t88a-lvds-panel with
microchip,ac69t88a
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 86735430462f..06381c628209 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4565,6 +4565,31 @@ static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode mchp_ac69t88a_mode = {
+	.clock = 25000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 88,
+	.hsync_end = 800 + 88 + 5,
+	.htotal = 800 + 88 + 5 + 40,
+	.vdisplay = 480,
+	.vsync_start = 480 + 23,
+	.vsync_end = 480 + 23 + 5,
+	.vtotal = 480 + 23 + 5 + 1,
+};
+
+static const struct panel_desc mchp_ac69t88a = {
+	.modes = &mchp_ac69t88a_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode arm_rtsm_mode[] = {
 	{
 		.clock = 65000,
@@ -5048,6 +5073,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "yes-optoelectronics,ytc700tlag-05-201c",
 		.data = &yes_optoelectronics_ytc700tlag_05_201c,
+	}, {
+		.compatible = "microchip,ac69t88a",
+		.data = &mchp_ac69t88a,
 	}, {
 		/* Must be the last entry */
 		.compatible = "panel-dpi",
-- 
2.25.1


