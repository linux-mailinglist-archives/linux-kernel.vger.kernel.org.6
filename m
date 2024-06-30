Return-Path: <linux-kernel+bounces-235262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE49B91D284
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8905C1F21405
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67995155325;
	Sun, 30 Jun 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rad49wGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5A154448
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762363; cv=none; b=HY3pHGmkekWhcFDywilHpn7QY9AomK7u/rc/2+SZE3syDBxwEofPgdqNpr/kCg42wfZONHaORC5GqVC2d9rPl1V1CgTXl0uXf/noVQnJ4Y/mI8ej4thslUEjkDPpDGdkonh4qnRdkVExaPhH0CNiyEzuEoJoiwpZxPqlzfbwkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762363; c=relaxed/simple;
	bh=ArdDQfyXHb2t3eKL77pVHgTlvsYbNsmiqAc5QrYF0ns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sIgZmdX3FRiYPIX0yEw9TpENi+al3aYegzKEkU0+ePknfq/+VfJfM9dzt1ngO2bPNN3eXVzYOLoU7Z6nRiUztaRwWp9QBVeduVOssw0F10inQ1jaZuTH9YcgYOvgNXtWiTVn88Jn8eKV/YfqQtaPWY3YQ5PJNj4AIb2k7scTeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rad49wGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 370CEC4AF0C;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719762363;
	bh=ArdDQfyXHb2t3eKL77pVHgTlvsYbNsmiqAc5QrYF0ns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rad49wGGopwhcNNhEE4uzl6iT0dUfqIA4A+JO4eEZKA8T5/eR3T+jx5gDodoyOygX
	 f2QBTFrIUFGqhqRdKiK3AFO79k4qQxryEQKI9LWIXo8SrlKEYfqIacJHDisad6gd6o
	 VARiGjc5RvC/hCErQ/CWI9c7jzVkhoTECs8wEbmiJexE9CLHZy3v9OP86qNc06D1AH
	 7T30X2KuRFIl+wdw5POs5vNvpXz83y+AFXPbDAAq2oNOl2+8XGXWo6PRg79Sl3YlXd
	 9pjqXqbCX+kidaLXZfTbymK1V96X+kHXl+oYuqWpHDlg1JY5u0YJyfO4vsOzw8Zcrz
	 z6pHdOFUrpZSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24A81C43445;
	Sun, 30 Jun 2024 15:46:03 +0000 (UTC)
Subject: Re: [GIT PULL] smp/urgent for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240630083037.GAZoEXraxiw1FTc-Mm@fat_crate.local>
References: <20240630083037.GAZoEXraxiw1FTc-Mm@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240630083037.GAZoEXraxiw1FTc-Mm@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.10_rc6
X-PR-Tracked-Commit-Id: 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ffea9a7a6f71b5fb6f997d7b2ad95634dae57ab
Message-Id: <171976236314.1786.13105502233014658839.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 15:46:03 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 10:30:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.10_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ffea9a7a6f71b5fb6f997d7b2ad95634dae57ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

