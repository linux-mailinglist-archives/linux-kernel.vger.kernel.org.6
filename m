Return-Path: <linux-kernel+bounces-361767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2299ACC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EFF1C25C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1981D0B80;
	Fri, 11 Oct 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5pAlbG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE71D0431
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675241; cv=none; b=N72yJY72IIn2ljGSP/2vcJ7pkzT95KcQfPVVfXDH8DgQJYGlbQm4yOQK3FM1egb1x4a8G+7Gz2RQZ0YCja3AwCyKd0H9kc1uUxT852CB3GURS3GtY2DChwvU/H0Uf8NYlrV1BHHgpCrpurD4xZG9VU6+TJntUlH+fwwpfEjpvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675241; c=relaxed/simple;
	bh=YgCjjDO3uX4OroQ0xWe2A7Ve/fVrRQnGKrJmXP3HCSM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GXnC2Re9saYRvofVFt7OVTEb34ED7lwgxDEAGfEh+I62K67tqBFahV9HttUZnWVgEFt0lDPG5ViwgCRkmxKAkUhNxeGAnuBCbNmH1zDBKsTAypXWlhwgKIlpHCRLnMavlPlIjfFhHbXz0nzIxT1t3S+YuT0dFGq/gogUw6VoQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5pAlbG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F2C4CEC3;
	Fri, 11 Oct 2024 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675241;
	bh=YgCjjDO3uX4OroQ0xWe2A7Ve/fVrRQnGKrJmXP3HCSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s5pAlbG63p7qvVDvj8tpwnJqfs0NBCYeR34bORp4z9AFKPcRXDZc6n/zSDQqKHVjS
	 bhICE+otxroEFPAVZy+hH7il+N/sPclYZeGKhgaYplF1fiB89vvFqPi8Sr/Y+0xViG
	 9sOwEXcmdP/+eYz1eiWyAFwGo7ifAsMvS6oVrmxti4r7opcAplXN7T2y+Xsvp8TaXm
	 M/FuHrOtrQXXFinzV9EVDMdvEy0AtgWJderzFvvREW6dQI02fkRAWz4+pihDzt8u6/
	 xtyc3tH9fcRu62kyl7hYsYPCdYRHGA7kmdD6D4meNikc7uiKaM0ucgJEaxrOgmMOAm
	 J4RHTGAull+Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB338363FB;
	Fri, 11 Oct 2024 19:34:07 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyf6kxBxT7H9aPK8y8RDDu7Bx-mLEVPT1zWkapNaXKpcg@mail.gmail.com>
References: <CAPM=9tyf6kxBxT7H9aPK8y8RDDu7Bx-mLEVPT1zWkapNaXKpcg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyf6kxBxT7H9aPK8y8RDDu7Bx-mLEVPT1zWkapNaXKpcg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-11
X-PR-Tracked-Commit-Id: ac44ff7cec33d5c2d4b72d52603552ec64c1a8bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: befcc89362383208f62b15887592758165459e3d
Message-Id: <172867524582.2975359.3347201287082078558.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:34:05 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 17:17:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/befcc89362383208f62b15887592758165459e3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

