Return-Path: <linux-kernel+bounces-288308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E89538A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E291C23C06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294851BB694;
	Thu, 15 Aug 2024 16:57:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D72A8D0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741075; cv=none; b=mn2ADd+/936m3xwXiKnEmUhBwSB9KSXsHn8j5fTC0sXNvcuF2RvZqlI6iUMncqunvjUU16l9j5TEqcwlksx27nOTBpcZSQMgHdeWHMtQ4f7HVGiuViht6wZzGWYGOOcYrfZdRL7iWJ5CN+HUan196FrlApV12X9UdmaTPIJ2WHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741075; c=relaxed/simple;
	bh=sqbfQHWKOzJEmm+CKEgibVGeRBjn0P9QkylGrQOWQ+Y=;
	h=Message-ID:Date:From:To:Cc:Subject; b=EUdzr1AKjRtN3k6+qGEJtWCjGPQ3FBcZwwdlhHNrSDb6RKISdEtk/IQ538rA3SM1MehEW+THe5+tev265LJOk92v54SKvv8qtSwFbPMqpG5m+YdsVqz2rj+JPUJ6PTh5sGJsj6KJYwX0QFErdfLzLWS3HbutQIXjiZIeG5vOwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863D8C32786;
	Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sednf-00000001uKU-3xS7;
	Thu, 15 Aug 2024 12:58:11 -0400
Message-ID: <20240815165744.699054530@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 15 Aug 2024 12:57:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] ring-buffer: Updates for 6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 4c57d0be528b1255abe61d8277f3213d4d22e85f


Steven Rostedt (2):
      tracing: Fix ifdef of snapshots to not prevent last_boot_info file
      tracing/fgraph: Have fgraph handle previous boot function addresses

Steven Rostedt (Google) (1):
      tracing: Allow boot instances to use reserve_mem boot memory

----
 Documentation/admin-guide/kernel-parameters.txt | 13 ++++++++++++
 kernel/trace/trace.c                            | 27 ++++++++++++++++---------
 kernel/trace/trace_functions_graph.c            | 23 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 15 deletions(-)

