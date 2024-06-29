Return-Path: <linux-kernel+bounces-234834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995091CB44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D970C1F237F5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21195381DF;
	Sat, 29 Jun 2024 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="PD5Yikpx"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBF374FA
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638610; cv=pass; b=pAv3UpSq6/06zj5foUY1CG9Dpk43Vk3w7+1wGWRz8YATj+WntupFmXJDZprd3/A7aF7n3MxfER4DYR8xeDccLMFc4vRUp2AyH49Wv1/CVMRfr3aOhfAAiwK6uQ8IInu8CA9e8pF7y19QhHEGzaYhGsrybnxAJ3TAyWCSwdSKqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638610; c=relaxed/simple;
	bh=sb40Yndd1QV5J124GfSY24yvDpzRWJYgrpqBKCKq3YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyUDLtPWCwWzsaXz7NGKzPi8/PkJHe6/AC7qLU2vV/ekBHZI3cP+8D+8gldX1hhsx1FL5D5tzgnMVwwSnjLZgrCrexpC9Upz4jso5Xl3IeYyiI6N5b7ZoCZ1ifNnuETqSUJqYb1sv93ru0MQGoICwEZILoJ4OvOdMOgFmRLZzs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=PD5Yikpx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1719638598; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N/pQoJ2HBGvk5OK+rAVXPycZXrx862RBstQIPY3TLRJFlxTQGNm3x5+pdTId6PIFR/xFLKl+zNYPmVdHX/u7stLAqPAXOiRYBSDGbWX0oQ+ZZ2MTBdFPweATWUa2FrJ1xwW0owIMVG2UGCJAwA4pbwtcphMmH9zrfDD48hs/Jtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719638598; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZiTmCeUwyWMd9DM1cMRWsanJUulWwCpqnbNYD4zrjzg=; 
	b=XiDgC3JhNqZXq3Dl/co1ZX9jCsgGaeO1sy4ayn2iV7CC/nzYUyRRrkmZ6CL0y39P5nHhg8Eqjn+Rc+pho9NGbri77nRrpO+I7ujk7UUGXAWuoen1utBAvgcCM/ZlsZ4baUYHX/7B/gBJanO+sGmdCcUdqUVGwGlOwHiG3XUX6XA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719638598;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZiTmCeUwyWMd9DM1cMRWsanJUulWwCpqnbNYD4zrjzg=;
	b=PD5Yikpx54BMenJrjK/5RN8Nx43MLhxJbJdCq4ryw9GJhTyAw3y3sT/SEk8dAoI5
	dkDAGn61fk51ei0dAE9cs+9R5eXuHNz26yvlI82iu9eg+eqTfLeroKmGzxjTTsafXss
	gy0M9q1usdBjzdZQf7yHgxn4rHin7T/qN1WOuJ1nqc+tmeU/Cr7dRZyeDgXycSPyGu/
	3E1PxqfdeesDrojoKPJdV4uM1q3J+Xh50PUARjTLX7e4eW5mGV/CZ8WjgeIbPlIVWXc
	RrdAStixwbiKk+JHHwq/sY2U5jKL9BL3benHiUfI8asoTw8bcipK5dup2XlVHYnpSHM
	1zMaMYQkAA==
Received: by mx.zohomail.com with SMTPS id 1719638596401770.5863508458222;
	Fri, 28 Jun 2024 22:23:16 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 2/2] drm/ttm: downgrade cached to write_combined when snooping not available
Date: Sat, 29 Jun 2024 13:22:47 +0800
Message-ID: <20240629052247.2653363-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629052247.2653363-1-uwu@icenowy.me>
References: <20240629052247.2653363-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As we can now acquire the presence of the full DMA coherency (snooping
capability) from ttm_device, we can now map the CPU side memory as
write-combined when cached is requested and snooping is not avilable.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++++
 drivers/gpu/drm/ttm/ttm_tt.c      | 4 ++++
 include/drm/ttm/ttm_caching.h     | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 0b3f4267130c4..6519ce047787d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -302,6 +302,10 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo, struct ttm_resource *res,
 		caching = res->bus.caching;
 	}
 
+	/* Downgrade cached mapping for non-snooping devices */
+	if (!bo->bdev->dma_coherent && caching == ttm_cached)
+		caching = ttm_write_combined;
+
 	return ttm_prot_from_caching(caching, tmp);
 }
 EXPORT_SYMBOL(ttm_io_prot);
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 7b00ddf0ce49f..3335df45fba5e 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -152,6 +152,10 @@ static void ttm_tt_init_fields(struct ttm_tt *ttm,
 			       enum ttm_caching caching,
 			       unsigned long extra_pages)
 {
+	/* Downgrade cached mapping for non-snooping devices */
+	if (!bo->bdev->dma_coherent && caching == ttm_cached)
+		caching = ttm_write_combined;
+
 	ttm->num_pages = (PAGE_ALIGN(bo->base.size) >> PAGE_SHIFT) + extra_pages;
 	ttm->page_flags = page_flags;
 	ttm->dma_address = NULL;
diff --git a/include/drm/ttm/ttm_caching.h b/include/drm/ttm/ttm_caching.h
index a18f43e93abab..f92d7911f50e4 100644
--- a/include/drm/ttm/ttm_caching.h
+++ b/include/drm/ttm/ttm_caching.h
@@ -47,7 +47,8 @@ enum ttm_caching {
 
 	/**
 	 * @ttm_cached: Fully cached like normal system memory, requires that
-	 * devices snoop the CPU cache on accesses.
+	 * devices snoop the CPU cache on accesses. Downgraded to
+	 * ttm_write_combined when the snooping capaiblity is missing.
 	 */
 	ttm_cached
 };
-- 
2.45.2


