Return-Path: <linux-kernel+bounces-421783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688309D9019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082ABB27E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77B47F53;
	Tue, 26 Nov 2024 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8tzAy7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C33FBA7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585282; cv=none; b=N7SDb639a3NyXieb3jObH/M+OskHhng8T1p9qgwefX4/a/wzXStTk/lzXsXL5oAlwb2wVZSjA/8eU3Pc7XtzJZR8kHH1ZHl0eHw3FvcBEIMARLoDROZ+cjmGac44mt/dbAXv1gi/LR1mfypKInOxccNpxEuwxIrHbTn3xdVfKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585282; c=relaxed/simple;
	bh=dPLFM8fuL1iT9cW9RGNA9kmHMGk4K6BuS4jfs1juxKQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FXDuTgPQ9EvKneSaTg3HF7K+/WLINg+SWmcqRKden0BEMl6qj8kEQH3Cu3ab9SWLR+xF4av3CG237teqlBVJWYjXFOd4cN3/8OIb2FnC42XGKJE2bmT7UZ1H6O2aHneqkiz14is7p33Tuf3Isb4dezvGoMtP0lzwKLRmV5uLqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8tzAy7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4206C4CECF;
	Tue, 26 Nov 2024 01:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585281;
	bh=dPLFM8fuL1iT9cW9RGNA9kmHMGk4K6BuS4jfs1juxKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e8tzAy7pUVFiumnWY8TxeRLZRAFzTxcAkXaWoOSzjGGYAFrm6qPda8LkoHeUz2eym
	 3u2WpW6c0NQPwsdgYUJ3bJESAJzO0n3O9QfEh0AhXcKARqhiVvT1F2BVZyNCdMvNbF
	 IXPfds9gA0OXNO5BmsUoug922w/FIlpNaVcpgcyfeLh/pN39RHBR491zEnrT+zUEFq
	 0ScXzpWwsWpqcuZKPWxZhJFjVZHKwELsGK/4R5V8KJofDsv+Nku7+r+AyyBQWR6fGP
	 5B2l7UkVetHQAEPqh6BgnFLwAY31DsgSCq2OZ0VlBTNpqh6WWvRLHXgKRo55g7MsJK
	 yaUDefmZAgaNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7DA3809A00;
	Tue, 26 Nov 2024 01:41:35 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241123071306.GA108525@workstation.local>
References: <20241123071306.GA108525@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241123071306.GA108525@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.13
X-PR-Tracked-Commit-Id: 4752e8cde8344cb8673abdefe0dd74e9a2fe23ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d38cb9bee73969125c7818a9f9e3358e0db07d6
Message-Id: <173258529439.4103683.11822463336371572539.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:41:34 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Nov 2024 16:13:06 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d38cb9bee73969125c7818a9f9e3358e0db07d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

