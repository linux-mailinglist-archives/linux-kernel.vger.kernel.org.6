Return-Path: <linux-kernel+bounces-544740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C54A4E47D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155DD17E827
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41432857CE;
	Tue,  4 Mar 2025 15:36:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77256281376;
	Tue,  4 Mar 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102591; cv=none; b=Ss+mRj77joXZv/I+dPzLwe4YXiYLh91R+3R5eDVz6Gsb7FgimlG1A+Ivc+/Bp++CU7OHV5zn/kZYnzGgypjujNmo528imETeOn1Pip/ZF+uwDpEVDt8jQF1o7kp77TSgJ8LP8yhxap18Dolmr/Wp0QFPax+DqaoJvHlXHagwogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102591; c=relaxed/simple;
	bh=tSynnfCl+qgL/CFGDBo3wiUx8w791HmiuNgz26+G8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hyyirDZauHIKHJJ3O3O9/yoY5KwcAU6XbsOk7Hz9+Q9j2rVdlchCY5URvtJkNYMUFgGSfW/NoSmkfUZ+FnR1jOmoYwl++JX0nQVxhkoV/JV74ZWzqoTAUYNHvHAFF4LYNq4UfjU/bZP4RuFsutBOAss0DuuyLHmARK/cdzX0Hv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557E2C4CEE5;
	Tue,  4 Mar 2025 15:36:30 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:37:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: [PATCH] tracing: Update MAINTAINERS file to include tracepoint.c
Message-ID: <20250304103724.174ecb36@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Updates to the tracepoint.c file should not only be Cc'd to LKML, but also
to linux-trace-kernel@vger.kernel.org. But because it is not listed in the
MAINTAINERS file, it does not get added.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..c203aa4225b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24063,6 +24063,7 @@ F:	fs/tracefs/
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	kernel/tracepoint.c
 F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
-- 
2.47.2


