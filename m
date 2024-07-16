Return-Path: <linux-kernel+bounces-253229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B15931E63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51392283630
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63D6FBE;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF4prrSw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25931E54C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092654; cv=none; b=gzgelv2dNv8Aqn8U5gpQdL7mCMR2lFmkxiHm1Oio0yQpLU78qtasnCaRrKvD8KH7QB4NbI4FnH7jEbkPs+u2qe7zuRkK5BswfB6Qz/r2hAYdeQnJJnOL65bhhZMrNQFls1EyWqQZ2TpDz6LTOK4SAU52v/AbFx77gZAw/izUJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092654; c=relaxed/simple;
	bh=E7jx93tCkd8wfG7j1I+p+WwSpXjDC7OevdJzp0ACkk0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DrYmFsDkIHbCWPAOOV/JDckL3PF9W9CsVZGCUUOnyvj4XBiU6PoWBDrNmphn43coH+R6AcFw1uv0+7hAJW/VuJDnk/oJ5ZoutHFkP+ZLpB4jCxNEtH8ZdQA9agSSSB/QQbXnBlQIKKrnfB50sNy7AVqO7rRYyJ1PFogQiwj2pWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF4prrSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08A0BC4AF0C;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721092654;
	bh=E7jx93tCkd8wfG7j1I+p+WwSpXjDC7OevdJzp0ACkk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HF4prrSwXu2uCkBt/954+OTdewJ68IOJrzVERDQbiE4xoKtBxbh196lprhQOikKiX
	 OjGdXmte1XPjZBwvbceR3esLGbfM9IVTsY/j8TsNvPaVznJI/eHPPPX7Q/2Q2ySEMS
	 7NvKNV+OYRJ/RhfrcEUue9JAZbfBCU3CUGB9gLWoQXAokVeQiloaT6CCYN3G+8L4pV
	 1PgiTJ0iSL7P4Uh8X3I5lQu9mxRDQQSeP9WjnhraSFCJ7lTi8iYebQGQmzLki8EoOL
	 CU+2zHfPLW3sRE4EfHAU12G7NrluA7bnBpJH6vBJ/7QoU1JR54NVsZmtjdUWcVFneD
	 /jS2etw2EYVlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB6A2C433E9;
	Tue, 16 Jul 2024 01:17:33 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <bc8cbd2e0620ffd78a3a4f71b06a3a88.broonie@kernel.org>
References: <bc8cbd2e0620ffd78a3a4f71b06a3a88.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc8cbd2e0620ffd78a3a4f71b06a3a88.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.11
X-PR-Tracked-Commit-Id: c2bb8198fee88a428513f8d023c627ecd13aa694
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25617a5c4503b20d2edcc75804169960e7c0d88e
Message-Id: <172109265396.10916.16753263621365510515.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 01:17:33 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:14:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25617a5c4503b20d2edcc75804169960e7c0d88e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

