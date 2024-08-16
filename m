Return-Path: <linux-kernel+bounces-290056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E45954EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3501F265D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223E1BCA1C;
	Fri, 16 Aug 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRvGps54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715E1B3F0F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825959; cv=none; b=IoA1uo5nGwr6c6j45BpvdVJAenkaQ0Pob3O9X2/TraW7KOMz+a4OdkuZGnAMj+mMRoZaSMEh56RGYze+FskDv/5QHj3uSa4zcBEEMykDjIzwqcGtKmqDa2xU3edxd5djy9RtdVy2t5O3E0Lcu9ffYsRl7KYh+rxcRAzY3br4L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825959; c=relaxed/simple;
	bh=EPs0IqSoJTfi4M7WPh40SrWqMnzvWxfTqkGPO3jiRnQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D7nhNWvRY2EExz93eBxwr4ZvydXZDMmyuQzId7Who04egJgX944gkd59I3/0vReTsWwZxhosry+MWkUbKW5p5ZvnmCVM386nwX94X6ZkXBAndOvcFBrrY2j8giFvsxTEMStd4GPdWPpIJz7hLlN8W7jp5Hm/ZFwk+Kv8c4dKWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRvGps54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ED1C32782;
	Fri, 16 Aug 2024 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825959;
	bh=EPs0IqSoJTfi4M7WPh40SrWqMnzvWxfTqkGPO3jiRnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oRvGps54XkvBUTtCqz4PwCZl7oLA7IH9tpJBT1ADuMe0vfzfMDzpdpYzLAC1ik4LH
	 vdgnHe0L1ZJMdePLzK2/n8meL4sxQp+mkj+HZwrHOctNNwhguboj/Rd48e9Li+z07E
	 yK9Ei/NqA7mplB5BtmljWaXeKR7hW3ldvjS1Wf5G64EaiUN1OAJS4uFG0Ewv4OgaPD
	 7Prugn9ntmc07Ghhjt8RJnAFo4bo8amyyX98BMktK++lzX2OJv1UzUO/RsXsOXeKiS
	 fvLUjN0JkVjVtgSM1kyUyen5cdG+47lZndKxlixyUUMJ8aEbIIhIO9/Cu8Zyqt7EOL
	 CyGgpb02IGRww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB42138231F8;
	Fri, 16 Aug 2024 16:32:39 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx8NORNyjwOMapLrZwGEVxgVxYDmChmkLOwz1vyYUgoGw@mail.gmail.com>
References: <CAPM=9tx8NORNyjwOMapLrZwGEVxgVxYDmChmkLOwz1vyYUgoGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx8NORNyjwOMapLrZwGEVxgVxYDmChmkLOwz1vyYUgoGw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-16
X-PR-Tracked-Commit-Id: fee9d135e2fd5963a7f466cd1ef2060731a1ab29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37b20e9a5810e132a21c54f858043b22671396dd
Message-Id: <172382595844.3569819.178240747837345650.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 16:32:38 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 14:09:28 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37b20e9a5810e132a21c54f858043b22671396dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

