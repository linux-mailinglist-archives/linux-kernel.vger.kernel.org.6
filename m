Return-Path: <linux-kernel+bounces-373375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED89A55F3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0BB2820B4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180C198A0F;
	Sun, 20 Oct 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeWmHKwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216A198A03
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451541; cv=none; b=fasaVuAfUHtQU8a61MkjzDvKIRQ0wJJU5+onlySysEt29zbRkQqLx9kwepq89nmEgAKbLzSm6JJxleV+W9cyTP9lXH6IGx8/XlNLfNBHwhJn0a+jhe6DAhQCMz93Y6tMeexp5B/VvE60GGT6JIAaeW5gJE6mTjre5WPfO4F4wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451541; c=relaxed/simple;
	bh=P5XmhZCKt1vQ9fegEOCHlBYz8+FcmipwR9Bh2hUwRzo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hXpNPXTuqol1Fz+m3R1/4X56qCPaD7ywOoaM0Y2DtqrgFbl1MAFUER2prnKHfTH1QTUP5+kvZyidvxZmt/Syv0SifDgcUz4s+aGxzsL5LOV8LMxS4TkdUxZLIqEGEdc4tC1AkJHN2p8TnDf1zzGAoRa3A8RVKuk+AmUYNWTMpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeWmHKwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C8C4CEC6;
	Sun, 20 Oct 2024 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729451540;
	bh=P5XmhZCKt1vQ9fegEOCHlBYz8+FcmipwR9Bh2hUwRzo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MeWmHKwQZYRN7ytz5JEyv+MIrqOzjqEYAJ1ZtSqcTD4D1epKbjlxoZCDxJ6fhXSGC
	 LqzyMyRkK9KdW9nR25wEaK4CVUizBoYjPxNdIVNtNFJ7S2SpYluQ9rXle3SU5s4UCn
	 /Yb3GuLXxWYAv6+Erh+oVQFYnUgBpNc8r82EWfa+qkb+G92YpiBrwaziyY10CxuvTi
	 4ulFHao4SIpBqChOZoxe3Zn2wCNL8JnFsa3BK5hnCR6bW9um0xarzw3mA6d/oLeomk
	 uzsCRd+Th4f1ZA2wXcIbqpiDLDz+7DanqJN/UWmN4zc+IYEEV7oJ23Z/rUM1iixkOL
	 e8vWJUzNcL4cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5B3805CC0;
	Sun, 20 Oct 2024 19:12:27 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241020113351.GAZxTqnz0SOdrMUAA8@fat_crate.local>
References: <20241020113351.GAZxTqnz0SOdrMUAA8@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241020113351.GAZxTqnz0SOdrMUAA8@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc4
X-PR-Tracked-Commit-Id: ffd95846c6ec6cf1f93da411ea10d504036cab42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db87114dcf138b5b1290ba9aa9e29c21297a0b48
Message-Id: <172945154637.3627590.18161308302698195933.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 19:12:26 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 13:33:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db87114dcf138b5b1290ba9aa9e29c21297a0b48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

