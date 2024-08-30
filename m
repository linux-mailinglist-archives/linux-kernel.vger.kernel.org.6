Return-Path: <linux-kernel+bounces-307947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF2796555F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4B5284494
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BD7EF09;
	Fri, 30 Aug 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgoYIFM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AADC380
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985871; cv=none; b=oSBCNbbkkTfbiNWcBg49r4pZWL7O46EQlldf6lOdXdoG/n++6jvqwWd7fc1mp6lV/X2RNLKyUw+iaI52XimWXHkS+meRWLzLFOSORMFPc9EzA0e1ynb2gtNjCMtaqXCdiDTcZ1ykXj8ibz10sCz8MivJZbQcLqEbHWGbqYnHM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985871; c=relaxed/simple;
	bh=YwtLZX5pURwfENoqmHQ8x9epk3jKD/jNs/+Im2Zpaoc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LRHlW/OeCk9qcbWfJOjITz29Q0ba2GK2ciPoqzRYkthajsCROuY772M3n1j9ugC8Vvt3JI//v6YvMYPIdvtKLQjefcJdWnsBEohyZJFVrqOYH1HoyFaaOFXSDDSAlbBE8kMzolL7pMOb/hTjc70yTo4IwemmClFplZMgT4HE7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgoYIFM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BBAC4CEC1;
	Fri, 30 Aug 2024 02:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724985871;
	bh=YwtLZX5pURwfENoqmHQ8x9epk3jKD/jNs/+Im2Zpaoc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jgoYIFM5M3OO9DXoZr2doObHCrVSZ8KoI0xiSv9VBlSyUjH64PuSBNbw+8lFkaVyM
	 1h9zmJYgc6IL4w3bgy78Rlkg2LazOlLhZ0SghltpHLnZCx9LFe65VdFR04gyKXQHMM
	 bQSwL5Y3DZmbhiOocGbYIYDiBtThnwzlTcaM8D51c0w7T1ADSN0jCkfY+l665OdmlG
	 VOIr3HOdKoaB9ezLDcP8QfsHI1MB2Q9N7BvM6knlRqh5sEYqb/vj2N20wX1VV5LfN9
	 qKff4RFJGZ313vmMg43NYLeFSoV6rRExtflDJuP6w8AywM4lzFMIrg4uapw5zwP+eI
	 UXsm0Wp9FSJVg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BD0DA3805D82;
	Fri, 30 Aug 2024 02:44:32 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
References: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-30
X-PR-Tracked-Commit-Id: 27f5b729cb56e46d8beca47c227c0edf1e958fbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20371ba120635d9ab7fc7670497105af8f33eb08
Message-Id: <172498587276.2149268.13806942469470410020.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 02:44:32 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 12:08:41 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20371ba120635d9ab7fc7670497105af8f33eb08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

