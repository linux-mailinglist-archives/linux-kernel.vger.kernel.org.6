Return-Path: <linux-kernel+bounces-255862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C1E9345C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D092A1F213D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A745948;
	Thu, 18 Jul 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsJb+LYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525B39856
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266039; cv=none; b=l1WWwAp1zxQMetmA7NAeXLGhroId4+9hbWo2PMY2Weq1NjI3K6Cp7/wtxaiD8vC/nfRltpyGwKgrh1u3gs+rr1dpX2EShzegCITpzir/DZDLefC6Mkxzphqdne1/7TAJLxQsIwyo9cR+7BOjAgRdO6GjYUvqyKc50M9zyd8VJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266039; c=relaxed/simple;
	bh=/YKbw26apfvM6C/ym9muvWgfF3ix0DVIWBFANmOA0js=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hs6BO5hRLkzgAm2DjEFdaMs6arVT22lquC7V6r4OprdVk54z6qzAKMeWegFQ5T/ed2GlfSIZBMQP+q5MWj7cKpG196Kw2r+IKIq62TlYj2e4iTqB3cGKndTUS4kg00ZUpbGLepAa7shylzoyWjNFft36N7AUd5LL/Sv4AOmddPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsJb+LYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50667C2BD10;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266039;
	bh=/YKbw26apfvM6C/ym9muvWgfF3ix0DVIWBFANmOA0js=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gsJb+LYi0htI3u9UwYfKK2CIl2zQck+7B+mtsM9vbRl3Id44dXwzx49uAghbcLfAd
	 xTDjpzc7CYLAvOdMZIc/w2A+GSG6/NmCM1jQkm1B0gmo/pYgQNyAg6eEYkFm1d2RhZ
	 wIeulGAdNs39S3zRESZirsu0NcQ5gvLoPz3muOYKb5YkwvJWwsElNxcO0IVWJDc/gH
	 x19bjaVuL4gLnM0nlzRs9CDtL8Wb8PuAZAWzq9tPy96pOQJ2CTOGgXHLKfmY7TdPUP
	 SF9s2aPN0sE2d1735x4gqV8m3nRST0C0iT5jDU+k5i1K9V7vwxV14FzC7EhGH+h2ug
	 fPG0FMjwV1XPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 462CDC433E9;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716142041.GV501857@google.com>
References: <20240716142041.GV501857@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716142041.GV501857@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.11
X-PR-Tracked-Commit-Id: 1df5aa3754cac2045998ca505edb84d994786c67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0d97b04eceb637a476a2d0233bc7721611a9cb2
Message-Id: <172126603928.24030.9101868142454827891.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:19 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 15:20:41 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0d97b04eceb637a476a2d0233bc7721611a9cb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

