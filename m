Return-Path: <linux-kernel+bounces-380979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED69AF87B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C268DB21C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F2A18BC15;
	Fri, 25 Oct 2024 03:51:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5618A6D8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828288; cv=none; b=mN7TijWwpvFQMlS6D69kDwELEWDGz83Fk/OvJxbpAPKCz855Tt6crFtQdI8wXxHRH1DnyQgCFpM7xxlSYjX8kSqCFqfmak5nkCyYnzASfZm1gvflD1ge+p4cQinc0fgpYHaW+LYgrExwrAEbwJhll1UHi+Pamu1iSBX3f/NsRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828288; c=relaxed/simple;
	bh=bXQJj20jrXVJ/ZbIYdvZEYjtmv9yxDKyxxU7CvU6pZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXK3TpjMC0gd63d2DLmfNUdtpizXCV9en++uExaeFpUBoomYEQmnenJzqEgV+fG/MdCXgTMZAW0SwBpgB5l+lXeXHiz0KzTMk5XeO6UM67MgKTguVRxGH2czzfv53e9Jvmn/lWtrPGvvi9yBj66wQdLSuQLZHU1TnqGYuDzfDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 629cda28928411efa216b1d71e6e1362-20241025
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ae7975e5-53d8-485d-a6d9-ab93ee85b120,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:e6841dc3a29fef6cc4c4d47c9684e538,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 629cda28928411efa216b1d71e6e1362-20241025
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 591682689; Fri, 25 Oct 2024 11:51:15 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id BE1E7B804842;
	Fri, 25 Oct 2024 11:51:15 +0800 (CST)
X-ns-mid: postfix-671B15B3-636278766
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id 02073B804842;
	Fri, 25 Oct 2024 03:51:12 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] amdgpu/fence: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Fri, 25 Oct 2024 11:51:10 +0800
Message-Id: <20241025035110.10854-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
index 2f24a6a..d047afe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -818,20 +818,6 @@ static bool amdgpu_job_fence_enable_signaling(struct=
 dma_fence *f)
 	return true;
 }
=20
-/**
- * amdgpu_fence_free - free up the fence memory
- *
- * @rcu: RCU callback head
- *
- * Free up the fence memory after the RCU grace period.
- */
-static void amdgpu_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
-
-	/* free fence_slab if it's separated fence*/
-	kmem_cache_free(amdgpu_fence_slab, to_amdgpu_fence(f));
-}
=20
 /**
  * amdgpu_job_fence_free - free up the job with embedded fence
@@ -858,7 +844,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rc=
u)
  */
 static void amdgpu_fence_release(struct dma_fence *f)
 {
-	call_rcu(&f->rcu, amdgpu_fence_free);
+	kfree_rcu(f, rcu);
 }
=20
 /**
--=20
2.1.0


