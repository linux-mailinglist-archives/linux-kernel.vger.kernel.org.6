Return-Path: <linux-kernel+bounces-319386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA696FBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD2281103
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48171D048B;
	Fri,  6 Sep 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Cw9wh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F31B85D5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649949; cv=none; b=CZ7idHjYpG4DHyo2Qs9H2T0tRgSTi8nIsOfzJ6b6CbJUEMDVAxOnc+1p6xpWGgQcQnuH5zWcFq5G3DypqZLbP7XHEeZ1S7+9tvYNW0HyjLI5+6VJABBfsT1AAeC7+0U5sV+d+r/1DJg6/w5Dc6W9zdQ3gj1vBjCTSZvJlOMB+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649949; c=relaxed/simple;
	bh=M/aJVCPnr0oafrkzunsaolMDGtXhUZ0zx+ax1AH9tYM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QPSuYYmv/wVNtF5bjgAcMwMMNiTqahD5qsN3lJeLo3f9KEYnkFR9Mi3weP6vC+4UaSUAprtgQuvsxyhgnfyJFxQbHS5S+ojCefvgLeH7ko8ovHR6aNDOxPMdmJANk03FXStVqL8Ku/aY14mUgWJm+yfQIHDceDaEjtLo4EYpCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/Cw9wh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12025C4CEC4;
	Fri,  6 Sep 2024 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649949;
	bh=M/aJVCPnr0oafrkzunsaolMDGtXhUZ0zx+ax1AH9tYM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t/Cw9wh9DPx7sC/kwA9QO8ttT+LDQuy8ZCdY0zCATCK7eF/iT5/CiCY5/0rOwWaa2
	 X2QhLXG43mXf8C6mxPM+UDPt39B08LMy41bIamabSBvFwEp5KW9Nje3DSXnxIbjzdZ
	 NMMGReiDnq0Hk3ql9XCOKW2P7u/pNDt7Ktt6oMwRVX5Egv3NCivGBgHYKZEVQ7dAnL
	 Vd4Qd/iDaqiZKqDMEtOe8B9lBmjfWXqHFvBQ4J7zG44Bw2KlWCa6Nb/Pz1THnCd5rD
	 Eh1IMwQ1hFYHPML4D+PMLxvdYxLEmU2MYWZtLYnADi+B7TfyJuf1GcieqHthCyKHkN
	 c+fQf8BgTz1WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E053806644;
	Fri,  6 Sep 2024 19:12:31 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twtq1CjWbeNnVKRaquctv6GHYSixXofFbprS4Dk5iBkGg@mail.gmail.com>
References: <CAPM=9twtq1CjWbeNnVKRaquctv6GHYSixXofFbprS4Dk5iBkGg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twtq1CjWbeNnVKRaquctv6GHYSixXofFbprS4Dk5iBkGg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-06
X-PR-Tracked-Commit-Id: 141bb6bc73cf45e8b742d6fafa6734b6d5f82b77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea462f0fa438381e0d420f94193c075e2a114894
Message-Id: <172564994987.2497610.13706982466704345355.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:12:29 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 14:42:24 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea462f0fa438381e0d420f94193c075e2a114894

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

