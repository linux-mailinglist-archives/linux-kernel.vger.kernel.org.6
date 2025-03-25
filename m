Return-Path: <linux-kernel+bounces-574747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3CA6E979
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388B1188D75D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0842517B5;
	Tue, 25 Mar 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJxEdDjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE327715
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882846; cv=none; b=reZiCbIPKt9y3G3A00JbzWGemeGkW+va09RY7OYvU4NT4XeKOpsl9KJOGg+cbrxWD9gbgdbRPFJM4hrfCm+aJxBkobgc5Jk4z7agZgkpMAr71t01ZLIKOK+weK3QSbhAacaOMPmqpxs30KjQdE+h7TjlQgweQlMA22r5ARMYaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882846; c=relaxed/simple;
	bh=Ia8/KS6PmVz+8QD33h25ny5DZbsfIiRhV0brqQeoTsM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lppZPPsvZ+NFrPQtpC+bFZkBsf1qiVBYjXMJG50aeV83i8Gzr3VwgsyEhAISCXlr5x8CHIPpBrMcmo3Vy9Ea0MoJo/XMck9A4UH9uXlTkCAmWSFlo+XFZ6FkpNIb37AAfVhEh1ExHhVp1bjU19JZEb9h1lv5tPHl9LY3+k1zTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJxEdDjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F35C4CEE8;
	Tue, 25 Mar 2025 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882846;
	bh=Ia8/KS6PmVz+8QD33h25ny5DZbsfIiRhV0brqQeoTsM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gJxEdDjsCxijeU6DWFQ6LDYtzsEhJz824XX2NPtoh8DM6Z3nVwDCyL/X/LqKWnVEi
	 KnRQ1CMgUWn5/Mk0HT5IggItGmJxPmU4kQi5Hc5ut0dNLQM3uzpgF22qAktCnb7VbH
	 xzPSBl1q82t68ZA8LivYQNExDBYCD1NEUv7GDcFSPbaxsi8ZFvvDyzj8qaAb965Ggv
	 5YbU7/cE9YclqWQybRUm8qbs9vRKl4J6MhAgTROCOfq9RLCd37L/S8MjAr28H0IPnt
	 gZjOAqN8XpUfOmSXaRsLUMmhsWWOSEDXBiNIcUo74x1cEiDbESPN4IbrCAm7fRMA/v
	 ETX2vfRy7Y5cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4A9380DBCD;
	Tue, 25 Mar 2025 06:08:03 +0000 (UTC)
Subject: Re: [GIT PULL] x86 core updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96f8i3nJgdV4O9g@gmail.com>
References: <Z96f8i3nJgdV4O9g@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96f8i3nJgdV4O9g@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2025-03-22
X-PR-Tracked-Commit-Id: 1400c87e6cac47eb243f260352c854474d9a9073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e34c38057a131d14e47b4acb461564d9f351b9f7
Message-Id: <174288288217.109792.17447914495866664290.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:02 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 12:33:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e34c38057a131d14e47b4acb461564d9f351b9f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

