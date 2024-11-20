Return-Path: <linux-kernel+bounces-416313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B009D4329
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A2284103
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B31C4A3F;
	Wed, 20 Nov 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enUlTRW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8D1C4A00
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134964; cv=none; b=IJvzPUfI7DikhvYOqc+UCUHxDiOtWB6/4CEQUA8gYM7WJW0aFK6EtR8xRYeOj7dwDyIpqx1snPUtMIC179fQrJC42oLMFzX+KPkdoKhEBFNFBIGohx36Gdh+37Cwz/ly37/nzgyf2DsepTwgVLmSu7f09Ewo5X1joFNuQLdmajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134964; c=relaxed/simple;
	bh=NCsVE52jJA4OfOi8kdXyjBOcqSAtUnl+RBeRawGhIqI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JFFU/4iv89oKIZ6oHBmoCeJU+kmp0wrsFUjyut8SxOt30VscgKqCPKRfJ73hOzV1uQ9aUVA4b03zmM9rHyKA0QdmpMgRurUh3DywZ6LTSDEZVJa/Hr7nUel7a9WBXuCCH1N+wOLGVg/EXNc3prBZVFx1kvtQPA4bUH3c3czNPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enUlTRW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325DEC4CED2;
	Wed, 20 Nov 2024 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732134964;
	bh=NCsVE52jJA4OfOi8kdXyjBOcqSAtUnl+RBeRawGhIqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=enUlTRW2rJA0nU3s0BKDfQY+isJXMEyLyYEZ12zs/gOk7UqpRATT+/wm+W9qLdmUB
	 2y0DuaR22S0okkciAUzlfl/v7RrVURpGP+E+jJfSuED0QZZkHE+/F29AC/tpNLx5mp
	 p5N9H7OImIirMgqdLRVNIQ7gM/oJwqaD46vsudCyTbsQ+llw8G3ioqjLRJbKxw6Qhn
	 r1eMqSlQPwaZqM3FjpiMsYwCs6ieckPzbY8BOQJiFICT9OpNYmWltEWEuaG83avtSG
	 zaLJ90Hh1qdXDyDrsWim28gz+TssVbHY4x2PGUgbglM1Co87nocX1qhfrZqOmQHF6h
	 Vbikd74pxpSUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEF3809A80;
	Wed, 20 Nov 2024 20:36:17 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <bd78e37c1570dc055bb19e393670d9a7.broonie@kernel.org>
References: <bd78e37c1570dc055bb19e393670d9a7.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd78e37c1570dc055bb19e393670d9a7.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.13
X-PR-Tracked-Commit-Id: 21ccadc64dae18bd092f1255bdbaf595f53381d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bd37a902ab66d63f20e75d42f17aaec81de2263
Message-Id: <173213497581.1342014.2175157073176635860.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 20:36:15 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 13:32:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bd37a902ab66d63f20e75d42f17aaec81de2263

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

