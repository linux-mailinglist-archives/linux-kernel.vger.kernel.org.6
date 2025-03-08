Return-Path: <linux-kernel+bounces-552279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2209A577DC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D13177164
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18451547EE;
	Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C43AD4B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404371; cv=none; b=r1kF/iBgdCoNPaAG2s0Mucaukt6b5o7bRy9D6VRhrItlUC/8OTQQjjy5+fEgyJywviP1kw49pcltLljl1QMXmjLSIxm0DgR7x4IT3uUgU+WSmZUgh07drepEEPHxiG+65rnb0Hq+Gave37X58m9tjznWKMMP66leXLbNaoPKtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404371; c=relaxed/simple;
	bh=1k35KY42/7W5+ToXF1WDdti6RIeY44pn/qiYJ3GFNf8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jqXvQOxgpefkQbgghSHUNSkMMsWF/Q2TqbEZBT8a/k0o+jtKnhlJgDjMpg9aO1tSCHs2qNvJqY1pF4qwcftZXRcDdO0GIcK+jHT4WxxTLxFYA+UnwFMQkGyqM0l+i7n2jX8CUA5eu9Mv+mCVaUpGy/PPgHSA69rQ3i4QXxjTnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A90C4CED1;
	Sat,  8 Mar 2025 03:26:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqkpI-00000000UkL-46TG;
	Fri, 07 Mar 2025 22:26:12 -0500
Message-ID: <20250308032432.109115966@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 07 Mar 2025 22:24:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracing: Latency updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
latency/for-next

Head SHA1: 41a4d2d3e3b6fe86bd54cc4c3b731378290a0d00


Gabriele Monaco (2):
      tracing: Fix DECLARE_TRACE_CONDITION
      rv: Add license identifiers to monitor files

Tomas Glozar (1):
      trace/osnoise: Add trace events for samples

----
 include/trace/define_trace.h                    |  7 ++
 include/trace/events/osnoise.h                  | 96 +++++++++++++++++++++++++
 kernel/trace/rv/monitors/wip/Kconfig            |  2 +
 kernel/trace/rv/monitors/wip/wip.h              |  1 +
 kernel/trace/rv/monitors/wwnr/Kconfig           |  2 +
 kernel/trace/rv/monitors/wwnr/wwnr.h            |  1 +
 kernel/trace/trace_osnoise.c                    | 55 +++++---------
 tools/verification/dot2/dot2k.py                |  1 +
 tools/verification/dot2/dot2k_templates/Kconfig |  2 +
 9 files changed, 128 insertions(+), 39 deletions(-)

