Return-Path: <linux-kernel+bounces-333300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41997C69A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA01C23D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9119A281;
	Thu, 19 Sep 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOwodeeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3C19ABCB
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737012; cv=none; b=L2NdAM1Olwos6n8ZoxvqQ8A0310NqeQEiq1hip14K7yftyotLC13VzMnQgaHKyXGo7x9rWfvcQfwIMwgY6VTxRPOtxaPNEs4AHKZJTx79o0zRajtNRLsS8S5NwNP5OMTpmcHaZBXsKZuGg7stSyerBGi53sun1uNq/pllMzz/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737012; c=relaxed/simple;
	bh=aPj/d/4bg4JcV7FUscYipxQyjHqi+ST42baM/NxI0F4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n43rvtqw+lffJWzF3v3s8iwp/vyquhqgcRtByc8w0nD5yQVBvlaoCqqN4L/Nc6BZz+o1oeQkkpTN49hS63x6RYxoMs0ZfropOUwzRvatNE/nkEOzqgX2IW6s2mmMijHZp5HAASRaN36Dqry3N6QWwr/dcUaZpv0QABjMKOurgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOwodeeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D57C4CEC5;
	Thu, 19 Sep 2024 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726737011;
	bh=aPj/d/4bg4JcV7FUscYipxQyjHqi+ST42baM/NxI0F4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fOwodeeAeuEui/UYDEY17ZfQ6Bs6LtDuBmu08iUwspE+SKSefeJL8sOpg12pbaQhC
	 Y34hi2rvRS9Re4dhONuFaidiaLOL3qoy25Pcjal8QZ8PU0zllHXX87m8Mh2XiTgOxB
	 RXuEg4yacLux9xFYbiOQUGQ/eygQ23cPwFKJoU+raqMAf7D5vgK/HhNHIE3DaLV6kf
	 cyPB8MG8iTNdq3t3KKArBgBHY0xt2xSs6ygPuYNFormwA2dJamFsvuvFXoZNY/rnVw
	 2XOMFTySRsSu6y/pEsmjcPH6hkTy2htmH/AwRLcEz7bsd8hCdMe6pdBNHN5cv+0BOU
	 nMgi3WCspmItQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECFBA3809A81;
	Thu, 19 Sep 2024 09:10:14 +0000 (UTC)
Subject: Re: [git pull] drm for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
References: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txujwc-GoV6qB1DpKjbDi-8uDcJLnJFSY4OBgPu=ZAVBw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-09-19
X-PR-Tracked-Commit-Id: ae2c6d8b3b88c176dff92028941a4023f1b4cb91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de848da12f752170c2ebe114804a985314fd5a6a
Message-Id: <172673701376.1425468.11289340107634023074.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 09:10:13 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 17:48:14 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de848da12f752170c2ebe114804a985314fd5a6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

