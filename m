Return-Path: <linux-kernel+bounces-186674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40F8CC763
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652A0B224BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48130146D5B;
	Wed, 22 May 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwDVtKZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957F146A79;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406697; cv=none; b=QKlyp6fEG6C0RdhPqqjpI1za1k5xYdbFgP7riFWIxF34bqqm82N7tqRRgXeCRl3NfgQtvfNYmRhrD0dEE7/tIKzxbYSsB38Y0hRYTdyWoKA4yvVeCl4geZrnHRAm+EOlm5yh+PQa3XI58BF0ljD/xKcidhNjL81rrdAroEXPe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406697; c=relaxed/simple;
	bh=fHXvx8CL2UwVPwAeZnP3j3Tm0Kp3Ebtfy1/hNZlqxqo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QgOK472TWyWkpr0oclMI2I8Z+rDBAuVJpf67fikEp4xTlAujCI5HeZuDRVw9KNbJ80f+KVqVqsczFH9gJ1UiVwODg7vvL5kaMNEKQ/QliE0lTIEK+zbJZ8DRzPuZMnakkMPFcMIw+SDLaXNj+g6nGtKSuc7R6gNB53OoK6JhVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwDVtKZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C37FC3277B;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716406697;
	bh=fHXvx8CL2UwVPwAeZnP3j3Tm0Kp3Ebtfy1/hNZlqxqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TwDVtKZziCv47dYKYHRWCNp0zBVaQ6O1DqjV+hgJsOXUGt6NMk/qhE4Nx41F4nJ9F
	 inGjahNpIh/wPRkBiLYT6YODeVlGzJXBjlyv9DR3bZoOoSsRG0s6MnI0uBQMg8wNaA
	 NyGiIuVDuUjC7iF8lrFNaKNYaS1K7ymkw0NwEioyLcRV8kfDZqhrQv4UtGpomqqzlG
	 AOXyzgpOtCzrdo4PeJZcw6Gm3RQkrJBDZw99TjnHE1Ez3ceAdTzO9z0EA7wX39EcU4
	 88lPISxHRc6mwCDoozL3PR/qMVeXXgmDBcXHQoXIRPHSEo3j4Aok7Pxz3gGjXz5KUv
	 2Ealq/jOr65eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 659CFC43618;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk4GPfBsYwVvk2H1@kroah.com>
References: <Zk4GPfBsYwVvk2H1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk4GPfBsYwVvk2H1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc1
X-PR-Tracked-Commit-Id: eb563dc752d33b0a5d4952964af15ca892f59524
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be81389c82e2c1ed0997629cb3d910f584666e33
Message-Id: <171640669741.20241.18116329327209924009.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 19:38:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 16:50:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be81389c82e2c1ed0997629cb3d910f584666e33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

