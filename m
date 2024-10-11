Return-Path: <linux-kernel+bounces-361572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E199A9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F861F24D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC61BE854;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9A1A08A4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667817; cv=none; b=LrYMgjDgKWf1ZEPZ0FEOVunZodmbTIj4zUrPxIdwdwZVpMeQBXTJyqGc5nLP2PzuCtL73RCcsTwiBGvgYnexUD7VJogFwZxvtHlaEwoNBi+0jqthmFKDNuwu1442WRE5Afnu5Gd6m8GD/yE/nSSRrtM/ThO4EZCHuE3KEX8BPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667817; c=relaxed/simple;
	bh=YhTHPp8Isk7CCUxeNhc9BZXlsJGwPlLmA9rrxx++YAo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=FA5s+wHGVFsnvCq7ifkEJE/Px/akSiufxc9ikIzzxeDAwJr0u+T92ZalsxCO3YrpcVKoKOdpW9mzVhEZf+B1p6tRWSsF79VMbzWXAOwqUGORV2yUk8tqObhCaA50w0DpTM/8tIeyihg5Il1l59tEGc8DF29a/LjH3BAIq7MuUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCD2C4CEC3;
	Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJT9-00000001Txr-3iCa;
	Fri, 11 Oct 2024 13:30:27 -0400
Message-ID: <20241011173010.441043942@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/9] rtla: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 76b3102148135945b013797fac9b206273f0f777


Andrew Kreimer (1):
      rv: Fix a typo

Ba Jing (2):
      tools/rv: Correct the grammatical errors in the comments
      tools/rv: Correct the grammatical errors in the comments

Eder Zulian (1):
      rtla: use the definition for stdout fd when calling isatty()

Gabriele Monaco (1):
      rtla: Fix consistency in getopt_long for timerlat_hist

Jan Stancek (2):
      tools/rtla: drop __NR_sched_getattr
      tools/rtla: fix collision with glibc sched_attr/sched_set_attr

Tomas Glozar (2):
      rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
      rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long

----
 kernel/trace/rv/rv.c                   |  2 +-
 tools/tracing/rtla/src/osnoise_top.c   |  2 +-
 tools/tracing/rtla/src/timerlat_hist.c | 20 +++++++++----------
 tools/tracing/rtla/src/timerlat_top.c  | 10 +++++-----
 tools/tracing/rtla/src/utils.c         | 36 +++++++++++++++-------------------
 tools/tracing/rtla/src/utils.h         |  2 ++
 tools/verification/rv/src/in_kernel.c  |  4 ++--
 tools/verification/rv/src/trace.c      |  2 +-
 8 files changed, 38 insertions(+), 40 deletions(-)

