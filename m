Return-Path: <linux-kernel+bounces-178982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D348C5A08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E582D1F228D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75232181335;
	Tue, 14 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQv+huue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16451802B6
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706186; cv=none; b=Uo7hotXeNbViNgyz8uaHTqLTrufDlIeWCShOPUT7oefz06b00peoWtpxI+G6p3LZxCxY/G5YiaYGnqY6uIhdWAUb3Wc/EOypzrXvONhYpOQC11Ih5IRc5ncf5iz2keoknReGJpMkalx+/2oPgDeoFVa3/CK8MRa8pcJMGa7TYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706186; c=relaxed/simple;
	bh=uVuLUzX5+DEYtNYoDJ6DK3zMte6pZoMQPjhXvDwP9ow=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NlVfBnzLeyiPGtzoBnBzjkPkEOh+3jN9qV/y+6NgEJqxexNz5X+vMcL1X9anB3bPgSORtn+x7cgxyIj0TVW1yT0Yf6u19mih/925iypmJQ5Xvnk8bIjB3mSA9opVDI9ykqoBAPM/9p3C08mrKHrWmL/b2nbqvviW3C38tT/jHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQv+huue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F5BFC4AF0A;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706186;
	bh=uVuLUzX5+DEYtNYoDJ6DK3zMte6pZoMQPjhXvDwP9ow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OQv+huuesqh8hdo3RyM8BZ5K9lcpFLQ/XV3LqpURvp7SzPB4AA9DxOte8NBXRR5Z0
	 12YxJyLhgIqbk83xYjpT8rHW06DjCoahlth3m6isb70F10o9HLrIN5cyG4rLR8Xn8o
	 mOeI0hR7XFFCSi+knMbFYRBFUt8F2YqrLC5PKUSfZuXJ33FFcLg4wRamwvQoY1QRb6
	 AHPeT7KHts6XvWGK0HjAL1tndvhI0NqpkqLlEV1d0txrYBUFKXS2rD9beu6YECUc4y
	 u1cCvNgndl//c/o1KZAvRHFzJTaoqMkBdk65etcH0lDFeYOrvxGL4TP5BLUsuxiAru
	 LZdKtgerBRGXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76F65C1614E;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513182855.GAZkJb52i6WCWQpXA-@fat_crate.local>
References: <20240513182855.GAZkJb52i6WCWQpXA-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513182855.GAZkJb52i6WCWQpXA-@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cache_for_v6.10_rc1
X-PR-Tracked-Commit-Id: 931be446c6cbc15691dd499957e961f4e1d56afb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5186ba33234c9a90833f7c93ce7de80e25fac6f5
Message-Id: <171570618647.7410.10590472490375651399.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 20:28:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cache_for_v6.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5186ba33234c9a90833f7c93ce7de80e25fac6f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

