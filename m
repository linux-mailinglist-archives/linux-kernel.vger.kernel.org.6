Return-Path: <linux-kernel+bounces-537788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93190A490D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2443B6449
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80F1BD9C1;
	Fri, 28 Feb 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5uBmvJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D021A4F22
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720086; cv=none; b=eFIHqNnqlR8iAwXb4LXAt0d0+/NoGZJ5wtarfvh7pI96FNitxNbJxLqtKiWv0Ke1l8NOigUzUSyDXVsU3Z+GreptEqfAqJkL+D+mhqushxSS7l0CbzYf831cmbWkVycMXFMlQSmVuf5DPcOWlUsclH7bjS/cHyTMcSSlnn1FfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720086; c=relaxed/simple;
	bh=IiO6bqvHvrlwdns6n7FZHG/SXwx+AjPzl/gQzbxXnnU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hAVOddqQFIrUyMTy6yg9P83ZA4+p0l/nKCtVVGqT9bXB6DGR60+9yWAyQfMR3DNN5HsGzlSUXjag8tgXEP8Vn3Wmc5wNoyWa2/Babp3u1UJr9hY7MTqPu0pphAQBXfG8qco/BtQPs24GpSjAu2H2KoUcD+QDvd7aXbIFgU/w7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5uBmvJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20BC4CED6;
	Fri, 28 Feb 2025 05:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740720086;
	bh=IiO6bqvHvrlwdns6n7FZHG/SXwx+AjPzl/gQzbxXnnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q5uBmvJ3Y83djE9Wfivnxqk2ynyzI4Xxwr+5NwVdbpRrOk+S3xHKNvPm2LuA1wA6O
	 rU0fMxv0gOa7Uc2P6nus3o6cM5v0ZRnyhaUncUt8hWACkCIqV4ldwPzGF2T2e67kpu
	 IV/vk57Rw8SvYG8wWogG6WfFNGrCzrhgFg6IpE3C8QyLD4vk7oTEFx0G/ghyszszoy
	 EsAk3oVw9j2sfbBBcU5iyGHTm3Wh5QcpUP7vPrhUVAjfQI3/3qzvxDvsopMJzKw8lM
	 uM1OsedaRh5ILf0f18oAsCyLJzAI5QeHKXKqZNlPrir+Qk8mAV5V+mxMw9Z0rUIJ+K
	 n5WFu1+5jXjdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB185380CFEC;
	Fri, 28 Feb 2025 05:21:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzCwv8Uhq9BzwMJ_rQoxEBAEFDQzcFJms=cmD9Njrd3hw@mail.gmail.com>
References: <CAPM=9tzCwv8Uhq9BzwMJ_rQoxEBAEFDQzcFJms=cmD9Njrd3hw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzCwv8Uhq9BzwMJ_rQoxEBAEFDQzcFJms=cmD9Njrd3hw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-28
X-PR-Tracked-Commit-Id: 6a5884f200693eeffac4b008faf1e8bdf1c92af5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76544811c850a1f4c055aa182b513b7a843868ea
Message-Id: <174072011849.1692901.9839987485498147780.pr-tracker-bot@kernel.org>
Date: Fri, 28 Feb 2025 05:21:58 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 13:10:16 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76544811c850a1f4c055aa182b513b7a843868ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

