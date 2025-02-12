Return-Path: <linux-kernel+bounces-511584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3EDA32CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1542188C3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83925C6E4;
	Wed, 12 Feb 2025 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="qHWlJLzg"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCC21506D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379925; cv=pass; b=nw7XT8mpA06exFMD6B3jvmm6UlABJtLUivpItuJuMm7JvwG+Se0F/CB1Zte2imqB3vEf61exy+0pvUWdYYRm+UG3Kb2EGDlZle0wYditOmbGBJh0VoJFHloaiOoEbJWaiTkJs1ZcxrMPpwM3vRLPmGSDM6KO7WCnzJbYb/8O3hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379925; c=relaxed/simple;
	bh=RdsXEv3SBSsPet3rWrbJqb5tDfGYvktt/g0mVmqlN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maho/kVl+VQ/PxJjRcNjFqN6puWEhh6+f2O+25tT20cWCc2I/k7FLGXdY5qBRrhVz13nNWUD4plZCe5zCpTfM/NjFrhkUFdEELJ5H8rjBVFuWhyWEZRUKQNBK2nnhXadKLc5qE98UaFVmZS4yRS56VYGl+VbIqiSq83kwA+QODw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=qHWlJLzg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1739379905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XzIdDMmlQvd+7eqBZ48Ft6NFDObvfGC3Be/pMeDmAHLPoCZJGXVUw97X39UEEAiRrblYMg9eWQxWtGxx8O+AOY7du8of9Rb7iiopL+no7EDmhp/ei/Iwodm+YTmrTV6TYBr/KeYfR9PvUHuI9Rf9HEr+EX4+uC+9W6LQrxfUG1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379905; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EhaY44LabIRZbp1gFKZbV5ZkU6S68tdKwnnQCkN/Ysg=; 
	b=Q6hdsqLSw2EQ8IoXJFpXGiIyLVC6ufy+1fbbE0nOhSS9xbF7jam4O4R/MEDsdQFi4qs5MuOVtefWGgWbtg65f2E+CfCbxSffeN6MLw6NKh3bI+beQJrfn0nLzjn0CzEZkIYsWs74w34oZI4jGGWc53o6ppxEMNQ36bUkw6iKBk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379905;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EhaY44LabIRZbp1gFKZbV5ZkU6S68tdKwnnQCkN/Ysg=;
	b=qHWlJLzgnc9QMfKFDayNYxao2HW5JMbJuKDS1DFJa3ffaak9qasaCWlhv0RcSBXQ
	3oETqjpXidQyELvC8sc4Kv6ckCR5CtA+OpUkiGob0VzTWXaSF++VcCoqtlrnIRXlz+6
	m0nLTPfPTBKEB/XAd+xXfF51zWFMEpclkGlnwGCBF+Htit8Wl6j2AOut7qWo1HyTVVW
	no1hkY7wzQcKlDHBsY515YGGoL551gwJwxOsJt3z3EKjdktHTGLoUElNfbYKL2Bo92m
	gQ651RY/FaucuTgXU7Jy2ofel++q52NOhkhUr1W5Wp+ZuObrYuohrl9EWTtudbKhVkh
	Vbv3G5QxAg==
Received: by mx.zohomail.com with SMTPS id 1739379903389217.33151028331645;
	Wed, 12 Feb 2025 09:05:03 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Date: Thu, 13 Feb 2025 01:04:42 +0800
Message-ID: <20250212170444.16138-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Here is a small patchset that is developed during my investigation of
a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
SSD), which is because of the SSD's too-small CMB block (512KB only).

The first patch is a fix of the PCI DMA registration error handling
codepath, which is just a observation-based patch (because my disk is
only NVMe 1.2 compliant, and the register cleaned up here is only added
in NVMe 1.4).

The second patch really fixes the warning by testing the CMB block
against the memory hotplugging alignment requirement (which the CMB
block of my SSD surely cannot satisfy -- the alignment requirement is
usually 2M with SPAREMEM_VMEMMAP enabled and even larger in other cases).

Refer to commit 6acd7d5ef264 ("libnvdimm/namespace: Enforce
memremap_compat_align()") for a similar approach for NVDIMM subsystem.

Icenowy Zheng (2):
  nvme-pci: clean up CMBMSC when registering CMB fails
  nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

 drivers/nvme/host/pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.48.1


