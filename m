Return-Path: <linux-kernel+bounces-530333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CEA43222
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D0B1679BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0EE10A1E;
	Tue, 25 Feb 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hvTKWSPw"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4F23AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444991; cv=none; b=iaP1zCohJTWzbYCR+59WDni0mTeDLa87v+x0msepOlGyyzKV4GZBKPlpZ7h3ye4d0h/5zWkUb9NiyXN6UvwwA+/Wj91kRzC7mnMkAaw0HIWihpGxNs2orEpMaYB+PFQ5IJoN1tvSy3nhCVTB6c10CRgdnBafB8x1KxvN42T6e2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444991; c=relaxed/simple;
	bh=L4XqhSC+5QQ1aomriMfSul3p0/mMZQNVRcw/FajCz30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBxwzibZlKAZrcbk5Wiujtz0QXwo6qu12QGRizprwHh7B1wof43hxY64oUIbgsqV0W8t66FCUlugbaW532xb/5vp1j/FWs5gQh/+ChnxaTxyQRvJv+etQ6O66S4J13gqF7wM81UB+Ugx+jUhDaW3HpaaCFfU5FjenEAm6buiqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hvTKWSPw; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=OAHHgv0L+tOtR4u+k11uGAQYtSpCSi3f0RqAKr/DkRI=; b=hvTKWSPwPE5q7AYa
	8bKYG5N1T65B2gD+f0QOTee104qZutU9BRaFM7vpYADmbRtKu9H8rq7V2eMnDJ5ziGNah1Xzz45jv
	opBt7YsreyCj+9OtPbUdbZ0xWhQrW7tf1vxGoONZXitK4xrN7giD8u13OhDsUMhSaWbRHvZoHp1h9
	ZMmVbzhKWHPmWE3J3qRntAUao+jq3CmEpJt76yKCxLxBxOARpGifJEAgKJAMbRKXHKrMpXjyENjFG
	Di+xjZt/HhD3v5O2izEwFHr1xOKviLf1oLVJvqu7MxQc8Ritx4aafxqMc63L90WRcOixvWaiM08Ou
	G8Lho/3TNp05TIDOQA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tmjFF-000YZX-13;
	Tue, 25 Feb 2025 00:56:21 +0000
From: linux@treblig.org
To: tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/omap: Remove unused omapdss_find_device_by_node
Date: Tue, 25 Feb 2025 00:56:20 +0000
Message-ID: <20250225005620.88667-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of omapdss_find_device_by_node() was removed by 2020's
commit 811860ddceac ("drm/omap: drop unused DSS next pointer")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/omapdrm/dss/base.c    | 12 ------------
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/base.c b/drivers/gpu/drm/omapdrm/dss/base.c
index a4ac113e1690..f8be1399a79c 100644
--- a/drivers/gpu/drm/omapdrm/dss/base.c
+++ b/drivers/gpu/drm/omapdrm/dss/base.c
@@ -73,18 +73,6 @@ void omapdss_device_put(struct omap_dss_device *dssdev)
 	put_device(dssdev->dev);
 }
 
-struct omap_dss_device *omapdss_find_device_by_node(struct device_node *node)
-{
-	struct omap_dss_device *dssdev;
-
-	list_for_each_entry(dssdev, &omapdss_devices_list, list) {
-		if (dssdev->dev->of_node == node)
-			return omapdss_device_get(dssdev);
-	}
-
-	return NULL;
-}
-
 /*
  * Search for the next output device starting at @from. Release the reference to
  * the @from device, and acquire a reference to the returned device if found.
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 4c22c09c93d5..95897a1b711b 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -240,7 +240,6 @@ void omapdss_device_register(struct omap_dss_device *dssdev);
 void omapdss_device_unregister(struct omap_dss_device *dssdev);
 struct omap_dss_device *omapdss_device_get(struct omap_dss_device *dssdev);
 void omapdss_device_put(struct omap_dss_device *dssdev);
-struct omap_dss_device *omapdss_find_device_by_node(struct device_node *node);
 int omapdss_device_connect(struct dss_device *dss,
 			   struct omap_dss_device *dst);
 void omapdss_device_disconnect(struct dss_device *dss,
-- 
2.48.1


