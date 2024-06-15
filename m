Return-Path: <linux-kernel+bounces-215680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5079095CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58128609D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418918042;
	Sat, 15 Jun 2024 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHrK/AVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F36175AB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420479; cv=none; b=pqRjr5DJoCxX7xZS/iLBn2rBTdRGSj8ilfR5As4z7vZjHnCMoELFfUC+bfz75pxh96d+meDeLyB40E8XTxnLk7RiHD2I7sp//RFJJPMteqewnjclTuWy0URHNTXZJCNRiqhmH84KoLmgoP5h97KmOSW8wGgxs2wmtrQAvcs+fjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420479; c=relaxed/simple;
	bh=2WxBplAAQ71N5XwRDn4LeaKrS1hGSIRuVcFtwLE/t64=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LeDGLpc0wNsA78o0FPJRqWGA4dBrJWf1MeIOwPI3dMb4rLzv5Vgq65O7Wk3RuChgMdWBCwTnv4hp0iYvDOcSyn1wkpgZC7Dw6/+23IHdXaz0mcfc+B5kKAOl/clH8RIIk2JFqWAADmJhOcwbJD4qR1odOrPd1TjS6041CCAR124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHrK/AVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FCF1C4AF1C;
	Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718420478;
	bh=2WxBplAAQ71N5XwRDn4LeaKrS1hGSIRuVcFtwLE/t64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lHrK/AVyZJ393mFOPLHQgtbSJ6YeT+BwLAqw02mRmZMFUbeR0o8zBTlZ54URet/U+
	 fg5/sEAQjIYwzXWN5Sxaa0dIbdjPQMMfZV/FZ/cjHF00OfFkOU6LEVTKSb/gHWYhHk
	 DkN41Kw/xh5NKm0V67LUr5C6VWUhk6pGnAH11UWnUcqGmA6duX1UFHCpLFrTwVVY6N
	 ZonnHypJaxu/dBD/fQL7XxiuS57Yws38aDzKMrywi5v3M9q5sZK1H727LMBxhZj4XV
	 RlmVw10lJ7SaA/UcDQGAqdfrZnDRqRkiOdKKOcw+mPGX1y58nAcGL6uKWuvEsdGQFE
	 Y38jt1ye632Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7527CC4332D;
	Sat, 15 Jun 2024 03:01:18 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw_3xzMPo46mPYfkPpnxy8jgeBy1Q5Ep1pH8Ws2BdA87g@mail.gmail.com>
References: <CAPM=9tw_3xzMPo46mPYfkPpnxy8jgeBy1Q5Ep1pH8Ws2BdA87g@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw_3xzMPo46mPYfkPpnxy8jgeBy1Q5Ep1pH8Ws2BdA87g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-15
X-PR-Tracked-Commit-Id: 9f0a86492ac4de4d1db718986a91833fdc914a54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4332da0f2b5cccf2b195035a3f30fce7c1bb7a7
Message-Id: <171842047847.4182.809836259225642221.pr-tracker-bot@kernel.org>
Date: Sat, 15 Jun 2024 03:01:18 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Jun 2024 08:05:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4332da0f2b5cccf2b195035a3f30fce7c1bb7a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

