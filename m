Return-Path: <linux-kernel+bounces-343863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88498A072
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5B1F24519
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818F196C86;
	Mon, 30 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ieMF5X63"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491A192B85;
	Mon, 30 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695313; cv=none; b=N/z5ovi5gL5uwgadtxpmdeEoe90l7dG+R8CqOG1JkZUU7K9KqADXvf+FBVrIcmt3ydo3alIgsluTjH6H7WBGxe1B7qsflGpaRhgX7EuUEFSYuFkXYK14NmxyMWRIEKMPsEs+qY7CUVKUfxVJ86lzgqgs/em9T4F4+n2kfkGrBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695313; c=relaxed/simple;
	bh=bZliJJbFo2IN3n4dVutGITp1Mh2I//yTpJhop+j2CoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kl8aOhd9yzc9mQnGP+WX3rzsV8Rx9OEDt3bVXjXR8+rLDdRUj5uqYQ91DUO3iIVAaMEXkV1ukhASVmhMcedPn2XbdxBcIKFl4p6QPVPPzpLo478uLN2HGX7y6gsk0pYaYJvEQvTJkdYomJOgmnuOSruxAISoFi+f6E08Cgcu+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ieMF5X63; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DpNHPysHFcdW+st1pCs6FRvPCloR1wCmvNrlpVL8YWk=;
  b=ieMF5X63x8wsel579EOpHZ4yMnFPF3OvgQ9rchZqSwalbrFvl3BnW2+1
   o4B5hYIY4bSL4qkSUqtMw2XzU+t5/M3oVFfflkTN8YYSjOLBCssD1eHKW
   NUpoh8Uq2fATv1f0ueRDKyOIurGLZos8szpsZHX5ABnyztNUSOo9652JJ
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956890"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Joerg Roedel <joro@8bytes.org>
Cc: kernel-janitors@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/35] iommu: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:05 +0200
Message-Id: <20240930112121.95324-20-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iommu/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..ce72edd34f07 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2216,8 +2216,8 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
 
 /**
  * iommu_group_replace_domain - replace the domain that a group is attached to
- * @new_domain: new IOMMU domain to replace with
  * @group: IOMMU group that will be attached to the new domain
+ * @new_domain: new IOMMU domain to replace with
  *
  * This API allows the group to switch domains without being forced to go to
  * the blocking domain in-between.


