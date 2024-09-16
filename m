Return-Path: <linux-kernel+bounces-330160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18D979A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D571F23675
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12112481CE;
	Mon, 16 Sep 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhaZfMUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DB82D91
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462516; cv=none; b=K+0FKnKKheSpkDOR99hIq8fWznccmx86R31/Fv53OhWsmDVgPB5WuDSz7kwQftHmgJFWR83io6u1sAqwRr5C5EXsUmGDw9JG/NPI9KhMSx8gdyLytUZ7zLLzAs4D/FoAFQagsJDjNzqIy71ZO8HmgG7+wx+NcABagZNCtxFb6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462516; c=relaxed/simple;
	bh=FYNtwuK76sYVkYz8O7H11Kaoo08M9q0ojvB73r4Uhfg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K9RuIeWRxSsYjYY80+SKXbk6c47/vtvu4sPVcdo3IGQZqgXEdBxyQHQjKz5WTN/IhkgY7o89AOu04iQTmpgc81xFkmIKY8lzdAIHGjpbAgTc6Conu5tPFOrFd8zFYqdd6jWISzGsuw0awGT9dCW7UcXXbPiWSVquYIjzV8LotVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhaZfMUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9620C4CEC4;
	Mon, 16 Sep 2024 04:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462516;
	bh=FYNtwuK76sYVkYz8O7H11Kaoo08M9q0ojvB73r4Uhfg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lhaZfMUmWDqCcks67zQBg6pxF4bXvB+6M+tcUpIxmWBxXGVrAvdhU7ivGUVNM8C4A
	 gO3Jlr4gp+3fj4N9giU3tKEsFlPZ+bRwTbE17gdplKZlFbABy/u8OdoDHEi3btdPZA
	 GesmD0qxIcMpq9oJ2skm/ZZMAyGVbyhLun51WpjCgeiYvdpMgGpEerAphvOyqYHog7
	 ynYHYSBElmjV8SZKyVO9QIzALTtuhJ2H+OwcLrWRpBkrMNYwEDjMBUzV22D9ENdZRO
	 ASmUEoN/sAvA5H5xP+B+egDDBUUnWr7xr63gWWO+lLCp5h8qZfX1rKQwFqYvYcU4Va
	 tnxuNhuPvjAOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC643809A80;
	Mon, 16 Sep 2024 04:55:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909145908.GAZt8NPCHCknkzaJBQ@fat_crate.local>
References: <20240909145908.GAZt8NPCHCknkzaJBQ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909145908.GAZt8NPCHCknkzaJBQ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.12_rc1
X-PR-Tracked-Commit-Id: db4001f9cc32e3ef105a4e4f492d7d813b28292a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d580d74ea2836edbbd49cd791eb5d0acad7b14aa
Message-Id: <172646251737.3235832.8601531897655496023.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:17 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 16:59:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.12_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d580d74ea2836edbbd49cd791eb5d0acad7b14aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

