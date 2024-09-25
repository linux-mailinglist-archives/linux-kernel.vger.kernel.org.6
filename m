Return-Path: <linux-kernel+bounces-339246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6A9861A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10CD28C015
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DD4963C;
	Wed, 25 Sep 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkDGMSw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6D481AA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274720; cv=none; b=XG2xFYykjzZZgwCfe022GO+QWf8yOmRAfOufmGfghh/o0FZYIGLbcRlRiuFy6anRSkGW5meyOzkw/lodCQgsTcaibcS2c9gLG25stDSd/0FscWCv48KHe8dU1mGywSsbfOG1TvJm2R3fIv8U/WHWjjXJGgpYRnIC11eM9QrYAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274720; c=relaxed/simple;
	bh=ZYvitAm60TX8CTZYTj/7uE0l3I/AkI5AAxcOZWATK6U=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=NPAbY9e0LR/KHzoHGVwxisEIjzEX4uXFJCDX4oBMfaIySE7KmI22igRlsBEuhlNnLhKEuOQ0DysC7b0w2Zyk3UQFIeeRIKDx0ZKDl5jPzHZL3OIjKpKrYbQVF47fYnuMjpUk8ns9507IE5l10ioDnGFdNN7YmBcpOl6DB6mYijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkDGMSw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA7FC4CEC3;
	Wed, 25 Sep 2024 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727274719;
	bh=ZYvitAm60TX8CTZYTj/7uE0l3I/AkI5AAxcOZWATK6U=;
	h=Date:From:To:Cc:Subject:From;
	b=CkDGMSw52Peoi2NECGcqxhh2t141g1fw+6ZQa8O8BaOHDMHABLhnw6qbgsusvd0tB
	 tZRapZXO3nImGufEODsgEbHJjpMn5mgExG0ITLLeiV9z5Xxvlre1FT/k5TZXPBZc8A
	 xZ9SpC4RHRUyHfnntL6gSK27TPh5Wbo67C8epMrRQk6mbOPsOh302b50TJJeOK/2NR
	 ugX8Bdpbk9UdnKz7FKhdLvESBLre2y8ZBsXzQR0BisD0HIBSXZXzKeE2ifEubpwwRU
	 zPWZm58G5n6x60gFy0Mrxq0xqQbqlEMeEZS7rrD/gcxHNwIark7iJTkz+0SSgPF7+2
	 WA8TLpNyiTtKQ==
Date: Wed, 25 Sep 2024 23:31:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui
 <cuigaosheng1@huawei.com>, Masami Hiramatsu (Google) <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] probes: Updates for v6.12
Message-Id: <20240925233156.20824ba2b21ff5d9a22c2baa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes updates for v6.12:

- uprobes: make trace_uprobe->nhit counter a per-CPU one
   This makes uprobe event's hit counter per-CPU for improving
   scalability on multi-core environment.

- kprobes: Remove obsoleted declaration for init_test_probes
   Remove unused init_test_probes() from header.

- Raw tracepoint probe supports raw tracepoint events on modules.
   The tracepoint events using fprobe were introduced in v6.5, but
   tracepoints can be compiled in modules. This supports such a case.
   This includes the following improvements.
  . tracepoint: add a function for iterating over all tracepoints in
    all modules.
  . tracepoint: Add a function for iterating over tracepoints in a
    module.
  . tracing/fprobe: Support raw tracepoint events on modules.
  . tracing/fprobe: Support raw tracepoints on future loaded modules.
     This allows user to add tracepoint events on modules which is
     not loaded yet.
  . selftests/tracing: Add a test for tracepoint events on modules.


Please pull the latest probes-v6.12 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.12

Tag SHA1: 66af4af443ef76c214c5751c162ea058ae05bd1f
Head SHA1: 4e78dd6b4c27c5a6d057f179ff6c1ddd75a7a2ab


Andrii Nakryiko (1):
      uprobes: turn trace_uprobe's nhit counter to be per-CPU one

Gaosheng Cui (1):
      kprobes: Remove obsoleted declaration for init_test_probes

Masami Hiramatsu (Google) (5):
      tracepoint: Support iterating over tracepoints on modules
      tracepoint: Support iterating tracepoints in a loading module
      tracing/fprobe: Support raw tracepoint events on modules
      tracing/fprobe: Support raw tracepoints on future loaded modules
      sefltests/tracing: Add a test for tracepoint events on modules

----
 include/linux/kprobes.h                            |   9 --
 include/linux/tracepoint.h                         |  20 +++
 kernel/trace/trace_fprobe.c                        | 179 +++++++++++++++------
 kernel/trace/trace_uprobe.c                        |  24 ++-
 kernel/tracepoint.c                                |  42 +++++
 tools/testing/selftests/ftrace/config              |   1 +
 .../test.d/dynevent/add_remove_tprobe_module.tc    |  61 +++++++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   1 -
 8 files changed, 275 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

