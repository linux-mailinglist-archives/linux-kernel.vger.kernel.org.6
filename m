Return-Path: <linux-kernel+bounces-186815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED38CC99B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F37B282C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2014BFBF;
	Wed, 22 May 2024 23:28:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6A14B95C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420510; cv=none; b=mwpV+o7i+Wgp3VUyTOXm1w/hV3U/2eW3ei29gK9ef6knjT2tkwgYJPExCLwrbOpUNTCvDgDJGUaWOrBE9cZ9Pk8a5egeZil3IF8fmo2Pfzz8J2/jJYrkPcSxPzeO9Mb0f5J95Bs+PoVWsVr5gSkU2nPvy86orIqubNyEIr4ZnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420510; c=relaxed/simple;
	bh=t6ahul2U+kOwbq364k5bg28EYDgtbYGGA0cwn8yA8/Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LETQRv/HQ1HTew3vl/hP4B0cJClLaZ7WvLTBe6p3CowHmUWGEK8u29/6NW8sn4urtouS6kQRX6wyBliAu4mM1pasTzhGVwQCg4MhyY75YhHEGB85yg1HqbNP6gEVnd27/DJDrj7ebN4VHcCB2nqwCaqC3+2VXaMSU5dZtTFfMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1468C3277B;
	Wed, 22 May 2024 23:28:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9vOT-00000006Qj1-271l;
	Wed, 22 May 2024 19:29:13 -0400
Message-ID: <20240522232913.363451688@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 19:28:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Subject: [for-linus][PATCH 4/4] rv: Update rv_en(dis)able_monitor doc to match kernel-doc
References: <20240522232851.522913754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yang Li <yang.lee@linux.alibaba.com>

The patch updates the function documentation comment for
rv_en(dis)able_monitor to adhere to the kernel-doc specification.

Link: https://lore.kernel.org/linux-trace-kernel/20240520054239.61784-1-yang.lee@linux.alibaba.com

Fixes: 102227b970a15 ("rv: Add Runtime Verification (RV) interface")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.43.0



