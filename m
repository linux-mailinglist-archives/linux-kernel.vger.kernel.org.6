Return-Path: <linux-kernel+bounces-362269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8648F99B2D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A11E1F22060
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0714F9F8;
	Sat, 12 Oct 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5QpuVil"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA120136330
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727716; cv=none; b=dVdnfy9TXKiNM5WbYGuRkHoY8wtmmZyQP8L358CRakmGMekKbbM6Xiej8W4XBUSZMwR2i7JY9lphurW/kGPQrutjVjm48DNCkjmbJdjJ9RN+7gcGktpA4+qqvXmTRmI3PF64esYiDc8A3D0Op42/Wx3rZGMOvYDTIyMYCAt8J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727716; c=relaxed/simple;
	bh=N6Bw5fsGC9GCNUuZay8RwqciLn7iOnxC1DIZKhjaksM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVn18Jv/gXjr5rA6a6ZKWQRiU5EsBGx5qZWOslK1Fm8ct2WqWQekwsegoHC6Q1VOrpcahPu+etrASHfAxu7gvLVY5BvSs+yuFwolHZlp4RdMfvZh8ugPV3M2yzw/vPZ5jqYToQglz+s77zcJdDHQqo7l+ajQan951Z6tY9bG+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5QpuVil; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728727711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M/Z1kGRQ6XK+3dMdtxFQCawe3c47o4mAN4ZYkgDdhuM=;
	b=Y5QpuVilXMS/U8nLbEsOZsS9xUgz4g+cJjVrCXcbEqQoUaOjtT6UjAe1OoNIm6Tc0AkddE
	Ga/wuvBYgor/kskz3EFV12M7I2pbGXZcbi11FGmLXx5gQ5VicbDoT/rFE9UXBHKAHk+ZMC
	677LruiQE54oqeK5ObzZErZHlYiBRAg=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Michael Kelley <mhklinux@outlook.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] scatterlist: fix a typo
Date: Sat, 12 Oct 2024 18:08:17 +0800
Message-Id: <20241012100817.323007-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the 'One' with 'On'.

Fixes: af2880ec4402 ("scatterlist: add dedicated config for DMA flags")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 include/linux/scatterlist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index e61d164622db..c5e2239b550e 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -273,7 +273,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 }
 
 /*
- * One 64-bit architectures there is a 4-byte padding in struct scatterlist
+ * On 64-bit architectures there is a 4-byte padding in struct scatterlist
  * (assuming also CONFIG_NEED_SG_DMA_LENGTH is set). Use this padding for DMA
  * flags bits to indicate when a specific dma address is a bus address or the
  * buffer may have been bounced via SWIOTLB.
-- 
2.34.1


