Return-Path: <linux-kernel+bounces-444712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A89F0B66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DA9188388D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29451DFE36;
	Fri, 13 Dec 2024 11:35:32 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AE1DE899;
	Fri, 13 Dec 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089732; cv=none; b=FOldc7ORvXSsrLJ9n2QzKVbrOhhd0jpS3zSFx2qx79WBMtVsxR6qUX7/dClJxIpuFbNDrhcUuBMtoycQppL57t7e0AI5vpo6c1RiKpRjzwKWhddxc2VxaMrAOUO9OA44S3R4NyrYzvwnWPCMQfsndYIS5BGr0q4OUkQM73/PSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089732; c=relaxed/simple;
	bh=sQUCe9J8BdQtIT92lnvd4wAHr/Zh7afIUFCoH8PFptw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=U10yTwTpGxA5LPcVZpHJl+qfyf3jh23MkpLeJEu4qDbTedK7yxVKOH9O5mOvXuxj2y2qgck5elTLPb1jRsP0Zwho8nrzSv5dATZllwJeAKmHJjM+DqGNfryRZ5VOsW9df/sM4HLy7LALTNVU3/EczHK8yZdKpDbuXJT5pTh8XqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Y8nB82zcMz1DDT;
	Fri, 13 Dec 2024 19:27:28 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Y8nB30nMdzBRHKP;
	Fri, 13 Dec 2024 19:27:23 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Y8n9t1DG0z5B1KQ;
	Fri, 13 Dec 2024 19:27:14 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Y8n9d6Whmz50FXL;
	Fri, 13 Dec 2024 19:27:01 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 4BDBQvZo004681;
	Fri, 13 Dec 2024 19:26:57 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 13 Dec 2024 19:27:00 +0800 (CST)
Date: Fri, 13 Dec 2024 19:27:00 +0800 (CST)
X-Zmail-TransId: 2afd675c1a04ffffffffc14-1f4ed
X-Mailer: Zmail v1.0
Message-ID: <20241213192700771XKZ8H30OtHSeziGqRVMs0@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <bsingharora@gmail.com>, <akpm@linux-foundation.org>, <david@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIGRlbGF5YWNjdDogdXBkYXRlIGRvY3MgYW5kIGZpeCBzb21lIHNwZWxsaW5nIGVycm9ycw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4BDBQvZo004681
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 675C1A1F.000/4Y8nB82zcMz1DDT

From: Yaxin Wang <wang.yaxin@zte.com.cn>

Update delay-accounting.rst to include the 'delay max' in the output
of getdelays, and fix some spelling errors before.

Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
Some fixes according to:
https://lore.kernel.org/all/20241203170816.3fe81941fe1866ca1672eba8@linux-foundation.org/
1.fix some spelling errors
2.update Documentation/accounting/delay-accounting.rst

 Documentation/accounting/delay-accounting.rst | 42 +++++++++----------
 kernel/delayacct.c                            |  2 +-
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index f61c01fc376e..8a0277428ccf 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -100,29 +100,29 @@ Get delays, since system boot, for pid 10::
 	# ./getdelays -d -p 10
 	(output similar to next case)

-Get sum of delays, since system boot, for all pids with tgid 5::
+Get sum and peak of delays, since system boot, for all pids with tgid 242::

-	# ./getdelays -d -t 5
+	bash-4.4# ./getdelays -d -t 242
 	print delayacct stats ON
-	TGID	5
-
-
-	CPU             count     real total  virtual total    delay total  delay average
-	                    8        7000000        6872122        3382277          0.423ms
-	IO              count    delay total  delay average
-                   0              0          0.000ms
-	SWAP            count    delay total  delay average
-                       0              0          0.000ms
-	RECLAIM         count    delay total  delay average
-                   0              0          0.000ms
-	THRASHING       count    delay total  delay average
-                       0              0          0.000ms
-	COMPACT         count    delay total  delay average
-                       0              0          0.000ms
-	WPCOPY          count    delay total  delay average
-                       0              0          0.000ms
-	IRQ             count    delay total  delay average
-                       0              0          0.000ms
+	TGID    242
+
+
+	CPU         count     real total  virtual total    delay total  delay average      delay max
+	              239      296000000      307724885        1127792          0.005ms     0.238382ms
+	IO          count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms
+	SWAP        count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms
+	RECLAIM     count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms
+	THRASHING   count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms
+	COMPACT     count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms
+	WPCOPY      count    delay total  delay average      delay max
+	              230       19100476          0.083ms     0.383822ms
+	IRQ         count    delay total  delay average      delay max
+	                0              0          0.000ms     0.000000ms

 Get IO accounting for pid 1, it works only with -p::

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index d64ad2a48b4f..23212a0c88e4 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -93,7 +93,7 @@ void __delayacct_tsk_init(struct task_struct *tsk)

 /*
  * Finish delay accounting for a statistic using its timestamps (@start),
- * accumalator (@total) and @count
+ * accumulator (@total) and @count
  */
 static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total, u32 *count, u64 *max)
 {
-- 
2.25.1

