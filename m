Return-Path: <linux-kernel+bounces-250894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D492FE38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76458287551
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16E178CDE;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzLeJ1yZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C63178387;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800350; cv=none; b=c3ICRL73kGInAeGtbwI3YNJkC/1KN4L05JKcQElEe0XqeEVZLTfikNzSn+QP3nEwpNMCNclbY3htL4zRkbgvTFB8seUGt3rFz9kPPHq9e3cATCXLWaPzfHWQidId9Mzyr7jPw67kz0mc8asoop87NtDiWGY79Oo1xKNaYg6k7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800350; c=relaxed/simple;
	bh=Dxz0p3nSP6ZbWPn3w1petAoB7ZV+9uYU2Pp1A6fszI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c/kUN00nlEgetGVmi7iEYGpVZwefUW2wknwd0a+aR2wjrZx4hqvEdTP/MBdEI5LyqrUvoMf5w5rNOYyF/F70pNWKvjPd18pYwvIsxz43pJgpmMz7pzl8/vSuVcj/1EpMuoxylmucpS5kwHaT4H3mVdm7GF1XZP1SZYuh2CHhPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzLeJ1yZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8AB0C4AF07;
	Fri, 12 Jul 2024 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800349;
	bh=Dxz0p3nSP6ZbWPn3w1petAoB7ZV+9uYU2Pp1A6fszI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OzLeJ1yZiTXA5aLZekGoJgNiOapGv0PwPJioldWApxcZqg92N8nQcPgFnylT+AO41
	 3jwWW9WX5Gv+dMiQ9OPoT0Mb8N+ZMumpso5lpNY23FrssKqASvG2O0ywTOE2S5qwOG
	 6LVbN6DhtUUmWK4D73uEIrlkLI4W3nkj1PC0YCZ6G8M91yajT3f2feAEhiuyvuvheS
	 7zr1SWMe6zpFSRGfHFeFVw80pEl50/PFKjIKqBE31TH4ccJjAdr+c2nTMpCYa1oj3o
	 7JqeMZex0gWxD/UVJnrSgrMDhB6oT/07qcUesI0jZaX7rFGikvHxOe13BGHd4Zvpy5
	 aJDvPzF0e4BfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1AECC43468;
	Fri, 12 Jul 2024 16:05:49 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a5int5ln.wl-tiwai@suse.de>
References: <87a5int5ln.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5int5ln.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10
X-PR-Tracked-Commit-Id: f19e1027f6c0f5fae18b2f2ed88b55a6a637f76e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b48104b2cde4d392ebf52fda17c3eb5282cddaa
Message-Id: <172080034985.10368.9559171273149343421.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 16:05:49 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 09:46:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b48104b2cde4d392ebf52fda17c3eb5282cddaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

