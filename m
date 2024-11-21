Return-Path: <linux-kernel+bounces-416764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D219D49E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA9AB21AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01931CB9F0;
	Thu, 21 Nov 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MbSWhlg4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B81CB328
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180993; cv=none; b=uSNvw7d0QMfLM0RMzZeiafEChvl79NaY/0mVu3q4OmcNtwdQcqGqvOfBbr+CN1eL/PzAlUkQMJ5VBTFA9w0mOBzGvcTxSVXSN9ziMWJmiI/OdMqsqNcWBRmseAqa9XptH5a/A8aMEz1RZSOirc/KMNTfE/ZV2i59jA9qrMtUFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180993; c=relaxed/simple;
	bh=Sa8bPFHTaj9aW+dktFBUNt2YyId16vwK369IXtQxnwo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bS6BorLq4nsLIfMj6RiX4M5ICRT0N7UWsD1EDsDzPpDVR5KyVqSt60hG66hV23+tKVj/nl7PDcrquQn3zREYLq8kxhDCBT3e1L4wO1/2GtfsMmcc9YpJbJzAENBzAr36W/nLj9UnEzb4BBqLqi728YRS9VxrYOj47jpLaKE6OsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MbSWhlg4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732180991; x=1763716991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sa8bPFHTaj9aW+dktFBUNt2YyId16vwK369IXtQxnwo=;
  b=MbSWhlg4aNh0t2M344224E8NNcF40qJPQwACkKovcznykxiQTH3AECU5
   Ul5nKTGknTyrxGkIGWW5Ct0n9B4X0f5ZL0q66X3Hd5+3KEM05tqTwFkij
   7Kog6NQ9HYx0qkSsGIFtiGjohsTbYk/QDbBGA7gXp2WrXa/4XpoiaqmRX
   oE82ygABv85WKxIwZK71gvHRwg/rFGMRROc7mggZhhNKGd3uo3OS45qUH
   ufJb3Dohz8ZwE1aA1IUBO689opv1czGtchKOPEIzmZvblm2EOhzMYqbDF
   NyZbYZW4OrZM3pkBU6iH5Zi9kLmFsh7MgYs17mSVTPSiBcI2bOfq7bU83
   Q==;
X-CSE-ConnectionGUID: YiAoo1hURNCm0K6Jsadz8A==
X-CSE-MsgGUID: jyCdARExQnCVU/SgCMKtbg==
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="34608880"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2024 02:23:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Nov 2024 02:23:01 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 21 Nov 2024 02:22:56 -0700
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
Subject: [PATCH 1/3] drm: atmel-hlcdc: add support for LVDS encoder type
Date: Thu, 21 Nov 2024 14:53:06 +0530
Message-ID: <20241121092308.130328-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add support for encoder type "DRM_MODE_ENCODER_LVDS" with the following
bus formats:
	- RGB888_1X7X4_SPWG
	- RGB888_1X7X4_JEIDA
	- RGB666_1X7X3_SPWG
	- RGB666_1X18

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
[manikandan.m@microchip.com: move modifications inside the
atmel_xlcdc_connector_output_lvds fn]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0f7ffb3ced20..0e709047369a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -356,6 +356,42 @@ static int atmel_xlcdc_connector_output_dsi(struct drm_encoder *encoder,
 	return supported_fmts;
 }
 
+static int atmel_xlcdc_connector_output_lvds(struct drm_encoder *encoder,
+					     struct drm_display_info *info)
+{
+	int j;
+	unsigned int supported_fmts = 0;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
 	struct drm_connector *connector = state->connector;
@@ -374,6 +410,8 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	 */
 	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
 		return atmel_xlcdc_connector_output_dsi(encoder, info);
+	else if (encoder->encoder_type == DRM_MODE_ENCODER_LVDS)
+		return atmel_xlcdc_connector_output_lvds(encoder, info);
 
 	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
 	case 0:
-- 
2.25.1


