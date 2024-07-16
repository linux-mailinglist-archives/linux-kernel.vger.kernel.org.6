Return-Path: <linux-kernel+bounces-253424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99EB932128
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953172826E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54628387;
	Tue, 16 Jul 2024 07:26:19 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F3219F6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114779; cv=none; b=QxGuLp7zEIG6e+GpoHFIvFgf1G+G5ZvRHRqG6C+svIajnyg45/Ic0swjswoxLTrOG1y9Oy/IYGjZwwLj9mlczNihyD3GYi3IlIpV+5INs6hU79A+4d8o3or2Azn1UkQESh4Kuu0idV5IEZKxXUGwcgertvoNIG0md5Oj0MsAkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114779; c=relaxed/simple;
	bh=5TeE6nG+SVarqq22UTL3bw8T6FItccUVOc5vZCC71AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSbe7wL8ywDpUMRgeJ7r+GbETDwMUQ43Ls9yRwA48rZGkY20EKW7uwVIjNAz+JsxKLlME11xi8Hfg85OlkOdbBin/qDVN0hoMnS2XqQJR21LC7khoPB5rUwF0QYyLOm+UxBhOXBDi3i6g42sIoRU7Ls24e0hWpDOQiZqVcw06UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACnreWLIJZmVeCVAw--.49954S2;
	Tue, 16 Jul 2024 15:26:03 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iommu/amd: Convert comma to semicolon
Date: Tue, 16 Jul 2024 15:25:45 +0800
Message-Id: <20240716072545.968690-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnreWLIJZmVeCVAw--.49954S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF1UKry5Kr4Dtw47Jwb_yoWDCwb_ZF
	1jqrZ3G34YkrnxC3W5twnavryjgayktan2gr92qr93Ar48Ar48Aay8ZFy8uw4UXr43uF1x
	G3s8Cr13uayqvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
	CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd5rcUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: c9b258c6be09 ("iommu/amd: Prepare for generic IO page table framework")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iommu/amd/io_pgtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 9d9a7fde59e7..1074ee25064d 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -588,9 +588,9 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 {
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 
-	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES,
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE,
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
+	cfg->pgsize_bitmap  = AMD_IOMMU_PGSIZES;
+	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
+	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
 	cfg->tlb            = &v1_flush_ops;
 
 	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;
-- 
2.25.1


