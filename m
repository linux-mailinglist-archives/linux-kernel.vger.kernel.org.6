Return-Path: <linux-kernel+bounces-197598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66028D6CED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C631F263E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BD136653;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cocCuuAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5712FF9D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198816; cv=none; b=WZ2ZXsNaVDbEova4u8Ple9HW0PTHDdM6h0X7bkEpSCiUU9ooAgW8auvym7wYt5o2YhSNgDFrJ/5lDcczbQ4I94lA+Y1Xtm3hr3kcIx+tLClhbEOg0uv1x5L8rOm9O+PvPol0uOcfRReNZWcEkviMmmv+72l+n+/CxAg8GGvWjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198816; c=relaxed/simple;
	bh=P8Lg8oOFIGtxGhpc/iIdXQhKZ/1SNJUfvGYbec9PlKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kd5enh7yQlDlzMj2EHXAgD8s2buV8krZOhE+WLSgRV23Dam8C40YWcXd8dk3RdCXJFRyPMt+JddU7ZDSh0bYaTc65qrRWavFVg6I00lAnuLfPPdE+RnszC1npS5ATdbNTpFNXn2S7u0e1DE8zZYLRKdIfP3KONsll9ZrOYgySC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cocCuuAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB9D3C32781;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198816;
	bh=P8Lg8oOFIGtxGhpc/iIdXQhKZ/1SNJUfvGYbec9PlKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cocCuuAcHNL/HS4mfjG3pNjw5hbQCPbWChyT31NNO0J3HK24n59dYRekUyFeKFVCR
	 QbvpROJKtia3rqRnq7DufL1mFIKBRTa+6iTu03PE4iN1/+JhQqER4Xi2pCdw4YAwgB
	 KlIqbJC3GdsFXExyLcTgSKhQLXtD4NWuxX/p+W6p+zUJCxG6tViL8kkvxpZY0MCTCd
	 4OUxfI0N7hB1ur1gfFJCdeiKKw7Udl56y3jM7Oph0DDtpzjfD+JsBix3hfQCApKeaC
	 txyzPcQwT/GwkCotUTw+UeWONROpCKHGcstQvgH4rT9nljDpVseaHorZYnZzSoV8wy
	 DhUJbKWz2DW+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8809DEA715;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <95218454cfe88d47c47e2440865d09a8.broonie@kernel.org>
References: <95218454cfe88d47c47e2440865d09a8.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <95218454cfe88d47c47e2440865d09a8.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-rc1
X-PR-Tracked-Commit-Id: 611b7eb19d0a305d4de00280e4a71a1b15c507fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7c05622da0e40c0ce93f847055a57e47df35492
Message-Id: <171719881668.1891.4796137032842986080.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:16 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 17:55:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7c05622da0e40c0ce93f847055a57e47df35492

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

