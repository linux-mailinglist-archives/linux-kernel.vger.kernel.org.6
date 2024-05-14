Return-Path: <linux-kernel+bounces-178265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB18C4B47
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8972285855
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CFE1CD2B;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf9OsHuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA111725
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655089; cv=none; b=aVMCkOwxIepRKFP4bZXoOkR0GI5tZaryWu8aVNMki1LZJmmRnQT5IDoze2xdlAZEU76hfHUVRE1Fo49U3vIMfU1ppf34vrF9S1glAJjvPqfFWg858HXhTfKW6guw4GTK4wQxSO6otmka6R2aL73ra3cgQCoXpTsLJbwqMJfjweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655089; c=relaxed/simple;
	bh=S25CgJuHVAX0aFspt+I80NSKHR7pJ71mS1ucWf41ipY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cb2gu5i8dBabNYA7kCiJsWkf9uDLvd6/ZUq/U6NTJEtGkXTThspatgBFYrn19hxnchfjQ1idr9WoZXhjw8iW3kJ13LSlWdRuoZv6pyT9/SyLvB7PfByRhapdzURisXP/OZgFAiFYI65bvBoBsYcR57xiWEftf4keh1dRznH5q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf9OsHuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 519F9C4AF0C;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655089;
	bh=S25CgJuHVAX0aFspt+I80NSKHR7pJ71mS1ucWf41ipY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mf9OsHuX5MhI4KasdDqA/EBkJvm6Gpupee3jjPvNGw+jgMo7hBVmg92opuOJUblhT
	 rN7ArLRYWl5+Wk5evzeV0+z8BkVeFmDg7Q22/Y4ytQoXeQouGe0QrB8DSjGqmj3R7E
	 zBX3OlxCwutrrjT8ipIdUP6nBKLkjXXLT194r7wRWsVjbRHO4Ji/XMUZWfxTVJQr47
	 ikas1yHPyU/fHMhnwxZqsSxUf5t3Wv5MCD7oELj9j3WiJQNnNVVB+GbJnNRZdfVXf0
	 xbnkB72N/mVz8QIvA4WYwYnd5TAvMY+GDBV8YRdspVCKdRLwB4mkQglHTK89skm+6i
	 T9SEvznfOBhjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47C4BC433E9;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG17XCNvUM7C0k5@gmail.com>
References: <ZkG17XCNvUM7C0k5@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG17XCNvUM7C0k5@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-05-13
X-PR-Tracked-Commit-Id: a0c8cf9780359376496bbd6d2be1343badf68af7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d791a4da6be46559393b23beab73d2ca20518864
Message-Id: <171565508928.649.433148711200747937.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 08:40:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d791a4da6be46559393b23beab73d2ca20518864

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

