Return-Path: <linux-kernel+bounces-169115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C989C8BC34B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D0BB21121
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D736EB40;
	Sun,  5 May 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PknaXrCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3F57C9A;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938236; cv=none; b=OJWOAChrZcMc5ABc2j+tHuphLkNA2zjlz7Pm1ZeOwROEQLDyNzCxvfjPcw1zc76jwHrkLb5/BhMlfAS8dgjJh2O87rxpfK+X9c3/vPMFYy2ZowPXNlRMjRf5cOyKijgCKxwtkGz3owApR4VDj2vl3FB+TX3+SvTZrJ4zCr0fjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938236; c=relaxed/simple;
	bh=QT/cnNhS/lRNYDSCAVhuDgbf62pM0ckRtbPm0TtZsmg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=htQybUiwLcLfXdUXTAnXvyHeG+czN6wmxNhNc9mMVfv856rOQLwhR5V/H5P8dF559lVPnwwsCWYaRBWYZnjHw5P9sGL3fLRG+AZ3ojkVvIJ7NMC8BRt7j+sjkYFQlNkQGt1McmzRdQ+qnaoYbXwms9cDgFn8tUNEJT/8KBw/r90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PknaXrCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36A12C113CC;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714938236;
	bh=QT/cnNhS/lRNYDSCAVhuDgbf62pM0ckRtbPm0TtZsmg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PknaXrCr+BQuQZ+WhKOU4BzIhxg7Hn1LqLtIqVDcZPziqaUNhz0LTnqZVbq2iKBbH
	 YvgsOOOlG9PNYeZlH4SgNnSz+8vROy6z3IDZITNm873UPhSTyDIx22OEZSfqMyolvH
	 OeK6IctNq8fFxdIzvrjXY1L3pyP6dkirdbCBjvk4nd5yP8pOjsPZG0iLp/3nMa/yhg
	 0krUQl2uvupr55rxnaPhtReOJocZAMa0583CjiyClIYoXXYfhtogvFCo8JSYRPWLGi
	 hMLca37qZIeHrfJnjEVezoc8GfcDn5IIFb4Xsy1oTlqgMvWB19anIC0gFv0YJ7KkLY
	 lgI/7I2w3iHsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A0EDC433A2;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240505095735.GAZjdYD8m5ZAhNGd4_@fat_crate.local>
References: <20240505095735.GAZjdYD8m5ZAhNGd4_@fat_crate.local>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240505095735.GAZjdYD8m5ZAhNGd4_@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc7
X-PR-Tracked-Commit-Id: 1a24733e80771d8eef656e515306a560519856a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f462ae0edd3703edd6f22fe41d336369c38b884b
Message-Id: <171493823616.6787.10215282157012022983.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 19:43:56 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-edac <linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 May 2024 11:57:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f462ae0edd3703edd6f22fe41d336369c38b884b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

