Return-Path: <linux-kernel+bounces-188944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A558CE8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A09D1C20FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4113048E;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7IyEWR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A012F37F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569126; cv=none; b=s95kDg4JFTbwlLCjiw2/7RFTDINcHiL/a4H/TBclDffNmR1poYr5CrIJytQiXI7p+CaZwIxF7q2IRKW0CrZqoE6Z2sF4NO3NWg7g82DYhtsh2Aah2edbFKzfHh3kjP/3mkrWTBKzzVLLRTh26EhpdguDjkwd4h7XRdi/OkNC15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569126; c=relaxed/simple;
	bh=mVMF17iZ0ctXn22b4zE5DnNNybYbq5LdImWjLQG1OSI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QrgfwrNj2dLZ+qBfgk4M1HwitwQUel0nrG8HzRmdgRWOi+PESUitwcVgXl9oUpsT53//vKGj1G/9wWEO2c9ZrdA/Mhe+tRbgKvMJpjAEuaaf9DeOpItOKneuxhNr1Olerf8jtl7MdzutwLRdVJ8BQe0ZbpUmL+fz5Zy+FGRfv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7IyEWR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8EC5C2BBFC;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569126;
	bh=mVMF17iZ0ctXn22b4zE5DnNNybYbq5LdImWjLQG1OSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u7IyEWR2xjxaH4FOZpHzyg/NZPYfJqA+sbwS+yUJUSEx7r/d+Yb6Irev9Df6Keh05
	 O9colKdV/3DUqs9Uu65PkWGQX16uxpFiY8p5sOOyydCVZ5S/4Vo1oyomREOx5mdsAm
	 qEJW2+Sh8aRpjJToRlqoUpZPhFYkB3Bk61eDLWS+rGM/wKA92VnOihdg9EpZloxoup
	 IcBJtevIX4UXcq5uwC1WLY3YzYAyAq9eb+0xk/Y9gKed4Rps52880FAU6yJRoHOhwv
	 2Sb4X9iks7F8WBCsaQ573ZCx6cui6mJqA8Ssg5xFOXeF5bPi6Fnueu0jRmqSF/ZzUz
	 1eu5SifehN/cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5B3FC4332E;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlBGcsni1Clme5hU@kroah.com>
References: <ZlBGcsni1Clme5hU@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlBGcsni1Clme5hU@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1-fix
X-PR-Tracked-Commit-Id: 008ab3c53bc4f0b2f20013c8f6c204a3203d0b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e292ead0c9dad3580cfd45693a59902c8d31a0a7
Message-Id: <171656912667.29701.2441165765690216210.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 09:49:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e292ead0c9dad3580cfd45693a59902c8d31a0a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

