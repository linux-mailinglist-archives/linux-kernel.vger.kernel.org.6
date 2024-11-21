Return-Path: <linux-kernel+bounces-417587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CB9D5645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413F31F2244B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC71DE886;
	Thu, 21 Nov 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6eo/O3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765B1DE4E1;
	Thu, 21 Nov 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232417; cv=none; b=PsKqFpL4zBe5SZfxevCO4FTkmyNHOeoDrz01XvKYedZxQtKxzvWl0dVuN+WIZK12eh+dQKX+zr3T1Cjifyz5sXPGF1m6z0BmPBWw+bQy4jQ+iPGfxH0wtqyrkuk2xPJsFjHz2X+eWNr/iRt4mLBHVMz3l2se0PiKSA1sgfSsQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232417; c=relaxed/simple;
	bh=yZbL8SBOdYHkfBJxwpMK6/x6Du4i+JL3awMyMSX3JDM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UWDN+A7u0165KlyzLq5OIIRKNQqaq0qvsw8TKcbl1UaVfizynAmHSrUt7ak2VlLPKXC2wULGQhZxAtcV/pbRf4ekc8+wOfMMv/qEt2O4BBuXjiOlDyebrN0Oy6+yEHwFjf0xsuKPDYJCE7phHHioW7jywx22GU0JPIZ/TFnxscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6eo/O3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F2BC4CECC;
	Thu, 21 Nov 2024 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732232417;
	bh=yZbL8SBOdYHkfBJxwpMK6/x6Du4i+JL3awMyMSX3JDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K6eo/O3DWQEjqIir1Y/Dxa5jEDCLZIYiCdGRKYUQNUQ/MrrvPavAvuXbVl9iJJXLm
	 Op1yN3rtLHlm4DZHuYFoNKit4bLw6J2JLRHVLAmyydD+RVRD7Ttb5VMOZ8KbvoWtt9
	 GTermxsF6ewQJ4t86oHH4KFncw2nRdiUcMSgrlvLzqZ3q8C24BacJLQSLcP6vPs9Ko
	 Uhk1b6YbGWHsoZhlu9MuXUq5bfDK3RZE4YfC5JIrhs8W5Jo7ulZ3+ZwClXDVN+P5Qp
	 gDLugGn5/SbECTtDpvJhwF73pmE7EXszXrcxlnwWeGFdFs0a0VLvLbi/D2hqezM9hD
	 yd1w2OSHIaHtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D63809A00;
	Thu, 21 Nov 2024 23:40:30 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87iksg3jod.wl-tiwai@suse.de>
References: <87iksg3jod.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87iksg3jod.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc1
X-PR-Tracked-Commit-Id: e3f8064d8b29036f037fd1ff6000e5d959d84843
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 071b34dcf71523a559b6c39f5d21a268a9531b50
Message-Id: <173223242959.2158732.488164773681676900.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 23:40:29 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 12:33:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/071b34dcf71523a559b6c39f5d21a268a9531b50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

