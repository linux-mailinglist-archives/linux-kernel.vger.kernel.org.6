Return-Path: <linux-kernel+bounces-197597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DD8D6CEB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AC31C22F59
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF8C1339B1;
	Fri, 31 May 2024 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAzQsoJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D12FF9D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198812; cv=none; b=OtNq59ItOguDleRElvax/XiQIS2lt9WTrQzfJbd6iNThIiAM6sM4TO5c1FqBNfh/0IYdBBX43mZTy5lwvIGgSr1E8C+oNK2AXlykveRhmnIwrUHbcr5caPFQ+iw1gbgbqFHzZTyIKkgFVaCD/GpwKqGErgZwZK0RD9DYovQw6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198812; c=relaxed/simple;
	bh=8onv2TtnyXLtC0Wzq506cZmSByXAEeudWx0gs4f/q1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WO4frqwqBaJh7Naxg5bbGgMFVCs+eJPr5qYFVpdhEoYrYrY8peCn4VxZkCHooJHuzlmArkhlavN6ndjT/a9YanvMLCFHUf9AX9IV1HWRKIcDsj2SiENgVR5LMoxGt9sFS+W/M4bnQHIHBHpb8to8jrkUEWwD5ilCih9PKLIbyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAzQsoJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42897C4AF07;
	Fri, 31 May 2024 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198812;
	bh=8onv2TtnyXLtC0Wzq506cZmSByXAEeudWx0gs4f/q1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aAzQsoJi/DPJzvfdRP3y7DvKyjBjef1e6Wu8fixKuiD8tuR4VBS97JbrIqTpAcBKf
	 n3JCUDhuqk0jEBSuiLPNUZXDW1Xd9abQsZpzexIdBiIa1CSKqr60s6XPzbAPmG6thw
	 Wiwn7X4UZe6vo+fP5yE9eTHlpcsIbi/biFNMD5jSQq4Fw7z2rF1/qzNEzvK9V73x9J
	 4bnm2jCFg9CwlwANbZHVUDRcO9c/cj9TvicCPbdEvnTKQQ2iPg7sAvRZWshpD1gkWm
	 G4Tce/Z9VfxAjGGbgYm76dzWHKVAncyLdeYYuJPFTHX+y7OIkwVXIpNNJi420fbxRO
	 KKCNFmba3KjEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39434C4361B;
	Fri, 31 May 2024 23:40:12 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3AyxdWHaQpN0zgbwBeQ0cmXs+XrMaRvYF=h0a3tnO0Ug@mail.gmail.com>
References: <CABb+yY3AyxdWHaQpN0zgbwBeQ0cmXs+XrMaRvYF=h0a3tnO0Ug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY3AyxdWHaQpN0zgbwBeQ0cmXs+XrMaRvYF=h0a3tnO0Ug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-fixes-v6.10-rc1
X-PR-Tracked-Commit-Id: d551ce15d08114514d489fad63bd275de2aca862
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7087cb35a007245de172b0e05130d56f56248d5
Message-Id: <171719881222.1891.9666945734100239780.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:12 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 13:12:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-fixes-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7087cb35a007245de172b0e05130d56f56248d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

