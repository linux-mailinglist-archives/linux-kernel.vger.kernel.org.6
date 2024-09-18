Return-Path: <linux-kernel+bounces-332541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4197BB00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A451F25085
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011018A6AB;
	Wed, 18 Sep 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNNq1mjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173431891BC;
	Wed, 18 Sep 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656005; cv=none; b=Gpnlvxkvs8vuct0iW4tAnZ9Es1ym249R9GwVg4LEfOEO7pHk9emSI+YdajTCe7NCitQ7rG0r6bjrIOn+aSnPnLMLeutc3dYgFo4klGpgA+kM/u4bruQzEHDqdTAfh6WtN3LYvwFujEnl2HpV8YX0jENLVmOGcv4AEhBPA09A3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656005; c=relaxed/simple;
	bh=MqEPieSVljok+yHteP2ajFnQuqJjyNzPY4C1gEMD2No=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J2ROrxOMpF9zWDV2T/4SRV/nwDYwIAjsegXxdkh0Jri0XdtxVdlUOFfgmRpqMrCFxvqDuWGT/pdPQVICnrjzUJ4aWD3uoIRad9WCUzKQnLPMV8MTYD7yMKwfVuxSfJbMhTeo8HVNR/X76vRzqWj73cXnOtbfTAN8Hiux+F04xDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNNq1mjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8CC4CEC7;
	Wed, 18 Sep 2024 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726656005;
	bh=MqEPieSVljok+yHteP2ajFnQuqJjyNzPY4C1gEMD2No=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oNNq1mjK/q8zA/PcifchvEQC3BEFExKwa1Oj4fKqsBC3g+Kfa/IoAoGDPdA5ygiUO
	 j6YvO94SmlgMhPGPFtBhBd0kwdH5ju9FQ2KCjk0FTwox2MgVEpmcPffykZqJfeIOJh
	 Js9/lX4yVfmHZIVBAVNRzxYads24P8yGAUvAZcdYNq13LzDpjNH6rC7pVdbsbi0uQv
	 jz0strozX1+gmFPsotN1KrtJxo1yN3aAaw9pPZ8uOmEj4ec7L5vnQg29hgT2CGyu+z
	 jmoxh6SCT6WBKVMzv31nSFFtQuEYuMQZq0ankJ3OQJ0FdhRC/xR7k8vyoobz106O2p
	 iKtIQQ3JL1rZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAEC3806655;
	Wed, 18 Sep 2024 10:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202409160124.07E708A@keescook>
References: <202409160124.07E708A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202409160124.07E708A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.12-rc1
X-PR-Tracked-Commit-Id: 1bf8012fc6997f2117f6919369cde16659db60e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c9026b2b054540bb25203eee1b073a32da84020
Message-Id: <172665600680.763643.11356915093768770328.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 10:40:06 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>, Wen Yang <wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 01:24:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c9026b2b054540bb25203eee1b073a32da84020

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

