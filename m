Return-Path: <linux-kernel+bounces-430865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014B9E36C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D231DB2EFD0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7121AF0DD;
	Wed,  4 Dec 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JspZ0/ak"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120641AF0A4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304703; cv=none; b=oucyry2A7XdTxKkLdfH/cJGVjjKKLccJE3eYMJR4LkZJ7YBNJoEpAROYK5r57g9D4Vp6cFFmQJuQfOVzwNAq0Hw9Tr5/E2jEC6kPRhGQDF50+0nRPDcW3WpqvWgEMR7hOh2nGNyNw3b7+RWhLqQSWy3ZNdI0V2q0+t+hUEBKEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304703; c=relaxed/simple;
	bh=sCHJvD8U07JxBtUqGM5UTqa2HW6hh4J/lkYVcIDy00M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9rZZgv0HhNRzbInprEgUi8pheyWo+bjS4N9/vnW4EzovKgXkbopaV7kzXB2JJqR5/O0Ss84c38mwc33yYLj7Fo3lQViCxTUl3JRZBXqvn67kIN2LPuYWs8MZ/5WabPIjTrL4Q113s/cJWz5NgXEdAftjYKNKneqN4TVOYBJbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JspZ0/ak; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 839C510B6;
	Wed,  4 Dec 2024 10:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304669;
	bh=sCHJvD8U07JxBtUqGM5UTqa2HW6hh4J/lkYVcIDy00M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JspZ0/akMHxSwdhbHvSstkWmh2oHp33qfJL4qjpX+Vc8N5fPGe0NmZoPjZBwbDXAf
	 75q9cZBDEXOClhSc3CVUP92BEqXj7qTY1uxXR63aoXp3124HREp4S3eXMgWayO7zK2
	 KZo3MiRtK+vkmyF8/gLD7p91MQxak6Tp64HT6MVE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:04 +0200
Subject: [PATCH 04/10] drm/fourcc: Add DRM_FORMAT_Y10_LE32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-4-0bf2c5147db1@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=sCHJvD8U07JxBtUqGM5UTqa2HW6hh4J/lkYVcIDy00M=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFyTNQ/7HzSBX/EC8mTWm7YSE/vU4Lw4pSWT
 4Raqs09XIWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcgAKCRD6PaqMvJYe
 9YlvD/9mxwXHhjhOyZPLo0JLVNL09O+45LWilOlM1+aDdyyT6erkNa1MdNa2WqBTQIQKxtpH4eT
 iZ0aWa5Gaq7AQk0dgTTjWiW8UjXtIsZdaTqHBQDaP664PV/po8134LYP/8vHm1zrM7coNSx5Vag
 IQAudHBGh6dDP/wRCw46xFaZcHbuJl/wpPLL/IxDzjk5iuZy4PjlcXPxoyLezp5AmGGdX5ZoXz6
 kfwi8qKWYFxxnvtgu5CJD83+q+tlzdkXdVs4b2ar1k+pylpUn8S187Rdivcc4fYFdFEdJZ+4Kkj
 H0dvQ3JBZGOPacXK9wF1SA+4VZ+w/BrIVTigfQVUD0HQyh8I4gfeW5BengMAERkQTNwFNDhAkHe
 ZFfedIUasMu8bBozv9dCpTritRZvrcY8eIper0tD0QuLErRM1JkEWr2lgC4fa6eokPUFU2M+a/F
 uAQgfQSr3mpweN14W4aQFIgWEYSA9plCP2IzhjmvULQOdDApLngpb91uEcFc2Vx0MpiGQ4ggPiB
 WFYZLMgaBa8O1W3lGAg7WX7rzoWzMCIUj6557NyrCbi6LGTJ2Sb8/xtKwKEZvpEvRYBu0EyLD+O
 C6a+AQ+W7vTe6tGMCZF8mxo+1A4TxE9QSbitxafvhravvdnosC+9wEZcu0tQpD4pGyYPzqqYU4x
 29PongQDkMspvNQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add Y10_LE32, a 10 bit greyscale format, with 3 pixels packed into
32-bit container.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 4 ++++
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index d721d9fdbe98..6048e0a191dc 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -327,6 +327,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		  .num_planes = 2, .char_per_block = { 4, 8, 0 },
 		  .block_w = { 3, 3, 0 }, .block_h = { 1, 1, 0 }, .hsub = 2,
 		  .vsub = 1, .is_yuv = true },
+		{ .format = DRM_FORMAT_Y10_LE32,        .depth = 0,
+		  .num_planes = 1, .char_per_block =  { 4, 0, 0 },
+		  .block_w = { 3, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 1,
+		  .vsub = 1, .is_yuv = true },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f79ee3b93f09..82f255eb3d1b 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -408,6 +408,7 @@ extern "C" {
 /* Greyscale formats */
 
 #define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
+#define DRM_FORMAT_Y10_LE32	fourcc_code('Y', '1', '0', 'P')  /* [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian */
 
 /*
  * Format Modifiers:

-- 
2.43.0


