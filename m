Return-Path: <linux-kernel+bounces-242845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F570928DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A841C20D38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B91176246;
	Fri,  5 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnPBd/qO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44D174EF7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208278; cv=none; b=qoruyureUF8VJJbZl7tKIuMvSE4YiUR3+8LgndGWLi7VZ9iglI3cl6YNBMVJ3G1aRi+tS1GVbQSvfHOtARa9/hHU1hu6VwZ/lpVVpzdP44+7aRqMnWhKXntao/XvQpT0xOpxEF8YIIV5T5gg50+fgcjfN1dz/S375CNHb2ttWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208278; c=relaxed/simple;
	bh=QmxDXWhbURXuUWtYMT4oPszmHDCN/dLT/1LFJprLC70=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W8AEL212BSEmG1EG/8Qq408IOoRZMOObDFguTrJt8On6IDfeQu7zMyrG6aIC+1a5YswJ++mla1o/H6QKVJrLzwrD2efFEY73g5LxKBH/EO20O/iDagA/yyD2LHdsLgnyHfxlPaLg1z/R/b3Uo2uRpwoy4g+HEdX6yWoysj+Jrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnPBd/qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB77BC4AF0D;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208278;
	bh=QmxDXWhbURXuUWtYMT4oPszmHDCN/dLT/1LFJprLC70=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WnPBd/qO4nDYm50JaSwcxylUIq+VZkgRSQHLTerfcuwK+3GkK+l8YmS45v9ps9nBt
	 PT9QkBCi1gY6njfJFzO4rSSF++FF4+WvnI0vDlR1l/V3FcTOXtFvTZtIDLLOuMHGl0
	 lzH2j4xCpwekjBXEnyLCqT4l3Lpy4yySrgMEDEAijqhhR6Z7IN4NVM2IpLr7qTPbXC
	 D20jX7Zd9Y25/xaq8nQsY0WICp60+SWeJgEBX3dBb+quRYLRK2DLbsOktQmqLxpAB1
	 6dndrt1i/ZIVHmn+Inxw1g3DIsFvTlUgrPrjuHnP6jfMkZGvL/DexjCHGPfv9SU/qu
	 DTFSiesyOwHmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0479C43446;
	Fri,  5 Jul 2024 19:37:58 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZogN3gNPBVb29Vgl@phenom.ffwll.local>
References: <ZogN3gNPBVb29Vgl@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZogN3gNPBVb29Vgl@phenom.ffwll.local>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-07-05
X-PR-Tracked-Commit-Id: 3c6f5afd91cfacba9f43fd388f2d88c85195ae32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9d7390b2de008448eb3328d4a0504c76c74572
Message-Id: <172020827865.9250.17848296938618641540.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jul 2024 19:37:58 +0000
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie <airlied@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jul 2024 17:14:38 +0200:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9d7390b2de008448eb3328d4a0504c76c74572

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

