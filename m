Return-Path: <linux-kernel+bounces-574454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F26A6E58C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88461896E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA641DF72C;
	Mon, 24 Mar 2025 21:17:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1D18EB0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851075; cv=none; b=hJFYfUuJNkjrlDCNkt3m71hCHku8XUCn36Jog2jFkNR7b0VSPaewZoipwNskdXneBY5gtdAVRSziXlwr190FE9d97jXfTbkKVHI/mF6ujJt9P0+k4UGvUyZvPVYkF7arv6rIyc8P6JfDz7fgHNMSg928DboN4dGaebI7xHLc3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851075; c=relaxed/simple;
	bh=7fEdp7o09t9k7tD+M3R/5f9+f+JyWga4Vv6vW5YSgJI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Y7J6l6iAOdq7UZv22fvzjAGX+yJT6LMIX6Ocyaco4fIj5x1tmRH9MgDYv5Hi9bD0x0CfzSCDBbiaDGlUg5YoDJwklw9vB9MnWycFHsNc6yXpssoP7AOLfC5cqaMiviWmiGRLxwhpat15eZWsWl/WZxm/0tAaG3VAzYWx8y43fD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5345C4CEDD;
	Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twpBt-00000002AcJ-0b5f;
	Mon, 24 Mar 2025 17:18:37 -0400
Message-ID: <20250324211821.731702961@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 24 Mar 2025 17:18:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] ftrace: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 391dda1bd7c56de62b96126214f040fe8965561b


Jiapeng Chong (1):
      function_graph: Remove the unused variable func

Sasha Levin (1):
      tracing: Use hashtable.h for event_hash

Tengda Wu (1):
      tracing: Fix use-after-free in print_graph_function_flags during tracer switching

----
 kernel/trace/trace_functions_graph.c |  4 +---
 kernel/trace/trace_irqsoff.c         |  2 --
 kernel/trace/trace_output.c          | 19 +++++++------------
 kernel/trace/trace_sched_wakeup.c    |  2 --
 4 files changed, 8 insertions(+), 19 deletions(-)

