Return-Path: <linux-kernel+bounces-402308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4F9C262B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7422821D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FE20B7F1;
	Fri,  8 Nov 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBITd6Wj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DA1C1F3D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096350; cv=none; b=jt6iiwvHyEbEN6324mj7ksOFNK4+hrFfmKH1nlQNke1IgdI0ELoa0Ns584FbXB8WBvB+O9JEubv25apAb08iu0ywY3eWMXPxDn9XKrQCA0WdK3DxJjvMeGF9BqDHM3zqVjeU8lnFAfzmCmpM5aoTRoMhvUbtd+O2iH+3ctxjUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096350; c=relaxed/simple;
	bh=RiInFnZtd+yq4KTcsnqpGXeJXhkdBPO/yaqnzdZ/9rE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YTlPlN2b7cX/UfF9dwlSdgHiqtsA42LPK7QBmZueWyCNYMFGtp30BhuKYLfOVzAr7L3wEBHpc0YoecnuNp0VouNFgqFrkoq2ku0x0uumQy70J0dTRYYhLcWBLaENujaetbJbwYoI+QcTLnVsS445POEdtvxxJry6VA7/yFF4wRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBITd6Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144F0C4CED0;
	Fri,  8 Nov 2024 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096350;
	bh=RiInFnZtd+yq4KTcsnqpGXeJXhkdBPO/yaqnzdZ/9rE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LBITd6Wj5JXYnA5yqyaVCEggcNkE4dHAGZ3bS7v9/TF7Unll93SXYvTiOYv21SmDA
	 bA4AVOpW5q+jguw1WKWfIGtzIosLHfkESD80B1kxmRpah05kt/SQ1QB6BvKkEg3C9K
	 nbhhjjICnzQAJ5ZlxG3VSURVzCK9/4vTHcwnEJyDuEuWCPpRmIfSfCGPIkXtNe/wBE
	 /EXIwe0SnF45K6f1cgvGBlzhoj0DC7PIhF0FViJ/MKPRuaoV8/wyksh/q6w4dOz5X1
	 K94BfzReq0SYG2TPfI0Z3lUM+fShlcvxVqLkPqCmCdMuENbq3xduJZOBdxxnmc84KS
	 eLewC2Y+yzvwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6E03809A80;
	Fri,  8 Nov 2024 20:06:00 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9typGnBRiPLJwjeYnWSWAXtuvi_4gi55zBXzLGD7+Kus0w@mail.gmail.com>
References: <CAPM=9typGnBRiPLJwjeYnWSWAXtuvi_4gi55zBXzLGD7+Kus0w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9typGnBRiPLJwjeYnWSWAXtuvi_4gi55zBXzLGD7+Kus0w@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-09
X-PR-Tracked-Commit-Id: 1a6bbc4d9e55d6c9df2dfe7d4f2705a544d8ca13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952a33dc08cefde50540cc82abaa2e09f37ef540
Message-Id: <173109635919.2749259.3637012080355381927.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 20:05:59 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Nov 2024 05:31:26 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952a33dc08cefde50540cc82abaa2e09f37ef540

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

