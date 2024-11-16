Return-Path: <linux-kernel+bounces-411872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A149D00A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD16B23BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C3199951;
	Sat, 16 Nov 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhfQV67V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B11990D6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784912; cv=none; b=EzeVmRM+rSgHKinH1+KdJ8GMqodK3V/ACMuAbWu+gS9hWPhZQ+l8lfk9V1S1sl1Ivu6FblalIgqrpeIdIg8xx6Gx1lVGGUaubRjY26E8g0h1KwVMWaNDNPxVWwjixdTIixr+EiRYPV4vCXVCOEHs0tAfXsTGvyk0uyavBBarwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784912; c=relaxed/simple;
	bh=mbV4wku0UG04aiRDSJPIwUpvYV2Ki7n5eukpL9UiQsU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MCGa2BrdcuiPBpJkPrcAzPYBb7110p124kiNBhfR7EZNHb00qUAvJerBnq10IVgfPV4Aiz/fOYk5g+lSw7QHf4HZfUV/ipaUBNoqdaeVDhv0aZ0Wk2Bx+4s0uBdbECSoudFS/cbMo3m+IbiyyTpi/pP9kg1Dk4ln1YJn+jXC3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhfQV67V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CFDC4CED9;
	Sat, 16 Nov 2024 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731784912;
	bh=mbV4wku0UG04aiRDSJPIwUpvYV2Ki7n5eukpL9UiQsU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VhfQV67VIdavd9SUDnP7QnUu/DsBTPTaLwOBK/MDkF/+CK9n4+9MEKsL6nLH9z4Ld
	 ZDexPPYKHygCc1jWlKM09O//PbTGkvWNr82Vhq2l3uMf/s4lmU6lHEPm/6630IrK7m
	 9A14lV3x8zaoV1c5XGQk2Zclv+dz+Z/q4wg110KPecSNvNVODhtV4bItIEFAybacdS
	 HyoyJxVsVvAD9EP8h5pWlorw97cvWPlzdJ49IlChb7C4GC35h4QLm4Z5t8UWCX0xLi
	 Orl6G9C5l/PLp1l4+eXvHQxEhelsFUec6k+KrImvBJdkrkNT0bYlDA6+IYestypRmB
	 XA64A/e17ecvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A0B3809A80;
	Sat, 16 Nov 2024 19:22:04 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/ring-buffer: Fixes for the boot mapped buffer
 for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241116085339.4248f843@gandalf.local.home>
References: <20241116085339.4248f843@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241116085339.4248f843@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc7-2
X-PR-Tracked-Commit-Id: 09663753bb7c50b33f8e5fa562c20ce275b88237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5a24181e461e8bfa8cdf35e1804679dc1bebcdd
Message-Id: <173178492269.2978276.9438520204201286560.pr-tracker-bot@kernel.org>
Date: Sat, 16 Nov 2024 19:22:02 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Nov 2024 08:53:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5a24181e461e8bfa8cdf35e1804679dc1bebcdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

