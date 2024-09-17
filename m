Return-Path: <linux-kernel+bounces-331852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D697B202
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451511C23C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256541CEAD2;
	Tue, 17 Sep 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQJT8UUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82314181339;
	Tue, 17 Sep 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586342; cv=none; b=P8QtLTym893UddOTsPmU+suQPoWunYPJsQh3q3874NLC/rJC5FNKgK78/iAviymrg6uH5OJgIAtcUzClKkZuNqocpOhxwp7GLMf7jfi0q0rKnpHRxpV68gl6U33HZDkSBoTOHzZEvjDSND5iC65tTr45g0LqkGZBpEZE27wE7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586342; c=relaxed/simple;
	bh=rlV8cTGvVpNU5TT7iUI/7tybizWfNDvT5+gF6cArPQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SI7vHMVo/WRcSfM6EwaTstzdJGRs0rSr02ozd9irxt6FEEpXodbGT0LKjhaiSlcA7ovP6yg7MJ4B3G+bBmpNEUPZz8mIMLTRtl/tHEKvpkM5O/nM3/37/v8wZJ7nD951Rm3vFpDJuE8P5tcLAPaLiJiAp4Oi1s5GucGcJosKm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQJT8UUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA3C4CEC5;
	Tue, 17 Sep 2024 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726586342;
	bh=rlV8cTGvVpNU5TT7iUI/7tybizWfNDvT5+gF6cArPQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GQJT8UUaPA5Q6wr5UhigsLEroOBimZqswPHFiK4Nbc481UdNRqnIzbj78PF7TP1rb
	 DMAPsl1UhAHImxGi+hmDdlN1WMmGTjdl+0TAse06QP++6EuqiwE6EX5B7IqQvs+4gV
	 NUaRpzRDxwLhhF6Ttqtv5b2MhSwEYGRZe2qCEUmGTmP68dQqCkjaf5dWnOIJiB0m6o
	 /lshdLJw4ixOSnHyLDDz4iAuhhLricW8EB4Fl2kOoH0EGt6rBpprDU+VIgdW1fUtJV
	 gBi583hfoUdSUJcBp39YngfMD01gdLBN+WUhH8orslMICy3UPdXQAxitW1Luj1JNPf
	 cFIVb8z+ZMHOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3415D3809A80;
	Tue, 17 Sep 2024 15:19:05 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.12-rc1 (early PR)
From: pr-tracker-bot@kernel.org
In-Reply-To: <87wmje9oav.wl-tiwai@suse.de>
References: <87wmje9oav.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wmje9oav.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc1
X-PR-Tracked-Commit-Id: 64c0ce555ad2d84f497f5f584ddd31e87ac690a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f27fce67173bbb05d5a0ee03dae5c021202c912
Message-Id: <172658634380.193087.7811029650358720507.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:19:03 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 18:45:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f27fce67173bbb05d5a0ee03dae5c021202c912

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

