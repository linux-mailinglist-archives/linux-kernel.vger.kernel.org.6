Return-Path: <linux-kernel+bounces-183422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9898C98CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F1728215C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCB168B7;
	Mon, 20 May 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n/Oci2z0"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EDD52F;
	Mon, 20 May 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716183768; cv=none; b=Pd6erLiENgTgIwezl9F4LLT0oo5yU7j69uQk1HDJSRFiUlCoLfGYdAKr08oayh5fQLdgDYSbjaZuFYm5haA0WT60vAlcFCDdgKEsWaSBGq+DoW5pIS/7dcQD+4Ds9IzKPejtiVzXcfTCaGiOosPfyax3rPY5GrcoddugsfIJULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716183768; c=relaxed/simple;
	bh=rrxj5CDV8a5jl8H9LjuyaHtxC6maznMOSsHg2w6e7YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A413amO46dnfJOgV/ZOx4oGoH777n8v/bNIhR+KtrOzzKDgOEIM1fl5AJaDfpGh0FY2HLjixxYfVoEN5YAYf0M6n44ot9fCRHeNQQf3ey98uPr9fHwPpYVPyXTLUJD7w8f6IeOz/f5H00O4PBSzXwllpZfmNIovNbH11a6HKy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n/Oci2z0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716183763; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZrUDAK+83eL96IhjYRDyrFMUNm5nZQ72ww7sHH7Xvro=;
	b=n/Oci2z0LkibUswlMnDMf1XEsxaPU5tRFIydvQIIBu8u1VxE6Q6Sg12I32jhKM9GuEsCd7cLbkKS4jOXfws3/8DDnTUqW7wMBcQ8zHravsg5HhVBOP+9HBotOlYiJecULJqiEIpAdpcPK4K7NoD/1bTaLPYM+UpeumsjsP53jFA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6mQHf5_1716183761;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6mQHf5_1716183761)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 13:42:42 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bristot@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] rv: Update rv_en(dis)able_monitor doc to match kernel-doc
Date: Mon, 20 May 2024 13:42:39 +0800
Message-Id: <20240520054239.61784-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates the function documentation comment for
rv_en(dis)able_monitor to adhere to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/rv/rv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2f68e93fff0b..df0745a42a3f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
@@ -256,6 +257,7 @@ int rv_disable_monitor(struct rv_monitor_def *mdef)
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
-- 
2.20.1.7.g153144c


