Return-Path: <linux-kernel+bounces-511316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18299A32951
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5121F3A7F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A0212B2B;
	Wed, 12 Feb 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pTS+bPzP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797F211712
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372221; cv=none; b=RpT52qfQGfK5TGom9HA0G4lga+c+MZMmfqhEf3/YrXLw7k2q9tcLUPgghyb9559wz2UjdFhS5lor7uWnWNHc/O8e1RiurKQfscjNdoTDA9K8xHDu/sICHb4sYr7kpxfB3l3Izc7zo4u3P3xboAIsdJdOeiKg+Q2hFueehiYp0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372221; c=relaxed/simple;
	bh=bDFZpF846TRaGLUNMCsvrDnuqA1IyYJ0UMcEGvK70NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3lzWpWJbDhD24vYSpma3xyjRYec8e6IwTu1gcotriDgPzNl76yYLJ00vkpknM58JNvkp0OzqNU/hVd++jjsuJosdJ+w0yU+pUhg6p5layEd+9Rj/BI8V5huMopiBnu42djcgSOopXTu5s6Aa3qQxpajQ3rX8hC3xD6e90YZWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pTS+bPzP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6A36195A;
	Wed, 12 Feb 2025 15:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372131;
	bh=bDFZpF846TRaGLUNMCsvrDnuqA1IyYJ0UMcEGvK70NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTS+bPzPvekp3SSMt/3PXnVkG5KPaAA2TBaIdiEBD51qn50oGKrhG3R1lEjlSP3SX
	 UZ7+NXUyaBJlws0L+p6JuL6F6xJL/6f7WNeHOCCkcpVnTDdFB2GD7WwR0Umm3j2xfC
	 l+d6i9weFxweUW5nkcM7cYEh5D68iXkkVS7G1g0A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:08 +0200
Subject: [PATCH v3 04/11] drm/fourcc: Add DRM_FORMAT_Y10_P32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-4-90d0fe106995@ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
In-Reply-To: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bDFZpF846TRaGLUNMCsvrDnuqA1IyYJ0UMcEGvK70NI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLapJR8dbSjlDo39/S7HPLbMH+NK3wKLj0vmc
 0KCVDLaVcGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2qQAKCRD6PaqMvJYe
 9b0ED/97NbOe7n+I9+K/BtfgS30c0wImbKKCFZJDoK3m+ug57HgG0A6cxmlUlR6A+OFJW4vGKQf
 DwSDUzsXxD3U2P3vxfR4xb8eKIBahbKfnv2e+TmD2eFOHrmW2fZis9xLwmS7SzU3xSPy7k5cP9H
 jqYsXl7BdK8zTc1sEKGSrOtBghzihTCcKyf8Cs+9d48oVKTovpNhVoLc+mlmH30TIrAlevw8gAZ
 k1yGJSQH+sLXCIz6vJgmJjO3vatOLTZC8NXxAQO8kDNLI+QksUSwwKvLDbO61SBLRfeIfD1mURH
 2iMHPvnBLZFQku2auop9zbhBABxLZfVGN0lVOfmFZTYwFkE7RDeTtRrsTZjbkI3JtclffKIewvU
 MOTS6TFStjtzkREFJpUlCEPwIj4AXjutKDEeGuAQBfdhzAzoynwp62y9rB9sOxzwYGaijB/RJnm
 DtbKGmQ/sYg5Sx3f8FWvXHui94ulNSFltwUP7BkqSFLlcfyZpAJVBs4sW1cpl63bIYvd0BKQ9QG
 3ccT2xYlowzni5jyva6EmJDdeqgqxh8tZ4fwNM//aDF0FQnYisaEUl5nQhLp4McS2dCDw2xiVZ+
 3dZrlWBazCl2zp+3FcmyjvQ18SdHRKzWr98iVYItp+BoIA1fwuecZXUA7wgRIsZpYGyvXAwJKLu
 R/MdV/wIq6342AA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add Y10_P32, a 10 bit greyscale format, with 3 pixels packed into
32-bit container.

The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
packed, A - 10 (as in 0xA), 4 - 4 bytes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 4 ++++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index c8c6dd8a8d4a..155482d9a409 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -355,6 +355,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 2, .char_per_block = { 4, 8, 0 },
 		  .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
 		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y10_P32,		.depth = 0,
+		  .num_planes = 1, .char_per_block =  { 4, 0, 0 },
+		  .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 2778cea9c861..e87349d46325 100644
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


