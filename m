Return-Path: <linux-kernel+bounces-421781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B59D9015
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BFEB27C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAA10A1E;
	Tue, 26 Nov 2024 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb0mLxL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2DD528
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585277; cv=none; b=gaTdKEijLzcTx15EduFIz13aeBJT9aJw8J9mKHSp/jRGQvR9K0EeNO+He7FTwEfKVjuDcYHjdN3PcIuEroGhSmXWVMRYGnSY3oVOicRHi4NY738QufJ3F4I77yxbTcPWHYkNpvPgsrXgP9F66fna+b+hVyPKfgVRqc1lxZYs1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585277; c=relaxed/simple;
	bh=nZlGcawCFMz0vnikdJS/S8mPjXy8ngaNnZLbbvsxREE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lYmQBzht71uB20S1/y2GAu4mYAcS3SbwMxbaFLkLoELWopv5R/y1sbYWWYmc6+DE0x/6JFiQmQutLI8XpwYqXJtnPFvHCBgy5J/nMl9LJGDpztr9q8WQLwYUGk3l8/yjNlws3WrBpfkQt8juKEM1OMIWHfZSZIwqAWlhamm2rGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb0mLxL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D27C4CECE;
	Tue, 26 Nov 2024 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585276;
	bh=nZlGcawCFMz0vnikdJS/S8mPjXy8ngaNnZLbbvsxREE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Eb0mLxL1igDKXTk9BlsloK7Fdm0pZpF5hd5bPP1NCvMJE2sJniNFDY7M1iXaeMk/7
	 FPd2qBVDK8OKaxM1krbHvZYFTMXqejECYdsCbEnEOwMUR46Q/OWBwI78/NuxUpfZLS
	 FS5n21C8JkeFzknFLco0D/zdLGhaFNLxM03Oz6xT26bDZHIYcEGUjHfbyGDSNeomu8
	 qAH89MFUSnJXfO4iD9s9TQ9/YtXrKoVRDp/txLPwsihBVr1hwjWBdxXpvmvpX51ZPb
	 u0hMXkaNzs+1qxZKJtX5HdY8xNr89drEvOik2FhMkKaY4zN2iqQ5PSFiGaUL7pFAum
	 IknTWFKNjdkmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF53809A00;
	Tue, 26 Nov 2024 01:41:30 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202411210641.BB0D295A@keescook>
References: <202411210641.BB0D295A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202411210641.BB0D295A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc1
X-PR-Tracked-Commit-Id: f06e108a3dc53c0f5234d18de0bd224753db5019
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36843bfbf7fdeab459e164b0ed8bb939660c378b
Message-Id: <173258528896.4103683.17699018756008012081.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:41:28 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Kees Cook <kees@kernel.org>, kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>, Thorsten Blum <thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 06:42:43 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36843bfbf7fdeab459e164b0ed8bb939660c378b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

