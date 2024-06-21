Return-Path: <linux-kernel+bounces-225182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3C912D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24F0281F98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121EB17A934;
	Fri, 21 Jun 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukfczxJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8158820;
	Fri, 21 Jun 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994690; cv=none; b=ueRg2Lb1UTmxRRokCv2JzFPGUdB5XIXtTRVLblUsJzKgtAetbcY80r1jItD4z0xFsqb56T/Vb40Crfdt8RKRAu3YC8pAnXpEXhtQWaCV4j1m4P2MeLxOcejfWvp6J6CM58QfpA6VWaTjyzmATsAXSr4VFrYrobm9jfqDGZ/IY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994690; c=relaxed/simple;
	bh=ky3tFOhbgiOtLllNttLIcZDpNEAB5ofHWfWJjScDROE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I8yftfqvY1pByY9G4tg1tffpSkYkHZaDlK2emVOIzT7RntSqHtqjK/7P4xbrswz86nYiaeomyGstV5pW3enZsh5cZWQf7VwpNEnUwj9hg+T836LaE85qNLboRx1ZV0u2rrLSJygdwlFwLu8VL/TK/My5HjpaNYigTsngarUbaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukfczxJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D11F5C2BBFC;
	Fri, 21 Jun 2024 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718994689;
	bh=ky3tFOhbgiOtLllNttLIcZDpNEAB5ofHWfWJjScDROE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ukfczxJy3Nws3RVTwJWdMMd6HvRGnuehcB/PamENyhGqkaNuWfWFmb9EIKWYLBwVU
	 JGybd4Ri5JyUv996h48OgQ0ied5O2FQP4esU6Yrnp1JG2nKx7fjvEMOG4lTHzCz8Mz
	 RbqUXfuBCeF4xOj1sh/AEXxRSRA4CCt2UvhINCZoPlKgkeZFja8NhebZFYiiS7CnB3
	 zNiZw4AsnqsiVtZt+b3MnNX187wZaeDPemreMSCJxwHykuRzwF+eqJt0nxp+NPnwpn
	 7oZr88OlRn6tihzB1qcU7gB/FHsYkPoU1kNznxz1mfNnAfs1XohjwR9dUhq/OwgMpF
	 0Y8ssgzeTH8Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4BBDC4332D;
	Fri, 21 Jun 2024 18:31:29 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.10-rc5 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sex6xs37.wl-tiwai@suse.de>
References: <87sex6xs37.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sex6xs37.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5-2
X-PR-Tracked-Commit-Id: 17563b4a19d1844bdbccc7a82d2f31c28ca9cfae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4545981f33be5f04ee8dd43397ea29c37337dd03
Message-Id: <171899468979.30407.17176503047223416985.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:31:29 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 16:56:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.10-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4545981f33be5f04ee8dd43397ea29c37337dd03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

