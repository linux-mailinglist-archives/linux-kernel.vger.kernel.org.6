Return-Path: <linux-kernel+bounces-377118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6B9ABA16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C5CB229ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B121CEEB3;
	Tue, 22 Oct 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="miiCJCUh"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E651CEAD4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639790; cv=none; b=BNV57oXhpePtYCFStX3l9Ydv3Frswu7QnaDgqIBbVAMIwkFcxD7+DjISWlOTS9il0bJe5jW6aV3QD+HpEMBW3uqUwAecCYCdVCAYMgXBPjXV9UrmqRw83qacPYNiR3YJ9lfe1imFJP0QTaw1l0EKRWnL3L11d7tRLYszjb4igMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639790; c=relaxed/simple;
	bh=UwRkCv/pdCmbbrU8lfOOknKM8Kkd/1K6UQrMyfcArRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1ZRiwsKi5I/Wiw5P4r1XRrkpGbwLe6QM1wrYqD2uIA+iy5PiRpFQaBJ9HhfzMlerER4SCz9Aume424+FcT83h33y8cerCtlFw0yqbDIcgnVnch7M8ZPGV2MDIw5JALvB+gQbKO2TSzLVzXKT00lofC0mwn7rkrByPVOuNmUvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=miiCJCUh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7tqnPkF2BTUcYbffZanA7zfXObwjUDobXcZGkQ4od/8=; b=miiCJCUhKGG/Ek0G
	WjNqQ78qCseA8+bWR4xRZsPFkTkPLUTitts/v6Sw+BaGwkIzk6anjII5irleL9WmskoNOS9U+p+u5
	jhQ22tVqbiizvsMvFByh6ulMj/COw9BgpAtsdbvlF4FcajK4Jpl0SnxPvqR+QigUT9VANiKwY0ywC
	bJOqnxSU9yHk05TTEjqTfsZeQg+Djnuz6NgVz5i1kFQnqNnypbx//hWvUTWgIkRnUUVtKe5aAjRTl
	IbvL62sPERJHyZm3w3Fimlvc8wsGcKKS3vevJlvt4marKPeTxi2/VIOQdx9rT/mf6cd4REiXpnH9e
	RQdnRtMZCS32+VU5IQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJn-00CtGr-1c;
	Tue, 22 Oct 2024 23:29:39 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/5] drm/vblank: Remove unused drm_crtc_vblank_count_and_time
Date: Wed, 23 Oct 2024 00:29:32 +0100
Message-ID: <20241022232934.238124-4-linux@treblig.org>
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

drm_crtc_vblank_count_and_time() was explicitly added by
commit cf6483050e9b ("drm/irq: Add drm_crtc_vblank_count_and_time()")
in 2015, but never used.

Remove it, and rework comments that reference it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/drm_vblank.c | 44 +++++++-----------------------------
 include/drm/drm_vblank.h     | 10 ++++----
 2 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 94e45ed6869d..67d6367e9f4b 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -908,10 +908,10 @@ drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
  * drm_crtc_accurate_vblank_count() for such use-cases.
  *
  * Note that for a given vblank counter value drm_crtc_handle_vblank()
- * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
- * provide a barrier: Any writes done before calling
- * drm_crtc_handle_vblank() will be visible to callers of the later
- * functions, if the vblank count is the same or a later one.
+ * and drm_crtc_vblank_count() provide a barrier:
+ * Any writes done before calling drm_crtc_handle_vblank() will be
+ * visible to callers of the later functions, if the vblank count is
+ * the same or a later one.
  *
  * See also &drm_vblank_crtc.count.
  *
@@ -936,7 +936,6 @@ EXPORT_SYMBOL(drm_crtc_vblank_count);
  * modesetting activity. Returns corresponding system timestamp of the time
  * of the vblank interval that corresponds to the current vblank counter value.
  *
- * This is the legacy version of drm_crtc_vblank_count_and_time().
  */
 static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
 				     ktime_t *vblanktime)
@@ -959,33 +958,6 @@ static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
 	return vblank_count;
 }
 
-/**
- * drm_crtc_vblank_count_and_time - retrieve "cooked" vblank counter value
- *     and the system timestamp corresponding to that vblank counter value
- * @crtc: which counter to retrieve
- * @vblanktime: Pointer to time to receive the vblank timestamp.
- *
- * Fetches the "cooked" vblank count value that represents the number of
- * vblank events since the system was booted, including lost events due to
- * modesetting activity. Returns corresponding system timestamp of the time
- * of the vblank interval that corresponds to the current vblank counter value.
- *
- * Note that for a given vblank counter value drm_crtc_handle_vblank()
- * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
- * provide a barrier: Any writes done before calling
- * drm_crtc_handle_vblank() will be visible to callers of the later
- * functions, if the vblank count is the same or a later one.
- *
- * See also &drm_vblank_crtc.count.
- */
-u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
-				   ktime_t *vblanktime)
-{
-	return drm_vblank_count_and_time(crtc->dev, drm_crtc_index(crtc),
-					 vblanktime);
-}
-EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
-
 /**
  * drm_crtc_next_vblank_start - calculate the time of the next vblank
  * @crtc: the crtc for which to calculate next vblank time
@@ -1978,10 +1950,10 @@ EXPORT_SYMBOL(drm_handle_vblank);
  * This is the native KMS version of drm_handle_vblank().
  *
  * Note that for a given vblank counter value drm_crtc_handle_vblank()
- * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
- * provide a barrier: Any writes done before calling
- * drm_crtc_handle_vblank() will be visible to callers of the later
- * functions, if the vblank count is the same or a later one.
+ * and drm_crtc_vblank_count() * provide a barrier:
+ * Any writes done before calling * drm_crtc_handle_vblank() will be
+ * visible to callers of the later functions, if the vblank count is
+ * the same or a later one.
  *
  * See also &drm_vblank_crtc.count.
  *
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 151ab1e85b1b..572e54425970 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -141,10 +141,10 @@ struct drm_vblank_crtc {
 	 * Current software vblank counter.
 	 *
 	 * Note that for a given vblank counter value drm_crtc_handle_vblank()
-	 * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
-	 * provide a barrier: Any writes done before calling
-	 * drm_crtc_handle_vblank() will be visible to callers of the later
-	 * functions, iff the vblank count is the same or a later one.
+	 * and drm_crtc_vblank_count() provide a barrier:
+	 * Any writes done before calling drm_crtc_handle_vblank() will be
+	 * visible to callers of the later functions, iff the vblank count is
+	 * the same or a later one.
 	 *
 	 * IMPORTANT: This guarantee requires barriers, therefor never access
 	 * this field directly. Use drm_crtc_vblank_count() instead.
@@ -260,8 +260,6 @@ struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
 int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
 bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
-u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
-				   ktime_t *vblanktime);
 int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
-- 
2.47.0


