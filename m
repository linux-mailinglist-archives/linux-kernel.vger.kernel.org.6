Return-Path: <linux-kernel+bounces-577018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40546A71769
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A003B08B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50B1EFF91;
	Wed, 26 Mar 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bzAAnpmF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE71EB5C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995405; cv=none; b=CVoITMPgxwKOwvbjh8J1CjZs5UN8srCkeKQkPhmS60g+aQC3UsK/igdz6fopWowvQynzLXFYzU5A3ECPo2lCzAUyIUUhlXpN1bDkqhTQP2g8DZj+QjTQP915XMe3inSnKpGWc9trm+4R4GiJQcqAcXRxs8dq1kS1HBqZkwmAouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995405; c=relaxed/simple;
	bh=PtShATPcCu0HjOE3jQ5aeC8LyNewsgbKYVLFevEUXT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGHu7f0SYFfqMLfPULMCQZnAdOsizGNZDW5qLOz1hXVgGXUUJUeSmkdOUFhFLpKxy2uwvpDK7d2TVJymKxUyJnD6bQjIIBe7LV7aeLIYyXP9AjWiPQ5EnLQ8aj/J2A33o8scy2iXlZ2+76Pwxky7tmzxHRN4NP/EqbaeZsxluMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bzAAnpmF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FEB01054;
	Wed, 26 Mar 2025 14:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995292;
	bh=PtShATPcCu0HjOE3jQ5aeC8LyNewsgbKYVLFevEUXT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bzAAnpmFwKzwlIOcrh3kmM7/GpyTMV9Lkwh9nwMk6sQx98fkSku4khyowhPRiwWZG
	 MurfrHtB+XOlj+QBE7axKtWe+uVOJdxxYzEmHLH9y3IbFk6RcBZd06h3k3FaqhsA9Q
	 7GOZFTnLzkcjz8GR2SmkGtzm9g25Ctt9JjlxQwFw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:46 +0200
Subject: [PATCH v4 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-3-322a300c6d72@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PtShATPcCu0HjOE3jQ5aeC8LyNewsgbKYVLFevEUXT0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//Ava8OwHFVld64m7jx6U9gxzgqkK/V5FaDT
 BR7EqsDsnyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wAAKCRD6PaqMvJYe
 9cr0EACMRJguvN6Fjc6Syac+iVs6MM73egJDFs1wdRMGX8RoKhaIe5dwVQKRdo1SOwHDowRRH2y
 tkkLZxYyF1NNrjton8vBFC3UV+fwYYa7ZvvCdxNjpXeAFD+qwWuw1BJILscXpe9mfIWCLMbUV19
 gH2WnUlRV1nUzTc9TZWchKBnT9hVDfg8VgGj4VZ+Oj1/tt57jfw3Zud+CaAv+IsYICLoP0jeKF2
 zzaalq1eEUG5/awR7nW0hrdyJ1buR0XHHePbamPuRH9mIvLYXXJh3jCjIYlZ90AfOlpw5AmgCZe
 FZkdHpH3RFWOxH4fXErJdOwHkiFP9Sio641Mzuv1Y+Nygs9gcoUPLPZTUL3rOnlO/okatLK8AkR
 Pp/jKKhw0gbncvZlWZpGdhRgORUgGl91sdSdsxvdSUqL1lKtF1zpHIklBLG4jPK4bY2B/5YQLAZ
 U3RQfRugZPXRoKaYPK6o2pbhr7Z9GrlikxRBIzTK+aq3sglhNz4I6TCeewxvzd1sQt5uWL+VWTs
 4R9lke+eORcGYvF1TsQqtQl7TZ9srUPEJLw3rsYsAV59j5Tp6W1zi4X+v9xbo36kAm8iACvcMnJ
 sbo4ExwaZC3ZQykcA9hNlnI97MRzMo+nv0d/ttWng+jWSVUgZYZS5nwKDFwzXYdSHEJl8UP+q1z
 0ve2qpgngqqZfHw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add greyscale Y8 format.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e101d1b99aeb..355aaf7b5e9e 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -267,6 +267,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_YVU422,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YUV444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_YVU444,		.depth = 0,  .num_planes = 3, .cpp = { 1, 1, 1 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV12,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV21,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2, .is_yuv = true },
 		{ .format = DRM_FORMAT_NV16,		.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 1247b814bd66..751b8087b35f 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -405,6 +405,9 @@ extern "C" {
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
+/* Greyscale formats */
+
+#define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
 
 /*
  * Format Modifiers:

-- 
2.43.0


