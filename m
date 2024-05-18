Return-Path: <linux-kernel+bounces-182747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA6D8C8F44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326E7B2183E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7ED125BA;
	Sat, 18 May 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG1JA1u7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B9DF55
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997259; cv=none; b=m6AGRVxgdgr5/DCbpcWoUYjWxm22+fVMIaVt8aMKnM+1h55eahJATwbBqMP3BgoYotxks7Ia8hYzEOqhiq23PkU0rX6mfBtuw1U3J1NjECHbtNpTHEnGhDMH5Yo1VexbKHwkplcEhOZeNSPIaJ8OBp2yxp/w33FskCe3SkPdRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997259; c=relaxed/simple;
	bh=ZTCmOBPBBJ5bNc0IMiC7N04B7g5S6Y6hQ4MNQCS9Cd8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l74nYMFfg3ZJEgK1Os4RxyIpiMT6RMoLPUZAijaG7FOmvI31F3Q9Mp7saYZMsdKuWy2W0H6Am0j4a4N0Zryfir9Yhtkax3msJsY0fBTjFdtm5oqthWpNavkseronHVO1zu+ysMGES+rfRDctHMcLz65GGNHxU3O2iTJbRVRuV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG1JA1u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E72C32786;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997259;
	bh=ZTCmOBPBBJ5bNc0IMiC7N04B7g5S6Y6hQ4MNQCS9Cd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RG1JA1u7C9lbWIZXweLeNacXeu2VCpNGUPDKdjAX/foe4QcMS59TlzwBMrWr33F0P
	 YpH8b/5X6RKfqQ1M8u29ganlv303JJyASE8pO5EVY9yQloezsVAzUbVQ/LKb2NjbgE
	 Be+JPeYD053/4bxLhCL9du+B/6hOBssph92eOoV4ZAnIUP8v66EYC6vjrANZAwkf+N
	 rFei5glR6vnTFfzkfBjPHD4a99t1yeZmmGuHxOFx5WGTLslW+keOw3W769JQY8ElRQ
	 arshkOy8r2/6FjVA7SF+EhanOx7j00313jdFzZkYhDRQN2XW609bzjPQepMmsLDVfu
	 eUj6OkGYmD5dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C010C54BB2;
	Sat, 18 May 2024 01:54:19 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/ring-buffer: Updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516123348.1feacd26@rorschach.local.home>
References: <20240516123348.1feacd26@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516123348.1feacd26@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.10
X-PR-Tracked-Commit-Id: b9c6820f029abaabbc37646093866aa730ca0928
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53683e408013407848bd598da15641b2f0979351
Message-Id: <171599725930.22868.13114594059662160172.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 12:33:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53683e408013407848bd598da15641b2f0979351

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

