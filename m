Return-Path: <linux-kernel+bounces-520631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E62A3AC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446D0175C43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A051DE4C7;
	Tue, 18 Feb 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YHwYeW+G"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629081DE2B5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921358; cv=pass; b=pu3fqms+GngraIakUOkTqC3IIPXlwFfszMP6QQBsQIo4q+gxVNyl+ESluM2p4AFVFELRdyaFxe+yk1GWi6/rZ59RiMJhyyQM8aWuea5Uxk6SSuc2Fz2R/Z5js0Xdwd1W+dbniGX/0cLRUEPSWTN9rzgWkw+GK9IuDNoTCSOBERU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921358; c=relaxed/simple;
	bh=83bAq6pX3ZK+2WbLvwKw/f9ubqpeJlg+GNDZKlJsScA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1v8Y8STNrpd2ZPvt3135SeJXRJQqxEtWH1a53WpzDCVjfxjQux49BHVyiAl/Cv9izq7OIGCiAOY1ph+54MQfFFOp3mBBiON6qzkWqL3OY40waZfYSsxUCLsuU8c4INaI6V6Ch5a+nEWqldVeX8mOUvgl2BFWeIDMYcWVD01P/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=YHwYeW+G; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739921338; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KAB+ODyFxGhg7B6x99dY/ELB1ZUxT4mKPu1HceEiLZbGFSKNWjggrdYJGFquNuSvUfXaVAI/07+ckaai2Zr8jb9yTlrBaRVpINI4IbsrQHsthbTeThmkhdgF0rDTCs/dYo3CSdZw/g5xhvpd7+KdMmLYBpshaLrIlauw5GEMdog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739921338; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xXOQHDyDK3ylLZfTlWzUigjKBktcbj0fWV8yThDx3wA=; 
	b=SC0T7cuumYiDbudXfvebEbIuTjsdTWZ68i99nzQui5PMwjcVjauxJb1yiQ7YZyJscy1755Ht2exz6sKfcoTWN4Q3YqjMgRDjjkspn/v42i6vvkssmkGa7yGEB3W+mqiMPXjBejnMmVgzvmR/ojRjMCfEYnIIXemL9AzQ1Fx5+OY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739921338;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xXOQHDyDK3ylLZfTlWzUigjKBktcbj0fWV8yThDx3wA=;
	b=YHwYeW+G8NwqvIUlXgU7Tl3xjbF/vDtvQq33g0bLvaR2ve1bbmsPlR98L7/Ehi/w
	0PsRn2/aNwdggrxgsQ0VjV0a00pbkmzLaorCCooWmkTkaLMIeB6EsmRXjp6VtqaoMGE
	Gtx9jDeaQ3fUggAJIXJij2KMEb80IthjjMho9gOY=
Received: by mx.zohomail.com with SMTPS id 1739921336488392.7532493423994;
	Tue, 18 Feb 2025 15:28:56 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [RFC PATCH 3/7] drm/prime: Let drm_prime_pages_to_sg use the page_array interface
Date: Tue, 18 Feb 2025 23:25:33 +0000
Message-ID: <20250218232552.3450939-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218232552.3450939-1-adrian.larumbe@collabora.com>
References: <20250218232552.3450939-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switch to sg_alloc_table_from_page_array_segment() when generating an sgtable
from an array of pages. This is functionally equivalent, but a future commit
will also let us do the same from a memory page xarray.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_prime.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 32a8781cfd67..1549733d3833 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -837,6 +837,7 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
 				       struct page **pages, unsigned int nr_pages)
 {
 	struct sg_table *sg;
+	struct page_array parray = PAGE_ARRAY(pages);
 	size_t max_segment = 0;
 	int err;
 
@@ -848,9 +849,9 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
 		max_segment = dma_max_mapping_size(dev->dev);
 	if (max_segment == 0)
 		max_segment = UINT_MAX;
-	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
-						(unsigned long)nr_pages << PAGE_SHIFT,
-						max_segment, GFP_KERNEL);
+	err = sg_alloc_table_from_page_array_segment(sg, parray, 0, nr_pages, 0,
+						     (unsigned long)nr_pages << PAGE_SHIFT,
+						     max_segment, GFP_KERNEL);
 	if (err) {
 		kfree(sg);
 		sg = ERR_PTR(err);
-- 
2.47.1


