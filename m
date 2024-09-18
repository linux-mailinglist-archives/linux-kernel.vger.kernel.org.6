Return-Path: <linux-kernel+bounces-332542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F497BB01
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518B51C23716
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6518A6C9;
	Wed, 18 Sep 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvoYYdd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92A18A6B5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656006; cv=none; b=Bq0507PcHJxf5MgclZZSFNoPxi6g7XUtPLMQwOuG+4urVsiP1UjZr2p7wAZpcgf2NJ24KJdSznnGJnjwTXV+ycjO1bVTTNEo9ZvwXfkOD+KDtfMKTbJhFhshtNeMaLUIcRoxA9ylylKi5AS+nlo5eCqc7rBCC0OaYVdYVLwIXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656006; c=relaxed/simple;
	bh=O60+tmkbt1IgtOXmERPY+TxEiHGaHX0XuCROkTEK97s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZBSyHR+VfvwixXWDihGf7VLbC5Kbt1Pepbhm6PKa9t72TCXxUPmK/oEqPQ8MOVHffIAPQ0Js/QI6Qp2GY6+s6R97eMzgt85mugn6Vsee6okjDALxrQ5nwiLlC5SJOMiscF+ZuuGTKLblCWl2FOz5I5imqu8rRqJK4b9UrvikDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvoYYdd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA6C4CECF;
	Wed, 18 Sep 2024 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726656006;
	bh=O60+tmkbt1IgtOXmERPY+TxEiHGaHX0XuCROkTEK97s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cvoYYdd2pz4+8kOJKXA0EdPb+AmmednO2Dx5UciV5YpLp2kG0+G5Gyk/tA88Og7iD
	 i3I4NRCr0kndvIjl7QxQvTKdukWDkQmVD1EuZ2HwF84go2U3vJ3TZ91NuNrHZNSa+U
	 uetV7P+0ScEjSdcvH/NpBCIPxTm9YKXbb9ErzB+enyMQYQTK5W9CeaxDEO368fO6Od
	 HEe6YNlWoybsRXPxyVqMDUtmgg33s2PGT8/e7NxI27GjrRaZXUlWj8aW2aCJdYzYBV
	 duKULKup0Du0cscRZSGoIwspFUca7/FgzIzNpzAAGZhm8fe2JOMT0/9RgeN9G96XXl
	 3lMPvGEzLeHeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 61B6E3806656;
	Wed, 18 Sep 2024 10:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202409160138.7E27F1A55@keescook>
References: <202409160138.7E27F1A55@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202409160138.7E27F1A55@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.12-rc1
X-PR-Tracked-Commit-Id: 44f65d900698278a8451988abe0d5ca37fd46882
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667495de218c25e909c6b33ed647b592a8a71a02
Message-Id: <172665600818.763643.12669998612166321574.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 10:40:08 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>, Brian Mak <makb@juniper.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 01:39:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667495de218c25e909c6b33ed647b592a8a71a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

