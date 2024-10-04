Return-Path: <linux-kernel+bounces-351272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB387990FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8162DB2B013
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2D1E3DFA;
	Fri,  4 Oct 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2ocsHGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA61E5707;
	Fri,  4 Oct 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067177; cv=none; b=HhuZAvckSFJ3FGiSoXWZEBvuk+/NdXWLRiV7TB9RXIFBznQBhnn+msnTBybgm5HhnxeGPhU0SnHLaM7W6AzVIW61NrVj/nhb3nSB5KphLtbDeBRr+kN5qwl4p4IEVDndLyBRt+MI+H/jTN2MezfEE5zd8gabuhQ0tFrRQS5bCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067177; c=relaxed/simple;
	bh=doMn+327wnKAyIjfjzxWA6waL/iwcekAO5T1yXdQLKI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rpYEQHSXvSeAPg1G+thKaCjhvjVuSWs20JCFApQQmlm5fa0v+M0RiqtfzJp7/Z7fx2qd6VLFsiGUQ4Y/YJdIM0JXmpE16X+urr/AuKKI1B3WqN8boIJxNkgyqHQ/eEQ4dzF5VoTe2cA6pILjWKbbcibzzj23Q+cJ1ICxFovNtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2ocsHGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC19C4AF65;
	Fri,  4 Oct 2024 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728067176;
	bh=doMn+327wnKAyIjfjzxWA6waL/iwcekAO5T1yXdQLKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H2ocsHGGBK9uaU6n1nbVEEFzmdUn8uLahmhWb7nAnM8lYP43p88vHDZajjkIQDEgl
	 UltqvKKqFb8ib0vX6QoDkY2djzYfpUg6kJ+Rm45IKoZgT/mk8PKEC1b5Qe6ufbV46g
	 zd2R+aRNJt0ZXsLryBugE75PTd+Dms6De8F0xkfKGtZl3N3RhMJIVxaKAu3zL0UQqD
	 ALyhoRxz7AhbcwnrDAcFj3tV+YE4homPc4JjPFRr9P+0IYMqb0CR9K0ReF8IZhpjLc
	 79pMoHYPiPlr97Gtthtqdpr2nRFqRxwBDesFOnVsZaj/961GblMc4KtWsGh/WjFyMf
	 /fEq/1tPIgdzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8139F76FF;
	Fri,  4 Oct 2024 18:39:40 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xq8mdd8.wl-tiwai@suse.de>
References: <875xq8mdd8.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875xq8mdd8.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc2
X-PR-Tracked-Commit-Id: b3ebb007060f89d5a45c9b99f06a55e36a1945b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f91ff27b0ee99e7e526bf711626c1dc3fa12560
Message-Id: <172806717966.2698437.4535815157123130131.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 18:39:39 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Oct 2024 11:22:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f91ff27b0ee99e7e526bf711626c1dc3fa12560

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

