Return-Path: <linux-kernel+bounces-290462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B3955416
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283F91F21AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014E8821;
	Sat, 17 Aug 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHD4+4hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1A6AA7;
	Sat, 17 Aug 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853722; cv=none; b=UbVcRWB8sUsWQmFYzXS5FdxPEQYlmG2blZ4tYJuGlLS/TxxyHKdlvNr5wx1T4XENq09T1DvRaj/FL/VNrZD2fQI9MJU5RGTO9UOjaQ4d7jsm1+GoGQyaHPTfxoIncWlDZWGG+VmTtvepb9oqkS84X+mT/CTMmbGkO8z4jU9FGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853722; c=relaxed/simple;
	bh=7bXw66FAAXNy3pu/lc5Zxt2c2jFqLZwO6T20oGofBXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ARJKTuXdWuBUXMhXt5dt6fNMWwLUs43XHThak9nCnjk8lf+V3vNoH7TDIsBh5+7sxXYysV3rNkRAYCUGwmfxHdGHRu1wIGIQc8qh0rAIIV3EQBW9Tqay+M2D9ly15XyJg1GuDuOJGoyZ/w0+CWoZnXUOffW1d0G3lOrt8h9u+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHD4+4hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA47C4AF0E;
	Sat, 17 Aug 2024 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723853721;
	bh=7bXw66FAAXNy3pu/lc5Zxt2c2jFqLZwO6T20oGofBXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mHD4+4hiDhwadd59PdJEZfc4pFcOylHMjeYBI15zhe9oSz9xbvyj6kOf91cFUEfUu
	 +xZoEFWMr1oKYVeVeszUk0u+rhgTygbYcwJnsS8vypRkOi8z3HFYIJQtMaLykPlJtB
	 yh5yVGtsNewp4hRHnEDFycTn7NKpJHDuWzurgnQ0i6+VTB+mYPzusw/50AapTtyPA5
	 wl5WmskXaBjvpj8MzTwxRdQGA2RYAfNqTsA42YI9sdaYiSUMunmc40ptq+Y8FhCAsF
	 vAIdKA7PIAsRMZjMQR4aBLR5ahsHWGRzg9xWsszIIZDgLSfmhFLTtnckr6D3zrOZgx
	 QGTrmKzYUy+yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F9A38231F8;
	Sat, 17 Aug 2024 00:15:22 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240816220726.3580212-1-sboyd@kernel.org>
References: <20240816220726.3580212-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240816220726.3580212-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 39a3396558fb97e6e7d4c1eb04c2166da31904a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 216595b708dac1707fc68d48042738d6d559ddd5
Message-Id: <172385372111.3661883.15584541298103537302.pr-tracker-bot@kernel.org>
Date: Sat, 17 Aug 2024 00:15:21 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 15:07:25 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/216595b708dac1707fc68d48042738d6d559ddd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

