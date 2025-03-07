Return-Path: <linux-kernel+bounces-550169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D3A55C23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E483A7952
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F37DA8C;
	Fri,  7 Mar 2025 00:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1225569
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308327; cv=none; b=DZI02O/oKw/sJ5Uck5FkRQHJ0dkpH48vvC/9xG9hhplIrRi/FtMa4TmUtkwQyzSICuWuFPo1Fqh4OOr1K0C8xYSZHgm+iJ9AJek2sPGOAQlEhzTSZgeEL7FFtz+6ZAi3MSuFjDVoNKFwPkddPEIxknvAQLd/9AQyvfu23Tzf2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308327; c=relaxed/simple;
	bh=vzUvP9jLe+7RApDJrgJ9sz0SYLCrqsOQC7nJERMOcWo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=KIlhLVqoSFq9M4MPrL5xLwEpc6/tOejMElqHAqtU430uh80bBLj6jaGHBb2pWY4S3QR3qZYDl21lM2ZDlX/hYGjaj8yUfz9vI3/SZGxOcte7gdCsxCNrSQ35POBvS6d+z/uU8eIwkJeyHsqYURvjjc0qyjmTZMkpSzGdGk36mXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46253C4CEE0;
	Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqLqA-0000000059C-2Spf;
	Thu, 06 Mar 2025 19:45:26 -0500
Message-ID: <20250307004511.688485107@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 19:45:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: d4ae5070733b114b9431a49c9640437f5e8b2ec5


Christophe JAILLET (1):
      tracing/user_events: Slightly simplify user_seq_show()

Steven Rostedt (1):
      tracing: Update MAINTAINERS file to include tracepoint.c

Thomas Weißschuh (1):
      tracing/user_events: Don't use %pK through printk

----
 MAINTAINERS                      | 1 +
 kernel/trace/trace_events_user.c | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

