Return-Path: <linux-kernel+bounces-511585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F3A32CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFA1188D5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61E25D536;
	Wed, 12 Feb 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="kQHLMSUu"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DB253F09
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379941; cv=pass; b=ecyqJPuboOfJvl1v1SGamiDyiShLf134jJk2yyzNHKuLGj1LxMMEcVlMUHKr4fqITwBo+sBycFdH9hjJQNIK0sw/owm/BIT+vIMWY/8KBfqVtNguFcSH/sy/m9oca48J/iFmRbH7+uQM+vVFIACOVODkW5iUueQC8wLbSdh6t+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379941; c=relaxed/simple;
	bh=qU/JKIE8oBhr5wgbP+/tAgRL/Jnzg8tcIoTbMoXNMDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LalrPUBO/v4EjJAx7agD9I5fyfEU195XZK3t03N7+NQaxq7diug8ZglZSGYjMJDwAqzCT2mXy7A6FGuvNPr+mf2zxNOwCvFWRFONhNmY7hiGZbBqIpbL62pIrI5U6hz4vyRhiM7SYUK0B8yed2Co6zx73oV9pnudvAH+kDXCRa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=kQHLMSUu; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1739379929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b+zKe0hVzTzQ+s0ZD/DkQ4+MPYOf0gUwkcT+EMa8cUdy9CLIk5CjrIzaiPBeZNwAO8O/79ADR+aM1Cf28jzxmdIaJchMRBpoNmgUsz9lNS8jbwreYu9qD7182YMYWp+EW4JJ5pY4yUPHIM2epDXDyo7JqirEi3qVaSv0YcHKh0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379929; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=szz5q8OAuo67lw+94E1dN9/NQa54+wbklwNt3LY2h8k=; 
	b=WgHE7QrSM//8pKvvyzg6qDLDojXVzDt0Nu7pe4hnPavE1eEXf/rpA+M60tWmygmKmZux7cgj1u7aXAXP2b+o0jnpzOT/6wPY3JYWTtoS5jkw3WHC1/a1EaEHCC/gARPotfXQGymbAMhRGLMIbw1st7XK+aMmldFoMJDA46PJ6hU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379929;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=szz5q8OAuo67lw+94E1dN9/NQa54+wbklwNt3LY2h8k=;
	b=kQHLMSUuinqM7OLB8gmtM2syo0JuKWEA3hezCUKkmYaWr7fnm48R8ATycr/GqhGg
	6LKSlTBsfbB1r82RiVkKyEm0/2GdVivlLWIUowmyQqrp9bUGfqAWQxms2cH6D/nflPx
	6TCucciJ0Lv77B6YoyssaB8pGwtLHcbzYuNyMt8N7C3Ao8mwWX85t/uIf/ASGcWf4SF
	4KBbDrDATynKLR6W24aqdNH7fRphUgkkc09zPvKXNM6YOjNXplac6/n24xrWbbW45Kf
	6MjgaFeDsOBC0KdhT+ecnrT2LZ6otHMKAEyQDdxmbsoF3yyCJ65jBgQFSqFkWmKk0Hs
	zMauaDdM1g==
Received: by mx.zohomail.com with SMTPS id 1739379926466930.6067351141463;
	Wed, 12 Feb 2025 09:05:26 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] nvme-pci: clean up CMBMSC when registering CMB fails
Date: Thu, 13 Feb 2025 01:04:43 +0800
Message-ID: <20250212170444.16138-2-uwu@icenowy.me>
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

CMB decoding should get disabled when the CMB block isn't successfully
registered to P2P DMA subsystem.

Clean up the CMBMSC register in this error handling codepath to disable
CMB decoding (and CMBLOC/CMBSZ registers).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9197a5b173fdf..659ba85795a91 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2003,6 +2003,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
+		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
 		return;
 	}
 
-- 
2.48.1


