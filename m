Return-Path: <linux-kernel+bounces-355872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C955D995840
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7455B1F233F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E7212D23;
	Tue,  8 Oct 2024 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEGPmfNr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3722905
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418614; cv=none; b=T0s7fMZuaG8UhYg21us9LgKsAu7hBA5uWN80VHe6RulNYS2UinTJdL91jmurEPhzqj3Ank7pRNSHn83okJmlMkeGbpsbh4/eUm7k8Kl8a0mxhbZYRudsZbd7z2+KFCkmiUuPcqqBZPNucTQZO1VldGVvEOvRv8tYaAY7jj5pHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418614; c=relaxed/simple;
	bh=5Z1/Pbl1kheIgR2IiY7OnSGpGIemuG8rlErbiD37TXI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VpcFsHe9izX3BABuhgn8Kriqo+llIcIzKBAQMHMYiIYK0WTsl34jqC39IdVRaSczjypdYEmdSZgTD46yzdI3ZxCH+2dEYx5AfcAWMUMslPwMTO3DrIbgNoDFWiwiKKOikA8FH/HAbO79WCweXNRL/e8q9kqEXaD7A/ZhcpVttMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEGPmfNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338EC4CECE;
	Tue,  8 Oct 2024 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728418614;
	bh=5Z1/Pbl1kheIgR2IiY7OnSGpGIemuG8rlErbiD37TXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GEGPmfNr788NCe9FtwHeUByHQ/HUoINE/tHAshVyzA8kWjiWqEQo9uraeDPD8S7MN
	 M8qYUQLxqzceB87nAAiYqfftM20IwJriULDVS050jV1NRi6BdBN6w2oaYu6ZCyH9y/
	 rCnoTMrorEGcmstVeXMu+j0/lTpga9c3ucSO44V6RX8gT37R2yl+/Ooziw4Bv3HNFA
	 Ah+0gwNzr3vmJ8bY7durZ6xT4ECm7GPVsbRB00+PkgoG9HMtLlg24Wk2ptGnbQn19O
	 PNVyNEsdrTwctRYbfpfmCW34A3oqRu7VyLut3Jold3k64wvOGxplSaKQ0iS0+VOkRR
	 4129ltm3AI5sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719BA3A8D14D;
	Tue,  8 Oct 2024 20:16:59 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwWLGKG4fsUYQyub@slm.duckdns.org>
References: <ZwWLGKG4fsUYQyub@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwWLGKG4fsUYQyub@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc2-fixes
X-PR-Tracked-Commit-Id: e0ed52154e866a1e9e9b97ded50b164698f0a222
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75b607fab38d149f232f01eae5e6392b394dd659
Message-Id: <172841861809.670710.18320164342723865748.pr-tracker-bot@kernel.org>
Date: Tue, 08 Oct 2024 20:16:58 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, sched-ext@meta.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 8 Oct 2024 09:42:16 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75b607fab38d149f232f01eae5e6392b394dd659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

