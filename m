Return-Path: <linux-kernel+bounces-361574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659B99A9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D738D2849CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0591C2439;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E61BDAA0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=MDS0+zoTWkO/6RqTJh5DtuYNxbiO2b4fSxu+ABE2NnCIFyPOm+rEtUKuuCtAf4Z4MYrFBKdMnLcbB2uRSzPJLMWozdWqLktHmY7H0IxfG48kem+ZofAniTXTGIbMwAx8KbiH1aiJk7atam+ZKJmidn3VTULZPm8B1W6PThFrHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=8bjnbpyGuTuPAyqYprEmWKu3zOa5bj44HU35eTt/2Fs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QaJ6AYpLiqYGb1UcUhT1Uu5yc74+pxq3fXBUxS9H1wDGowNLOVN8titV/QO6FaYxElJTIyB1sb0lQVlZJx5kEC94u+N4B8TMTQgfNR7LUHRJzP6717KUzU7uMh7M55YAAGWRd83LIZbnRqKMISPcnnANwdNNcTe1GXHCCy1t9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA62EC4CEC3;
	Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001Tzp-2CYP;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173028.386283930@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Kreimer <algonell@gmail.com>
Subject: [for-next][PATCH 4/9] rv: Fix a typo
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240911114349.20449-1-algonell@gmail.com
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index dc819aec43e8..279c70e1bd74 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -41,7 +41,7 @@
  * per-task monitor, and so on), and the helper functions that glue the
  * monitor to the system via trace. Generally, a monitor includes some form
  * of trace output as a reaction for event parsing and exceptions,
- * as depicted bellow:
+ * as depicted below:
  *
  * Linux  +----- RV Monitor ----------------------------------+ Formal
  *  Realm |                                                   |  Realm
-- 
2.45.2



