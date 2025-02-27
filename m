Return-Path: <linux-kernel+bounces-535192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96466A47004
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76BB1889DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D6D27E;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87254C62
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615132; cv=none; b=c3noZt9sKjhJKTZ43GycLQXgyUVY4kJfmWmP9EzKTxA86UJL7YkHzBK/euGs0bofrQtTK+uXtH2hFSmU4FSlO7TZ2WAkVnxaCVapZlsMxnJxlVq1XPilZTLH8k74FQD72p1N0tgrpQgIm4onXR1VrY5yIZM1Y/fmi1qK4pZ9XWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615132; c=relaxed/simple;
	bh=BkNetgugt5reo6QpyCv2tYgVQjHU6Uwd2sGZ3C2zTH8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ZQMT24OCTtHw74H9I0HsqT2xqKi9It1pF8x74uL1d/PLLXnqD+/w+4GS9DdaT58I1QBhck+QDnfieOB3UZwMBRSLVKyAH0dRV8qmhwIxom7OaY9mKAYMNmXLTPTRq/MdTBE9Pd+dVrj0nbmh7jfR48pNWqaHALFM1Gq4rEmQyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638B9C4CED6;
	Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnRWI-00000009XQ2-13fI;
	Wed, 26 Feb 2025 19:12:54 -0500
Message-ID: <20250227001235.355892523@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Feb 2025 19:12:35 -0500
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

Head SHA1: 77feaf4a2efb078f4f8c703dce5918c0ce08b7e9


Masami Hiramatsu (Google) (2):
      mm/memblock: Add reserved memory release function
      tracing: Freeable reserved ring buffer

Steven Rostedt (1):
      tracing: Add traceoff_after_boot option

----
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++
 include/linux/mm.h                              |  1 +
 kernel/trace/trace.c                            | 24 ++++++++-
 kernel/trace/trace.h                            |  1 +
 mm/memblock.c                                   | 66 ++++++++++++++++++++-----
 5 files changed, 88 insertions(+), 13 deletions(-)

