Return-Path: <linux-kernel+bounces-210588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F269045ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244A61C23491
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258C152DF7;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FCB657
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138772; cv=none; b=DZCGBv+KeYWlTHwxDlsbqXrmjXSSM/u8qRxmybjbVZMi+DrK0fJFQZK3gvmksNh/Z2klZbBxMkJE9xCB6P64f8RN08kpQu5xOkrFtuMCAeyPQPiBgHFlJIVvhJdkcN9gQCPWYnpZN88LaAij9+CJ3NERqglfVQDsW9iNZUjyfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138772; c=relaxed/simple;
	bh=a6E3Q+qwNID4n+DlWnK3JrFxwFud17ExELicvwTVY9A=;
	h=Message-ID:Date:From:To:Cc:Subject; b=o3WXimSeGdWfFqbCsCQEdExxJjaAi7I+thCDgTW54r/s9GOTx3vjCTJEj3ie4ypaABEtAfwTYe3mNTgsHSTYuLG1kuMf1Gd7vK+LvQkb2Gjsvsp4zFvgsJ3SvyEm3uLTtELfYa2ZLAsoEw8qAwGS3aIGr3wChGxw7xEVBVn9CB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EB7C2BD10;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH8Nw-00000001V29-1vzN;
	Tue, 11 Jun 2024 16:46:28 -0400
Message-ID: <20240611204554.092271761@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 16:45:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] ftrace: Changes for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 9b5a45eb639c46c0374b5e040e6e6db386909676


Marilene A Garcia (1):
      ftrace: Add missing kerneldoc parameters to unregister_ftrace_direct()

Steven Rostedt (Google) (3):
      function_graph: Make fgraph_update_pid_func() a stub for !DYNAMIC_FTRACE
      function_graph: Fix up ftrace_graph_ret_addr()
      function_graph: Everyone uses HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, remove it

----
 Documentation/trace/ftrace-design.rst | 12 -------
 arch/arm64/include/asm/ftrace.h       | 11 ------
 arch/csky/include/asm/ftrace.h        |  2 --
 arch/loongarch/include/asm/ftrace.h   |  1 -
 arch/powerpc/include/asm/ftrace.h     |  2 --
 arch/riscv/include/asm/ftrace.h       |  1 -
 arch/s390/include/asm/ftrace.h        |  1 -
 arch/x86/include/asm/ftrace.h         |  2 --
 include/linux/ftrace.h                |  2 --
 kernel/trace/fgraph.c                 | 65 ++++++++++++-----------------------
 kernel/trace/ftrace.c                 |  2 ++
 kernel/trace/ftrace_internal.h        |  4 +++
 12 files changed, 28 insertions(+), 77 deletions(-)

