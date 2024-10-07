Return-Path: <linux-kernel+bounces-353787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EED9932BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656CE1F23BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083311DACA1;
	Mon,  7 Oct 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NiM1IqI7"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AF1DA62C;
	Mon,  7 Oct 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317452; cv=none; b=Zbxhw8dnXn0+63K3083tA9U/H4Usk8a6HT6lAJA0iHdaLqQ6jEnAOqv9udXMM1veaX9Etb14L2ZI3RCz9dWcTMkmwglN9GOtzrspN0uK+tcKt9CFfup6FEAE94VLyZqWZAAWGCNaxVqyIOCv3eo+jVqBCe8Czam6yMAtkLlfYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317452; c=relaxed/simple;
	bh=+UNcxZgMXrYbfQ0Wk9GKtPGOAGGqTYaVl8i/PMhH4u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSuyrSDsRS4MrKomYQkoJ9faijm5cjGKu17GEJojHFr3EgNia0UHiGeiQwy8kOknnZkaaWr07WKPXb0Hobg2PJPJA4ZW6J9MjNpX9CiZuO0m+IW+UHy9RMNwVD5d9lc/s3wOoTcNzwYbed9sIDO8/DrEKJLV+2+sd1zkYGFpADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NiM1IqI7; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D460E40005;
	Mon,  7 Oct 2024 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPw90jBWzUneCJNYVnnpD4jiAcd/VX1BxcTgAriuwkw=;
	b=NiM1IqI7RxHbqJFt5JCm4eivhb0fzFMbT9QAM39HLkaocfp0A0vlbPUfBkVVkVwf3GptRF
	2BM6noBNoeoeFURCFxLc4URtnWD/ckfp5mFTau28TM+yD+O0FqIoO+3hZW9gIs81Uf/X8z
	6Kv9CXOAVR9p9Tb50DVRQRKzweoHb/ksJR9NmSTt6XHd2w7EeB7PDlcYCgzmfQ2z2L22w7
	Md4lX+ggB8bg34y8TEndiszHanFsRwRCwQTQk8JmFmVmnh44rpeAOyhR48qBINBDSj6K3s
	p6H/RpFpyDNF3ngcVTjXtTIGOl4OAzJDjcY1MO1xIcx2HHqfLdjcm2CjquqAKw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:35 +0200
Subject: [PATCH v12 01/15] drm/vkms: Code formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-yuv-v12-1-01c1ada6fec8@bootlin.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
In-Reply-To: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+UNcxZgMXrYbfQ0Wk9GKtPGOAGGqTYaVl8i/PMhH4u4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAf/1uLz3+1BMZhhmt7HVAzlXd69eo4qn6hdh
 ZxqO/sdWPuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQH/wAKCRAgrS7GWxAs
 4rKpEACb6enr6SdiL97NNuPWB7Pum3NDTMTOFPLIxYmmZCsnhYpaKzDjU2fgalitB6k0aJSARnw
 +iLg+eJJ9Kf7SJrj/4BlcVxtvMHa+Vz3anCcFLtysklDME6o2KOYhlS9Q8rA9cqtfZOIheI16u2
 FraxfcObxbKkTUF4L7/H5r0hVUn9Bef8NiDchXMUrtaTaSN8tslDM7nOB6f2qDCsRb94K+E95n3
 LshWTN4uXx0OZmgwUlbFBYBjxuFEyA4fTe0++RVwgIGN5NYPeL8YXjQgvysyhDPFQNd4MbIBHKU
 WuzTYy/UNphj5q8Qu/NFjNZaP+etGb34UAWLMKw4/W7cgXJZ5yazdHJCdBH9MQowfsNTEJhA9ic
 v9l4gKThhFanDArG/tr3gn7WALtQrB283uLFSVA2ImlXVu/0tI4H5MgJ6hrWVDdbRx11rjbjFlt
 19c0jCXWTY/Ogsp4B+AW0QCMbt2SmOADI3VMxp5OYT45wL/3k/gzVMe7RGtj8tSvDzQJv2QswVT
 lTHZyslnP6OeudTo3WC3kwjpMJub9OZ6WC/wGWZuj0JYito0e9Rn6GWTijjjwBZEOdUDHG98jvC
 0ME5hMmbAnu/zAxXB2TsVVKm10ADHkW6ZJKjtuNdWtaQqpSZsPMixkLaTLDisFOCqQoME4A/TH2
 Ri6YxbWoqalosjg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Few no-op changes to remove double spaces and fix wrong alignments.

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 10 +++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c     |  6 ++----
 drivers/gpu/drm/vkms/vkms_drv.c      |  3 +--
 drivers/gpu/drm/vkms/vkms_plane.c    |  8 ++++----
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 57a5769fc994..931e214b225c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -96,7 +96,7 @@ static u16 lerp_u16(u16 a, u16 b, s64 t)
 	s64 a_fp = drm_int2fixp(a);
 	s64 b_fp = drm_int2fixp(b);
 
-	s64 delta = drm_fixp_mul(b_fp - a_fp,  t);
+	s64 delta = drm_fixp_mul(b_fp - a_fp, t);
 
 	return drm_fixp2int(a_fp + delta);
 }
@@ -309,8 +309,8 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 void vkms_composer_worker(struct work_struct *work)
 {
 	struct vkms_crtc_state *crtc_state = container_of(work,
-						struct vkms_crtc_state,
-						composer_work);
+							  struct vkms_crtc_state,
+							  composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
@@ -335,7 +335,7 @@ void vkms_composer_worker(struct work_struct *work)
 		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
 			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
-		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length  - 1);
+		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
 		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
 									       u16_max_fp);
 
@@ -374,7 +374,7 @@ void vkms_composer_worker(struct work_struct *work)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
 
-static const char * const pipe_crc_sources[] = {"auto"};
+static const char *const pipe_crc_sources[] = { "auto" };
 
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
 					size_t *count)
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index a40295c18b48..39bf9d4247fa 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -188,8 +188,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return ret;
 
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
-		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
-								  plane);
+		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
 		WARN_ON(!plane_state);
 
 		if (!plane_state->visible)
@@ -205,8 +204,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 
 	i = 0;
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
-		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state,
-								  plane);
+		plane_state = drm_atomic_get_existing_plane_state(crtc_state->state, plane);
 
 		if (!plane_state->visible)
 			continue;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 2d1e95cb66e5..19b7322ce49d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -82,8 +82,7 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_wait_for_flip_done(dev, old_state);
 
 	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i) {
-		struct vkms_crtc_state *vkms_state =
-			to_vkms_crtc_state(old_crtc_state);
+		struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(old_crtc_state);
 
 		flush_work(&vkms_state->composer_work);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e5c625ab8e3e..5a8d295e65f2 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -117,10 +117,10 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
 	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-						     DRM_MODE_ROTATE_90 |
-						     DRM_MODE_ROTATE_270 |
-						     DRM_MODE_REFLECT_X |
-						     DRM_MODE_REFLECT_Y);
+									  DRM_MODE_ROTATE_90 |
+									  DRM_MODE_ROTATE_270 |
+									  DRM_MODE_REFLECT_X |
+									  DRM_MODE_REFLECT_Y);
 
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);

-- 
2.46.2


