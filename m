Return-Path: <linux-kernel+bounces-235278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28B91D2AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2580B20FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC895B1E0;
	Sun, 30 Jun 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNm4Ze65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFB156228
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764889; cv=none; b=YLD0NLxUSNhAUwTvgbQNsxk93pMmZT7rJXF33+lPckg0ZqJPSfB4FyuJ08OMG/TihfjaEVBAHPKKPoZDGg4GT/GspiWav0kco+NkGNcbHbD93K5hS27KVw4yr6MTWqGbwX+OTgmQDM0ud+d9TAvemJ2ca0k0RCYYiFLAEe5SIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764889; c=relaxed/simple;
	bh=N7ZR5md2R+m7HBz5hrdiiSeab4L1S4vnJejIY2p6nXE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sHTSdbqp3FcStD08ADbC63NmdNmb3hZcqDuzIVmCRWXrN1NJfP5qlt0BV3zXjir8H3otSAAlKOFdTmUpje8Up7ya+EZEt/wjH9VYEe5UP8VrY4re5Yl9+KbzoI6d/PeAJZ6sNTGSjRymvXF0+d3M3Iadm2jUNGh35VuKKI68FBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNm4Ze65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43B32C32786;
	Sun, 30 Jun 2024 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719764889;
	bh=N7ZR5md2R+m7HBz5hrdiiSeab4L1S4vnJejIY2p6nXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TNm4Ze65M4f8LYMDxvDry5GgGG9SOyI1XyFbTCMCVF647+JobNneWzv8mmusw3JX4
	 MvGpPqWwhuohJN3wKY9/CoJHKYVu9oGuHpVqSjJtAb+4I60VPvS/nz899uwqlKOziB
	 BXup0rKUhaygNDtyAmJXae54fsbTe+FP+EuShMy4dEmUGrRMg9/Wgmsayyqzxppu+e
	 h/0c9RXmWKHYGLKiJvqinFmctrxK8kHSyF4q2a9X8zvlolz/LiJ5chr+T7KTsJeJZk
	 +quFNHZkeT3znOVITYfDQ7jS0BRqDYY284YxBodKsybTiv3RWBJRMojPe9Q6uiCkoT
	 sulMp5XUp0Q3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BFC0C433E9;
	Sun, 30 Jun 2024 16:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZoFn3eQvziKriKTG@kroah.com>
References: <ZoFn3eQvziKriKTG@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZoFn3eQvziKriKTG@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc6
X-PR-Tracked-Commit-Id: 06ebbce9c3a84e5632fa3cd0864ce07093793e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84dd4373d566df74fc77175ff76b1658089f43b5
Message-Id: <171976488924.24413.457982343050321722.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 16:28:09 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 16:12:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84dd4373d566df74fc77175ff76b1658089f43b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

