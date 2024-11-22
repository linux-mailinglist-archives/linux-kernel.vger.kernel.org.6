Return-Path: <linux-kernel+bounces-418807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D229D65CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024C51613FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD49176FD2;
	Fri, 22 Nov 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFZMa1Ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F3249E5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314743; cv=none; b=RdpxlJhjwpIHZS1bdVi5zbdnuOOnzbk4jA8F22BITHCHfao90DWVeARh71O6rGQJNA11N4RZTW5OVQImCH0WpY4a5+4wQ560C7FzcQkght3VRnDZP77GdT7dmxr7mzI0mBqD/Mz+lfsQpYKZqBzjBnKiUHzs9EDHXHwp4MrQaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314743; c=relaxed/simple;
	bh=D1xR47MRdkqdEPNct1JXZsJHK5UxxjvHt181/6zbhmk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vs3rXMMS8UNChSbnidpneMW42IQdp6rY3iao+uyVhXQw5eS1A9LOeMtX4YyYsJj/IPE6mUXJZR3A5rsKFF8vKnsgG1kVYqjJb1/qomZF5QClyh4qfnLZWCSkA3UVoDg/c0TmTJAdBjU8yxCP+mFTWVmZp+aQy5YoqFKuIsTnKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFZMa1Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3BC4CECE;
	Fri, 22 Nov 2024 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314743;
	bh=D1xR47MRdkqdEPNct1JXZsJHK5UxxjvHt181/6zbhmk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PFZMa1EdaeKyBG7KtSHYy0RLb+wmnBazZle0TdiH1b5511tl7/zWD3CQr885Ma6L5
	 xlLABV55VMo6RyD/Ck1o4/zPhAMc2QgVyz8d3czduNgn2fCa2sWRtdzvmD10Y1GEfj
	 KDcDLkifWVFt4BEGHxtKJXxd3PwF4G8mh/bNUniMbucfUMjCSerpdnECV6KV3mvC2r
	 aOPAqHc97hCbZJfYaKs+xHO6npv9QvoTfwLyv4WNaX2de7ZQ82BW/hkMRxqC6b2F3w
	 GrfIF3AHcGqVUCUplhw3X5km/2dhbBV/IB68IWG5Sg5dLVcRU4cPzye9vH09glqpi3
	 FuNwm7hzf7h8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8E3809A00;
	Fri, 22 Nov 2024 22:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120010733.807113-1-dave.hansen@linux.intel.com>
References: <20241120010733.807113-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120010733.807113-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.13-rc1
X-PR-Tracked-Commit-Id: f060c89dc1a3cfb6db3894e1d96980a568aa355c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be9318cd5a36ff67689e0fb0f8f5007a56290ac7
Message-Id: <173231475538.2827182.16197483655522881493.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:35 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 17:07:33 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be9318cd5a36ff67689e0fb0f8f5007a56290ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

