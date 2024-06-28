Return-Path: <linux-kernel+bounces-233195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F691B429
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935D71F22E93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598ED1C694;
	Fri, 28 Jun 2024 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1EyKDYB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0A18029
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534955; cv=none; b=E7hHA1n8ZMB0FXlQCBBHe60VeBJOEfJIxl7Ho4ykQdoBQCOWBPOvuq54zhiOvixLUWAQYuz42O7ElDv0McshvhFYayaArlq3DABsPH4TntRC+xHY+iRnRKL6mTiShIVOitPvow9HtQrBjqdMcl9nE66Cxf8TtPHfUckqatimThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534955; c=relaxed/simple;
	bh=6WmSWzyoePpAtPyiL0jaKQMsJSvJ/JRaQmhBARYK//o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YnpB59mEV90ycxCFzrl2E74hDXMAyADjUzLOQaaaAX+1zBDV6+BQUrStPzWgJevz/upACSfvmEXzzkt/Xu9OpGCwIJWZsTmWyTkhLVoRbzC8Nejz7tFeUP/ZVOe0YM3gA+QKYhkbuC2B58Y3uicoGaFJs+cvswBXSrV/wqSXnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1EyKDYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA2CC4AF16;
	Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719534955;
	bh=6WmSWzyoePpAtPyiL0jaKQMsJSvJ/JRaQmhBARYK//o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L1EyKDYBiN63QpudecV4RKDFOrB70P00DVDmhPLp7HiYVYLUUlrjzx7v9+4D+CgnG
	 ZQ1jF9Pyjb0PkKsMx5tZzCGVk/0OnugxJiZoiqamviDNSb5m4Esr51b4kfxjYhW8co
	 e0TgYrEYLOvNB4uqMycK7EVtmOq+0JezJGNQR6pOXLovglTzzsswSkV0uzUH152QHO
	 9XyjXF9g68DyzWxPMMPwCQVZy+XilHNNuIhGQFlpPBA5vflWyTuhGsuKXFyaIIR1mg
	 XUjxNePIClsi7CM410HbHj/YJB0pRq4ptVv+0mBjxCY/yrMU/l4x+CE/ymJy0swEev
	 R9DdQrFzJ1CuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26268C433A2;
	Fri, 28 Jun 2024 00:35:55 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txzYPEzGHDvNBJb_WXfbktOSy0Y8odZGTRGpqJ00kPgRA@mail.gmail.com>
References: <CAPM=9txzYPEzGHDvNBJb_WXfbktOSy0Y8odZGTRGpqJ00kPgRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txzYPEzGHDvNBJb_WXfbktOSy0Y8odZGTRGpqJ00kPgRA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-28
X-PR-Tracked-Commit-Id: 4f2a129b33a2054e62273edd5a051c34c08d96e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c52cf5e79d30ac996f34b64284f2c317004d641
Message-Id: <171953495514.15056.3571550818018104295.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 00:35:55 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 09:58:07 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c52cf5e79d30ac996f34b64284f2c317004d641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

