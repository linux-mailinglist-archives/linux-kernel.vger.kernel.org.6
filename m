Return-Path: <linux-kernel+bounces-178271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233C8C4B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431D01C20FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F35381B1;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO7MBAXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F891DA3D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655090; cv=none; b=fZcTb96E5wfylQQrLDgV+9mVT7wqVaGfr+l7HzWB4eDSjA1dUbMN6hFJJwLgCY7T7GY8yBUjOhlseFZXDjrv7ElYVWfull8nju8KxrwPy1hfxL+DSdPidtF2jB8hDLlnqH7XVuhk+15G9Fx+7Yl4zOSvNgXFMejkS7JjFZ+JHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655090; c=relaxed/simple;
	bh=CcmanB7/UHpNJPiBLbfGX7iSlnRoHr7BDE+iF2AkVTM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K4FL2hzFC3o2bj8h5AKZ8DgSJzUA3nT4D71/hnl4WJa+MSNAyTnz6UYH/FohSM2NEAV0Os/afJebyPKTSv8ZXhWRFMsPaGgBbcH70QdJOkCgju8txgBiRWwu2y9SF90MujGOdQBsfqnJWoNJkQdHYFw5HFvRW4Ae8RzjI9wvBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO7MBAXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66532C4AF08;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=CcmanB7/UHpNJPiBLbfGX7iSlnRoHr7BDE+iF2AkVTM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tO7MBAXWYX4RCxMROymiunct8iUpf1FcMfLK3XvUMS//QGvhWwJbk8O+VYl6oPFar
	 gNMD/1JcHa/08DEBNXjlplQqGV/xvp5SyuAVKCRckqd3v+b3r4emGmiZjDTl0uw8Lb
	 6oqVoAcXS2wX/+bmTLsRgu/oxQyBAfoox7YTNqMgVK6+Xt5KBTh4DAWoqK9tK8LX0i
	 3budjicdBJgHAORrmg71+ScxkPpNr2pG+r9A26Fphyo3YOnDOz4jtMFug2sRbbJE53
	 hSxZhEMveBNY10pvyJI1ZbIhMG75BU6tyctl487oJegYqIsroAGZ/l1oduA94uRxgH
	 1jkixDw7OzHzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EDD4C433E9;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/entry change for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHCrJYrQuGMh3PS@gmail.com>
References: <ZkHCrJYrQuGMh3PS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHCrJYrQuGMh3PS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-05-13
X-PR-Tracked-Commit-Id: b767fe5de0b4a5057b070d8cdefdcf6740733d6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31a568b54c0f828b8e45b178a8a7f5907084943b
Message-Id: <171565509038.649.7431900715817384307.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:35:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31a568b54c0f828b8e45b178a8a7f5907084943b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

