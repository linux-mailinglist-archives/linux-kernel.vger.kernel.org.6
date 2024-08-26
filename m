Return-Path: <linux-kernel+bounces-301857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9395F686
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BDFB21348
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D395194A75;
	Mon, 26 Aug 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C4oPdX5B"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93247E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689681; cv=none; b=JuGASzWxlVMl2c+WiEB5m4j1emCka9HazgZjtMbi5/Fq+dbCoIFQHqWEAiJc76LKZy7QZlaVyNns14bIntadxkntFZIvSDE5AGopDJTie6qkSiula0DYhuyBKfKbXagdwiaDLm6IK7KUeouFbE6x39ImzNCjk1gHaitxCbTXOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689681; c=relaxed/simple;
	bh=sxyzh2oWlsvCOBzm/vhCR+eRbF4VQBZxN/wTkbrI97M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IBWUGxI9V7p0/4Qi/6Ly5yC1y4oYg1VuQ3BDXXKtSQFoe94wiu49MNDqYeWSqZaelUXL+N7fvnHbU/SHA3VExoS1nvAjZc2wOWIhJGH63IXGP3/LsN1SbTxuXVJi7PQRk1HePzOClH/MUh9bm2b/rzwX99KYIY7BvYANVGkL1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C4oPdX5B; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id BC1DEC3E8E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:22:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76512FF805;
	Mon, 26 Aug 2024 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hmv5Zztvd+xgfFCyFuGY+vl66/1uKV6MU6cyJl2eurk=;
	b=C4oPdX5Bzq1by1yA7MY/ZQug9abWD6vHHF/ngQfTmtrtImdB/VYp9MVnm29fJqHYnSTnoa
	oPODHCdZC+j0FynIgikASAXbyM5aVDLvvZT86MYZYhelf/n13Zvzw717J6SXCU6TCAVwP5
	hp3s2wcL+X7TEBKnzXL1bhztuJeuFZRtE1z2Kz+mhFLmaPdkUF8kpe7cOqeiig7QXhzumE
	fPVI2SgYpAupK39dlK/E8UxBOdUnVBgNB9OBXSxvv8gHt6jAb6H2e7ClOYyAzwemPGhXPU
	RgMUaDc6FrF3pYuok///5OFGlfX+I64cvQLfsjZpVC8XbAXNHmzyXgO5ucTyWQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 26 Aug 2024 18:22:45 +0200
Subject: [PATCH v2] drm/vkms: Add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240826-google-clarifications-v2-1-2574655b0b91@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANSrzGYC/3WOQQ6CMBBFr0JmbbUUVMLKexgWpR1gEkq1rQRDu
 Lu1xKW7eZO8//8KHh2hhzpbweFMnuwUQRwyUIOcemSkI4PgouRnwVlvbT8iU6N01JGSIQqeadR
 YadViUUmI7sNhR0vKvTc7O3y+YnzYn9BKH1OsMRTqTDvDDHl1+h1swiXA1xzIB+veaeCcJzVtq
 fLyz5Y5Z5wViNeLvmquRHVrrQ0jTcdYB822bR9cMW5n9gAAAA==
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8372;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=sxyzh2oWlsvCOBzm/vhCR+eRbF4VQBZxN/wTkbrI97M=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmzKvYAYz4fv/OkpQXIMjtzPMjI60u8QEpUws0e
 Zwf7+bBMAyJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZsyr2AAKCRAgrS7GWxAs
 4oloEACG5D+osN9wRvX6TE+GHPAQxKHwdAcKNN654UPfZ2DYlxY7tifOcAP6sOdE6sskXTMHfC5
 UD/FEdHPhIEVvZR+BCSPvmKzhwRjPO2sECO6mYATRrqDzlro9yp9bk1j1kh0FhI37hPwWSVdEQM
 hiVI1sV6IL3zHq6EZnoiwCM4gJyU7ojpQRON3+PLWxMTlOOlk11z12QImv0fhskoa7Cw3Vrd3yq
 TzmRUExboAlzQ663/s5REn91KI1T8AGjOX/TfgX9tsKxqMHP/ZNOpaCkU4tpKg9ZU5vFlBq3Quv
 NxqPXBMa6nChOA+Cv7TGqy1Dml2QstMvODxfZDMr2TDsPZtkIvOHOlSHRTwCqYcQsi+MU3uBSnX
 NRoGv5rZr2WKYQ3jEVhoFCvWWgcxTjbuVtKcbcEjfxRqlTmL+LcgAfgddX8kAsHvUCtOkoxiZpv
 VzPp9wRo8qSqL42IpwMHZfWER17mc0y+wHMWKHBGlhVnJcbDuT/xmu5s5czhI0Iw3XtunfepyS3
 AKxRQa0qJaC6Kq18sq+GpR1WZaASZHYRTAHd87irbQQPpAcIXdEsEIHMVU8XCdXRQysbCPLRRKD
 FMP213GRZWVnzQ2BIhXv0N0VIinr1L7mN3MLBVAVdgyagQPjTFM5Y4B55d6AmssNhMBbK0ueHEi
 vNWU+EnPmRzZpYA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add documentation around vkms_output and its initialization.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
This series does not introduce functionnal changes, only some
documentation and renaming to clarify the code.
---
Changes in v2:
- Dropped already applied patches
- Dropped useless patch as its content is deleted later
- Remove dependency on previous series
- Apply Maíra's comments
- Link to v1: https://lore.kernel.org/r/20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 86 ++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_output.c | 12 ++++++
 2 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 5e46ea5b96dc..1fc068d4de4c 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -73,29 +73,56 @@ struct vkms_color_lut {
 };
 
 /**
- * vkms_crtc_state - Driver specific CRTC state
+ * struct vkms_crtc_state - Driver specific CRTC state
+ *
  * @base: base CRTC state
  * @composer_work: work struct to compose and add CRC entries
- * @n_frame_start: start frame number for computed CRC
- * @n_frame_end: end frame number for computed CRC
+ *
+ * @num_active_planes: Number of active planes
+ * @active_planes: List containing all the active planes (counted by
+ *  @num_active_planes). They should be stored in z-order.
+ * @active_writeback: Current active writeback job
+ * @gamma_lut: Look up table for gamma used in this CRTC
+ * @crc_pending: Protected by @vkms_output.composer_lock, true when the frame CRC is not computed
+ *		 yet. Used by vblank to detect if the composer is too slow.
+ * @wb_pending: Protected by @vkms_output.composer_lock, true when a writeback frame is requested.
+ * @frame_start: Protected by @vkms_output.composer_lock, saves the frame number before the start
+ *		 of the composition process.
+ * @frame_end: Protected by @vkms_output.composer_lock, saves the last requested frame number.
+ *	       This is used to generate enough CRC entries when the composition worker is too slow.
  */
 struct vkms_crtc_state {
 	struct drm_crtc_state base;
 	struct work_struct composer_work;
 
 	int num_active_planes;
-	/* stack of active planes for crc computation, should be in z order */
 	struct vkms_plane_state **active_planes;
 	struct vkms_writeback_job *active_writeback;
 	struct vkms_color_lut gamma_lut;
 
-	/* below four are protected by vkms_output.composer_lock */
 	bool crc_pending;
 	bool wb_pending;
 	u64 frame_start;
 	u64 frame_end;
 };
 
+/**
+ * struct vkms_output - Internal representation of all output components in vkms
+ *
+ * @crtc: Base CRTC in DRM
+ * @encoder: DRM encoder used for this output
+ * @connector: DRM connector used for this output
+ * @wb_connecter: DRM writeback connector used for this output
+ * @vblank_hrtimer: Timer used to trigger the vblank
+ * @period_ns: Period of the vblank timer, used to configure @vblank_hrtimer and to compute
+ *	       vblank timestamps
+ * @composer_workq: Ordered workqueue for @composer_state.composer_work.
+ * @lock: Lock used to protect concurrent access to the composer
+ * @composer_enabled: Protected by @lock, true when the vkms composer is active (crc needed or
+ *		      writeback)
+ * @composer_state: Current state of this vkms output
+ * @composer_lock: Lock used internally to protect @composer_state members
+ */
 struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
@@ -103,28 +130,38 @@ struct vkms_output {
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
-	/* ordered wq for composer_work */
 	struct workqueue_struct *composer_workq;
-	/* protects concurrent access to composer */
 	spinlock_t lock;
 
-	/* protected by @lock */
 	bool composer_enabled;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
 };
 
-struct vkms_device;
-
+/**
+ * struct vkms_config - General configuration for VKMS driver
+ *
+ * @writeback: If true, a writeback buffer can be attached to the CRTC
+ * @cursor: If true, a cursor plane is created in the VKMS device
+ * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
+ * @dev: Used to store the current vkms device. Only set when the device is instantiated.
+ */
 struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
-	/* only set when instantiated */
 	struct vkms_device *dev;
 };
 
+/**
+ * struct vkms_device - Description of a vkms device
+ *
+ * @drm - Base device in DRM
+ * @platform - Associated platform device
+ * @output - Configuration and sub-components of the vkms device
+ * @config: Configuration used in this vkms device
+ */
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
@@ -132,6 +169,10 @@ struct vkms_device {
 	const struct vkms_config *config;
 };
 
+/*
+ * The following helpers are used to convert a member of a struct into its parent.
+ */
+
 #define drm_crtc_to_vkms_output(target) \
 	container_of(target, struct vkms_output, crtc)
 
@@ -144,12 +185,33 @@ struct vkms_device {
 #define to_vkms_plane_state(target)\
 	container_of(target, struct vkms_plane_state, base.base)
 
-/* CRTC */
+/**
+ * vkms_crtc_init() - Initialize a CRTC for vkms
+ * @dev: DRM device associated with the vkms buffer
+ * @crtc: uninitialized CRTC device
+ * @primary: primary plane to attach to the CRTC
+ * @cursor plane to attach to the CRTC
+ */
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor);
 
+/**
+ * vkms_output_init() - Initialize all sub-components needed for a vkms device.
+ *
+ * @vkmsdev: vkms device to initialize
+ * @possible_crtc_index: CRTC which can be attached to the planes. The caller must ensure that
+ * possible_crtc_index is positive and less or equals to 31.
+ */
 int vkms_output_init(struct vkms_device *vkmsdev, int index);
 
+/**
+ * vkms_plane_init() - Initialize a plane
+ *
+ * @vkmsdev: vkms device containing the plane
+ * @type: type of plane to initialize
+ * @possible_crtc_index: CRTC which can be attached to the plane. The caller must ensure that
+ * possible_crtc_index is positive and less or equals to 31.
+ */
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				   enum drm_plane_type type, int index);
 
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 5ce70dd946aa..da69beb43ab0 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -21,6 +21,7 @@ static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
 
+	/* Use the default modes list from DRM */
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
 	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
 
@@ -58,6 +59,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	int writeback;
 	unsigned int n;
 
+	/*
+	 * Initialize used plane. One primary plane is required to perform the composition.
+	 *
+	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
+	 * composition.
+	 */
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
@@ -76,6 +83,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 			return PTR_ERR(cursor);
 	}
 
+	/* [1]: Allocation of a CRTC, its index will be 1 */
 	ret = vkms_crtc_init(dev, crtc, &primary->base, &cursor->base);
 	if (ret)
 		return ret;
@@ -95,6 +103,10 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;
 	}
+	/*
+	 * This is an hardcoded value to select crtc for the encoder.
+	 * 1 here designate the first registered CRTC, the one allocated in [1]
+	 */
 	encoder->possible_crtcs = 1;
 
 	ret = drm_connector_attach_encoder(connector, encoder);

---
base-commit: 22bc22ccf95bfa6eb6288ba4bc33d7fc0078381e
change-id: 20240520-google-clarifications-dede8dcbe38a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


