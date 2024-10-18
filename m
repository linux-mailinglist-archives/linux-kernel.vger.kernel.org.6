Return-Path: <linux-kernel+bounces-372216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA349A45C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FC71C21188
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38044204943;
	Fri, 18 Oct 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kenaPXZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A68204093
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275728; cv=none; b=qcYlQhWjrbKsaTLDAkkO9qltUjBjs6/dbpYF5lyDhwEYVAVLWrnw4dI1bOGopZoxh2BxdWRNzQY8Nj9cx0CEuHd5m/+w5eTH0fmI91cZCZ7DRyULRX8PIpfEW+QWxE9ufoPhrDkQ3VbHDkc08o1z3McXdFLmPce4Mjn6zJI/DvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275728; c=relaxed/simple;
	bh=s+bgolo34tH6sENSucwrWV78GxVY30I0uO5gO3vy+kU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qu5zR5A0UjxjhExJUEJ/tXLWUk3uW1Q1UQpznGbrPQtVDnC+85b1KHSO+Z1cWEeNJeLq6wsRn+db/zKO2D515apGzieQzJ77aGj/aCyw6uwQUm/pkywbVVXX2CA3yyZQ82c2s/vsUekTn+k2nl0GYjeUWxH8w2j8w563qkkBTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kenaPXZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8C9C4CEC3;
	Fri, 18 Oct 2024 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275728;
	bh=s+bgolo34tH6sENSucwrWV78GxVY30I0uO5gO3vy+kU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kenaPXZSO8nkGSPtgIy4jiJOsoe3OxOmfr+rY75ff+1UOJzzHfrFjv+a0+LCbF8Zz
	 3f9w0DlNh5YV3NBskPio1IW0FY/5rZQDy9B6h53Oy8GfPkhfKgz5X6QxjshQYLbG+E
	 8sGqRbyRwpoV11pYeficmV03z2/Jw4qE/g605KxNJrnzcOonvw/+F3PffdRK0jQHWP
	 xZfQFEtST5wX1Mi9lq/wLJZf6r4cICzpfZey7bo2OwVw/y3CLpwXKyTZJZspILBhKB
	 msA6JmRk88XZ4bwDhSxm/vRAC6YIFj7wJ4/ruTKqmm6ja6Vs9Eh2nQpGiuFce+zHdR
	 QcFPOzFlSePqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341093805CC0;
	Fri, 18 Oct 2024 18:22:15 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty_pQme=1c-KkA0yAR-X1PiUMqf8JiUnsCdGSOuM3fdpA@mail.gmail.com>
References: <CAPM=9ty_pQme=1c-KkA0yAR-X1PiUMqf8JiUnsCdGSOuM3fdpA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty_pQme=1c-KkA0yAR-X1PiUMqf8JiUnsCdGSOuM3fdpA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-18
X-PR-Tracked-Commit-Id: 83f000784844cb9d4669ef1a3366479db3197b33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d97dde4d5f751858390b557729a1a12210024c1
Message-Id: <172927573370.3196569.11915116378841687780.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 18:22:13 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 15:53:18 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d97dde4d5f751858390b557729a1a12210024c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

