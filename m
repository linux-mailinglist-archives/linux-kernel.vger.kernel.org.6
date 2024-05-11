Return-Path: <linux-kernel+bounces-176468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD68C3064
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F8E281AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D053814;
	Sat, 11 May 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hHuo8Njs"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEF535BF
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715420170; cv=none; b=BUwsHMYnzuQiDKJxs32CTdi5US/nyDAYAxlKTyXDFp9UIlsHgPEA1t1FOP2S8ZVLj9G5wRlOj4F41OIPooYTxK9GItpof4R0BJMCe/XU3HKIwlTBoZfIdtMZlA1HFxbhkJRR5DCU5itB/J8G6uNQmZJ2Ot6tuBcuRcaDRhPHmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715420170; c=relaxed/simple;
	bh=rAKFwk/efMwW+MeQPuD6PtCCtYxvnbb3HIjziVO2oGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFWpqixWwYwTymp95FP79RI7WWdDNswJj+7uL+hmbv44oYtSbuVT+pSyHsPXEp0yDfaKCbAfarINeFZo7auChw1P02eLhVzhdj+CUHinxOaodTpo+4iOUNnQhlc0XG7DxOQ6c3svjd1mXgQ8MpnSCooRmZMZ8Og4mIW6+qOkeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hHuo8Njs; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715420165; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EUPan2gfDkWp2M5OjKiJ+CMIZSYhzS4bg/90aCLR3Xs=;
	b=hHuo8NjsB9qid0RsOTv7IaJMYnTh70WjqQ3mz6sO1HPhTXFCfZCcBWPQ1TUI7cf7x7Ng5st2bWiKy+rjeXDk9npOA85aKYmEnuiC2lfgK6eZyumDjiUv98ulSccsCnYciB6lP7nFfYw8tDYd/kVm+753GPRW9Nut9SCJPLiq3sM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W6Cv1xp_1715420162;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6Cv1xp_1715420162)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 17:36:03 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] staging: vc04_services: Fix kernel-doc param for vchiq_register_chrdev
Date: Sat, 11 May 2024 17:36:00 +0800
Message-Id: <20240511093600.59180-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To adhere to the kernel-doc specification, use a colon to separate the
parameter name and its description.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 3c63347d2d08..67ba9ceaad3e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -1319,7 +1319,7 @@ static struct miscdevice vchiq_miscdev = {
  *	vchiq_register_chrdev - Register the char driver for vchiq
  *				and create the necessary class and
  *				device files in userspace.
- *	@parent		The parent of the char device.
+ *	@parent:	The parent of the char device.
  *
  *	Returns 0 on success else returns the error code.
  */
-- 
2.20.1.7.g153144c


