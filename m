Return-Path: <linux-kernel+bounces-382562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C59B0FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7051C20B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E3D20EA25;
	Fri, 25 Oct 2024 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="P/ecnuGo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034F1865FC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888776; cv=none; b=BYSc6kwRkmTybVtEMDLl/etWxv8HF3rdiN8v9isDSMUVGu9vY2Z2D8VcTGKtmeuhf+p+XuT0a8XQzzDFrSkL4a+7jkT/1zaeJZjjedXosKs7P0suzOxZwC9UsW/J1PIORLyOg1Q+FCHlUyrK+lveyj3xYmPC04Enh9pgpmrXl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888776; c=relaxed/simple;
	bh=grCafecDOdEYl/Y0UcmqBh9c8xZkNyOZEJhCdqTnUBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4N+76FLkksI/Qyj6M5ovRzl5aOY7cMz6kBcVEOLFP8Xw/I7f18IS5ALNKf2w+z1bJq/12j4G9iBYUphGiI9GpTu4qvAlyePdtIyqf6Z0X2ZVP8wOCVPxbXlgr1dSWv8F0VDSDQBwZRFFXSKvK3gj85JfFY94kVVUY5i+YYsDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=P/ecnuGo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/N2iCTYSr8UYoHJzGbHTr136+4N/JHiIfuSACMG1vRI=; b=P/ecnuGodOh9vPd9
	tr8s75qTNFz8XUL8Vkx6ZtQGXyRcn9gzp4IxCXxFxB9LzGxEZwN9yPGqDafkdfDo5DPx4eip21eiJ
	s8bry+A6gn6/8V9JGrUsP1jxV9pv1IlaKZ52s9lYX6dblxMT4FRk/TYMw1H6jQOVilHGDXpcJfNtB
	YFbs014tYyAQ4GH0xw91EZOPEpmiQbF3jChjDtd66X+GO2+xkIL8aYorOPVr4pVk9okDliB6nFcs8
	xmzxnnWTuc8Qo+DpnAAs8IqVXixxWlIZ2oGLV0PwioM2VhIAeywnhXyjjkFmUYe1SJNZZHnF4k/xL
	gu/rBg5q3CCAHVIxmw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t4R5d-00DbxR-2K;
	Fri, 25 Oct 2024 20:39:21 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm: encoder_slave: Remove unused encoder functions
Date: Fri, 25 Oct 2024 21:39:20 +0100
Message-ID: <20241025203920.244116-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

drm_i2c_encoder_commit(), drm_i2c_encoder_mode_set() and
drm_i2c_encoder_prepare() have been unused since 2016's
commit 7bc61cc5df80 ("drm/arcpgu: Accommodate adv7511 switch to DRM
bridge").

Remove them.
That change makes drm_i2c_encoder_dpms() unused.
Remove it.

Remove the comments about those functions wrapping a couple of
pointers in drm_encoder_slave_funcs.  I can see sil164, ch7006, and nv17
set those fields, and I can see some nouveau code that calls them
directly; so i don't think we can remove the fields.
(Although it's not clear to me if the sil164 or ch7006 code
can ever get called).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/drm_encoder_slave.c | 26 --------------------------
 include/drm/drm_encoder_slave.h     | 11 ++---------
 2 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder_slave.c b/drivers/gpu/drm/drm_encoder_slave.c
index e464429d32df..0c994a4ef9ae 100644
--- a/drivers/gpu/drm/drm_encoder_slave.c
+++ b/drivers/gpu/drm/drm_encoder_slave.c
@@ -125,12 +125,6 @@ get_slave_funcs(struct drm_encoder *enc)
 	return to_encoder_slave(enc)->slave_funcs;
 }
 
-void drm_i2c_encoder_dpms(struct drm_encoder *encoder, int mode)
-{
-	get_slave_funcs(encoder)->dpms(encoder, mode);
-}
-EXPORT_SYMBOL(drm_i2c_encoder_dpms);
-
 bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
 		const struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode)
@@ -142,26 +136,6 @@ bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
 }
 EXPORT_SYMBOL(drm_i2c_encoder_mode_fixup);
 
-void drm_i2c_encoder_prepare(struct drm_encoder *encoder)
-{
-	drm_i2c_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
-}
-EXPORT_SYMBOL(drm_i2c_encoder_prepare);
-
-void drm_i2c_encoder_commit(struct drm_encoder *encoder)
-{
-	drm_i2c_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
-}
-EXPORT_SYMBOL(drm_i2c_encoder_commit);
-
-void drm_i2c_encoder_mode_set(struct drm_encoder *encoder,
-		struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode)
-{
-	get_slave_funcs(encoder)->mode_set(encoder, mode, adjusted_mode);
-}
-EXPORT_SYMBOL(drm_i2c_encoder_mode_set);
-
 enum drm_connector_status drm_i2c_encoder_detect(struct drm_encoder *encoder,
 	    struct drm_connector *connector)
 {
diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 49172166a164..3089db10b6fd 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -58,8 +58,7 @@ struct drm_encoder_slave_funcs {
 	void (*destroy)(struct drm_encoder *encoder);
 
 	/**
-	 * @dpms: Analogous to &drm_encoder_helper_funcs @dpms callback. Wrapped
-	 * by drm_i2c_encoder_dpms().
+	 * @dpms: Analogous to &drm_encoder_helper_funcs @dpms callback.
 	 */
 	void (*dpms)(struct drm_encoder *encoder, int mode);
 
@@ -88,7 +87,7 @@ struct drm_encoder_slave_funcs {
 			  struct drm_display_mode *mode);
 	/**
 	 * @mode_set: Analogous to &drm_encoder_helper_funcs @mode_set
-	 * callback. Wrapped by drm_i2c_encoder_mode_set().
+	 * callback.
 	 */
 	void (*mode_set)(struct drm_encoder *encoder,
 			 struct drm_display_mode *mode,
@@ -223,15 +222,9 @@ void drm_i2c_encoder_destroy(struct drm_encoder *encoder);
  * Wrapper fxns which can be plugged in to drm_encoder_helper_funcs:
  */
 
-void drm_i2c_encoder_dpms(struct drm_encoder *encoder, int mode);
 bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
 		const struct drm_display_mode *mode,
 		struct drm_display_mode *adjusted_mode);
-void drm_i2c_encoder_prepare(struct drm_encoder *encoder);
-void drm_i2c_encoder_commit(struct drm_encoder *encoder);
-void drm_i2c_encoder_mode_set(struct drm_encoder *encoder,
-		struct drm_display_mode *mode,
-		struct drm_display_mode *adjusted_mode);
 enum drm_connector_status drm_i2c_encoder_detect(struct drm_encoder *encoder,
 	    struct drm_connector *connector);
 void drm_i2c_encoder_save(struct drm_encoder *encoder);
-- 
2.47.0


