Return-Path: <linux-kernel+bounces-532756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61CA451E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D30173984
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A5154C00;
	Wed, 26 Feb 2025 01:05:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540DE42A9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531937; cv=none; b=TdMOW+tclXHiB2nJTu+/nKPT8Hub2GqU7yYotSyRz64dX1e53YwFlr1ZcCQaltkNd1hcMvdVl2G7WVO+T5uyOkb3sx8d8cEocTdcoAo0qLW5oLbPAYBiE9FFvmbLxdHoxyGYr8+LjvJYHSluCH7v0WI9WBVXSkZmOu6JII/S+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531937; c=relaxed/simple;
	bh=84I/twVNlJ28RKVOmtGJu0t7S2eTz5GsYHlxoUvSGuE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JJDb7tGcor7Zjc4UU9O1564vqh+ShQbQxs/khjTzA+l9nPD6gONvqrkh5qH6e8lpHvlZ3zu3fNKomyO4F+fOwuniKCYbfu1qmjUvnnaN4q1716oz1ja5ylnLAB+siFWXZaAnNLKFHBOoeQGI5/dDtxUtvfmJjkDsPb6Zt4mxFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BC2C4CEDD;
	Wed, 26 Feb 2025 01:05:36 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn5sO-00000009EYF-1h1c;
	Tue, 25 Feb 2025 20:06:16 -0500
Message-ID: <20250226010556.526552688@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 20:05:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] ftrace: scripts/sorttable: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
sorttable/for-next

Head SHA1: dc208c69c033d3caba0509da1ae065d2b5ff165f


Steven Rostedt (4):
      ftrace: Test mcount_loc addr before calling ftrace_call_addr()
      ftrace: Check against is_kernel_text() instead of kaslr_offset()
      scripts/sorttable: Use normal sort if theres no relocs in the mcount section
      scripts/sorttable: Allow matches to functions before function entry

----
 kernel/trace/ftrace.c | 23 +++++++++++++++++------
 scripts/sorttable.c   | 16 +++++++++++++---
 2 files changed, 30 insertions(+), 9 deletions(-)

