Return-Path: <linux-kernel+bounces-511587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09192A32D01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B5169977
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3725D539;
	Wed, 12 Feb 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="oWrklSyM"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479F256C83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379949; cv=pass; b=d9uu9uR7nMch5ChBUqgWyZ/N8bPXMbs7Tb45XZ+i8AnmpCPeSPIBx2S5Rig2HhgGa/rPfboL4+Q7lh52WnWcCIroqNHtnhulZBxrwEFbVcmDOtlrKenhBEpGJIb0sddyRY0ofN+E0lyqHbmBoOQvXTeZqMC2cur/Im6dY7tKR3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379949; c=relaxed/simple;
	bh=ehl4uK7N9uxnhjH5MyPg6eHObjNvCSmCx5FguWXMEPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+qXx4H3n23FrPHbgNsAVtOunv1sV6/o7T/rBwYWYOx5wW72uju/NUs2T63zjLrPQX94FGws7amrY0lnLyi6kmliwE0LtGyHCT9N7ZwtW6mwCEgnr6ZPW8vlMyI6xA63SSdKZBHpH5gJWmhyYEeWPpC92S5hcgEcvPuDGngYoJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=oWrklSyM; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1739379935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hTuz8gGCmAz6/NBm7x2386wVyrsN941gsocYRg+g3+UXSUKRFTlU7284FPZkcYKxLK4pWRo3DqMRqevPRv1rXhICt+FsAZeZ6a7ySdt1Bm+pVT6qBjUNBqjelUbrN5p7ymdZfpTjvVLWazQ991PYC+Q6yoImo4+SR3LrQF/9k08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379935; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zpnS5LdUZemikz3jDhlU3VLItf8J0nEAlg+TMLI01V8=; 
	b=jiiALIKpOceXbs44izIR1/J28Rhiu+Cx/2ZZM0dVt6QGBCjx1JyJvt7AAeTSI9N1cOUhlPkIzpPH2Du7brk+hZhlghWoKP730j0UjGGwSNkaohd2TeYUYbo1/NmE2dtUCkijWKLZjvVVGPds37PLSCXLUCORycH/e5j1ZO12jdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379935;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zpnS5LdUZemikz3jDhlU3VLItf8J0nEAlg+TMLI01V8=;
	b=oWrklSyMJV7/9lYP4MoNQlK8kEEvvLyhL/rppCWn/mwCB3z46Qx6ddcYuR+NPhDm
	Z9vecKExVTh+9t4M8kuc8Q8eFuSwuHINgzoO+HOqYKzQuJGjFfPC4C+Lhyni3tssAU/
	WDuWfuOhmKkqZcbj6V8/cRy9/ftPPVyW/qGaePs60Xe+fu/VtlYJ3A2bJKpy4CfTgmC
	jznRkRkx2aeH9XmrK7vUfdx50F1YYzOlcu0b+KR1DO3E7drpqt24V4krH3KjBDZAhou
	z4+fr0Xhve+pysuvLG7/+Rjd2Fr+nniwHC7SJSIXBAq/wntlrgSjUR858dceKeGUTyT
	lDmNDDLbDA==
Received: by mx.zohomail.com with SMTPS id 1739379932694459.250015065458;
	Wed, 12 Feb 2025 09:05:32 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI P2P DMA
Date: Thu, 13 Feb 2025 01:04:44 +0800
Message-ID: <20250212170444.16138-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
References: <20250212170444.16138-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The PCI P2PDMA code will register the CMB block to the memory
hot-plugging subsystem, which have an alignment requirement. Memory
blocks that do not satisfy this alignment requirement (usually 2MB) will
lead to a WARNING from memory hotplugging.

Verify the CMB block's address and size against the alignment and only
try to send CMB blocks compatible with it to prevent this warning.

Tested on Intel DC D4502 SSD, which has a 512K CMB block that is too
small for memory hotplugging (thus PCI P2PDMA).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 659ba85795a91..1a27688417b3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1982,6 +1982,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Controllers may support a CMB size larger than their BAR,
+	 * for example, due to being behind a bridge. Reduce the CMB to
+	 * the reported size of the BAR
+	 */
+	if (size > bar_size - offset)
+		size = bar_size - offset;
+
+	if (!IS_ALIGNED(size, memremap_compat_align()) ||
+	    !IS_ALIGNED(pci_resource_start(pdev, bar),
+			memremap_compat_align()))
+		return;
+
 	/*
 	 * Tell the controller about the host side address mapping the CMB,
 	 * and enable CMB decoding for the NVMe 1.4+ scheme:
@@ -1992,14 +2005,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
-- 
2.48.1


