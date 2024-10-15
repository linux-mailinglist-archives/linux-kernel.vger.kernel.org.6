Return-Path: <linux-kernel+bounces-366713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3999F901
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ACF1C21C05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C11FBF76;
	Tue, 15 Oct 2024 21:24:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C371F80BC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027445; cv=none; b=I8Pr+js+geUx4N0mpSpJSB1ubpIREz3cbXuGGK5ukzK/Hug+f+K5qGqW9Ca7s0vnyyRregDmyIGjO2iExUHpbMsjqdZWylaIV2zdU7CHN9ppxNklQaxGyVJUnKjcCjvQOZGMOxnp6zg2mVgJcc2an+zVt7WRppurFxPcH61D3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027445; c=relaxed/simple;
	bh=H6uHHdx/l/AO+sEqQ5vFVeWqWgWaQjURHR+kboh8d/U=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bxfVIfInGvLaVmoeoZwzh0xxt6fqmRVxERz+FKKDB0jOMHc3AS9AFN5rxsES4WYsbMaej+DLbrMzk1Nw/t6zsveIEjUYUbeu0FYNesqXKuxbj3GTy6BIqiY75iDD8fdwaJbWuOK3X1X9sjOSVXH4gvbnb1s9zDiq1kIPzLIDD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC36C4CEC6;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0p1k-000000034zR-1pae;
	Tue, 15 Oct 2024 17:24:24 -0400
Message-ID: <20241015212408.300754469@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 17:24:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] ftrace: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 2d17932da44fdc1ba835ad05110ab996d2912dbf


Masami Hiramatsu (Google) (2):
      ftrace: Use arch_ftrace_regs() for ftrace_regs_*() macros
      ftrace: Rename ftrace_regs_return_value to ftrace_regs_get_return_value

Steven Rostedt (1):
      selftests/ftrace: Fix check of return value in fgraph-retval.tc test

----
 include/linux/ftrace_regs.h                                | 14 +++++++-------
 .../selftests/ftrace/test.d/ftrace/fgraph-retval.tc        |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

