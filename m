Return-Path: <linux-kernel+bounces-330157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAA979A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0261C22AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5735C603;
	Mon, 16 Sep 2024 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsZEge5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4A3770D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462512; cv=none; b=t8hc6cOw+J6bsjTvotzOG4ICQaiKb+KZcmWl/JQsyuT1t0ombDU9ZOFDL1bweOsh8JDE+yYZmgqcO4JQiQZNlu9/INHYahCntjjz8g9oiSm6NU0lLBigjay36Ur2iQq2jRGRImtC74e8qTW6lje0sSnY0A3kwLxpfNi7G/h+FX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462512; c=relaxed/simple;
	bh=X0bTg/YvtW7YCXVe801kL1AAb21EvnMbQtNVEsMRHVc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rUtMNf9ZlqLzISukjMTkQ4q2X6XWD668dq8a23WaisBLyCFLjEIJcpLJiVj68u/4kJb46G4d9FPwyN2prxeDxA4czmB2Qq8YAKbPmCuyihhFPdO9p3AA2gftNIT+NhT7x75O6ADjgnVlwrymniEo5xZDgRFO6Ngo5KsKhiIX/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsZEge5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B14EC4CEC4;
	Mon, 16 Sep 2024 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462511;
	bh=X0bTg/YvtW7YCXVe801kL1AAb21EvnMbQtNVEsMRHVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dsZEge5pIm8PErlJ8Ck7NK5dJddmuBlayp2HSmkYSQiBdDdBthqxMGcIoSYZcRjN7
	 XlmFk8VfByzW29XDGQNxnibcBzDKSd66/JFbn1fzK5LMcOBr7ubHYYjQ/yfuxwLs9/
	 tFokndCwn5pjwEHwwjtLCCXoQkn7P+oS9BU/3XYt2S/eCpqAHUZbv//5q6bMtmC3Nb
	 tkV5he163e34bvzQlu85DQW2KgAtAXD0XwIJw/UHaLgaBJcZPRaN5v6iCK3jzshXG2
	 bIGiaQ1K85S1bo0u8OMi3iCrEpmrlFcrI0hYJ0oGzf1YOfXI3rWP832PnsKRTabDSm
	 oh8dkdTsGczNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340D13809A80;
	Mon, 16 Sep 2024 04:55:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909125025.GAZt7vEdURlnid5eDh@fat_crate.local>
References: <20240909125025.GAZt7vEdURlnid5eDh@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909125025.GAZt7vEdURlnid5eDh@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.12_rc1
X-PR-Tracked-Commit-Id: 5343558a868e7e635b40baa2e46bf53df1a2d131
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f1a6adef3718c295b2ffb403049f15d5a2797d
Message-Id: <172646251289.3235832.7128658892438907443.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 14:50:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.12_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f1a6adef3718c295b2ffb403049f15d5a2797d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

