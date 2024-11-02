Return-Path: <linux-kernel+bounces-393120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89359B9C10
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF891F21E0A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF696026A;
	Sat,  2 Nov 2024 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al14Axyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97534D8CB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512041; cv=none; b=dohCvT4UlSuQMXK1ShTbccxYPjCtZgzr3D1/SL97ipT90SrAI9hcVX9uCltJLPPSv2UVaxoe4YbBc7pLrjvxYflJiuG1EBG4FpyTpFLY+FoaE/mAoibO3O2GjUc6aK6eRd18LHotToaksRsJ0+czOLofWMJ4H+w8o0RQcb5vys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512041; c=relaxed/simple;
	bh=Bp1/UbuDjuiR1QJB1pHBQZNzQn+ZOVzQbMloTSuOYhE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oLo4o4nkWiU0gwpRyYTVATj1kOxCigdtNxHa1659xIPJM3IG+TupsQ39lRTqIzwkUTpsCjsmeXLd9X6hq/PlXEhp1NfcrHq7shpsfT0DB/edAL+AoosrwyQTeFs54RzchEShjvU0D9ysU9A3vJDgpLhY4nRhJiRKi2hSu1d4jS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al14Axyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACE0C4CECD;
	Sat,  2 Nov 2024 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730512040;
	bh=Bp1/UbuDjuiR1QJB1pHBQZNzQn+ZOVzQbMloTSuOYhE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Al14AxyzKxWz0YLPaVxzPtecZ523z+fmxBek2GLE6jRKo1tEUdkufzORJ0qHiCHl8
	 j1uEdO4AvhSz6TZomugX3Ly6vM0Y6jgzqjgkF5wJ0lqhE/R8FQaN5rXYDTIVSmZJZx
	 aWn6O0RQx3jMXpgeqJwT9pyNCnatmStIMfJDBC42KuKWK5oX58by5NLIEcKUJ1qTUN
	 37x9jEGLU5hsp9p9lnxyyf0u2OnK0qZLSC5yPJXuW7t+SUZaQ0PCKPTZDBJSyhKgi9
	 DRyefyHHxQhQrjk+OETGI8KqLJkUeMtCI7PCQMYIS+3kvySypT715XQVd0WA0bZlWa
	 TpyvlpkKoZn2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D003AB8A90;
	Sat,  2 Nov 2024 01:47:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tywoHB87EmV5CYripW2A2gVBg2dMTM-+gv_xbxOK3EQ=Q@mail.gmail.com>
References: <CAPM=9tywoHB87EmV5CYripW2A2gVBg2dMTM-+gv_xbxOK3EQ=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tywoHB87EmV5CYripW2A2gVBg2dMTM-+gv_xbxOK3EQ=Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-02
X-PR-Tracked-Commit-Id: f99c7cca2f712d11a67148cfbe463fdefeb82dc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 269ce3bd62e8ad83dadc80a2f755a799697ca4a3
Message-Id: <173051204870.2889628.13489806884825759621.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 01:47:28 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Nov 2024 05:04:48 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/269ce3bd62e8ad83dadc80a2f755a799697ca4a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

