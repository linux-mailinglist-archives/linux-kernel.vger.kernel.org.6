Return-Path: <linux-kernel+bounces-254484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559A9333BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C001C22949
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF80D8121B;
	Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa5QW+kA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C9143866
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166221; cv=none; b=RdO/iAS2cA2pOqFX7NbPFRArL/Q17K2x/fy8+6NEIp1RO0EqhZoLzP/4qg1UzCmp31kWCacNMcOu8Hibc9/qCKekWpNXlwWXPApKFFZAAdnGCksy1kxe/9ARuM0SXCMXK5FfrZleQldGgVlYF6ZEYF5RRB0kH6qFYObhoIJRruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166221; c=relaxed/simple;
	bh=UOH0XN5Sm9+cBveRicctHhHKXbCFnCyZ42NdRYp3ZIg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kOI0qUU9QiDIidBW9p9eoGguUAejXN+jby7aatrBuWFC3IXNYU4aF9/gU0yKU3f1X6SKyfmUzvA9pQ4jpp9EbKtBgEBb79frks0ZvPRXUlqTIWGpuJnIqwyTGF2/FJUmBym3fmlbRuf/VSvbUZsbtIaq60Yt6tWiP2YQRCsOSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa5QW+kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B3C2C4AF0C;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166220;
	bh=UOH0XN5Sm9+cBveRicctHhHKXbCFnCyZ42NdRYp3ZIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xa5QW+kAamkYgj+LHs8Vo7OVfeZnN0B6udZ1ia+FNy38xrr+9gQqhvxSsJpQXdnYl
	 4oOqNU8j4g6vsfDXI+46EnWLQ2DIO9QrD3SW3MR+rPPUa21FObthQm6xW1aN81oQpk
	 5X278FzQXCvA+b7MZ91JAhPOIjsaPMWKFdUhoug7cQ+yFluF+XlEAHz5R4RbVcVo2E
	 d4irvx6T/YMSuuQV7XFzQgRoyAomGCb9WoZaO5Fdb6nWl+0yBXJjtazB+yyvmjQK2y
	 +G7p7boRwdBUj+hXUiFQqpD0nzD6Ruu7rgj6jRdwexe/PnA+kAnmMYbYou2BPOYFAH
	 w7nmdEClEFDdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7213AC43445;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202407150921.BD2B798C6A@keescook>
References: <202407150921.BD2B798C6A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202407150921.BD2B798C6A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1
X-PR-Tracked-Commit-Id: 21f93108306026b8066db31c24a097192c8c36c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72fda6c8e553699f6ba8d3ddc34f0bbe7a5898df
Message-Id: <172116622046.23491.1064645900162388948.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:43:40 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, "H.J. Lu" <hjl.tools@gmail.com>, Kees Cook <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 09:21:11 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72fda6c8e553699f6ba8d3ddc34f0bbe7a5898df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

