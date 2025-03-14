Return-Path: <linux-kernel+bounces-560614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90238A60717
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EA43BC9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918CA3A8F7;
	Fri, 14 Mar 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4fS4qt/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A942B9A6;
	Fri, 14 Mar 2025 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916292; cv=none; b=upzzhc1NTElHgEoHLpxH1wMJwdDrF1hzBzUDgwg716SrNiGTnmDPhiRkWVGjysVgScQyIovAlBftuV55LAHt0gn+QHeUkfLZYr7b59ajYVIFb58YFgEf/M0iPBlE32DRZW9mIAtpTeiblbLVTKVsmh6XiSy/cK/iDehC9wF4qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916292; c=relaxed/simple;
	bh=TkUTPOveu7ZpjX5sp2EirBE4zHffyJRRsZt2HpTZcr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A7M5Tjpx35qQLMuYYY4HsWAUod46THXgHr7YH1HU8WH4aEFd1T2ZNiELA01HSN0bigAmxVeH1AR9JiPABaQEOOfl9T6gv8InSChLrtG7bFUHW2N1p3QSUZL16ZA31t7KbFisw619RmCV+baJdLX2y6m9jTyU9MfZvKzPHPLCyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4fS4qt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC4C4CEEF;
	Fri, 14 Mar 2025 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741916291;
	bh=TkUTPOveu7ZpjX5sp2EirBE4zHffyJRRsZt2HpTZcr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f4fS4qt/2XJdMyqbnTYHaHW2Lx5E0E7OwX+O7kY6v20UOgVEruKY0xsAnFxrvG0ti
	 5z7kDolT5mUNHSJDC0p6IvQtRwK/JtrcgWW2QvN34HhRAvxWPmIlFauR7gQKWxSMX/
	 GZSIceCRnerXIaP8nXzl5YqmWs1HL6bpKoLnGCiY8amASYuKydLdrD/hsZiztaAGxf
	 WihGaCBKca98GHksBfmNzkkBu2UJGtpWejjqwdMgS6NHmJJ4NQ8BKXeS6IHa8/olHc
	 bZ1FFTX+qv8ItI5IsR7IasD70G6YEVfePHkmKVXHbq0Hyk05N2YLZqzuN7parJ5DfR
	 IH0mx9X3dmFRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343A43806651;
	Fri, 14 Mar 2025 01:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250314005511.1022757-1-sboyd@kernel.org>
References: <20250314005511.1022757-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250314005511.1022757-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 54493279312f9e6edf64173681cb18d1df4297c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3a854b577cb05ceb77c0eba54bfef98a03278fa
Message-Id: <174191632589.1722086.15030621555018409020.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 01:38:45 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Mar 2025 17:55:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3a854b577cb05ceb77c0eba54bfef98a03278fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

