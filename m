Return-Path: <linux-kernel+bounces-432004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C909E43BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF401665AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFC91B87C6;
	Wed,  4 Dec 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YbpWbPaN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCA1C3C0E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338241; cv=pass; b=ki1d1CKQ7PI0SrtNDeCYFWd5PhSJe16l1HW2rzFHZ1zQ43e73984UNkN0JDTQe+DlVRDUXMP4p+eElzIUlGhgNMy0bOhUjXyGsS1jpoQaS64Nn7DWzD+Bcjua6v1nX9zs2elrhJRYCWIbKa+QpjREJkZCHeIYXpUrC5fkfKFbn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338241; c=relaxed/simple;
	bh=VmekAnvTHihGZIfchksMeLHRR9dERBj/FgRIAtmd1VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEcO2pSS95zEGURXyvQbY3k/6hu4KWXmNOIU6cuLVQcignGP4CGXzye2WEqgcw63vfrNpqR4XsXoRcTw4agauY5IYc9lAwHkG8UBLtT5pUONdtm4X8qV/A0Uhuexa8oHaVSbgz+gPxPR5n3w6Zj2tqdvlsaLF0JWcLIVKN8wfro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=YbpWbPaN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338220; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FDLspdUKvddl5QQ7rm+9s1QxoYfxUggzhN0RAsmx2Qn9e3BJgBr3nZccTdbJBU/L6UBNnXEh5lU3Gd4P62RPPgY/xQYDCz0Lj5jZwQ1kSqSe+wYSuhy5bP2Zt7g+Rg7z9O/LdgDUx68EMll0uIZrUp2OvjAjpUwRo5BUCY1LJYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338220; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sgGFYTpB2s0EDBW/ccLjDBCyNPeLkKbJ491OXwFkDP4=; 
	b=Cjc0RlfjNGdJGExdfU3b23TFickqDEJIug9TSoRnd6Wxjp68BriJCJm2NQEG8ivXjBslAmeKSPHUjZxatJw4AKVLbYMkkCWqXUYI/rIZ+VH2nw7CmDttBzWil6SWKq4OTAJhNlgxyHqxOmoQcc2StJ2lLVUoiqtEjihLULda6q4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338220;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sgGFYTpB2s0EDBW/ccLjDBCyNPeLkKbJ491OXwFkDP4=;
	b=YbpWbPaNA9NMsvjSVNKu5iwt4SRPxieWWCOToFW+NeIVspee4AMKm95XcjKqRULg
	m6crQy0+uxPXsiGVYTjWTogxHP6HsA7Z/mxlefKnal6Wk8WeSSrGPdGBros5PCSjbp1
	KmcVTon3kHrGc/biYz2j6CVJHgQD6LaK4HSWKpPc=
Received: by mx.zohomail.com with SMTPS id 1733338218055806.7687330402214;
	Wed, 4 Dec 2024 10:50:18 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] drm/panfrost: Handle error when allocating AS number
Date: Wed,  4 Dec 2024 18:49:33 +0000
Message-ID: <20241204184945.1477677-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we reach the beginning of the LRU AS list, then return an error.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
 drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 9 ++++++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 83bc74f6044e..d10f66f4cc53 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -214,7 +214,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 		goto err_hwsubmit;
 	}
 
-	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
+	ret = panfrost_mmu_as_get(pfdev, job->mmu);
+	if (ret < 0)
+		goto err_hwsubmit;
+
+	cfg = ret;
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 2189e42d2bfa..03ac527b35e7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -155,7 +155,7 @@ static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
 	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
 }
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 {
 	int as;
 
@@ -197,7 +197,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 			if (!atomic_read(&lru_mmu->as_count))
 				break;
 		}
-		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
+		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list))
+			return -EBUSY;
 
 		list_del_init(&lru_mmu->list);
 		as = lru_mmu->as;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 022a9a74a114..e6e6966a0cca 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 
 struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index f30817bcf8ba..c551fa1ddfe5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -130,7 +130,12 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	perfcnt->user = user;
 
-	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	if (ret)
+		goto err_unsetuser;
+
+	as = ret;
+
 	cfg = GPU_PERFCNT_CFG_AS(as) |
 	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
 
@@ -164,6 +169,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	return 0;
 
+err_unsetuser:
+	perfcnt->user = NULL;
 err_vunmap:
 	drm_gem_vunmap_unlocked(&bo->base, &map);
 err_put_mapping:
-- 
2.47.0


