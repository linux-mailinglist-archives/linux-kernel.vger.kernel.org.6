Return-Path: <linux-kernel+bounces-391040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75C9B81B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCFF1F21CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B71C461C;
	Thu, 31 Oct 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JXbQ7+fH"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8B1BFDEC;
	Thu, 31 Oct 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397225; cv=none; b=OWyBwomAdkekVZdQt5pvHMh+BguRNt7hj94qbRB7W9YaiI0P8cnuvKS8H13K5eneYBrVVgZ5RXQawr78cbMjkF1rD4pK/DSgIhOg903QeK6Ogs/KiJ1csi7yHJCQSd077WsAn4PDg4dq3/SwwuWRPZiLxA+hbilokNFlt/4f+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397225; c=relaxed/simple;
	bh=+UNcxZgMXrYbfQ0Wk9GKtPGOAGGqTYaVl8i/PMhH4u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyTm8z6wBHXnkdR533+5RcT3tLAD71R1aQhGToFGO0hi1whrgrEfqJgUFgD9SuaF1rCeiJeqmEnPccEq01hAKWB2GQppb6crdieZs5fp0b1UPYxoMCteexeHSTwK6UebHUB2GmhZKgK/AGlzWzqyIk0AKz9UnvDgkkMLjITrF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JXbQ7+fH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C4C1E0004;
	Thu, 31 Oct 2024 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPw90jBWzUneCJNYVnnpD4jiAcd/VX1BxcTgAriuwkw=;
	b=JXbQ7+fHk3DMA3kBGlKtvnotuatUHPN2AB+xkDUmpHpvpZtgoT9pJHNANItIYwyB22liAo
	UqbbPISD4mZaol59zPxIYZSV2iOIxkoVxo77Uf0e7p63NomDs5yO5azhqpnFFk8WRtGtNG
	e+ixKblgW7vEpVlbX0FEjtUl0mmsnIvltOznaQYm6rrGcHl/86WfH3cloS6BH/Wz7naRvA
	AiM9PbbAAXOxYmsgJ+CR/okrXtwRu69La+6D65fI71l/AtWaQziHNr9v5OgWDxf7JxWDu5
	C7KGRx9sv08wwo1gQjdJ81zyKw3ZdkcWWZX+0MZq6Pnkhzn5RBZN2USYV0PqpQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 18:53:25 +0100
Subject: [PATCH v13 1/9] drm/vkms: Code formatting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-yuv-v13-1-bd5463126faa@bootlin.com>
References: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-bd5463126faa@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 Helen Koike <helen.koike@collabora.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8QbO6//f1X5+HAiouby0mxlRwWNBb9rgZlRs
 rNAosVqUTGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPEGwAKCRAgrS7GWxAs
 4h+cEAC+FMQ2S5fLDcIIhh5hSPwuVpYSOt3Gi3m4YqFr1g0kKumHCYwN0WJCcCigI3d6lBDNn37
 LT1Sr9iFED/i995GE/bT+EkZs5rcjVQULGuGiZGIzDX97SpDF4bOIujJCXtF2TPeHJqusCI3k2r
 kDbCtVd4GpQcdBCDeLoGvCs/TWjBWOeUVORBmjyqfMJ2dIPn1Xe9q8PNJNvO/mP4sUo6vmHXhxW
 N+tz7yl97LPdlwuy8ZIF8M/0kheUJiN6QHjC/Vf/w/ZzR7NpKjH/PrxiGdmJK+qY8SciBS2nMKQ
 c8FS4e25oYZwZHbnP1cSWV6hpjG2iyZ+/Zm7Zwo3HXFhe+95uNtYJx++W9QLCCEHCNmMBExaqzD
 0H1CukynLm7ujTjA6DagbPHRgsSiMvPCblLQwL+9g6GsCiH6MhUsB1Q5UFIfyjuS1VLc6ItCpmB
 RCxZj7w50OzZcjcU6uvo+4qrg51CTeGAwZqFnFiV9jm8gW7UwkNvWI3M7H8Nk1/06cGUpD+IFlk
 c6HdjYX7N3ODlnRPdl8CbNQTmvi7yRm7hhvlAQpvM5rCqITWWzAc21vUQd7HXWCpoU0egDD2tN6
 EtkYEDMOvRe/FJDcWFPSowKhaJVFN5EaNS1oaIjSNwS1NoT8+VMNbiGVaKuiE/Q79WXLlERwi9H
 7/VM6kvFD1dfQVg==
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


