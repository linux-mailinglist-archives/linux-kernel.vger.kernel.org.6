Return-Path: <linux-kernel+bounces-349781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFDF98FB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF51F23805
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC21D5AB6;
	Fri,  4 Oct 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TncjAJNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73917C9;
	Fri,  4 Oct 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001338; cv=none; b=BiXg9ionSTJzSyeJJ1NPKi9CR8NLmRyKYC0Ck6EefDWw0NiGM87xhwrFMUhc3rdOrjOVo8GMR/DPxn8qBDhxafXzFomCrPbQdEokh8aHMp3K9oOcz9SbNMLCbrHZhI/W/uqt5tu2G5sTGDIVQwANq9d/cFUoAzsSiOC/0dYyfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001338; c=relaxed/simple;
	bh=cemUmLXTgRkn8JAsLHltKD3CwhNlqtdTWNTEpiFj4dw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cJ6MKX7Xk+3iP1GZJ66yvPL1BYWOy/8VynEw8u0/4EvEEpr2kHmpIg6pvIrAxNS8qABOlnraoa29RDEYSxBBkDGbHhxW39C8djNm75syidsgM2Ohu4yrddMoCkIEM8ULSLbDpqF7iC8VLpWi8kXwy5SKZPF1hc3jxXERRYjJlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TncjAJNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4780EC4CEC5;
	Fri,  4 Oct 2024 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001338;
	bh=cemUmLXTgRkn8JAsLHltKD3CwhNlqtdTWNTEpiFj4dw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TncjAJNpfo2Ozn0gYg1mLEBoaBJ9CohsXq8pthkbSj1zD629YFeiQkpbMa09lGcsU
	 C2luvfwDkbWU064aerEByg+9CUfzFg3Wd6FbWQhxuc69kVh5RdkaPcXp9xxeEPIXEN
	 LC2C2X9ZOqBm8+BJG8Y32YrxtY3MrtjL+EgeLgsIoCo4EmfwoaQZKmh97ydqD1BQLw
	 T9ucM+0cX3f947nQA1xd3X/EqjYvFgWsEPGFANDXCJUI84Zp4n6o2dlvlpaoDnstFC
	 26LU9lP7ToweYzSjoWCPQUNDsu9dB7x0gA3RRW3QLQU52wuSxCRwDVwQHCAk1cNPIV
	 RqSr2JC98sICw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2CE3803263;
	Fri,  4 Oct 2024 00:22:22 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241004000349.675431-1-ojeda@kernel.org>
References: <20241004000349.675431-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241004000349.675431-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12
X-PR-Tracked-Commit-Id: 05cef2c4a421ca09ab9761a95e61423e59e5bfb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c559323bbaabee7346c12e74b497e283aaafef5
Message-Id: <172800134141.2042091.15540695441271383237.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 00:22:21 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Oct 2024 02:03:49 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c559323bbaabee7346c12e74b497e283aaafef5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

