Return-Path: <linux-kernel+bounces-176436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB98C2FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6C1C21429
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93217F3;
	Sat, 11 May 2024 06:41:09 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC8A41
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409668; cv=none; b=BLSTSpfLNu09l4npyp2kOGPYiTcHYQZbg6KidfWDs+dqr7DCZZi494JYcs0wh807MUmrxJndsWdKrDOcg8xKxfhw+idPaMnUWmf/pT+0MMe+xTR4sPxf4P8Epm3cmLQEvZ80Th84IMuq9NkHB86inSmy29BQM2gv20BDd8tJnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409668; c=relaxed/simple;
	bh=G6PziW8hJ8pKgyhhiGeKEEZGoN9+eMrONYc1lWIMfIc=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=J4NrK7SbbCPIG6tGL9gvox/b/f/qY0qCY3Zs6QbdiAam0gk+bGBGSlH4EEvyvN77XAMaDJH4cX4QvceXtyyJsHG5CfJ/g3fA27Vzjb11sPJ/S6EgAg+enUvzebeA/dbf4fwcDX3mmIDo+4Aw6P0o8Ht4iM7xzun22ysFi7kW/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Vbx3C6SXsz8XrX5;
	Sat, 11 May 2024 14:40:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 44B6ekuN054423;
	Sat, 11 May 2024 14:40:46 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 11 May 2024 14:40:48 +0800 (CST)
Date: Sat, 11 May 2024 14:40:48 +0800 (CST)
X-Zmail-TransId: 2afa663f12f0048-8630a
X-Mailer: Zmail v1.0
Message-ID: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <david@redhat.com>, <willy@infradead.org>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0gbW0vaHVnZV9tZW1vcnk6IHJlbW92ZSByZWR1bmRhbnQgbG9ja2luZyB3aGVuIHBhcnNpbmfCoFRIUCBzeXNmcyBpbnB1dA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 44B6ekuN054423
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 663F12F7.000/4Vbx3C6SXsz8XrX5

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since sysfs_streq() only performs a simple memory comparison operation
and will not introduce any sleepable operation, So there is no
need to drop the lock when parsing input. Remove redundant lock
and unlock operations to make code cleaner.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 mm/huge_memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 89f58c7603b2..87123a87cb21 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -478,32 +478,26 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 	int order = to_thpsize(kobj)->order;
 	ssize_t ret = count;

+	spin_lock(&huge_anon_orders_lock);
 	if (sysfs_streq(buf, "always")) {
-		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
 		set_bit(order, &huge_anon_orders_always);
-		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "inherit")) {
-		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_madvise);
 		set_bit(order, &huge_anon_orders_inherit);
-		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "madvise")) {
-		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_inherit);
 		set_bit(order, &huge_anon_orders_madvise);
-		spin_unlock(&huge_anon_orders_lock);
 	} else if (sysfs_streq(buf, "never")) {
-		spin_lock(&huge_anon_orders_lock);
 		clear_bit(order, &huge_anon_orders_always);
 		clear_bit(order, &huge_anon_orders_inherit);
 		clear_bit(order, &huge_anon_orders_madvise);
-		spin_unlock(&huge_anon_orders_lock);
 	} else
 		ret = -EINVAL;
+	spin_unlock(&huge_anon_orders_lock);

 	return ret;
 }
-- 
2.15.2

