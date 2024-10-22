Return-Path: <linux-kernel+bounces-377120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64919ABA18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F761C20F82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550371D0153;
	Tue, 22 Oct 2024 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Kyxf3bvH"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F061CEADD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639792; cv=none; b=BgrqVGGFEBoMguWfU5//mrypafX6iXInc0uo9FP0I4BCsDgiuM3gRUscvQ3QCI6j4OhB8mlqYi5glhPNpLZzDqKOK0crJpFRgWPjxa4B014OzuFQ0CBa33PahUSfu8oG5mlNyKLsPvCKJ6PJ5SYJ5oz1HQtqwexOHxMeNXe3Amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639792; c=relaxed/simple;
	bh=MW8IjQcGXvfLqPc5JoHqDyfjY2zCP9eWXkray5C89yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjcopYUpxC0k4VvfpFERAvXY0U24ai30wWNfvczvIspYzoHXMavCkJO9zJrug19l2P8xrpD/q/GISvhdbFmiyDfVemLdB/4zFDLdlGN9VJ4Eosm/T7Sc53slT7LUeFWhzUkjKj1QxjIo3/v40/nHpvvbKDKA6KUkbnPDDMidyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Kyxf3bvH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ITRmfwM+nhDMcdL1axA1LkbzgcdJ47VaYDlOpmeKPqw=; b=Kyxf3bvHSwxC1fn6
	GQ/QLK0DnNiN85/dlo4rnzlALQ20Xv5upG8S3T+l82AiYsIUALeupC9faUJRCnpn5/kyV8LAiw3z6
	qJxPAc+phAxox8FndPazjQT3bTlcmrCDORbk98YPdnBGXU5pWPKtHCnGeN4nKjTbmM68ivo6FeHRf
	PsHrAGbhCvsv/khEpZYrP/1dUWZM79gWq6JYXRweoxkTRrv09BeZJvewIsMjX+OitqYXO4P1+HcWk
	cofLoMNeZlB6EBQctdhMFE/J5V4DkzAwXaMh/Up0OkYSxfVbKpTmOMA7zfrXtHyNf3jTzJiz7m+gq
	GsOy85IAFB4llrJCZg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJl-00CtGr-2n;
	Tue, 22 Oct 2024 23:29:37 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/5] drm: Remove unused drm_atomic_helper_commit_planes_on_crtc
Date: Wed, 23 Oct 2024 00:29:30 +0100
Message-ID: <20241022232934.238124-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022232934.238124-1-linux@treblig.org>
References: <20241022232934.238124-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of drm_atomic_helper_commit_planes_on_crtc() was removed
in 2018 by
commit 6c246b81f938 ("drm/i915: Replace call to commit_planes_on_crtc with
internal update, v2.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 72 -----------------------------
 include/drm/drm_atomic_helper.h     |  1 -
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a4..dd8f7d6f5a36 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2705,8 +2705,6 @@ static bool plane_crtc_active(const struct drm_plane_state *state)
  * crtcs need to be updated though.
  *
  * Note that this function does all plane updates across all CRTCs in one step.
- * If the hardware can't support this approach look at
- * drm_atomic_helper_commit_planes_on_crtc() instead.
  *
  * Plane parameters can be updated by applications while the associated CRTC is
  * disabled. The DRM/KMS core will store the parameters in the plane state,
@@ -2833,76 +2831,6 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
 
-/**
- * drm_atomic_helper_commit_planes_on_crtc - commit plane state for a CRTC
- * @old_crtc_state: atomic state object with the old CRTC state
- *
- * This function commits the new plane state using the plane and atomic helper
- * functions for planes on the specific CRTC. It assumes that the atomic state
- * has already been pushed into the relevant object state pointers, since this
- * step can no longer fail.
- *
- * This function is useful when plane updates should be done CRTC-by-CRTC
- * instead of one global step like drm_atomic_helper_commit_planes() does.
- *
- * This function can only be savely used when planes are not allowed to move
- * between different CRTCs because this function doesn't handle inter-CRTC
- * dependencies. Callers need to ensure that either no such dependencies exist,
- * resolve them through ordering of commit calls or through some other means.
- */
-void
-drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state)
-{
-	const struct drm_crtc_helper_funcs *crtc_funcs;
-	struct drm_crtc *crtc = old_crtc_state->crtc;
-	struct drm_atomic_state *old_state = old_crtc_state->state;
-	struct drm_crtc_state *new_crtc_state =
-		drm_atomic_get_new_crtc_state(old_state, crtc);
-	struct drm_plane *plane;
-	unsigned int plane_mask;
-
-	plane_mask = old_crtc_state->plane_mask;
-	plane_mask |= new_crtc_state->plane_mask;
-
-	crtc_funcs = crtc->helper_private;
-	if (crtc_funcs && crtc_funcs->atomic_begin)
-		crtc_funcs->atomic_begin(crtc, old_state);
-
-	drm_for_each_plane_mask(plane, crtc->dev, plane_mask) {
-		struct drm_plane_state *old_plane_state =
-			drm_atomic_get_old_plane_state(old_state, plane);
-		struct drm_plane_state *new_plane_state =
-			drm_atomic_get_new_plane_state(old_state, plane);
-		const struct drm_plane_helper_funcs *plane_funcs;
-		bool disabling;
-
-		plane_funcs = plane->helper_private;
-
-		if (!old_plane_state || !plane_funcs)
-			continue;
-
-		WARN_ON(new_plane_state->crtc &&
-			new_plane_state->crtc != crtc);
-
-		disabling = drm_atomic_plane_disabling(old_plane_state, new_plane_state);
-
-		if (disabling && plane_funcs->atomic_disable) {
-			plane_funcs->atomic_disable(plane, old_state);
-		} else if (new_plane_state->crtc || disabling) {
-			plane_funcs->atomic_update(plane, old_state);
-
-			if (!disabling && plane_funcs->atomic_enable) {
-				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
-					plane_funcs->atomic_enable(plane, old_state);
-			}
-		}
-	}
-
-	if (crtc_funcs && crtc_funcs->atomic_flush)
-		crtc_funcs->atomic_flush(crtc, old_state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_commit_planes_on_crtc);
-
 /**
  * drm_atomic_helper_disable_planes_on_crtc - helper to disable CRTC's planes
  * @old_crtc_state: atomic state object with the old CRTC state
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 9aa0a05aa072..6ad50c531fc0 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -107,7 +107,6 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
 				     uint32_t flags);
 void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
 				      struct drm_atomic_state *old_state);
-void drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state);
 void
 drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
 					 bool atomic);
-- 
2.47.0


