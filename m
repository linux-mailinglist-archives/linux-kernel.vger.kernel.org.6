Return-Path: <linux-kernel+bounces-420344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 756029D7930
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D23E162EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A72188907;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FA2500BD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=m87wZthjZrMVUgA0I6nj7MRn962XOWzyhmHgdjUXQIwstElWmdOXTZuQ/mKJUJA7UwkP7AoVlybMyL3smfPh0bVJ6xJxsYBXChVs+RkmO2ShTzQc4NYS3kQA9hYCdMwfPx2riSaQSO3f4EGR80xQfgTbuwzOXnuGc+/O9ny2sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=A60pLmrFlf33ViNTep1IvpJ9/R0k4yfQ/PAdr/rjsZE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=phhu86jvf4v7ZWTW0S95Ahup4enft2tVi6HR5aweQwdam34G4p9jPYhmF9oRyntxOIdV6K3tYlM1zku6Vi3cAI/ppVKh/GyBjmcCAEMOFSTyfkbAWHMoskEh3w5nlJkNM59kn3zEtMx/AsdG0nbmjSqrrc1LSWIyHO2Jw27IWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CF4C4CECC;
	Sun, 24 Nov 2024 23:49:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMs-00000006vif-2PRj;
	Sun, 24 Nov 2024 18:50:18 -0500
Message-ID: <20241124234940.017394686@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Last minute updates for v6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: ef0d4186083127d2f99ed04e051fd94ba061d253


Mathieu Desnoyers (5):
      tracing: Move it_func[0] comment to the relevant context
      tracing: Remove __idx variable from __DO_TRACE
      rcupdate_trace: Define rcu_tasks_trace lock guard
      tracing: Remove conditional locking from __DO_TRACE()
      tracing: Remove cond argument from __DECLARE_TRACE_SYSCALL

Thomas Gleixner (1):
      tracing: Record task flag NEED_RESCHED_LAZY.

----
 Documentation/trace/ftrace.rst |  4 +++
 include/linux/rcupdate_trace.h |  5 +++
 include/linux/trace_events.h   |  1 +
 include/linux/tracepoint.h     | 70 +++++++++++++++---------------------------
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_output.c    | 14 ++++++++-
 6 files changed, 49 insertions(+), 47 deletions(-)

