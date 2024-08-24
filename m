Return-Path: <linux-kernel+bounces-299803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C549395DA3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82745284D60
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E3AD51;
	Sat, 24 Aug 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfO2Xq31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA479475
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458773; cv=none; b=MIbo2r8ZE9YHPOXliMqlinnhzuAeSazJ97Zh7YBCdzz2Y32LtJxG7kIZBsp+xH1HdGMjOipaMS24w+9GnHZJcMGbTU1JJrS7pMMHxtWsGUj3l/hA37pzS6ZkSb+UOqzGc42S5hPV+egoXWccxcpSUC1FhueH3EIZ4FM6E+TREDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458773; c=relaxed/simple;
	bh=1f2sfOtBrorhoRoNtbXAAF595fhdwABi8MUaRUUiVcA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TFJyfjDjDitv4e7O1c891Ct1avumSUU3441XQCQhPlp4iQRX3x84Iju8xZ8n0JjZDOjh/LMGzqjZsnioJ5kRULIqUksKQ13+MoJn9Lnu1Um/7wsqR+x3LWAkla1WR7AVSJoeprVScX8rqXzkaA8NHLJPr7kiyOoLRzXosKSpQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfO2Xq31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F548C4AF09;
	Sat, 24 Aug 2024 00:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724458773;
	bh=1f2sfOtBrorhoRoNtbXAAF595fhdwABi8MUaRUUiVcA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FfO2Xq314XNSb08nVD9b9hR/Psi70gXVmQUMvgPHHYDNK7zfnLukx58lv9HQj652j
	 jprDaieMA6IfSKV/1iQWYsUS8yDBiQlJsTqv30hC/j4pphx9qMyHYDC1cnrYzYENir
	 jl584E+ZE18DHE6U66R3bWJILfVflO0kXG13Tgsv4wfrWJtwK4S43e/nmmnkcelgjD
	 Otj1BvLaMtm0IyGV3Gvo011vD3r6zMZHngG1fAlak7Ry13W3ik6a/XSI7BCPykDykq
	 qjTqMvf7GX2qoxQmM6aKeCS0ZPjYNUTtLsm+dPazXQI2MwUK41ELGJ/dP651EFIb87
	 0+FKljHBIqc4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711653804C87;
	Sat, 24 Aug 2024 00:19:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw7_X_1Bhji+DNJXK+940VH2MwgLPsvjX72doJkKt2SHQ@mail.gmail.com>
References: <CAPM=9tw7_X_1Bhji+DNJXK+940VH2MwgLPsvjX72doJkKt2SHQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw7_X_1Bhji+DNJXK+940VH2MwgLPsvjX72doJkKt2SHQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-24
X-PR-Tracked-Commit-Id: 76f461867800fa9421d26a70a1640eed55dff0cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79a899e3d643a256b120d3e9cbf518b55e6f3686
Message-Id: <172445877305.3119442.1587059426359361110.pr-tracker-bot@kernel.org>
Date: Sat, 24 Aug 2024 00:19:33 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Aug 2024 04:27:35 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79a899e3d643a256b120d3e9cbf518b55e6f3686

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

