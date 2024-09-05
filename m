Return-Path: <linux-kernel+bounces-317600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7596E0E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F63B2875C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802291A287C;
	Thu,  5 Sep 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiBPhfdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AC1A2C2A;
	Thu,  5 Sep 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556328; cv=none; b=OMJF+VMNt4if6hoyQtOUweO135BLLfAXlWXjFtCS5XfbE4L1mQEd3d8ezt+zZPXlWzib8fc50NNqPWsQ5ausyEpa/BBUchOUtNS1E/ZGvbGrTfVFx/M5j7HrqNCx0sImJXGrHIJeh3ubB10g9SHFY4s03Fi9fFckY8bo7jzyT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556328; c=relaxed/simple;
	bh=CXZpTUb+dJJBjGu0ZJ/RiAZAZnr+PAUMMRpbLKhPXU8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cQrcJnAZzH7n3Ff4x6v9OyR9rhwzH2iGw8iroLhUc6qmIPPhuayJB0DvpYTFlpO5cXXQFI3/j4EGoCETQEON8mFvhGTbSUc4EWV5BTgdseWmaobnHlgTRXoGtJmZb3VlzkrGY/NC1UBT4ZKbEid1yGTv8NxiADGJNc0bqRCq+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiBPhfdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC4C4CEC9;
	Thu,  5 Sep 2024 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725556327;
	bh=CXZpTUb+dJJBjGu0ZJ/RiAZAZnr+PAUMMRpbLKhPXU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BiBPhfdgXoivUEs9mydRrY9wK7F5sbf9lrBc8xhHc85rLdDeygYkziVraRY6JwO7u
	 GlYLg/UHWRbX1XIIjLMHTL1hFisglWEYlwhU9hLH0vg0Lrt0n+XNR4Mk2iE+hfj6IP
	 HTpRGSJY7bS1Liy/F1IWt1RLUplqLhTotHHs6dLhAWwZwwkkYVRJBf7+gzorKCUo9I
	 lTxzM0GHyoH235elpCCebGeyrRAde2Xrzyo1LTIgEUvcdoGRKSAkrL3rC8baNixdhZ
	 mCogwVIeQKvsWE6RV1h6RO5oLBhZ5JqvZI7Krzn7ZxqCexwaOL3zIQmEVRz5h3hL9z
	 VSotYd0BTXk/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED13806651;
	Thu,  5 Sep 2024 17:12:09 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-6
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240905115603-931030098@linux.intel.com>
References: <pdx86-pr-20240905115603-931030098@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240905115603-931030098@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-6
X-PR-Tracked-Commit-Id: d34af755a533271f39cc7d86e49c0e74fde63a37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad618736883b8970f66af799e34007475fe33a68
Message-Id: <172555632793.1768720.7525000725152300238.pr-tracker-bot@kernel.org>
Date: Thu, 05 Sep 2024 17:12:07 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 05 Sep 2024 11:56:03 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad618736883b8970f66af799e34007475fe33a68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

