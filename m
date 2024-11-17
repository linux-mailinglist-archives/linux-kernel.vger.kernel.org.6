Return-Path: <linux-kernel+bounces-412171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B759D04DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0196282A84
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1569143C69;
	Sun, 17 Nov 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0IpCEXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7015C0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731865307; cv=none; b=MOgdebBFtOisvYjT/p2GinmDt9TvKfnuBAhPwVInPfpmbstvmVa87Y8zePycabq103NmsSdp6MrenH/UBm2Prbb60KTlV+TPmHJxrHXaeP8fCTDat4EIdu8y//cVj2urL1ZsvePcCiaaebTKq6KdsaRRk6wtDJwE9yba+u2gVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731865307; c=relaxed/simple;
	bh=ckN/aFOJzhUs39iv7cdXeRRpOyoEe1qnkL/ZAHnti1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zpdj8Rhbi+UXAmeFQ7C7bxQwL9liqc0c0vBMdmlL+1ix9UCKBfDiYoay4B01j1n+PVX+GWxkzgVwcZ+3ZlNyoeAKcnLaWfQtXXz9YI7QfBxSYeVNrmFZYFAnow5ISWGCcH+HjkHtYqVic5xKxZAFZC9ZkwaAxWotjvLUpzVi0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0IpCEXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29E1C4CECD;
	Sun, 17 Nov 2024 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731865306;
	bh=ckN/aFOJzhUs39iv7cdXeRRpOyoEe1qnkL/ZAHnti1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a0IpCEXKwvCYlcoJc8dgjNkRUED+MRQHm9aRmgHKsn07HBL5YS1hjINjsoA3/kvbw
	 dZRlXPLxbTs+ONpb+z5JhvPfbzYlkVHiwDOyBdFHRjTKaTEVU10mrPkiPpVNz0fBDP
	 CB81Ly9591p+VPTTe8pfqeoItot0X07vCXzqaMG5cKPW5aiEfp4q/nb+E9BiPEGKyR
	 R7nSpkPbYReT4lVLigcDGHxCrfhFYh4fR2fEN5xIPErcsG9rxI9VAXjDlyupd3idfo
	 nTCdBflF7Me1McUre+UXsQLcqXs5eKoJXHJbEFhppotWYh5s8lXPOJm3L7lcWij3KB
	 0QC8ZVKs8d8IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340153809A80;
	Sun, 17 Nov 2024 17:41:59 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241117123710.GAZznjdtizJgrgwx1I@fat_crate.local>
References: <20241117123710.GAZznjdtizJgrgwx1I@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241117123710.GAZznjdtizJgrgwx1I@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12
X-PR-Tracked-Commit-Id: 8d9ffb2fe65a6c4ef114e8d4f947958a12751bbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f66d6acccbc08b4146f4c2cf9445241f70f5517d
Message-Id: <173186531761.3182024.6493253115747566393.pr-tracker-bot@kernel.org>
Date: Sun, 17 Nov 2024 17:41:57 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 13:37:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f66d6acccbc08b4146f4c2cf9445241f70f5517d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

