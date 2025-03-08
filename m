Return-Path: <linux-kernel+bounces-552281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE793A577DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA3F3B5194
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9415667D;
	Sat,  8 Mar 2025 03:26:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB214B96E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404371; cv=none; b=UP2QM57FyKCxqOc/fcPjzjW8dOgoBak4LWs1mX3AbApb12xQzi8KykO9Lq3EaNVQfhwuia2xdK/fauvVpj0MM1hT0Ad0ne+EPois1nlKRu9oEXA3++nq+MWAtIYbUq2VgdN6A3oR7IO/t4xvtInCYgD8ucJHe39cwHZ0PVd/6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404371; c=relaxed/simple;
	bh=3la3ZTuD0xpvId0lrDivu5IdGwMRstaRwemIk2AxhaA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p5OJdy1q0c3NrB9mBEV7dCMLlrYEifK6N5gfzeHuzxF50Zdmisdr/wnCtueJTaRHrMBPOd5toaI+RRd9NafBBooBk8NIgQsIGXxZd0qjcC4a9WQfx/Do1R3RiOsLnoaZnAtMobA+0BibhuSBetsYrh4oD6qm1lXhlKn3MygslXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55757C4CEEC;
	Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqkpJ-00000000Ulp-25Ii;
	Fri, 07 Mar 2025 22:26:13 -0500
Message-ID: <20250308032613.347917964@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 07 Mar 2025 22:24:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 3/3] rv: Add license identifiers to monitor files
References: <20250308032432.109115966@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Some monitor files like the main header and the Kconfig are missing the
license identifier.

Add it to those and make sure the automatic generation script includes
the line in newly created monitors.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/20250218123121.253551-3-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/wip/Kconfig            | 2 ++
 kernel/trace/rv/monitors/wip/wip.h              | 1 +
 kernel/trace/rv/monitors/wwnr/Kconfig           | 2 ++
 kernel/trace/rv/monitors/wwnr/wwnr.h            | 1 +
 tools/verification/dot2/dot2k.py                | 1 +
 tools/verification/dot2/dot2k_templates/Kconfig | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/kernel/trace/rv/monitors/wip/Kconfig b/kernel/trace/rv/monitors/wip/Kconfig
index 3ef664b5cd90..e464b9294865 100644
--- a/kernel/trace/rv/monitors/wip/Kconfig
+++ b/kernel/trace/rv/monitors/wip/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_WIP
 	depends on RV
 	depends on PREEMPT_TRACER
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index 2e373f2c65ed..c7193748bf36 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Automatically generated C representation of wip automaton
  * For further information about this format, see kernel documentation:
diff --git a/kernel/trace/rv/monitors/wwnr/Kconfig b/kernel/trace/rv/monitors/wwnr/Kconfig
index ee741aa6d6b8..d3bfc20037db 100644
--- a/kernel/trace/rv/monitors/wwnr/Kconfig
+++ b/kernel/trace/rv/monitors/wwnr/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_WWNR
 	depends on RV
 	select DA_MON_EVENTS_ID
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index d0d9c4b8121b..0a59d23edf61 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Automatically generated C representation of wwnr automaton
  * For further information about this format, see kernel documentation:
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 7547eb290b7d..153cc14bcca4 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -160,6 +160,7 @@ class dot2k(Dot2c):
 
     def fill_model_h_header(self):
         buff = []
+        buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
         buff.append("/*")
         buff.append(" * Automatically generated C representation of %s automaton" % (self.name))
         buff.append(" * For further information about this format, see kernel documentation:")
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/dot2/dot2k_templates/Kconfig
index 90cdc1e9379e..03100eda1707 100644
--- a/tools/verification/dot2/dot2k_templates/Kconfig
+++ b/tools/verification/dot2/dot2k_templates/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_%%MODEL_NAME_UP%%
 	depends on RV
 	select %%MONITOR_CLASS_TYPE%%
-- 
2.47.2



