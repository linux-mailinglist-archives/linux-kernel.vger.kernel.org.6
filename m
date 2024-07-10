Return-Path: <linux-kernel+bounces-247894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775F92D608
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51323B26CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33C194AFB;
	Wed, 10 Jul 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NufT8aBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA893194A74;
	Wed, 10 Jul 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628048; cv=none; b=e/jRIM14g7bYYfJ74RCyu3dbu2Q0rZimv2d124iiCO67xF1BRj0qhs/ljY8ypU2qdHM8mQwhjRRt1vET32RynHAHzd/URUyXMEyibQ7uBDukgSTKTnVYxatHl4WJ45Azuj9bxNYArXEwSvlmiJSDuMt/gP9Y02cUYkF+d64V4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628048; c=relaxed/simple;
	bh=TFoq7+oIr0iAakVcweHXpatpmcWuL1c+a9eJnlM+nVY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=erBcwRx+bQ77LKDr9YyUnR+H8pPtqR7HYkkfU8ILoIJbw00y+chAPM8K3epiNfWj3jnUgA66WAPMuZfYSTJ5LmtTLUG5Y3+Egr650ZSpnu3jeItvc/J3Ukk5HtpQhHYTye5WPD9rr2RWyFD9k+1oCyVIs8bk2IiMOrDEicjLiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NufT8aBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69D6FC32781;
	Wed, 10 Jul 2024 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628048;
	bh=TFoq7+oIr0iAakVcweHXpatpmcWuL1c+a9eJnlM+nVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NufT8aBbAuqRJU3zCSQ8z9SACbthhYSGRIM7rMC0FZ1UiYXxoa5719MvacmvoMHjh
	 NpjYCyDCOGADVFEjYw39pUGWfqPpR/gBMozSXeIqCH3HG0VDQ4yBaaRnWk+00xSG7y
	 3Iwmdx9v2yDdziI6BbIeXTHRBDh5n5YWeERoKU4iIaAfvMa8Iw7AKjsiiavimuuuKA
	 qcvTRPKhkP2gggMFsqMmhtQVPjj7lWVEandwdpkIDJ8KyLc/5HsbCb2gFVSX152P7g
	 Zx5+u/8o4xGigPxosY+VZ6UMQIWnAYaeJgNEXa7coPWidc351UgUtnuk3DRiCgynK6
	 50GpJhDqN2/wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60252C4332E;
	Wed, 10 Jul 2024 16:14:08 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-6
From: pr-tracker-bot@kernel.org
In-Reply-To: <4f4c8c2a-c7ae-46bc-babb-7c6df4501df5@redhat.com>
References: <4f4c8c2a-c7ae-46bc-babb-7c6df4501df5@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <4f4c8c2a-c7ae-46bc-babb-7c6df4501df5@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-6
X-PR-Tracked-Commit-Id: b6e02c6b0377d4339986e07aeb696c632cd392aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a19ea421490dcc45c9f78145bb2703ac5d373b28
Message-Id: <172062804837.17113.10652934587384602971.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 16:14:08 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jul 2024 16:22:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a19ea421490dcc45c9f78145bb2703ac5d373b28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

