Return-Path: <linux-kernel+bounces-263585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F493D7F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400BD282095
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3E17C7B2;
	Fri, 26 Jul 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+fiVDrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877017C7AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017257; cv=none; b=Q1Cw7SqH5QNnLvM5d4cH3OydYmas3NzFDbSeiOwOV86FLsZMrHiFcxW93VBB17KB2hdNUuplT4SG3vrldxO9L2Hy5oqSbPNRIHm/FUt9Ts/CamiEfKDJUy0LBcNa7DqCWlAblj7X9KnYsxzblvvkPQsmcSPelmInMd+ZKsg6m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017257; c=relaxed/simple;
	bh=ebZmOXvycukmY/MHS6iPe9rr58K6w0SMUrPZdFY/rew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jZV2p8kGMGCu4BBxAPxJusH8fNQBS2IupamcMaO+KAlKIGGLVwbcV4cbNYckBAZigzJRTVl8AHVHE9ZH+EE4Lfjt5ypBGMR7IZAYZ03exRyIx5oXHm28brO3SeKlrh9ajFZ4rIYjl5uPVARerBKWWf9Y9aHJblwfXguvgLDXj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+fiVDrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AE2FC4AF07;
	Fri, 26 Jul 2024 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017257;
	bh=ebZmOXvycukmY/MHS6iPe9rr58K6w0SMUrPZdFY/rew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V+fiVDrPntzWCVmuvVCj5co9wQq+kvTuV8+yGxCHalUpu9yDzc+aLlBcDrSX5QoUX
	 YP/xPgpq67IcHxZxQomc7MLO25MURhsjDNfRF201357om+dWh8klRONbexjFsl1bcy
	 rh/uZvsm2sbGUbyDRwwy5j0Kz1IzOIglAb20xDBbdSdpp4XgJ/vll0ZzDJqcGJfJ/f
	 SGEhzXbDDbzCm6zB2AtrXLTve4g6KXnXDASfyMlkt2UuFs5ucLFbDPbDKu/HO4rnvT
	 blXYbopgjVPGUfC97L/IBly52SU2iGR3aflRKYn1F6ivj+gv4mKbZrlWQ+DbE2He+b
	 HaF2v4NdDg3Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 021BDC43443;
	Fri, 26 Jul 2024 18:07:37 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txAJoSXCOZHfjf2yObhi7tdQMxjXGggmujbjv1uLdZTew@mail.gmail.com>
References: <CAPM=9txAJoSXCOZHfjf2yObhi7tdQMxjXGggmujbjv1uLdZTew@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txAJoSXCOZHfjf2yObhi7tdQMxjXGggmujbjv1uLdZTew@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-07-26
X-PR-Tracked-Commit-Id: d4ef5d2b7ee0cbb5f2d864716140366a618400d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ba9b1551185a8b42003b708b6a9c25a9808701e
Message-Id: <172201725700.32235.5942224185755174399.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:37 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 14:00:29 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-07-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ba9b1551185a8b42003b708b6a9c25a9808701e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

