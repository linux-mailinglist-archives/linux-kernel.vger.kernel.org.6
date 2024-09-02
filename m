Return-Path: <linux-kernel+bounces-311444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF6968953
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A291F225A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6F20125B;
	Mon,  2 Sep 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="BGBFqUHy"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6019E98B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285678; cv=pass; b=ejuK1s+iQS1/OYsyvubMUhqiI2Us37eLg+TJKGie7eSAeL9qwumoulLVXhT18ULL1oXN8i7Hur7Db3Fe4RsDMEH+egHxg/WN+XbACZGamJ/0Cz1L7Uyb4GqkRRkHr4gZSM2+LRydDwn1CVtsSGW5szFW1xxkLY2R/b7DMbI/EFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285678; c=relaxed/simple;
	bh=vK6hmmM0DBV12CTZ0WyugrY0MWv9y2pgNL/Z9ZtvMec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cthm76aOOOH0dMsABBTsQFADe23PfpqfkfEJZFKBVf0D5t0GOMyaC7a0zTTUvummwSXO68Cbo/tU/toYWZbl3AZkcDMLlXF5/MPfOmpyFFxOOFzsNnd1KJf2vDejaHbD5uZAsRp4/ECJnrheHAG58D0lAlvg/bDrQi0AUpWv2UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=BGBFqUHy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1725285665; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S9flqk/B6l8l8AOmCYo1Gu2Tdqpn4QTNnkgrJOUmh84hTbdxCigzH1KNm+nl1vrpThUvNcHTSwLDv6FzrOuHOkSTKz+aIGGVZE2Qy4RnNyK8mtLcFZfg9+dkUuejjdI2bx+Svf0o2BB4U980yg8n4c0o46DA0AF6ZqGnIJf6XR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725285665; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D/7RuX7OmIGW9y/1IHddtkVDMYjXxYRmzEFQDdhUgEk=; 
	b=MUjembpRv8nlszy3FhUQFuNiKTSI+gKalzBMCGzpLSYiMLZsfXlr4o7rSkIaMzV5xutAjHUl8xEyy493ppdRsYeWeiNz2pShUBxH3U2yfrHe0KOGbg+YwufMYRVU8kGWeN+ARx1jL1p1zmoD34NyMrv9dyGDVKpwSU3JIrJ9uis=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725285665;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=D/7RuX7OmIGW9y/1IHddtkVDMYjXxYRmzEFQDdhUgEk=;
	b=BGBFqUHy4RwlL97QHFQDsiG2DjV48EuZ9IG+sJnykFzV8j5YhwLiZThgxm01oMbJ
	YIh6/P2qlkrOg1SBA4mmimF1HFgMl0qPSki1y45rlDsYdBXllxEaFmjUVdRMIRKUSFv
	V0dD/BLNc2CS/IHBLdO+Q+8LbXAA1tp3HRADosMw41gQYHdX0+x42kjq6ruz2HHw4fU
	LNdtFFyjJbnh8BNth5KGrXd/RzoK3o0rUX7C+JTMbLyAWT/lk3EdUnfjuAaSou7yEzt
	InKKhAH8Wi9xYlVXyd87iX2Fug49v7YYyZ6/Cy2YelHbk4zh2m/WX8vk9kdIPC+g1MO
	2med/CFc3A==
Received: by mx.zohomail.com with SMTPS id 172528566286781.8323865718055;
	Mon, 2 Sep 2024 07:01:02 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Matt Coster <Matt.Coster@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2] drm/imagination: properly support stopping LAYOUT_MARS = 1 cores
Date: Mon,  2 Sep 2024 22:00:39 +0800
Message-ID: <20240902140039.1972899-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some new Rogue GPU cores have an extra MARS power domain, which
controlls the power of the firmware core and allows the firmware core to
power down most parts of the GPU.

Adapt to this by ignoring power domains that should be powered down by
the fiwmare and checking MARS idle status instead.

The logic mimics RGXStop() function in the DDK kernel mode source code.

Tested on BXE-4-32 (36.50.54.182) with firmware build 6503725 OS provided
by Imagination Technologies.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Fixed some wrong change that moves the original logic into if(mars)
  instead of if(!mars).

 .../gpu/drm/imagination/pvr_fw_startstop.c    | 48 +++++++++++++------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index 36cec227cfe3c..ae137e35edf3b 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -191,19 +191,27 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 				       ~(ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_SOCIF_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_HOSTIF_EN);
+	const u32 mars_idle_mask = ROGUE_CR_MARS_IDLE_CPU_EN |
+				   ROGUE_CR_MARS_IDLE_MH_SYSARB0_EN;
 	bool skip_garten_idle = false;
+	u32 mars = 0;
 	u32 reg_value;
 	int err;
 
+	PVR_FEATURE_VALUE(pvr_dev, layout_mars, &mars);
+
 	/*
 	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
 	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been
 	 * powered down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (!mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
+					sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	/* Unset MTS DM association with threads. */
 	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD0_DM_ASSOC,
@@ -257,21 +265,27 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 	 * For cores with the LAYOUT_MARS feature, SLC would have been powered
 	 * down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
-				ROGUE_CR_SLC_IDLE_MASKFULL,
-				ROGUE_CR_SLC_IDLE_MASKFULL, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (!mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
+					ROGUE_CR_SLC_IDLE_MASKFULL,
+					ROGUE_CR_SLC_IDLE_MASKFULL,
+					POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
 	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been powered
 	 * down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (!mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
+					sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	if (pvr_dev->fw_dev.processor_type == PVR_FW_PROCESSOR_TYPE_META) {
 		err = pvr_meta_cr_read32(pvr_dev, META_CR_TxVECINT_BHALT, &reg_value);
@@ -287,7 +301,13 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 			skip_garten_idle = true;
 	}
 
-	if (!skip_garten_idle) {
+	if (mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_MARS_IDLE,
+					mars_idle_mask, mars_idle_mask,
+					POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	} else if (!skip_garten_idle) {
 		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
 					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
 					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
-- 
2.46.0


