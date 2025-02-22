Return-Path: <linux-kernel+bounces-527451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06DA40B68
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905FA189425A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D480212FAC;
	Sat, 22 Feb 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO1R+nee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D8212F8F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252165; cv=none; b=uI778DUIskb/dsWc3xgMQ0Cz48rK35T0KUvIp9IUQ9sdfqgcgRRsprRFD03GN3FRw6hTiLw3bBA7qcuULntX1dAAsP2uUkTcQwtnsKTZ9We8BY+iwQEcbrUoVpHre3KD9EMY8uZIQu6HSPZYkV1w88LS+BOsZ23QYU49VpzSbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252165; c=relaxed/simple;
	bh=FMf0XEEpQn6nt0yoWfG4bWnDBZIM+X9kfg06XOo7eCY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JGNBQcIasIC7LCExoh7kEA0Gpx/4zoDGatALkksZOujFgYQ9iaUtqfWK8pitI6DpgxGXhCnq2CFdJcumXpVHzEbYTCZJeb6kOor8ZLDrPt/dham1IkNsUrv9orSyYcaerXT4uESzxSQeFruIvlEoPPWpeNiDXwLFlB6ZoFOKR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO1R+nee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53401C4CED1;
	Sat, 22 Feb 2025 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252165;
	bh=FMf0XEEpQn6nt0yoWfG4bWnDBZIM+X9kfg06XOo7eCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rO1R+neeyXE/B8ms3qkW2A+GXU3iaa0hkd7YvNIByu2dlTAPlBzb9JSP/VXzW/t6I
	 omIVStQTgwqIHskDUBY9UK03qhsTFzfdWX5cYiG4Q6XZzUzHIjwC0ZhScgex1/C7B3
	 Rt0k3Ea24ebEzO+YaMsB0UagUP1/4bd41JMDgNETQRubarrbxJ7lyTqcX+4r8UN/ze
	 0SKdH+m7ywnXUmifUp7GDbWSkeJOmh1IoaTjb1ZxbP1tNlKedrNfj6QoCs/WBsNDCZ
	 K+Nk5+5HSMVxuNHQ1xvqour3LO9O3r66EMhi7rn7VfjbN9VUaRbUAQ8FIRV+tYIN1j
	 DKOk5WBpJV8Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7B380CEF9;
	Sat, 22 Feb 2025 19:23:17 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7nVrujho_tqIt8S@gmail.com>
References: <Z7nVrujho_tqIt8S@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7nVrujho_tqIt8S@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2025-02-22
X-PR-Tracked-Commit-Id: e9a48ea4d90be251e0d057d41665745caccb0351
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f112eea3ccefc8a267fff592059f128b3166ca9e
Message-Id: <174025219628.2429034.11999516053734715661.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:16 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 14:48:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2025-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f112eea3ccefc8a267fff592059f128b3166ca9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

