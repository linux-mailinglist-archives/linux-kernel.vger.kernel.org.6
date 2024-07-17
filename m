Return-Path: <linux-kernel+bounces-255645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC9934329
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8702BB21532
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6C18C337;
	Wed, 17 Jul 2024 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPkNjihF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9618508E;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247510; cv=none; b=MrYADj0sS0cKn0+fVS15n+hS+hmUiGWFn6y0lMjgXNsea8ggqSaY6yfXb4CKzdm/xcPtKrekfmJEDwC/frf4IvMDdiiqT8ZYosac91pK9NJBoS13CJyqQ1D4+Gn2f6YXwTTM9u8jWrUp4XdwwvLKkrJZQYtxgKNuQL8i4p03ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247510; c=relaxed/simple;
	bh=5Bi0+EKdvKCfvtyTt+hs+E4CbiYEl2SnjyKl/TkPODQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u/KSilpjMi2WBkrZ+8TVYPu9R2kUmDaLxrC4QQ8xh2Yd7RjUhlQrSRt3J2ZtwUp7RtXdgEk8JkoRvXBsG/U5Fb8qYtXkE2LAEj5UEeIb5/Bh8IaBrS99PZ3tBIt7wyDdUQpt9yvZ/FX7ogyPItlls/Ew8dYodcFHjXVO05FxBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPkNjihF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 807FCC4AF0D;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247509;
	bh=5Bi0+EKdvKCfvtyTt+hs+E4CbiYEl2SnjyKl/TkPODQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GPkNjihFA0uT0OGgYigyMwcBVzjXA6rinaaGBPSbSl8D+kmJZqJtYuKlgUCDSSnl9
	 MlMqHmfD0afJeF3RyfUeUeBgdEWff4gVNwghhycyTIfBUpT2K/Zs59jQi14nNFuPJU
	 wSC8x3HU6R9NmIkTrOmqAnQm0Ml5BmNAVmnb9weCjWb+Yl3gNs0fCrRIgNBewQKNIs
	 A3q6el2bNVkHUzJ72AxoRSrYV9xasJdyon1lpYqEKlC1twD22rkQMqObjl+u3A/Xam
	 uEhXOGISA+7woPw9a8PembIU60fgDVkcV4CRuJ8zW2omE/gTu6zo3MZQRKJPQD4QA1
	 kqeWVuR20hb5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 778E0C433E9;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715174757.876203-1-agruenba@redhat.com>
References: <20240715174757.876203-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240715174757.876203-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes
X-PR-Tracked-Commit-Id: f75efefb6db305b5b5c56a9b9ae2d72b54f20780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0
Message-Id: <172124750948.12217.4645849621171357423.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:29 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 19:47:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

