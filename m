Return-Path: <linux-kernel+bounces-431895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC319E4270
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A42853AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A121147D;
	Wed,  4 Dec 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="pgh5hOIx";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="jQ2Ucqx1"
Received: from mail180-27.suw31.mandrillapp.com (mail180-27.suw31.mandrillapp.com [198.2.180.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A2211476
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332448; cv=none; b=Vk129i0MVB+R7oN7bj+bzrPoX9/ei116MvTRwciE78Kfu00e/rzl8EawByW81XEsMIe7HoTWgp2ET4NM/n8zBVuGX0EfZJP4ALQFOEGhw+uVU0AdmaALzYL8HjXcw/bPnpDZTTbY6T2KpR9vBE4l4U3gdNV0PaZyzGrH7fE/gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332448; c=relaxed/simple;
	bh=Eq8SgbeFLIrARobvyglArW1NJkGFk0WxCrcOWUtZ4xo=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=bDqY0y0V7hgqBJ7GZwaHJaqh/ejTWqjWy6sLelsTpmLRL5qUO6vTQOWb+7cYy38pESnRQFwN5VmhOllNAEtpS5X4npC4A+hZjYKXlfq1q6/CgDU4wry2v3MdzFPtTjNotbq3aG3c52GRmj/STXVYrlBkLfD0IwjPRm2Bx1ROyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=pgh5hOIx; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=jQ2Ucqx1; arc=none smtp.client-ip=198.2.180.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1733332445; x=1733592945;
	bh=ha+PFFcK2rZoX5f3m0+6W/HqdkROKWb4ZcN5LYyjSAE=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=pgh5hOIx/Oy9rKgiKjTRVpU53srMnz/oFEg5NhkPkJ8Gfow8pxFANoVg8ROcLr0zy
	 rk/lbSRCsSwbK5H/pQG4CuozxORWxXZM1gjPHrwfH1zg1yxKzzD1RVNZWhG33vTg/K
	 Q+vN48xEyx7Ny5mrea45vAMuuGadAgG522IBkuhGxOefe8ZpxYwB67VP/zLFd86sbi
	 /FG53W27O27I9jptuglPDjxlhWl3BoCo9YPDfm/7V4zRTJYGPylMaw0bst1HngoA+g
	 NNGIh+UL81855i0nCfXze4BRhEOr1wdkn+xwLm4qgtCNbBiL7A0GUQDK1qFWRGuoTA
	 zDG3yR8k/iDSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1733332445; x=1733592945; i=thierry.escande@vates.tech;
	bh=ha+PFFcK2rZoX5f3m0+6W/HqdkROKWb4ZcN5LYyjSAE=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=jQ2Ucqx1+u7OWQ1j6qA5K/wQIwlF6Xldp0kPRVKWl/bmtd40mM3NorI0o0CmtBAuN
	 QROKjPa4SlIvmMmnMvZbOVOh8g6cd3zThMMOINwMco8EWn4rsuuHqtZ5tOQKQn3WUn
	 XMR0XmRfkF8WEzlgLf/NYsebctc/DPTAN2SbL1EiRw+kKDh03S63/g9mNhPQ90Rmlk
	 vMgr6+nH/ezgo/DpK1dKIgBpSM8hpasp+z+qdkb8yC4nQyhb1k5tcHZhpztDmy7HOV
	 zWADCQemhRCM2AblqdVHYf3LCNEbSFDuV1gzFg7Ur/OExgyD1CVxsG8KiqE9xZl9ee
	 w90Tk/zejwgmg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-27.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4Y3PJD6qbpz6CQRTx
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:14:04 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH]=20x86/xen/mmu:=20Increase=20MAX=5FCONTIG=5FORDER?=
Received: from [37.26.189.201] by mandrillapp.com id 6441a5165014448ab0b26a94dcf4d9d3; Wed, 04 Dec 2024 17:14:04 +0000
X-Mailer: git-send-email 2.45.2
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1733332443466
To: "Juergen Gross" <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, jbeulich@suse.com, xen-devel@lists.xenproject.org
Message-Id: <20241204171346.458105-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.6441a5165014448ab0b26a94dcf4d9d3?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241204:md
Date: Wed, 04 Dec 2024 17:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

With change 9f40ec84a797 (xen/swiotlb: add alignment check for dma
buffers), the driver mpt3sas fails to load because it cannot allocate
its DMA pool for an allocation size of ~2,3 MBytes. This is because the
alignement check added by 9f40ec84a797 fails and
xen_swiotlb_alloc_coherent() ends up calling
xen_create_contiguous_region() with a size order of 10 which is too high
for the current max value.

This patch increases the MAX_CONTIG_ORDER from 9 to 10 (4MB) to allow
such allocations.

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 arch/x86/xen/mmu_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 55a4996d0c04..7f110740e1a2 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2200,7 +2200,7 @@ void __init xen_init_mmu_ops(void)
 }
 
 /* Protected by xen_reservation_lock. */
-#define MAX_CONTIG_ORDER 9 /* 2MB */
+#define MAX_CONTIG_ORDER 10 /* 4MB */
 static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
 
 #define VOID_PTE (mfn_pte(0, __pgprot(0)))
-- 
2.45.2

