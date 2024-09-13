Return-Path: <linux-kernel+bounces-328743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45597882C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAD21F26866
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191D13A257;
	Fri, 13 Sep 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az5LxWqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC772AD33
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253475; cv=none; b=pCtg4CmnCOFpGfGBTcgaaDO4F0qjSGbl+3MvK+E0+exGQ15J0Nd1/5S4o+gp9bAGZMMy5Ja4WxkMsLaLzuc3unEaWTZDukP5+HB68UoYugaLf3jSV07Ho3MIxbNXyD97fmHP59QgdXqlovuYL25roNLBfneqte8x3COXrPNl3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253475; c=relaxed/simple;
	bh=4YpPWB3DrvexELciLj/6YL7To3ZQj/lSw2oGyiLNbHI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B0sK9qs9GxQOD7EXLt5/btaHQ9qPGZKr0Uo8RrCjhI3qxlF2rqDRVOaHvQDb3jkgPW5/x5o7g04cZVi6mXKAxfqzX8HWHOgPn8my0CpOkZgCkVtZtjj7sgngvpWZugRXJkm2Em2UHAK94jM8DvKwQ8c0mXui54cIE5rIwcBfE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az5LxWqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62283C4CEC0;
	Fri, 13 Sep 2024 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253475;
	bh=4YpPWB3DrvexELciLj/6YL7To3ZQj/lSw2oGyiLNbHI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Az5LxWqDSJ5Wv7Fl3WDRbAHaaaK69qTSlot+id0vKNGRU577y+LOHX9PYHDtshSIz
	 UFmevInY4LsGnK+Vn6ulg+6+yw1qIPz9dr3GaqPLqTfRvMET2VMgOPvnK/kZKkWC+s
	 NVXdViLmOyV5VV2EjoEzwjMHzI2lLg6hZ5axskWfD6XPbYk8t8YcUd95f8MATkWRq+
	 mqAhp+TuxsMUk4wHRPLsx2zSk9QcYc/cS3jZgh2zSjPf+ps+QM1Pq0T8hVtPXqboPZ
	 QiIhUzHAUo1PZzct48RgjVo6KOS7gwfnNOQi6yEc6HmzhNl/hVyFRfezJSYYds8trK
	 cS+rfBkIiRuVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FE3806656;
	Fri, 13 Sep 2024 18:51:17 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyi5A8t9bfCC3gtbG18Ai9cPS0bLrFVL_eJ1N1UyT4uBg@mail.gmail.com>
References: <CAPM=9tyi5A8t9bfCC3gtbG18Ai9cPS0bLrFVL_eJ1N1UyT4uBg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyi5A8t9bfCC3gtbG18Ai9cPS0bLrFVL_eJ1N1UyT4uBg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-13
X-PR-Tracked-Commit-Id: 135be1dc46c64c454f2828dbb7f239d035f47180
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46040ea8a6a58e5645d91ffa3ead7ed8fd633d56
Message-Id: <172625347659.2331887.6281602361918395805.pr-tracker-bot@kernel.org>
Date: Fri, 13 Sep 2024 18:51:16 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:46:14 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46040ea8a6a58e5645d91ffa3ead7ed8fd633d56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

