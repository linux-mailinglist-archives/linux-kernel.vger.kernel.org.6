Return-Path: <linux-kernel+bounces-423983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30D9DAF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A90B21DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B562040A2;
	Wed, 27 Nov 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n13927Ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B978204099
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743696; cv=none; b=jEF4gY10kLjfUqFXJA/Fi+QE7eombIjcZFZUUKL3GOVTBXG5IpU6OlakI0/GNm5ZGghTZ6eDAygbPg7PCuWGzdvoaVf3BW/7ki2OiXDmvyODZ1k13ZwJ4pDHWyo6EUL6dA5OVN/UUbDqqEQYxkx35pRC2ZvAtktSufF48yfb4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743696; c=relaxed/simple;
	bh=XRKsvraMBl6OVf3aOy2m/JUezL7k+J99hxhslU0Fjec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TYZDF79E5aXI/udWnHW6IEXvBbtN0jnpF6AK6f23DNLiR4dlOi5ax8KZpPKSNR2z98rk87ifa2gEWYHG15q5xZ7HvIdvUnCxV4ud1Yfey1Qaq9sNDYry3nIMjB9h6rFpQ2gX2r0GJUyD0OjOXTSrwCOn+hHD5cxIkgZD8p4pfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n13927Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE33C4CED4;
	Wed, 27 Nov 2024 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732743696;
	bh=XRKsvraMBl6OVf3aOy2m/JUezL7k+J99hxhslU0Fjec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n13927Ta/AYvw1TauFQqIreyY7nr4AKscDyyeN982Os9ZGHZrmRaHEFJbD/Z5tQhi
	 i199V/3RHzZfmNd4wt+gpDhzq8CPP42cNgtcCVQ4OAMp9FjQZFOAaapEdiRe6xaZZl
	 F+qK0zeEUts1hzYh8uM+6FkyXiFhJLSXHuNIb9XhsKCaCSKkbPf3O5eln/fqNHwIsu
	 PPmod4hAzqKMW2hZvjaeWOnE5Ny88BQ3Na4qEXzp5ubJkf04mpl4n781WTvL7S/daE
	 AqDE/z+40nGcLvIULTNBe1R5dInOuJ4NISFTRzKlcuEtxoj0G9/OcebdEGDPFF1Rfj
	 JYMn1OhvCEdEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE339380A944;
	Wed, 27 Nov 2024 21:41:50 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine subsystem updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0cJ+c0vvFZIu7I4@vaman>
References: <Z0cJ+c0vvFZIu7I4@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0cJ+c0vvFZIu7I4@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.13-rc1
X-PR-Tracked-Commit-Id: 8974f34de2ef173470a596a4dee22f4922583d1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7536c1a50ea592967b0db8292b44d4b86bca35bc
Message-Id: <173274370933.1220377.14963906976524599689.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 21:41:49 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 17:30:57 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7536c1a50ea592967b0db8292b44d4b86bca35bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

