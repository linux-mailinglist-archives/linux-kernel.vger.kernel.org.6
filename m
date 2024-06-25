Return-Path: <linux-kernel+bounces-228599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CF91620F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2A9B20A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA64149C42;
	Tue, 25 Jun 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mcCkyQSU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8F24B34;
	Tue, 25 Jun 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306624; cv=none; b=qBvheQvqkDdze9/mSGVjjKDYGGi5580lnUFLiyH8FOMr+CR8YBYA7keCscqwHXXUb/25acWoI8FZfIzjsviu0niUhLo/3Sz8/803jW+tGmpV43Ng74RBU6Jw+RVminc9Hj3+QReqxd5PMOSv/Rh8/g47wRERJAMcfQ516htghrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306624; c=relaxed/simple;
	bh=7d67MtNzgki1K1l7k4JkBWIBosjUeC2yFKZQLmUzIg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8PDdCzmjkIFyuw1nnaKCuEa2LyZ5OKGMZ+8YljWrnTm4+kvQC5U8+FCLxUQfKOneKsSUPCef6u4ZhR5SjYqRryexm+Xn4LelXXDZcdO3vn8JU5OACrbYIwPtmeLBXK5XaoH1kNyFPqW45QcHJWcB3W1Jwud1k8NADeuqC7Eh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mcCkyQSU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719306623; x=1750842623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7d67MtNzgki1K1l7k4JkBWIBosjUeC2yFKZQLmUzIg8=;
  b=mcCkyQSUUtEUoSEjiee0vfXC0v0g9GFqT2kjpKURCB1bdZwMZg4J0ow5
   j3suv0jqOlhbDRKWxRVLuFs1X+R5Q8CwAk82msv7/aHV5xIh47sIvL+4y
   uWsPkgXZSB5zIkbxzFiWMsMErJvPLHeQA1bS6moLExw8839BsBqUIYx2M
   zMkYUSH5mjwGu/UhFCWptW2USqX67dm4GL0vhowFTVLDRMpUKfOMLLym8
   8OYik2yiNIGKnO3GwBgpbPnX+uBKkqT1t0UvoqDVFjT/sB0tt/M5uRQTa
   h/ArdsW6Fp8LAMhSj/q1lsDDOzqZoNaZdg/KtYiauuLmah+mAK7kh1sgm
   Q==;
X-CSE-ConnectionGUID: 0ilkPG6JRCK6A+/+T6Es+w==
X-CSE-MsgGUID: 4Nt9WlNlTpiT/o/EZ49O9w==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="195857230"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 02:10:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 02:09:31 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 02:09:25 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 4/4] drm/panel: himax-hx8394: Add Support for Microchip AC40T08A MIPI Display Panel
Date: Tue, 25 Jun 2024 14:38:53 +0530
Message-ID: <20240625090853.343176-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625090853.343176-1-manikandan.m@microchip.com>
References: <20240625090853.343176-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for the Microchip AC40T08A MIPI Display panel. This panel uses
a Himax HX8394 display controller and requires a vendor provided init
sequence. The display resolution is 720x1280@60Hz with width and height
of 76mm and 132mm respectively.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 151 +++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 3be461fc5615..92b03a2f65a3 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -339,6 +339,156 @@ static const struct hx8394_panel_desc powkiddy_x55_desc = {
 	.init_sequence = powkiddy_x55_init_sequence,
 };
 
+static int mchp_ac40t08a_init_sequence(struct hx8394 *ctx)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+
+	/* DCS commands do not seem to be sent correclty without this delay */
+	msleep(20);
+
+	/* 5.19.8 SETEXTC: Set extension command (B9h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETEXTC,
+			       0xff, 0x83, 0x94);
+
+	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETMIPI,
+			       0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
+			       0x48, 0x12, 0x72, 0x09, 0x32, 0x54,
+			       0x71, 0x71, 0x57, 0x47);
+
+	/* 5.19.3 SETDISP: Set display related register (B2h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETDISP,
+			       0x00, 0x80, 0x64, 0x0c, 0x0d, 0x2f);
+
+	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCYC,
+			       0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
+			       0x01, 0x0c, 0x86, 0x75, 0x00, 0x3f,
+			       0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
+			       0x01, 0x0c, 0x86);
+
+	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETVCOM,
+			       0x6e, 0x6e);
+
+	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP0,
+			       0x00, 0x00, 0x07, 0x07, 0x40, 0x07,
+			       0x0c, 0x00, 0x08, 0x10, 0x08, 0x00,
+			       0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a,
+			       0x02, 0x15, 0x06, 0x05, 0x06, 0x47,
+			       0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
+			       0x07, 0x0c, 0x40);
+
+	/* 5.19.20 Set GIP Option1 (D5h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP1,
+			       0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01,
+			       0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			       0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25,
+			       0x18, 0x18, 0x26, 0x27, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x20, 0x21, 0x18, 0x18,
+			       0x18, 0x18);
+
+	/* 5.19.21 Set GIP Option2 (D6h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP2,
+			       0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06,
+			       0x05, 0x04, 0x03, 0x02, 0x01, 0x00,
+			       0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20,
+			       0x18, 0x18, 0x27, 0x26, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x25, 0x24, 0x18, 0x18,
+			       0x18, 0x18);
+
+	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGAMMA,
+			       0x00, 0x0a, 0x15, 0x1b, 0x1e, 0x21,
+			       0x24, 0x22, 0x47, 0x56, 0x65, 0x66,
+			       0x6e, 0x82, 0x88, 0x8b, 0x9a, 0x9d,
+			       0x98, 0xa8, 0xb9, 0x5d, 0x5c, 0x61,
+			       0x66, 0x6a, 0x6f, 0x7f, 0x7f, 0x00,
+			       0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24,
+			       0x22, 0x47, 0x56, 0x65, 0x65, 0x6e,
+			       0x81, 0x87, 0x8b, 0x98, 0x9d, 0x99,
+			       0xa8, 0xba, 0x5d, 0x5d, 0x62, 0x67,
+			       0x6b, 0x72, 0x7f, 0x7f);
+
+	/* Unknown command, not listed in the HX8394-F datasheet (C0H) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN1,
+			       0x1f, 0x73);
+
+	/* Set CABC control (C9h)*/
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCABC,
+			       0x76, 0x00, 0x30);
+
+	/* 5.19.17 SETPANEL (CCh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPANEL,
+			       0x0b);
+
+	/* Unknown command, not listed in the HX8394-F datasheet (D4h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN3,
+			       0x02);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
+			       0x02);
+
+	/* 5.19.11 Set register bank (D8h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN4,
+			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
+			       0x00);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
+			       0x01);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
+			       0x00);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
+			       0x00);
+
+	/* Unknown command, not listed in the HX8394-F datasheet (C6h) */
+	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN2,
+			       0xed);
+
+	return 0;
+}
+
+static const struct drm_display_mode mchp_ac40t08a_mode = {
+	.hdisplay    = 720,
+	.hsync_start = 720 + 12,
+	.hsync_end   = 720 + 12 + 24,
+	.htotal	     = 720 + 12 + 12 + 24,
+	.vdisplay    = 1280,
+	.vsync_start = 1280 + 13,
+	.vsync_end   = 1280 + 14,
+	.vtotal	     = 1280 + 14 + 13,
+	.clock	     = 60226,
+	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.width_mm    = 76,
+	.height_mm   = 132,
+};
+
+static const struct hx8394_panel_desc mchp_ac40t08a_desc = {
+	.mode = &mchp_ac40t08a_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = mchp_ac40t08a_init_sequence,
+};
+
 static int hx8394_enable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
@@ -555,6 +705,7 @@ static void hx8394_remove(struct mipi_dsi_device *dsi)
 static const struct of_device_id hx8394_of_match[] = {
 	{ .compatible = "hannstar,hsd060bhw4", .data = &hsd060bhw4_desc },
 	{ .compatible = "powkiddy,x55-panel", .data = &powkiddy_x55_desc },
+	{ .compatible = "microchip,ac40t08a-mipi-panel", .data = &mchp_ac40t08a_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, hx8394_of_match);
-- 
2.25.1


