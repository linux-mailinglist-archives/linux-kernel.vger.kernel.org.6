Return-Path: <linux-kernel+bounces-204816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB738FF3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69F828D905
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326791990BE;
	Thu,  6 Jun 2024 17:35:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176938DC7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695301; cv=none; b=t2GxN61D4CoyDJ6XiexGPDWBZ7lISd4a//g/3WbKJuglxDyO++kcujVF5/1xgX5MTq22QWm9PPj5aVSMIi1/fFanJ7NKkjWesgFPjkuwKAKLdXBbarNBFWlWoEr8kyakiQsYjR/wkyH/+Y1MCzrowrU6IfwBNYs0AJGwIfE4Ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695301; c=relaxed/simple;
	bh=KwoN4Fz5TcJmsOcKVhh2EwjGAOn5StLwFJTBkYl1G6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bYZvbZkN6iQxdiIap+7NAmoMaGyde6O+4ekIvzP7obbBFqYSl1BYVVN5Rd+0BCi4VJTF+L93/8xZd5eL44AOZ+X0zIGAfeMGFiLZiM9aIpdDH8fErhM+7N/3JRfLvM2j8/NGErkNczu87d5qNF2liWrYgYI/nsxQRgOTQtcmnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC0C2BD10;
	Thu,  6 Jun 2024 17:35:00 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:35:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [for-next][PATCH] tracing: Fix trace_pid_list_free() kernel-doc
Message-ID: <20240606133511.7160610b@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 22b639253ec046d66c69c54b9d28bb1bd30f3a7a


Jeff Johnson (1):
      tracing: Fix trace_pid_list_free() kernel-doc

----
 kernel/trace/pid_list.c | 1 +
 1 file changed, 1 insertion(+)
---------------------------
commit 22b639253ec046d66c69c54b9d28bb1bd30f3a7a
Author: Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon May 6 07:22:33 2024 -0700

    tracing: Fix trace_pid_list_free() kernel-doc
    
    make C=1 reports:
    
    kernel/trace/pid_list.c:458: warning: Function parameter or struct member 'pid_list' not described in 'trace_pid_list_free'
    
    Add the missing parameter to the trace_pid_list_free() kernel-doc.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240506-trace_pid_list_free-kdoc-v1-1-c70f0ae29144@quicinc.com
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..19b271a12c99 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -451,6 +451,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 
 /**
  * trace_pid_list_free - Frees an allocated pid_list.
+ * @pid_list: The pid list to free.
  *
  * Frees the memory for a pid_list that was allocated.
  */

