Return-Path: <linux-kernel+bounces-516762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CBA3770A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA473B1970
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020AF1A5BAB;
	Sun, 16 Feb 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpLLPY12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385E1A5B98
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732313; cv=none; b=mC3FHWJgSSDTokCPMvsIB0DRWpo8IoNodEJwhfL5FD2tnJ1duphiAHbfjJhz2K3UzVfF5UYfduaaaKQ3dVtv50rcMNU9fJa1kb6L2O/cxuG0YcqWC1mWMNkI/d6Esb7XrSn8p7iaETQAT3eqsOnrJFFeWtkvxTXLDb2+X/g7y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732313; c=relaxed/simple;
	bh=f17KjaZW8ovwlojAPB2cvRf2Z69kBHm7w/ps+vn59eY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jUEuGt9PM3+J1CrPo6xgGkW7sB/fkpTKOUHYhevCaq99cmLyQx+AWZJa0p/nF5aX3/tpttwQ1WzW2UrU0tKv5p2uRbQkqlUclR43MtnpXpOtNBTNtZYos1dIHrPn0Z8b9yJ20bINVte5ZlZSJBwl1Ndq0I/2jrF3DTFYGnynaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpLLPY12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E1C4CEE7;
	Sun, 16 Feb 2025 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739732313;
	bh=f17KjaZW8ovwlojAPB2cvRf2Z69kBHm7w/ps+vn59eY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HpLLPY12yYEcMztdJERCj9TXGwMos6LMaj/cxDovY/30okrpkTgk5VlzwUPbxYvyO
	 8qzbS2PKsGaMOGJSaIrCAxMOYckFq6RDqa/7zf5FftP5BauN6e3pjTxnT1BtBb1ZrM
	 ooMiNdR3y1lipn1l9Wj7JV+3FAw9DgwrWXO2C0yMPsd/UtK9zBynrcVP4SZYG8Vnyz
	 ALfVzQW2UquzSg0ETnRHj0nzQZMWL5f3IBR32iJ6ePvH13n8g8Pg3oGlGZT98M2nFV
	 34SffKDDVtp5qvaRsGoph9sHZFX3cXRLY+khdWiMR89fZ0TQJKLXOBLRJJnUPK48fm
	 tr7uuTr72dR/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B11380AA7F;
	Sun, 16 Feb 2025 18:59:04 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250216095307.GAZ7G1g8jr0xW0nGus@fat_crate.local>
References: <20250216095307.GAZ7G1g8jr0xW0nGus@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250216095307.GAZ7G1g8jr0xW0nGus@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.14_rc3
X-PR-Tracked-Commit-Id: 4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba643b6d84409e8a9057d5bdd6dd99255b1a88fe
Message-Id: <173973234306.2551255.2355808046709732311.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 18:59:03 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Feb 2025 10:53:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.14_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba643b6d84409e8a9057d5bdd6dd99255b1a88fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

