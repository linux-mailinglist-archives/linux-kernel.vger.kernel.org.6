Return-Path: <linux-kernel+bounces-564163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE78A64F18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC518904E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FA23A9BE;
	Mon, 17 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyI9QFKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29A23959F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215020; cv=none; b=dctMph8LfXO++w59p3xYxESenKChh7z/4bhxMjJ0unW7pUgYbkrNu3Qmi6OlE3Atdujt5aREewlk6drsgKyzoWDs1AHR8EDu7uCaQo4pmfo8mFKs2eWw4wPjbM6bMNkiX4bWygwCeEmnbHj0c8xNsYchCTWD72K6l/7O9O0PTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215020; c=relaxed/simple;
	bh=wdAdrTTIhxph6P8xOMWnSIdCqGUFHm3B9OhuPUTNQNg=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=oNAe8PNt0Hxo1eIYPweOfofchKvwh7QJuztUGNuYSd05j4hwrEnf/0ykFqu1M/ipn7JTk7s2ywovr1OaYnqKGjEZykh1KVSBzpuYwLic0DY3YC/cFcABwZRM7PcvrpK0o4jjutYrbmNt8Ph156CnpKwT3jeIobKBSCh9e+mWOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyI9QFKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF3EC4CEE3;
	Mon, 17 Mar 2025 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742215020;
	bh=wdAdrTTIhxph6P8xOMWnSIdCqGUFHm3B9OhuPUTNQNg=;
	h=Date:From:To:Cc:Subject:From;
	b=PyI9QFKt65ellLhU4W+1ZGOUrSaI9sQOzmLZ+BFFmQNCfqoQStKvF0nu365ZYt3o6
	 wlS0ApAzzdRweghwlzcGBcSaKd97i9weGHKTtvKVu5sCHl76Z3PTw6s7PhI1+J7BkW
	 OFLOOSyhvlzRyDKPCjeR0HNpTW0AoITuLrPcQ7I3rTM2D9euAXqpBpMYjc8zsPfiVB
	 7qpeTGRLBXaHotZEYahx8CdxA2FFUdrEEfGIbuyvk7ZvivwznxAfbfBxdMk834Q3t1
	 mkVM57F7WOf2d++76VKYlJgx9iO7LMVOJoORog4bqlUVZWvlRasyERjGu78s+pw5KU
	 OlV5+2LnYc+Yw==
Date: Mon, 17 Mar 2025 21:36:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.14-rc6
Message-Id: <20250317213656.3c684cdad49b4751d623fb77@kernel.org>
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

Probes fixes for v6.14-rc6:

- tprobe-events: Fix to clean up tprobe correctly when module unload
  tprobe (Tracepoint probe) event does not set TRACEPOINT_STUB to its
  'tpoint' pointer when unloading module, thus it is shown as a normal
  'fprobe' instead of 'tprobe' and never comes back.
- tprobe-events: Fix leakage of module refcount
  When a tprobe's target module is loaded, it gets the module's refcount
  in the module notifier but forgot to put it after registering the probe
  on it. Fix to get the refcount only when registering tprobe.


Please pull the latest probes-fixes-v6.14-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.14-rc6

Tag SHA1: 74f50e8db2a9d8eb99f1dd8b8286d11bb4099f97
Head SHA1: ac91052f0ae5be9e46211ba92cc31c0e3b0a933a


Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to clean up tprobe correctly when module unload
      tracing: tprobe-events: Fix leakage of module refcount

----
 kernel/trace/trace_fprobe.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

