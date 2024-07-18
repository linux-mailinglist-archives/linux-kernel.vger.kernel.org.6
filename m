Return-Path: <linux-kernel+bounces-256642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC693516A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AC1C22353
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0817D22EE5;
	Thu, 18 Jul 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZOvrB+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD07145332
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325621; cv=none; b=WZeq7eS/mC21nHfcaTVIfeh/zDEDjLNrRuN6FZgW39RHTyKMDXkfaykxhZhGK8aMqTLtKtoPA1kTiUS0Wof5ILTIgsQL0tW99xAMdaHh0dtdvyc0HhB7IFDK89AwKN0+sJG26nmIEXDdLPj4HXJZJRp3107y5BiNPyJaqFfDK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325621; c=relaxed/simple;
	bh=BNxOr+PKf5mfSUnC5XVsqhN7i4Qre/JBnqZaBkvH6ZM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j2q3OzZRpgaSTznOkD9B3UehaUP1X9zRiZfrKjP0XXX4m/RlN1NVnaMeqtwfmzeg+fSvq5vOyHV9VY35oeyCrEggzQljCu2frY2ON5tESnKQNhW9zs7NmmlJjOfgx0ivJqYnCsQdozcbBr8QXLnTiVXddbcCNURYXmEyJKcTSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZOvrB+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D281C116B1;
	Thu, 18 Jul 2024 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721325621;
	bh=BNxOr+PKf5mfSUnC5XVsqhN7i4Qre/JBnqZaBkvH6ZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nZOvrB+kTmJgF41/lpt3JvwINnD7zBFYCh4igpD4DI8tgIFQ6FFXOsAZfU6cnshhv
	 nvxi4DNh/mRhT3tdh5MmJUWKEnXHQ8/M04dn+l3Qv7WPNgCJHS2XexlqTAvuWWazu6
	 XC6SuSNUcYMAO8UPSP/PESk65RICP5g51m8ijbrD5WjiJnRqj/wEyNqV2xeahtAiCT
	 ON/Td2fBjrJMCq8gAd9K/mxLqY0Xqot23BJpKmDYs53AlJ08VkQb8j3/T5I/0L2jLr
	 3bHpbjKZIrbcnzgSJ8pLIIhPNpa9TMftyeJDpQa0UXzENORa3SBqbChN7wb5e/C6sN
	 UfSLbVDYD4fPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1E0C433E9;
	Thu, 18 Jul 2024 18:00:21 +0000 (UTC)
Subject: Re: [git pull] drm next for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzsihck03q+ooJQhTdJsuT3eQ96zF6gd5cjDwLFu_zJhA@mail.gmail.com>
References: <CAPM=9tzsihck03q+ooJQhTdJsuT3eQ96zF6gd5cjDwLFu_zJhA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzsihck03q+ooJQhTdJsuT3eQ96zF6gd5cjDwLFu_zJhA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-07-18
X-PR-Tracked-Commit-Id: 478a52707b0abe98aac7f8c53ccddb759be66b06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3ce7a30847a54a7f96a35e609303d8afecd460b
Message-Id: <172132562105.11827.13490312017811279767.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 18:00:21 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 15:40:08 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-07-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3ce7a30847a54a7f96a35e609303d8afecd460b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

