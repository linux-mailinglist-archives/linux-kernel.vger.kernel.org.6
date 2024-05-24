Return-Path: <linux-kernel+bounces-188945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6198CE8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B5B1C20CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0241304A8;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av8leDsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F812F59F;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569127; cv=none; b=cojHQiua4IIMMm6xZ6bYzeIXGpWYZz9EyKY0XhX7rz3quzd5Gig2j/uNIjEEWFQPDBRFhLUm7z3uoDyNO5R01/mFztnL7CU+E2dXqZbOoEswPvkeJpJsiTNkfW9NcNZ51GqY7F8YHC0z082PS6is/EF0M2q+HyfbhkIpQpYXTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569127; c=relaxed/simple;
	bh=68YxxV4pdXYdiWw/olzdV5vGd2q+J0mHRMXghc2Cqqo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p9bEw+9DqW9UJxsG88KBRHeLZLMAM6m7I+sB9qKm3aydHD5dDyREDfSxI7c//9fKcArsVcde0X6G8X21P06XhvaZjcVmkKqnXqmJK4TLeuMyHEPvydmPcTEwhlS8HDeNiS/y5/bCgB88spAi7iByEM3U+c6smasbVrwloJn3QCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av8leDsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 023E7C2BD11;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569127;
	bh=68YxxV4pdXYdiWw/olzdV5vGd2q+J0mHRMXghc2Cqqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Av8leDsyXArM1r8YVRfG1a8L2N+hX/Mg53vgwC8ZbqxU7K9+iE6oa9XfvcujkbfLy
	 PqZjNJ0xAvIhYQ2gvAs7Pi1gpSILDJPZhkVeRvj+3lANLWu3BD6wO/7BKURFrqgGVE
	 8F8sSNuMrZ8T1SSp7nJWWbxI1AQnBoopwA1V1lyrAOeF2/krfK9Z7KA6zEJWUy7IAC
	 wvJuclxIAC/0WUkBawkfwnn9U3PzNPSKI2nEFhMurv+E2FdUQtsrvlryYatruaZByx
	 jtCK46QgPCjzA/3+WbMW+pBOBsuVhndWZzOw9ZukGKQbBQXZaxwOE13tgoM+i6CNjg
	 8M3EazJKpM7gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFAC5C4332E;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ttin39vz.wl-tiwai@suse.de>
References: <87ttin39vz.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ttin39vz.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.10-rc1
X-PR-Tracked-Commit-Id: d001e978c1c45b25d823489171151d13fd28ef4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 041c9f71a47b8b98f6bdbbf4c0312f9782ca9a70
Message-Id: <171656912690.29701.5489205519619202548.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:26 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 10:13:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/041c9f71a47b8b98f6bdbbf4c0312f9782ca9a70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

