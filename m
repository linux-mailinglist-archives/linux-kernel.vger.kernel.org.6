Return-Path: <linux-kernel+bounces-392736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0C9B979C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818E3B21A15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308A1CB50E;
	Fri,  1 Nov 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMegm/u7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC050149E17
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486049; cv=none; b=XxWLbfri/rrfEuX+2R8oRpKjGgQGy0X4O1yQ1J6pIOilXyM8byEvioVkCjuotDF/VK7D9cp2cOWIeD6l6CfHAV0EQkjHoZTawlGRJefiLUCA+bN0fplL3+GNYzFO2VTpZN5kRaSVbuCNd36flBX2K1BED0RWhml9hzWa0zZWXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486049; c=relaxed/simple;
	bh=Qmy2SsUg/DjK0ASuxpIEoHApiXwwm7Lzg/npM5rGqaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nEd5lqlh9bbUSSKN8EMS20POrbkTxSBADEkrLTJNG8k0+391FGh6HcbPlGhGAddXrKQ4BuPVG2rJ/QR6uGURpgkrofhFSKFImuczaekNX+GrlVBKzyhX4VSh+yecW6yTuLOMC3fCHJhrzT5R4TL2ooQf128/kwXfikvNEvNJvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMegm/u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F92AC4CECD;
	Fri,  1 Nov 2024 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730486048;
	bh=Qmy2SsUg/DjK0ASuxpIEoHApiXwwm7Lzg/npM5rGqaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gMegm/u7rNcN37ojZ5yUGKFsZIUhQPuLimhohZaQF0vpls8akYp5KoPaX18TGEUpf
	 uh6FUgSRiQal7udxTuizRiKHmo+R9JKfBcaPIWEjYXym4fBuImkfjdfNtGRYU2NQuD
	 K2klZ5dIv/rYQa323URuisrJ2djIhBv+Um1DhbbDcNHr9dffuP21WKHgPxH/gIsBud
	 2k7KmkI8spc6Nch4p3t6z1Lyq7OrKtv7oSImME0NJEK55Ugrg26wf1xLOdVNKQuo+Y
	 zQMuqlrE5eFJl6yJf79Q3iHETPlCxNFYslac8E5/JzgH6+xaPiFz6rnNr90ctPXJQo
	 drnNuuXY8+wag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4BA3AB8A8B;
	Fri,  1 Nov 2024 18:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241101112207.GA8472@willie-the-truck>
References: <20241101112207.GA8472@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241101112207.GA8472@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 2e8a1acea8597ff42189ea94f0a63fa58640223d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dfffd506eff69e4246a0f1760e67dd90f9bbb32
Message-Id: <173048605655.2776063.16448857518642615257.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 18:34:16 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 11:22:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dfffd506eff69e4246a0f1760e67dd90f9bbb32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

