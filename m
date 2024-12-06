Return-Path: <linux-kernel+bounces-435581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7A9E79C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5951F16C5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF421DC05F;
	Fri,  6 Dec 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5eh8fKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70801C5482;
	Fri,  6 Dec 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515447; cv=none; b=K5s+TmKDAxceTsAM4mxMmoRDU3+mGdRY2r5/5yRRMS10cJHdXHCH+5LYWVAKN7PYiaPVOsroeNhSeGBou9eOJXhsYKR/2NbtEvqY5Bj7a8XOZnpzIGwckaZEMIb/+GUdD0qS7wO6wQxg6CZg9s0oXYurGqYnDLu6f6eX3NsOfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515447; c=relaxed/simple;
	bh=TWgkL3SKgYVdnsfgt+BwppG6Xb1QES6qU8WP62YsGCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tt9PJcNP5+3ZFr+m6YPCqG4Fp2RNi6EXM0YoncvMNHtuWThjCNU5ILRgUn8TddF/xoUNYsm5ZlWnlAW9VXeRZjHqyNPaffhgMH+tMa3OjXnUhzAK7K3ug00osJ7DuRY6DWoMJesJBAUdRT4NfPG2YpILU8AdnUnpxfze56bJago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5eh8fKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813EDC4CED1;
	Fri,  6 Dec 2024 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515447;
	bh=TWgkL3SKgYVdnsfgt+BwppG6Xb1QES6qU8WP62YsGCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W5eh8fKnujZaw/DHIA9wciQWRmuLGhP/2JjJ+LToA5eiC7ggPXNqgvKVHS3hAEXbi
	 U1SLP6QW4gLKxQ6k6Vmi8lKht3nJRuPSatBGdb70cQ7qKVxT7LZc+XGjxosVZ9eRQM
	 wVyYNitSc9jUEod1L3B2vzKB18V9NjM0b4wIuazSqfBuA2Hys+iOPVmZo0nGP5oLUA
	 WCcadJ6xzZ4w2iH/y6XUoJd7cRz3YntSB0SXDFkcespXccLexalHpD6B1NXG0DXox+
	 Su5jjK3NMLOM0QV10Yy1ASUjRGttLVkhrms6PT3cVwbzT91Ve1+DLiDeiqVCSBAtak
	 Mt2qK6BcRhSFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DB380A95C;
	Fri,  6 Dec 2024 20:04:23 +0000 (UTC)
Subject: Re: Re: [GIT PULL] sound fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734j1tc89.wl-tiwai@suse.de>
References: <8734j1tc89.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734j1tc89.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc2
X-PR-Tracked-Commit-Id: c34e9ab9a612ee8b18273398ef75c207b01f516d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b90dcd599b62ccaaa367947037235de8e6bc3a7
Message-Id: <173351546217.2778953.1392539592085467699.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:04:22 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Dec 2024 10:03:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b90dcd599b62ccaaa367947037235de8e6bc3a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

