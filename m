Return-Path: <linux-kernel+bounces-577447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F2A71D25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B673B1028
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A121931C;
	Wed, 26 Mar 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csOO/j9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A744219E99;
	Wed, 26 Mar 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010182; cv=none; b=fMdil52SzqGz78GLHISJcT9dz4AWZJVLZJZpSY5KAqUpvN18wN/4/tgSz/39lON61kcSpf1RDXPlIyeMBum9/MzpEymPjLuJcWHUIS0yUcYftIg/yYIY6taKmhJR34iCNmOe6hn30TESX0EjItLuZwP7PK3SN0e1UJBTos9DhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010182; c=relaxed/simple;
	bh=V7dYo+6vZXIcNp+Mp1Q27je6E0Gyymud0gPiSIIMoEk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MTSghJLlcBLzieQkdlKZluXe41RqP1h8wZpful1Mqo289DXo0G8yZ85OzPqauDWowqdo/No4lYBJTeFDQKTiF4vNl4WhAhLgcstVbu0mAvluxF7aHGXAkKzw+93dhoBYPb9T04WPam6BJiKtNdwuBc4TxTx7A3vqgDyv40mFJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csOO/j9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B4CC4CEE8;
	Wed, 26 Mar 2025 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010182;
	bh=V7dYo+6vZXIcNp+Mp1Q27je6E0Gyymud0gPiSIIMoEk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=csOO/j9VVBQlA4LrqRKgLFMui5et9jbjL2TDnzPRJ07NPUA/RjArAyJNiLfUTFUQ4
	 ezWfJkGMfRpQddcfXgVgnlw1LALcv1ucxtYeHmYjXSM7k+0pnji/g0he7q4F6aKd/R
	 nJbkudB5W24SGPuPRjn/hsno4C+3hrZEUwzcqfJnvOGgOhtD60RGSOS+qmXPRpLPNc
	 opHeH8qanUBGzP0FGhZA7/U0VE6evcWUEO/cMkz1smLZZBIAFfTJrWBjOXZCrgGITt
	 aBx3aHJGdgvnESHTZ/0AuRJOmoo7wJZWREO8OotodJw2MmlK5Q25eicxFVK2WWdMqd
	 4IQnnTTP+XOjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9FEE13810903;
	Wed, 26 Mar 2025 17:30:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfh89mz4.wl-tiwai@suse.de>
References: <87zfh89mz4.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfh89mz4.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.15-rc1
X-PR-Tracked-Commit-Id: 3a949fc08103c0ce3a1d0ef30459c7b3acc6a214
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e50da555ca4d42b1b98d0f26789db64f26a0919a
Message-Id: <174301021849.1396023.8656507449888304683.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 17:30:18 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 10:10:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e50da555ca4d42b1b98d0f26789db64f26a0919a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

