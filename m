Return-Path: <linux-kernel+bounces-411201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2BE9CF47F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9565C1F2B3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C821D9359;
	Fri, 15 Nov 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="WI9UFpQB"
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32838DD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697408; cv=none; b=pBenjrufGgh6F5SZjnJSjoFaRHA8Qm7rSLvPR15b1nof/028/7kgkgr3va1UimdMV58RWLzwW+5J813GP57sv/R+d/aj2vjJ2Z+Gpu8HEB0CDqqBF/AT38D1wnH1y2b4NAx6KnmS0Q+3pSA65PphI/Q1+t1Cd6VRvdMfcXhaoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697408; c=relaxed/simple;
	bh=cQsa020sv4AfeIBGhI4RU27/jPbQNmEs2q8pSQu/7HI=;
	h=From:Date:Subject:To:Cc:Message-Id; b=LUbzVY0FQAta6pSQyzzo9u+wbYdvtPPXERvlGw7ML2JordoGISA0ldooSNtU2nVWv5iLKNlBky8GG95ssmJf38uY0xwLHKasN7BUQezwssiBKraplh2UfI5hocHp2o+IFQxFTfX6mRtP4sdxT32CFM83FxwW9sCbKAgVoDH9zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=none smtp.mailfrom=bout3.ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=WI9UFpQB; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bout3.ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731697396; bh=cQsa020sv4AfeIBGhI4RU27/jPbQNmEs2q8pSQu/7HI=;
	h=From:Date:Subject:To:Cc:From;
	b=WI9UFpQBHXOh9erTjL5rKRmlSEebYKAoMVW4C+Mn9AHisJH4w8I7XHCu4Om3pCTxH
	 6APiVTy4UOkGqm21hE3eWJORSbHg8LVNAJ+PMsJ4eSsL65G9F8F2+iftYlmwE9TK1z
	 Q8oXfkLf8/lBPQDlCvW+IqQKXBd8RS8y4+HqjYWrMfksNOVmG0gZ2OQijVo1cz3r0R
	 w3Fb9uG9ezk7JYX8QJ2gflM6Dq11FnGBIuIqrpX6pOqie60stOKOqR5FDXfQ+d3miD
	 gC2+irmrKg3bouCnbspkM9fr4HtsK64CQRXMK3yGq9rtII9BpE8ByNXe/lLdxk7wTe
	 FFODOs2/LBjJT910jiCUUeAW5Sd76mDNlRvksAOsesXt7ooNNbdnzVIwmrwdsPDccY
	 /sy7D4PG+LutsYd0KyKjnlfXgW/A/n9ifbfuxM3yGJLwjchPz9hd9xtxaY8caJROjq
	 MutaCxdqkomlc59lHJbKgpRqHljmLG+QdvMJSuyX35DcIdbvChJ50UkIjl5ryktOX2
	 zm3EGv3plxShEgQl6Utvnz1t5kqo9uhK+iCVso1PFs6ZAkN8iyT6mxjdotMsAfQiRo
	 r2iRgajuF4IHk/WztEyF9i300yAr3vz2kl0yxZVejpByra3IcHVOikkrtmpU1gZ8Cn
	 lG93vv7pLgjEmEMGKSRQlpzw=
Received: by bout3.ijzerbout.nl (Postfix, from userid 1000)
	id 28A6B18DFF2; Fri, 15 Nov 2024 20:03:16 +0100 (CET)
From: Kees Bakker <kees@ijzerbout.nl>
Date: Fri, 15 Nov 2024 19:46:25 +0100
Subject: [PATCH v1] iommu: Avoid use of NULL after WARN_ON_ONCE
To: Baolu Lu <baolu.lu@linux.intel.com>,
    iommu@lists.linux.dev,
    Tian Kevin <kevin.tian@intel.com>,
    Joerg Roedel <joro@8bytes.org>,
    Will Deacon <will@kernel.org>,
    Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20241115190316.28A6B18DFF2@bout3.ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
---
 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 527f6f89d8a1..204873976ef3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4096,13 +4096,14 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 			break;
 		}
 	}
-	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	if (!WARN_ON_ONCE(!dev_pasid)) {
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+		kfree(dev_pasid);
+	}
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-- 
2.47.0


