Return-Path: <linux-kernel+bounces-264258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0993E0D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A430CB20E55
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707BA187876;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Q3MS7f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD618757F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110843; cv=none; b=t2dW8p0whTx3e/KlYtGHB+IrVFN+tC3kGlXcedJM1dnOQ0zGrHAosRHMxpbymqbo4nvD54SYC7xiEE3P0kX/jwasK3n5kqT+K6hvMPF5eBCvHxK1+kgbeFtjmJyzX0G/zC7X+arANMlCsRNkijxnhJID92WHmPGEQLyBBIQmk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110843; c=relaxed/simple;
	bh=GrlQXJX4RHnI4au3QTmK8GxYy3F+u0YNwOu15Fxtntw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bPp2BJCLkIBSyv0DrubmRWbfrXDyyqD0LhHSn+MWyGSlLyNbVkeXV2I0Bb3H2i9sX1DnJ/dpew6ZX1crbMMc6Ffe6wycYGBZkiJa8BrBOMv9kbScC1ucxZ7ZjtNrq2i991m2jz0GVDICBKb47/sWqYV80ER1lFTsLIqzH76sDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Q3MS7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9745AC32786;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110843;
	bh=GrlQXJX4RHnI4au3QTmK8GxYy3F+u0YNwOu15Fxtntw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M1Q3MS7f4RhTOH9KBORATZBKNTRVaBTYpUbH2w2qQzZ9OgQNtPuBth4zgNshm6w8f
	 8Z6d+fgl+r9yysq0rHL9PcSq2O8LoKeh4CvrdgEW2TaBVCvKCCNSjVS2fLPaV0PvSB
	 1FkixLBOmkjLg+0eUl7frTuIvZZodSJXQq2Q8oOGMUrxbpuBD07WdIEAQ1S1KaJs8X
	 dqzhaZA2N8I9scriS42VBxYf0QocnTRja1gA8/qSDswmjVdwP+Zkc0LEGZR9N15cuy
	 5+2N5MQQWSlWTW7qL8r1E2eKhndOF6p2lyziGGjTKoaYW40hhWur+dgT7GF0tyGZiV
	 lJz5OBjmHZcxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DC72C43601;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.11-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ba78d28fa3c92baae955e331c2f7a3f9.broonie@kernel.org>
References: <ba78d28fa3c92baae955e331c2f7a3f9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba78d28fa3c92baae955e331c2f7a3f9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.11-merge-window
X-PR-Tracked-Commit-Id: 542440fd7b30983cae23e32bd22f69a076ec7ef4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f3f7598cb657b9ceb6dacb4b97a52811f25f991
Message-Id: <172211084357.16614.8277766549357796842.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 19:38:16 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.11-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f3f7598cb657b9ceb6dacb4b97a52811f25f991

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

