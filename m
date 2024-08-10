Return-Path: <linux-kernel+bounces-281746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BA94DAB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39EE1F22A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009D13BC0B;
	Sat, 10 Aug 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p79bkFBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5C17991
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723264300; cv=none; b=UhS7HDalLBJiLLExWp/9DD3ODSnmUyh1C6Nk/oDgX5UHpVb1zGwFMhvkQe6IJgbPpO+aJB3hvI4P8VLGTt4lCM+0uQfBWjxmYc+dfaW5TkLoDu4iUDjrkZ39PzkRsEia7DAPyLe97K5IqwPNH3YXhUv+JDx5TAQI4nt0qHUySPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723264300; c=relaxed/simple;
	bh=FP0SLnbmxR3QxUwdq67ysAoCwxNoq4kFizOJyy1fu7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tGa3vFoFU9LrXtpxVcxStu0c152y6Pq8FKSAPYgpCyZd+Kk1nukB449I4efAVG7dkyXPXdffCFXWJt8JA21mrNig+iJCmpA33VCU7N+WXHC+hFvRwPC2909jPTg1NJuFqCIVhkmFpiiU//HV3/Cq/ygaIUVQr/qaExGQZMtiizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p79bkFBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05136C32781;
	Sat, 10 Aug 2024 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723264300;
	bh=FP0SLnbmxR3QxUwdq67ysAoCwxNoq4kFizOJyy1fu7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p79bkFBTIEvHYcDsCMRnZy7VYeG0cj0oxo72uUa0Ut7cUj2qvEyIBeHJN4B0wc2AU
	 65JLNIqBw2xBlrDf1hLYpL7Z76VRU/S/It+3xkLjgvkYHUrS1JK/FCHosFUFrEOEfI
	 Zu0nsFr9klWwsJKVnNb6pKHZ7OgxHmdLAh7XmHpTG8/2QcO6qgMAYOOJpKOAkGJWA8
	 5FP75d1cwjr3xa+06krOLXxuntXZ8OEGrnxpQm9wJiwPkRknVUsatKKyjGN/bZ5l6B
	 QuzxaNU8VmNQx1FVEEkvZCGMVQOibl8vxbVOGmvKmY3+PpBoUq49ersem5tGCjBb2d
	 XsuJQVizPJwCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8D382333F;
	Sat, 10 Aug 2024 04:31:40 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txFVKQ-E5rPvgUJSo_ypt4uWW4dCyozsb_A5HD8Ldc5zQ@mail.gmail.com>
References: <CAPM=9txFVKQ-E5rPvgUJSo_ypt4uWW4dCyozsb_A5HD8Ldc5zQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txFVKQ-E5rPvgUJSo_ypt4uWW4dCyozsb_A5HD8Ldc5zQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-10
X-PR-Tracked-Commit-Id: 06f5b920d1d0b686d794426264dc39aa8582db14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15833fea97c1fdb3b34fceefa4b51177dd57e18f
Message-Id: <172326429872.4136681.1164713458856473491.pr-tracker-bot@kernel.org>
Date: Sat, 10 Aug 2024 04:31:38 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Aug 2024 06:00:08 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15833fea97c1fdb3b34fceefa4b51177dd57e18f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

