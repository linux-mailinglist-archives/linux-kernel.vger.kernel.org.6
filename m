Return-Path: <linux-kernel+bounces-232787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A991AE48
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A392D1F2556D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E11ABCC2;
	Thu, 27 Jun 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRcuawiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8761AB8F9;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509664; cv=none; b=JWv8jy0In/XAnkUGSPnhBi7KXeW5IYPVtLRRWy08nZM1983+FkdrZDJeO+5s4/H8uD9igihGinKsoL2SbBWwfkorfWK0Dgpjo5ZAqfbCmvqAxCMpzDNwo3xXyGnE5H9Ve0AgOGDu9COgO+GqXmT7TVxW1oOCdKbdamg9dmSRsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509664; c=relaxed/simple;
	bh=qfLUMWcQhqARcnEJ2mZCwUYAPjdfne2ay10rJsqKTGU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xp3rPQkJQIB6v99PJe0MffDaqPdsIwVjbThPx4jXL3V4x+16jvJS1qWnIkJknE0LYs3benbh87UfpUxgWlB30UqiH27g1/sKsGYeq5Dwhqj/ocPDnMedBqzhlsaz0QqG6Ljw/9AxSOUnPT5cWEAysih/iZTVKmuUQUHBBjzXOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRcuawiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5831CC4AF07;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719509664;
	bh=qfLUMWcQhqARcnEJ2mZCwUYAPjdfne2ay10rJsqKTGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CRcuawiXtKFle13WdU+SmonTxRpFXuJmW+vGjAHPudRPNWFgJDzXe6Qi5rjlzmA0G
	 QJI2C6jEYCogN7bOWyou7SkgtEosTekmeVqRIwRRVjRjlMkBAbMXKSufS+ZsFfGnQK
	 M9s+VfN+N7zrbsdDLl8mrFKhG1jF8PfzaTbDdidevZCRPUfbl0r8jsV67XX7OMP4mP
	 lbbyaLwg9mwzhfzkkL1frkGH7bvlNNqthYmW8cZ8DMU5TUZ2MIr/C7WJz6t2q8mGIK
	 i6M6wqGbEWTZB2m/cKKpHSzOyuoTCrg+Cdnckif64+e6LExz+AOKg+L+ImtLO8Mdpi
	 K+HxXAi7l2E5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EAFEC433A2;
	Thu, 27 Jun 2024 17:34:24 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <871q4iizp4.wl-tiwai@suse.de>
References: <871q4iizp4.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <871q4iizp4.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc6
X-PR-Tracked-Commit-Id: 4b3e3810738376b3292d1bf29996640843fbd9a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c1d29e53d34537063e60f5eafe0482780a1735a
Message-Id: <171950966431.28398.17638166639263085695.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jun 2024 17:34:24 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 09:59:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c1d29e53d34537063e60f5eafe0482780a1735a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

