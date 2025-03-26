Return-Path: <linux-kernel+bounces-577020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C133A7176D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14652188A85D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899F1E7C24;
	Wed, 26 Mar 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eSYLKTt8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077B1F0E5C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995408; cv=none; b=DV8iF5wh5uBXD4EDcTUT6DDNb4jb5V36xbufFSOIKlX03avij/YhxFWfdxff5LMIf2AFbjClFZ62KWSnLC6EzAjpC4DdMSJOb34SnC18DPrXWDuI+uEkK14aQ+gGGvcJdfckCJ3t5KgigRDem/N7vRe1XOPQIWbvwlPB29F7DqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995408; c=relaxed/simple;
	bh=RuiwkWYkXDPZIyqS2srDTuseW4wRtdGOjSjDtskjiwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jx2tAYmOuyqI+nlb5nXA1ky+xJ4VDyliE21xCBhLq1JiTVCDegD09AHeBbLy0DC6wDiBvxRUv6dGKXLAHQ5aW8KtVRupvf8Hhkw4y1kuJivewtUd+jy2vQ1SAUbKsc/vmsxf2lBvIm25DSx09gzi7X+lAzor1qLncKhggMXIy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eSYLKTt8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D28D11D9;
	Wed, 26 Mar 2025 14:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995294;
	bh=RuiwkWYkXDPZIyqS2srDTuseW4wRtdGOjSjDtskjiwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSYLKTt8O32894iqX/Hoqr49QlQLFyG0/wiGIdhT+9tiE+X9/X+LV9JRyMzzUx187
	 snu2MfZWclN7MxmzCAjzGYwKLH0W4biifXKjjERNRWjfixwC8tyfwh/mpq5A9HJtcu
	 KiaJbbhcZHk6rGZSuPbzIija54HQ91ivP6hnUg60=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:48 +0200
Subject: [PATCH v4 05/11] drm/fourcc: Add DRM_FORMAT_X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-5-322a300c6d72@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=RuiwkWYkXDPZIyqS2srDTuseW4wRtdGOjSjDtskjiwI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//Bs2/DMsm0t+zsYTdQ7Dcu7n+xbEHvoo0jv
 I7PQSKvvUWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wQAKCRD6PaqMvJYe
 9VTOD/9jFgKgiTf0yGGG6QkDGvB2kB3FBx1D4T8EqaQKRDlJBrDiFvZiUnwrbwlrL66fMlHPBBw
 /Kkc3ysttJiQzXAS3L4QVnLV6k9X0atU/7ibDNZo55HERe3pNOOXCkRa+ZwVKSt9viL7oS1AVNM
 NpE15l3DGxqSp6Vxrj/T9EQdwsXFyQ1tS9NGYH9lf9Zbk6iPJ3DzlsVbf0tQSPyIIGkfeZFO9xj
 kUXudD+uNvYJn4XXl+hW4aXeUGVGxDfqJny8FblYXbhMl5WPLkdPk1r4PWIrwf/+3yaW4uyPJZO
 L1zzbeGTvrDam9gYqQhaZ2bO4LbIdYWp3+HIOVAJjqSkNlqm7SwYhToJUp8uqxa51VytWVbQvsP
 EEFJ2k6QqpeTGlFuaUKgF3gbedkXfTHGjvzTAg/3bke3BxWyEh3n2tUTyG/heshlbAQDafR6uJ8
 fIB7zUmpsjWm7gXWCm0ID+vfwyf/agz+6agZ2bSJZ2DO/H5rT9Szru3Kp57fH8hb9VBZbYsH88P
 Ykpow683tzybEeGhT30YmF+bNktP6IoPwWLMuXmgjRx8YWpHHJxqFavyIjmBvLhoT+BiRLWiZA8
 g1j25Dfk9PKQhNU6h4oe6vUDi+9GS+VA+n85Q96j7n4KOVYwcDWkRCGOH+fXd4ciBjdWpMKPzVn
 vFeC4HrV0kFgGyw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add X403, a 3 plane non-subsampled YCbCr format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 3 +++
 include/uapi/drm/drm_fourcc.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index e5f04f7ec164..60684f99f4a7 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -356,6 +356,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_Y10_P32,		.depth = 0,  .num_planes = 1,
 		  .char_per_block = { 4, 0, 0 }, .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 },
 		  .hsub = 1, .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_X403,		.depth = 0,  .num_planes = 3,
+		  .char_per_block = { 4, 4, 4 }, .block_w = { 3, 3, 3 }, .block_h = { 1, 1, 1 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f6316adbeb97..10d77f6f6e95 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -385,6 +385,14 @@ extern "C" {
  */
 #define DRM_FORMAT_Q401		fourcc_code('Q', '4', '0', '1')
 
+/* 3 plane non-subsampled (444) YCbCr
+ * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
+ * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
+ * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
+ * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
+ */
+#define DRM_FORMAT_X403		fourcc_code('X', '4', '0', '3')
+
 /*
  * 3 plane YCbCr
  * index 0: Y plane, [7:0] Y

-- 
2.43.0


