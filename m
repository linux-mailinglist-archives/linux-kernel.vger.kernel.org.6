Return-Path: <linux-kernel+bounces-377261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F99ABC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF53B1C20881
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB2132117;
	Wed, 23 Oct 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV+BoYFF"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B554670
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653962; cv=none; b=LA2ewI94LIGmx1zVoQ2/CYgY1chKiriaKuDRJNvkWrDwJrcV7AAbgnvnxYsx4+R/Wh/uQQBr1r/6ogV6xoWDEj2huuGT+mCchtRacZnT3TFfB/aME6VJ5w7PhkMEnA1iXUWWlGY+sVMiAxWPUiFDi7q9IEVQxk2asRrZhNT1BmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653962; c=relaxed/simple;
	bh=0xDWPvnfbgrU91PYgKeB/1iKFUnwc8D+YKpWNGw1P1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ku1wP6lS4vQfllpaz31aPm5pc9ZeFTsdYBpEF5wMI7g/aVnbzPs2KwyLiUJ+rkSeOfl79H0BoLM9d2JN6B8nLI9WFyer+iRIsqotTk86jkvpAj1om1zWh5p6ODwgQGwLGm7n5EHqQMpvO5V5jj/n+PrIT0b7VnxCaGbQmWJ3EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV+BoYFF; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729653956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dW5t4q7L8xLiWx5eCKLtNbxm+tJPClVqlJ+VFYgf8yk=;
	b=QV+BoYFF1M8vNmiupz3oGzTCt8fbyxqgKRYl4nT4BiMdjNisa8J3wPrbWcGwi3Rz5ixBFA
	7fcn9in+vRE4wKLiQVIH8B94/zwUQvXGdhd5qLvHN6VWnCp2s4r1Nqt2uCqO6WWG/uqPqb
	o7GHu/bjxx3LQHSnZo192MDm+kn121I=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] dma-mapping: dma-map-ops.h: Remove an outdated comment
Date: Wed, 23 Oct 2024 11:25:44 +0800
Message-Id: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "/* CONFIG_ARCH_HAS_DMA_COHERENCE_H */" was an description about the
ARCH_HAS_DMA_COHERENCE_H configure option, but it has been removed since
the dma_default_coherent variable was lifted from the mips architecture
to the driver core. Therefore it doesn't match any compile guard now.
Just remove it.

Fixes: 6d4e9a8efe3d ("driver core: lift dma_default_coherent into common code")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 include/linux/dma-map-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..7689f6fb4148 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -271,7 +271,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return true;
 }
-#endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
+#endif
 
 /*
  * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
-- 
2.34.1


