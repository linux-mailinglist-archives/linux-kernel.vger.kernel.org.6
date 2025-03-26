Return-Path: <linux-kernel+bounces-577019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C820A7176B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071923B1C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B01F1927;
	Wed, 26 Mar 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TkMCLwph"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA41EFFBE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995407; cv=none; b=VK/PLJ2grZirtB5o6D7+NABYbKbQufdU3C1DVKR3c6E2NlJqK47Ps3OtN4bft1KDuCjyvLxPhCBop+v7yq6o5dwmNiyIqRNKQGWStexltcj/NOQILy/ycwQSnMB6bQpzfUDxfUOcsuVljrUtcDGy9RrNd/AwHCvei3+oRj4BXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995407; c=relaxed/simple;
	bh=9MHTxZdH7A64p6rkGsMJ1pERN/pChugBsFtXfs/OL8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUHbNsdBWECL5hTuGf0KgCjPo8CnLVRvb0AhFZhdzGHTpV7uORx3hGCMOzjIiJpLNZUdEt5aGYfEUeFuovBw8EmtjotPKmPWe4uyXyQw4W66v1Uih6Kk6BTjPxO5ymp16MOm60yc7mlHDvEpsnQULKhMVXT3xyDJp5o8zF2uebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TkMCLwph; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A6EE10D4;
	Wed, 26 Mar 2025 14:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995293;
	bh=9MHTxZdH7A64p6rkGsMJ1pERN/pChugBsFtXfs/OL8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TkMCLwphYF2TsBTzKA4WS43gF1mPqgX3fD93IFX6AaJzIjJ4a1p9vHqw/Vz3dWRxy
	 JbaP68KLxa3k2Kco9f6jz6LMSbKXBW/txaY1E6x30BWJ6rmD90OJ10/qU15ppYW58P
	 Wshjb0iJvVOpKtfJagcLmPOWpY8l70Avo3+Bs+BA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:47 +0200
Subject: [PATCH v4 04/11] drm/fourcc: Add DRM_FORMAT_Y10_P32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-4-322a300c6d72@ideasonboard.com>
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
In-Reply-To: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9MHTxZdH7A64p6rkGsMJ1pERN/pChugBsFtXfs/OL8w=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//BdemlPRklQ6gnd/Q/5zTB5DnVlRkfQENq1
 3jF2adPkVqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wQAKCRD6PaqMvJYe
 9RHbD/0W5pG4aByofNdoxcApNE/W22S2TcyIDEHx0OB6JuQWt4RV5HfNgv5SsM0DWPgbEQ/qnSv
 rM9746U8NdeADgIIPhfzwgQEbaehU8mnNMBy6SCK0rHmWS9bFy4iBnn0OH02hiuvSJ30ILFuhPZ
 XEJoa+nC2zSLPgMwGhzUCu66dwPIxjbFJ7WwGaBgxn4kca5WRwko4WZMp6CdLDNshx9DLqtfsLY
 cmNok3UO1nxZfcIRPe4LSDcCOO2Bbe0p6xctBgokZQ+PIkKP/1bhTh48AY//hJTwvlCunXQcr7O
 FGdr1SP/HpD2jUApmpfm6Lw6XHcL+7dXlkMWbJuYkGaIazPIibIVjZDnnj4Xj1VpGvunERzj5UG
 QybSUL75aZ70FlwzNQYCfJ5+vPcJLYwRXj3GvHUwiaDordbCuh2bNxJZUiKTm1l51J6qrughUvF
 tthWvRNnOaRrqX2YAefKMFoc0VSUmb3f5aw+02o2lyYUrxe3AGx17YDrepm5Wxo7Mlz/STCL9AG
 v7e+Giwf6Fl3+5uX1BIm97lkqIQYQmIgn5jayO9mPkQcOLvwsPqPSFkedfL5yBaoGbs+xZfIPR5
 AGvt5VoXnUJXdCIJyTLNd70XWuq/QiimG87G90mrr+qFI3xCGgWFozpldGard6xcohxcJ36OdIz
 i2+d1/BDBIPojwQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add Y10_P32, a 10 bit greyscale format, with 3 pixels packed into
32-bit container.

The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
packed, A - 10 (as in 0xA), 4 - 4 bytes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 355aaf7b5e9e..e5f04f7ec164 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -353,6 +353,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XV20,		.depth = 0,  .num_planes = 2,
 		  .char_per_block = { 4, 8, 0 }, .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 },
 		  .hsub = 2, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y10_P32,		.depth = 0,  .num_planes = 1,
+		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 751b8087b35f..f6316adbeb97 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -408,6 +408,7 @@ extern "C" {
 /* Greyscale formats */
 
 #define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
+#define DRM_FORMAT_Y10_P32	fourcc_code('Y', 'P', 'A', '4')  /* [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian */
 
 /*
  * Format Modifiers:

-- 
2.43.0


