Return-Path: <linux-kernel+bounces-511318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C0A32954
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C554165DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F921506C;
	Wed, 12 Feb 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QKIE8Tgn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82198213247
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372225; cv=none; b=WSxe++9aeUN5AVRVyim7goidZ+el+w66c6wZ9n9jAkWrAyJNYAKF9T+AJQWs675cZ+X/cCLwoF9TgAK2JFYbrhH+qJTuBLqHCpgT9xAlitZcrqzhxad8tY5p/SK7TM09AgmXK8hgt9X3w/qjClB+CQlbIYSFq9+n5FIk280puBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372225; c=relaxed/simple;
	bh=aX44L/jouR9RyXmHvOIZYecSQbXOPHxOEd4+f9va8fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSB0rhQ6UiXSwwtmb+lnIaXRPqwsrA5jScNqxfSynnSqKj2LibmlLR870YGV1RJqQ2ux+N0VwPJ9X7Ja2ROpTzbnuqX2otAzPDcTdk0cF1EdZnnLiVbX8QsFPb1PrU1de2XH8D5RbVdAr/sC9XZIwU5EggxIImJoLnRjua+jTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QKIE8Tgn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE3661972;
	Wed, 12 Feb 2025 15:55:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372133;
	bh=aX44L/jouR9RyXmHvOIZYecSQbXOPHxOEd4+f9va8fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QKIE8TgncOCkNB1WmkRpENGi3DR4Gch01ajCPMYBAY9HOcy7mNGjDdqDkdbtKKPmv
	 IUlrqkroY7aaYYJPe7bAkKZSb6C3OEzLVsxJxfJ7/OUDH70Yz8hkFL+z15WplFqrKa
	 FMVtY1TxQRcKosNkOMaD+OXCUneUH1ytvRqHxAyE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:10 +0200
Subject: [PATCH v3 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=aX44L/jouR9RyXmHvOIZYecSQbXOPHxOEd4+f9va8fA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLaqCm1pnFAHRVyYizEhLKyTvAxHD/yl5ArKd
 /+R3NVmdROJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2qgAKCRD6PaqMvJYe
 9ceOD/9NzT4a1NCmFV6kCaWaPvNqsstvCzfbSAL5oOLt3kgPKymShbFd2E7ZdaZnGR/o8sbfIs2
 HMwv//u/7tMbc78B6qy+dpKu4nSAUHrgA9x3mS/D5GtSQEXhB5Obuo1xmqd7XuanTOb14lABXlH
 fUYkHcDiiUy/cKMJImUMwA7x+2Ay2rbueXgwHw08gx0hMzSBv5nxghanyCrnUOi/D9fYmpgBJUW
 AMD17PmhPrCb3D9vsPmrKVnxqAzfAHGdAmIJSvVyx2P4a54l7ipz+5pIHzsXTmvMpHy1dZ2MGI7
 IPPSDQd8rqahVMbLmShGWT18KbE41e4774/UY0hx2EW4NfLIFKeuSpTC4AsHOIyQDOws/elVgV9
 +gVH5udA94bMmxB3EA1nQhn50+wPHELTYKG8wWPsvHqOq95vVrPUyTvmyWBwt1hxGhJKcP/Im6T
 1gkkEeaG7bboq1cGY0jIUuSU/Rfp+YXP5fqymA+scLKVctQI/+7k7wWgRVVJ65kQc8Y8y77E2zT
 CpSW3jA6lOV+etEQEnQdjIDgbyvjXZJ2RkvKHpO+4t6/9gBdKCFEzyvtxHA7xakwg59dMB2zAiD
 MnVM4EU80d91rsoEeVsGMiuXWh/e5DpGYNZXM7yuhMB/FudZJZxvgEta+5EBoGnAk6XN2Kq0gMA
 FFabyDO6cD9fPsw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
container.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index cc7e1ef4ef21..07b03b0fe9ad 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -280,6 +280,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_VYUY,		.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_XYUV8888,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_VUY888,          .depth = 0,  .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_XVUY2101010,     .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_AYUV,		.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true, .is_yuv = true },
 		{ .format = DRM_FORMAT_Y210,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
 		{ .format = DRM_FORMAT_Y212,            .depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 2, .vsub = 1, .is_yuv = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f936cac2aebc..7e8aa3bd52b9 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -246,6 +246,7 @@ extern "C" {
 #define DRM_FORMAT_XVUY8888	fourcc_code('X', 'V', 'U', 'Y') /* [31:0] X:Cr:Cb:Y 8:8:8:8 little endian */
 #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
 #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
+#define DRM_FORMAT_XVUY2101010	fourcc_code('X', 'Y', '3', '0') /* [31:0] x:Cr:Cb:Y 2:10:10:10 little endian */
 
 /*
  * packed Y2xx indicate for each component, xx valid data occupy msb

-- 
2.43.0


