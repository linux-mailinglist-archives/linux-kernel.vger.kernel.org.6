Return-Path: <linux-kernel+bounces-445824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294709F1BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FA116A0D1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDFD199B8;
	Sat, 14 Dec 2024 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5p7UXwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EF18052
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140120; cv=none; b=SnvkCWsfmCRaiyuyydouk8GAkjoll6+jyUo4tGjhtyZ6zMUkw+dm6yJ04F9ZJ8dgGQHOhjgXdUZRWO7invS5QxWW+lc6GwrXBYSpicwJYMf8BCLpZqMDhOM1p7zqNtPJ0DQzYVlYQJS7TZ3PRxf6B8sOuliNe/EPbcP8A53KL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140120; c=relaxed/simple;
	bh=FWO3E/XoZLlJuIEe8a6qtXunEBSJTNsRV4xPaCmttuc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cnT9m/5vKg2/pXQGTLfWkwoeCYkkM/6/RTongTHAUF58myzEgeWW4ipyySCXTY7UTriZ2b/QSPCFHlS9WD4Q4dnvgvjbbjVpd3LB8/YzutO51jhAP8Xt7RqC98/kwPetBV3FThEE80NRgb2AarmgWP9YdiuE3GEMkJGgI6Xo2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5p7UXwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEF4C4CED0;
	Sat, 14 Dec 2024 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140118;
	bh=FWO3E/XoZLlJuIEe8a6qtXunEBSJTNsRV4xPaCmttuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X5p7UXwTVB0d3xqZ7MMdDgZio46PijTq0/y46LUSJ4yyT8QDzK8u69pREBgk0lwZc
	 n7ESAmtcyM7rYiPDhbbdfxH4BRq2KZ8jnuUSwvaZ/n3sDrWEFtRoAnZdJQCji8NwlC
	 tuePmWSeF33X3NNf2TPhtHUJshMy2bqrYpMt2CCymnAS/huWXh1QtW4SxlOwJnZYft
	 JY5ZFA1W6vC5TuXiJrvHdZLqgQ1/6kQ/Hjl7rfVanybdvw7Ydnb4fBw+yO9l1+aJSn
	 OVTsdaE9Omdh218r/P0aOSRxKliXheM4kkGRvIpmB6U5OK4eKAAt2sk92XUK6RiCmg
	 dkTuyhyh3mI+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715E2380A959;
	Sat, 14 Dec 2024 01:35:36 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyHzxubr_sRuNSoPdJB4uL=E1cFzUzNxY1dPrOW=y-NdQ@mail.gmail.com>
References: <CAPM=9tyHzxubr_sRuNSoPdJB4uL=E1cFzUzNxY1dPrOW=y-NdQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyHzxubr_sRuNSoPdJB4uL=E1cFzUzNxY1dPrOW=y-NdQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-14
X-PR-Tracked-Commit-Id: d172ea67dbeec5c90f72752c91d202d5718e3754
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e72da82d5a6deec67a680434e1f19ba3996fbb11
Message-Id: <173414013500.3218065.12670757919328687969.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:35 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 07:23:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e72da82d5a6deec67a680434e1f19ba3996fbb11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

