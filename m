Return-Path: <linux-kernel+bounces-312349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0596954C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E3B1C2137C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104911D6C5C;
	Tue,  3 Sep 2024 07:26:07 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B401D54F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348366; cv=none; b=L0x1WaqnRxqvcRR0iW2RjxevZ0hQ9BO52QFW13YX+qwKbz7SqOCIVvXH1Uh2bLeJ3kBpsK6zxB/RyXf+wXRVojJBX5K/cheW9eTN2xoMA9m2/x7wEZL8BGoVifYbvpy06CEKRbg4MyRn2JPTUCNq69mGgK5TNFGReYeIlwGGkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348366; c=relaxed/simple;
	bh=12GmkGOMibEQ+eJlqJfLkuRReRvjDI5Yl1/I9s0ocvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmj4VvJSRlpp0FINDK8hCacGBlsxvCDxP5DD3MLtpdW5IgXB8TN64k9/eH0getEP6dOMSbYmazhdoB0UM5VQXV+/4tEUHWVNVlGixyqyvI66ZYFbWZipsLBc+J31YuzTKeqJ/bmFViJWTbj53ib8QAj3C3RzBPLFK/jqDRQXF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX38AutZmTaq_AA--.45023S2;
	Tue, 03 Sep 2024 15:25:52 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iommu/amd: Convert comma to semicolon
Date: Tue,  3 Sep 2024 15:25:18 +0800
Message-Id: <20240903072518.780705-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX38AutZmTaq_AA--.45023S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUXF4UXFb_yoWfKrb_uF
	4UXFZ3Ja4DCrsIka4Utwna9rW2gas2qan2gr4vvr93Ar1kZF48Zay8ZFykAw4UXr43KF17
	Grn8Cr13WFWqqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUDuciUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iommu/amd/io_pgtable_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 664e91c88748..67f1fd8fab07 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -373,9 +373,9 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	pgtable->iop.ops.unmap_pages  = iommu_v2_unmap_pages;
 	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
 
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
-	cfg->ias           = ias,
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
+	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+	cfg->ias           = ias;
+	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
 	cfg->tlb           = &v2_flush_ops;
 
 	return &pgtable->iop;
-- 
2.25.1


