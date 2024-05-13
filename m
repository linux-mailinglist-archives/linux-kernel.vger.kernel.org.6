Return-Path: <linux-kernel+bounces-177813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFD8C44EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286B8B2240A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6774158849;
	Mon, 13 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5JwiLaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A42157A56
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616908; cv=none; b=FP0g6bD6yL1fiLIbiUUXLq0QYPLSyfBKBkiYwZwnFNH1d0+7RM909YjCqQlC/4rsvMyOMvDLbFahiWKQ3REZwIhqP0XWvElQBTUAl1spdIiJ7B2hBfHdnBD8lVOAwlUQGMrDr5oaVAP8eSbBtxdMANnAR2Z6JEf+I4rbyrH0ulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616908; c=relaxed/simple;
	bh=E7QK33IDKAmCZvmyhuJmbwWmEmmiVieGUFYiNuP3f4E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XfYGeZzxmMnQKkyPXv47m8f1rJauwiXT+IFFoIdc/x6+jHxNXNcmZOXn0T3/0meISlwtyWiR7A5lvb6xAd4eg7is5JFE4IzIxJxquIFwHUQpXMJGnenVYQWODwxRNwyYgffwcuboot98nP6y3sF/GUCQfYVGzLBzuCM8b4GYjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5JwiLaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D189C4AF0B;
	Mon, 13 May 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616908;
	bh=E7QK33IDKAmCZvmyhuJmbwWmEmmiVieGUFYiNuP3f4E=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=g5JwiLaM/MCgKGzdpJA7bIy5Z/8w8TwHjmEZJcwP/bWg9MTcINO8C9LF+zLbItDEQ
	 do2P0s6EY8KBGZ/lhBuqeg1q07VFAZ8YieTyAatDdvdDYlBkjdwtVcrU+OMJZPSZ2K
	 E1+s8o0bT/Qep8cPG+SA8JmkKCNcf8cBzq28aKX9Sp2LznTEjVeTia0G2eg6y7k3HT
	 pVL+HnF8mMXuKzGGqhMnjqtjhA9PUAL3yEZCzlNtrrvPLvWL1R4mR3bmiVASOodzZD
	 LXg4FhO1pKRbIxgzC/gqciRZug88nNvXwR/AqkJWS1uzuoNJm4eGlfbdrR+Hpp6dmB
	 LUg1zQR1auADA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0436DC433F2;
	Mon, 13 May 2024 16:15:08 +0000 (UTC)
Subject: Re: [GIT PULL 4/4] soc: defconfig updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <d8eb719b-3b66-4475-b117-7a4734af9def@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com> <d8eb719b-3b66-4475-b117-7a4734af9def@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d8eb719b-3b66-4475-b117-7a4734af9def@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.10
X-PR-Tracked-Commit-Id: 78b08cf6313061499948126aebdf00e1079e4d21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d1346f1bcbf2724dee8af013cdab9f7b581435b
Message-Id: <171561690801.7727.7331858026509769153.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 16:15:08 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:13:38 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d1346f1bcbf2724dee8af013cdab9f7b581435b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

