Return-Path: <linux-kernel+bounces-435694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660A19E7B21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24176188648E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955922C6E2;
	Fri,  6 Dec 2024 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l00u+leM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA722C6C6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521151; cv=none; b=APbyXTbSTKwS0cvpg25RKf/ziv0QEfblLJnFr+Mp0rLYG46D5nWKFNoVgW5OvcOjL9Zp0NCPNmAGMQUtyTcrjjUhugcT4aSAv0ycOTTK+pHh9hclF9AvP6yCrQ/BTSqkNQf7rm4L+lsxaYFXg+zayRBDE0zZc4fijiqhb+20Z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521151; c=relaxed/simple;
	bh=vZP4vM2AM8D0g/lVrkfB4MhuFwblDSY7KwP63Gv/D8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p+O7d3NG5OQQWK/18KTXoo6dBnOl7YYQTXwBQIExJbIE+hrz0HUETLY6I7G9xydWZK1CnfP0KckCPiJlgcmBXIIRd3EvQXApOBe1cStqzBT2z74WUXazW5BpMbV/GDpew/Z2sTbnKRP5MS66CWkcW1VznbjjETjEiGAVtS2GGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l00u+leM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BF3C4CED1;
	Fri,  6 Dec 2024 21:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733521150;
	bh=vZP4vM2AM8D0g/lVrkfB4MhuFwblDSY7KwP63Gv/D8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l00u+leM5BDLoSPmGyuLQ0Ljoy+R21QZYF7G5YPm4fN9jf/lYhkYeLjuR/XQLx8yC
	 FjhAS1x9bXNHFWKoUBk8qBe+hQ9HbsOXK/q2KKeDWtDB570U4l6vph35fYPQMapB/s
	 2+7ANU/q3kM8Jj4SRzb0kKbs42NipjnBT7rx25UgjelGo8s+mRb5lhNksyziCtChTy
	 54Ad0zy2MYFr1HUMnSEBB5Fcj+5q+pNyZf9Bc7us/P5BisGKZSBG6FSFyKO3NbzpHo
	 80PL/ZrIoncZKp4eMU9hjc8Rg4wZlvBXGRiC8ygVKCZAMXJYLKWJOsjQU28O+GOmFj
	 /iPu+6XyaYUHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE18D380A95C;
	Fri,  6 Dec 2024 21:39:26 +0000 (UTC)
Subject: Re: [PULL] drm-fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z1No0B2ZRO5kq7Yx@phenom.ffwll.local>
References: <Z1No0B2ZRO5kq7Yx@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <Z1No0B2ZRO5kq7Yx@phenom.ffwll.local>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-06
X-PR-Tracked-Commit-Id: 1995e7d05062097109ea1807778ff8654c2de7f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7cde621b2acfd6bc7d5f002b19b60ad2ed25df8
Message-Id: <173352116553.2804777.13986947259395633354.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 21:39:25 +0000
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Dec 2024 22:12:48 +0100:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7cde621b2acfd6bc7d5f002b19b60ad2ed25df8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

