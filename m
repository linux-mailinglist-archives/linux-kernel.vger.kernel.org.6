Return-Path: <linux-kernel+bounces-185324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E48CB37C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C41C20D22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABFE148FEC;
	Tue, 21 May 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co+24TqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A01487D4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316050; cv=none; b=DC/KiYXG283I8p8jLYMWrFujpVurliF8VqCA3TToyy+rNfcnYC+XgJKrzpuqKYglAbM2gzFX01AumQ2OOUCLpWok0G4lxa21W8wXuNYf5/KZygl9uE6t5lKDp/pHSpcXYxdSqosN9rcNd92NXf5LLA7KmN6zPjxYwS3tCst8Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316050; c=relaxed/simple;
	bh=tXgQgsmEz2K3ekijVfso4ZDoTTcpth7PsJZu83L0hpo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YPEM3Nu148o35ojOz3CO5/M1VQMccTIihB+weCaObT0OogK49OMV7x9CK6uiMHYWI4O267tiwiB9oDd0YTv6t3PJlT8JPISRPJPTCGBh+YbjmA+SjXVFxAztuWtavEaXV7t7S2cMon/JFhSTiFlYY81poKKzXupNQfWzJL6lc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co+24TqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAF26C2BD11;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316050;
	bh=tXgQgsmEz2K3ekijVfso4ZDoTTcpth7PsJZu83L0hpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=co+24TqI7WtqDXTLlAM5i0va7g4Z2xrB+G+0cfggCBwvSj77D7Rt3PQBK21CtIaem
	 H840MtG+pvzl/rIaMUr8LXzFSeRt0l2BQYVZA5POvG9gJQJjkF8Gs+04jUjOrunTio
	 CNBsl7FcBuQ/fHmW5TuvOb7KXZ46EvA4PwnGYFQ2s2av0iYKXAdP2HvEQe1DR7Fsq1
	 clMZC5Jrl8L2DlL/2IHg4fFs5Nzf0R3nsTpQNfPVzBQl8SaNZb3yDb4o+im9EIAR6j
	 DuGNk/xDsg0jWYEZuIXtALm9lV6xWk36c50uYcHynhMIwh+Vq2c4h5/hzgdI4g1y9o
	 swsqaeSLJwW7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADCADC4936D;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkxQObZQUTGealkZ@matsya>
References: <ZkxQObZQUTGealkZ@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkxQObZQUTGealkZ@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.10-rc1
X-PR-Tracked-Commit-Id: a0df7e04eab07cb2c08517209f792a8070504f0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9dd56e813af002f45f6a494414d4a05dfdaa30e
Message-Id: <171631605070.31501.13837909874878782790.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:27:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 13:11:45 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9dd56e813af002f45f6a494414d4a05dfdaa30e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

