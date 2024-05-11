Return-Path: <linux-kernel+bounces-176438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE108C2FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D93A1F2278D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC93F1847;
	Sat, 11 May 2024 06:44:48 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F1EC2
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409888; cv=none; b=MEqZTs7nXAeDvzv3um7EcNfhojlxydTNre3u7mHV8eJw9+BTnv6eaLpteuMvpdvB2hqevEHenZdeRC7Wv36uaNOBx0SVGi3GM10nBxJXXRM3aUA0Pfk3mGwOooVI9AmPUaAhsG/33+cPMeN0yACTK08ej4OJcLH5OAa/dGQ09UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409888; c=relaxed/simple;
	bh=WsNHsd+jz9I274qS7nFlFQWVmYolB0GcoLoyQbUvVMo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ueDMxoqDPDVVkcbZ+mEUawr5hcY99X9Dn3UNxJqUh8Uc2cgatOW7Me4kRUnSkiXQqUImBhfwd2MEiz/1L0IgM7s/nDhO77814rhjJ5C3I1cTVACfZh1A1MQo6mHijCzTU8pVnhb/90wuRz7QCUtp9JUof5r5BZJF4ms1f2qqh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Vbx7X5tphz8XrXG;
	Sat, 11 May 2024 14:44:40 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 44B6iY3k075463;
	Sat, 11 May 2024 14:44:34 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 11 May 2024 14:44:36 +0800 (CST)
Date: Sat, 11 May 2024 14:44:36 +0800 (CST)
X-Zmail-TransId: 2afb663f13d40bb-06f01
X-Mailer: Zmail v1.0
Message-ID: <20240511144436754EiKfJM4xjMSTyCbEExwcL@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <david@redhat.com>, <willy@infradead.org>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0gbW0vaHVnZV9tZW1vcnk6IG1hcmsgcmFjeSBhY2Nlc3Mgb27CoGh1Z2VfYW5vbl9vcmRlcnNfYWx3YXlz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 44B6iY3k075463
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 663F13D8.001/4Vbx7X5tphz8XrXG

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

huge_anon_orders_always and huge_anon_orders_always are accessed
lockless, it is better to use the READ_ONCE() wrapper.
This is not fixing any visible bug, hopefully this can cease some
KCSAN complains in the future.
Also do that for huge_anon_orders_madvise.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/huge_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..6573430ea600 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
 	 * So we don't need to look at huge_anon_orders_inherit.
 	 */
 	return hugepage_global_enabled() ||
-	       huge_anon_orders_always ||
-	       huge_anon_orders_madvise;
+			READ_ONCE(huge_anon_orders_always) ||
+			READ_ONCE(huge_anon_orders_madvise);
 }

 static inline int highest_order(unsigned long orders)
-- 
2.15.2

