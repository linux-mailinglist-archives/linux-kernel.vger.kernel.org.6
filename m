Return-Path: <linux-kernel+bounces-546053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F077FA4F5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B4716F00B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E9189919;
	Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F633993
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146631; cv=none; b=If06bO7HIO4aQ6h0ftl890S/kLUVUlJ2ubDa78Rm2VUISbS2LsSsrhy1QyBBPgz/Ru2eNpuH2QX60+EkoD7xXlR7+aS6+T6MUD+PbY2ZmnqSLirQ++wU29f0aoxLS4XS4xfWS747+g1Fc7fizgqF1bEtMBr7vx36Xyr9DAHxE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146631; c=relaxed/simple;
	bh=gHQNLknaosrOn54fkvl4rmdQiUD4RTMAV+6yX7BebFQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rpC/MTeKzPhhGB7yoP529waH5Pj/Bf21h9oqSENn1vU2f8qKaH1Q7+VFJj59ODSu442R5Xu+fw+N979WfbJQRrckHCGS7pfAnAbgn4825HgO80PEQLZTUp5nIjfarrMK4JOHiKIOnEs1527ZFeesrHdKdZktLIKWT+xJ91w7e7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4879C4CEE2;
	Wed,  5 Mar 2025 03:50:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpfn5-0000000CYUS-1g5p;
	Tue, 04 Mar 2025 22:51:27 -0500
Message-ID: <20250305035127.253015650@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 22:51:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Haiyue Wang <haiyuewa@163.com>
Subject: [for-next][PATCH 1/6] fgraph: Correct typo in ftrace_return_to_handler comment
References: <20250305035107.307030265@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Haiyue Wang <haiyuewa@163.com>

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250218122052.58348-1-haiyuewa@163.com
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5dddfc2149f6..8d925cbdce3a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -865,7 +865,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 }
 
 /*
- * After all architecures have selected HAVE_FUNCTION_GRAPH_FREGS, we can
+ * After all architectures have selected HAVE_FUNCTION_GRAPH_FREGS, we can
  * leave only ftrace_return_to_handler(fregs).
  */
 #ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
-- 
2.47.2



