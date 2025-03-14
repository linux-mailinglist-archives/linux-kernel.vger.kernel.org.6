Return-Path: <linux-kernel+bounces-561895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5549A61844
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B288691A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8C204684;
	Fri, 14 Mar 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="dIdUMG9c"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD25204680
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974024; cv=pass; b=WsGzHyHbqkEgODhRnl0DhDDmBr9MXFoF0uZ5Ni0Au4/x6vOOr9wokOpP8I/Tcwp43LbYs4Ylqs+1AU/dvgvpWpY8fDrrs0mTk/NbxkgNmd7+bIAA2Azm2FjUSfyzCTxyfN4P3fmRWwlxzRwQpCyX1nYTF8RpMWkiH+5GtPrDtBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974024; c=relaxed/simple;
	bh=p++KVk3Fw8pgMe8xXWu7SiuG6QOWrS2JQmXG3WQYqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6OqL8Y4JoImf4JuBH91SO0VUu3w4nrsDQSAlUA7pTNDEs5OTNVTcAspiYycWikxJgywojCTyYFqJJag4/LupLCCFT47hPCIl7estpo6iU0UU1UniYwkugDeANIJNhMhqbodB1teAGwO2DeR3mGWvYEnps8fsXec8Y4bNlyS0UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=dIdUMG9c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741974001; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZCkG7Az+Ny0TDQTThm2KSY658Yw0UhGBTaHip7knOva8Lf7dJfNoepNPQtE+NZMoRG4XwU3lpsLZIuhblJ3SHzwaxttdE/qaSi8Fp2K0W8Gu/ChNEyV648raEfLGZe/9yviYWb4/VdQSfPiNDubq2UgdYZQT77qVdlBP9+X925E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741974001; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=; 
	b=a8o2pkyrf+OOmozU3zWIN3kOGW00HreHdVHlLtuxMaLx6f+7UMQJuDladIDtMmivcCupJuW9gWdEHh2wvcE8xc5mfnHGdWErHJYpA7oiiCKZAVWixCgInpELw2pv8kslAiGAId3PCnqiFpCEMdqRJK4vmCxmEsYKVxTKGUBsXqU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741974001;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ghqsESCSlYDpPWVp7MysrBKDg3K0+nOb0GO49Q1Vkh8=;
	b=dIdUMG9czft3lYTgdhVH62QHefFWoI8PFRxt6BzyTd6/5J0mU775O123d/KGbsO6
	xNWkpjFKRKftz33ip1akzwfc5GO+ivGlcQrvCZVk6Qdg1sBZxHc8htF34sxXknkMmPa
	XfqLhPOO1JwjCQ4T4A1mDH1WSBYaBXyPEDsc9IP0=
Received: by mx.zohomail.com with SMTPS id 1741973998131839.7415151177113;
	Fri, 14 Mar 2025 10:39:58 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v2 1/6] drm/panfrost: Set IOMMU_CACHE flag
Date: Fri, 14 Mar 2025 14:38:53 -0300
Message-ID: <20250314173858.212264-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Panfrost does not support uncached mappings, so flag them properly. Also
flag the pages that are mapped as response to a page fault as cached.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index b91019cd5acb1..9e6f198ef5c1b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -327,7 +327,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	struct drm_gem_object *obj = &shmem->base;
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct sg_table *sgt;
-	int prot = IOMMU_READ | IOMMU_WRITE;
+	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
 
 	if (WARN_ON(mapping->active))
 		return 0;
@@ -528,7 +528,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		goto err_map;
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
-		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
+		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
 
 	bomapping->active = true;
 	bo->heap_rss_size += SZ_2M;
-- 
2.47.2


