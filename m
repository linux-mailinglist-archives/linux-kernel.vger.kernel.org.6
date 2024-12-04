Return-Path: <linux-kernel+bounces-430866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC949E36B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68E91692B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD701B0F16;
	Wed,  4 Dec 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YAimj7nz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2D1AF0BA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304704; cv=none; b=tgkHF4IhOGaYxvlvDJ8CiNx2v+25e1FJCgq1wonuF2etnfiNMVaXh/q/mUkKbJ6dqkZGlHQw9W6xlTVLOS0V/3GJ3BhePbUG6aeEVXA3HLA05gLukGyBW5EJ6FOLDksnrC7494t2TUKxy4komJ6nVur4POGB0+fdVNfJqr8Qoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304704; c=relaxed/simple;
	bh=tvMPrDZtee9n82xo6aNU/4PQa7v5HzHr3u2kPTARj3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Si44LSZF3Qb/RfEoS+yD7MKSk0AOUISwmBfS8DUA4s6MzGTy42bvyPel+2ncQ1BVNIjIOtb3oyFxkbw5ZDm0vETZ35yyRZPbDawFoZ9N6a93zJDKApNCHbCg/BuFEHbNTJIyaNdiNAX5W2QeHpytSyLzBVwec03PYxrdZY2Kalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YAimj7nz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 592F0157E;
	Wed,  4 Dec 2024 10:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304670;
	bh=tvMPrDZtee9n82xo6aNU/4PQa7v5HzHr3u2kPTARj3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YAimj7nzYQULQeidimnqh3H3OPPk/X99/EMoCvnDiFLidzDItFEYHZbVbX0VArFps
	 7uDFveL75r5hx2mN2ZOC97wliYMGHVzJ/wcXexxGbOGK/YYGoMpAJ8bdy/VzCPISto
	 YhbxPp3AxhXPgYCifSZt3FBPagnoPcwO2JcgW27k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:05 +0200
Subject: [PATCH 05/10] drm/fourcc: Add DRM_FORMAT_X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-5-0bf2c5147db1@ideasonboard.com>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
In-Reply-To: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=tvMPrDZtee9n82xo6aNU/4PQa7v5HzHr3u2kPTARj3M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFygysXkOjEMoy40hXOyiyvyWv/rkOZmGJNZ
 oS6zZYKsiWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcgAKCRD6PaqMvJYe
 9VIsD/oDLZF8H/FHcv6f7SUf7QmryZogfPRwUG0h3yAwM9HymRrbzwpDheUYCDmQkOzBb4oYwJs
 2q1htt2fXMOufdXbAGCJA3+rBT/6Pf2+4xPWNFVAyxWT3Qox8wk2/c1zfBHZxsioLumpDTzkwBu
 PGCAckYPjkyFCwXprXI4wj0B7NLdBULLhMz1Cj4JADP/+eaDnBw//4J+9zxC+yQE2/YdUw6Pga1
 vu1MPBu8r/Q/IBUt3aRA1GvBj6G8vKdf5p+V0CA3P5GjzvIDDIDm2if3aL6647BAu8KOoyu7MX5
 Qlamz+P/RYbp6dgeehWMx9uG3ZEEWbpmdtWmvIN8jFiM15idLIEWGabXmE7Pf/79p4ReLQTPkcL
 N0sjALOu1mbgRE6zzcqGyjrSXYAot7Ly2ZJDbG43iKCVU1TF+wP/qgrheLxpFqbk63yfQE/zYzt
 JLosv0gW5Iu1RUvPMxgPhdTZNLKLr93//BuS2tEa0KAL0tITqOUR4r4GYU1oiLXWoHtCmthfLd+
 /agfnhD/NKGO4uG6mV4NZct/35xzPKRD0FSWJTqIdQHFE79A+0dCVJNLlRjMME+Js5PRxLret0P
 0C2RdfCXaLEbw0K58Cu7W+fTFf0tcFrPEhIEc+gr432jLgF9yA8wZXJsxfzOPhlciq/6nkbe4Sn
 /tZS6FaumK2qzgw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add X403, a 3 plane non-subsampled YCbCr format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 4 ++++
 include/uapi/drm/drm_fourcc.h | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 6048e0a191dc..219113b5924c 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -331,6 +331,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 1, .char_per_block =  { 4, 0, 0 },
 		  .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 1,
 		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_X403,		.depth = 0,
+		  .num_planes = 3, .char_per_block =  { 4, 4, 4 },
+		  .block_w = { 3, 3, 3 }, .block_h = { 1, 1, 1 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 82f255eb3d1b..097904407617 100644
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


