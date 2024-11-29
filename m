Return-Path: <linux-kernel+bounces-425934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F39DECB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CF8282A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72745156C5E;
	Fri, 29 Nov 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm+ds+oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCC142E9F;
	Fri, 29 Nov 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912246; cv=none; b=dr2iHFUPgeEfZM+ZzTs3tGdSaA4bIswUM+EBwdVsJyn0WaH0+hK4fziAtkqRRg67HSebBEB+atcEZQMhyeExZGmdLB9B6/3tWQhpq0L3fuADQCsG+B+E+HCZKQd1jI+p/TjD55/3RGjezFMcubYcRpHbXnegyHxwz5G6u5mo54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912246; c=relaxed/simple;
	bh=Z6UyGYUfQUCA94Fs/9BXk9QWv32GUsnSWsiGF+utN3U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XIN5Zm45JEUuBQakp/xHvB3msNyTm6WBrP47SWmvMLvKSCkQyfDofnyleB8XOH4OeR9Y8/+warJFhS/Ev0oAGsZ2oGaTFTbXvBQwNrNDVI+kkirrNglbU+fdO/ctTtoN3EpfEz/GTbOoaoJ+22Zig+9nhOb0xXtwsmQYaBQaLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm+ds+oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A22C4CECF;
	Fri, 29 Nov 2024 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732912246;
	bh=Z6UyGYUfQUCA94Fs/9BXk9QWv32GUsnSWsiGF+utN3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hm+ds+oqFQyZ4DBvooNGoZDKlZzPX0LXZQDrbwS3/rNAqCc6UR5EcR4fJm4t9PeXR
	 fWCO23mwhvh/gbq0A2+YchfOMYDSsl1Tweh30Ase7eYUY11w+dOmK4EXKkpgYjmeyz
	 pLO+ayuDHKSkMI6R59UxiwYOTDeIhOVe0Glm52u2xetGZ5cqjUNG/lHozl+pf7HpR2
	 hKZ0Vd+948rdoxh1gFMFEma425Vf3oe1X9FxZN5gnN2Ed2juLIl5UDjPc+vQEw5J6A
	 +pEH3zgzkYH6IBUQv0DjXxUe1MgZrmCgd2k98J3jvlucFagia6JBi4EsbQYzjmzFJO
	 JsIrcaUAZ/trw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD9380A944;
	Fri, 29 Nov 2024 20:31:01 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0lCyXBV06VyH96s@kroah.com>
References: <Z0lCyXBV06VyH96s@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z0lCyXBV06VyH96s@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1
X-PR-Tracked-Commit-Id: 114eae3c9fde35220cca623840817a740a2eb7b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0c1ca3934ddffe4f3f2a2bd860283a7b0ca5439
Message-Id: <173291225995.2175272.3250019554292131522.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 20:30:59 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 05:27:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0c1ca3934ddffe4f3f2a2bd860283a7b0ca5439

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

