Return-Path: <linux-kernel+bounces-179364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482078C5F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9CA281D42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88076374D2;
	Wed, 15 May 2024 02:58:27 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B28488
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741907; cv=none; b=oy6HMuL6SbCzcorGjUwgCB1AuKvrW3M9+H1fVWcI9qWMNupaHcDXYxFSh0DgJhdU1E/kj7EZS90Pwxy+Y8wF4aZTrFWr9N2o4MyYbQkesOXEez52CgQTh4X9T+MbDcBdC5eULycRMOoS5IOo+xn4XanMaOg4//hQH23Pnx0XaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741907; c=relaxed/simple;
	bh=zeabJBIcDLE+2SfFAsuUcbl7VHyQVDsU/JmrINFi/Ps=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=tWaGPEqRU6ziokl1oI3HZXMsC6mNUK+6PLUlr48vzNEUOSRrfLg63DoqN1MKOd4BgqIiio4AlFvED1BeDLvOnCLLvGeypE8XSJeMIJIeD6mIFEZV7f6ubJZu/iaFrnEKoHFhGZEbmgYrpiUVHA6URqZP621gRXrty5m3NZLAIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4VfHj316jTzCh0l
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:48:23 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4VfHhv6kKDzBRHKQ
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:48:15 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VfHhl0cclz5R9kD;
	Wed, 15 May 2024 10:48:07 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 44F2lr8a003023;
	Wed, 15 May 2024 10:47:53 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 15 May 2024 10:47:54 +0800 (CST)
Date: Wed, 15 May 2024 10:47:54 +0800 (CST)
X-Zmail-TransId: 2afb6644225affffffff811-00028
X-Mailer: Zmail v1.0
Message-ID: <20240515104754889HqrahFPePOIE1UlANHVAh@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <willy@infradead.org>, <ziy@nvidia.com>, <shy828301@gmail.com>
Cc: <yang.yang29@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
        <lu.zhongjun@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggdjJdIG1tL2h1Z2VfbWVtb3J5OiBtYXJrIHJhY3kgYWNjZXNzIG9uwqBodWdlX2Fub25fb3JkZXJzX2Fsd2F5cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 44F2lr8a003023
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 66442276.000/4VfHj316jTzCh0l

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

huge_anon_orders_always is accessed lockless, it is better
to use the READ_ONCE() wrapper. This is not fixing any visible
bug, hopefully this can cease some KCSAN complains in the future.
Also do that for huge_anon_orders_madvise.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lu Zhongjun <lu.zhongjun@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/huge_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..cf7f671aa634 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
 	 * So we don't need to look at huge_anon_orders_inherit.
 	 */
 	return hugepage_global_enabled() ||
-	       huge_anon_orders_always ||
-	       huge_anon_orders_madvise;
+	       READ_ONCE(huge_anon_orders_always) ||
+	       READ_ONCE(huge_anon_orders_madvise);
 }

 static inline int highest_order(unsigned long orders)
-- 
2.15.2

