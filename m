Return-Path: <linux-kernel+bounces-188984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF048CE946
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C882B219F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606133BBCB;
	Fri, 24 May 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk0atlaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67393BB24
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573256; cv=none; b=B3mgAo3vbs5qFIV27tkACfJoC3qwQ1y4Sj/GTC0+CnaO8eYzrScS0hNbFSIR9C+1AUUWJFzdCKCKMsWC/yO8aB31bdE+7wmtaawo3KhUMCJN7Dgyt5dHBwNO0f7fH/3OdXMIZtpnqW0wTD1KulBCgDmZeImp1L5hZlJ+FWW42+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573256; c=relaxed/simple;
	bh=71Tp+L1wf0lXLrMfxl6H7PNMVHNtLSbbAAf5z1JLfnw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ezFFbZUrf/ApJwttDOBr1wQFRFxcYswmhmRx3VlpVq6fYRTIRXPeT7j2YU1XgWi8h5ON3y8tueYRzeVtO3wn5lLJySFVMw/F7D09iUV+za4m3U36J6c0Pid3ySEIwh2wztWzSHxKLXpfGeiv/oXKlTtyvjRqqRiuVW3HF5c9b1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk0atlaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45C7FC2BBFC;
	Fri, 24 May 2024 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716573256;
	bh=71Tp+L1wf0lXLrMfxl6H7PNMVHNtLSbbAAf5z1JLfnw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dk0atlaW8wjp1W03BUxoBSCE1tel44OPPxr5G4zSrzVKQb+pmZUIzLKjt35P1O/yE
	 a1HBOh4uaiT3prEI5hgEn3Biy3RA+M3VcRdMBqkBmAMOKIvGObgW7hLCNjL3tdHDXK
	 yGauezXmwwLOJogIpOSPr+1R2QdxT0xDOf4bkbi51S/Y5nnTxBoGsN0x7M0iypLwad
	 9LUdAMnlya4ulT835zXdZutTJKsBqtIsrAV7FYiO/V98lIEWYPL0LOVmeYdCd4sGXV
	 I7MQ5BBcE+jd/TmHKKu6BgrZdCmhoojd+f9AYylxD6O7BeJVylKrGy9Boj1BcEqqQ5
	 axpqpq+vhOATA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F5ADC4332E;
	Fri, 24 May 2024 17:54:16 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240524133733.27825-1-jgross@suse.com>
References: <20240524133733.27825-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240524133733.27825-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.10a-rc1-tag
X-PR-Tracked-Commit-Id: a3607581cd49c17128a486a526a36a97bafcb2bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9351f138d1dcbe504cd829abe590ba7f3387f09c
Message-Id: <171657325618.4634.8934129604090299962.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 17:54:16 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 15:37:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.10a-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9351f138d1dcbe504cd829abe590ba7f3387f09c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

