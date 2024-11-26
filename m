Return-Path: <linux-kernel+bounces-422871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CBF9D9F31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30766283306
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BBE1D63F6;
	Tue, 26 Nov 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJv4w1Fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D511185;
	Tue, 26 Nov 2024 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660280; cv=none; b=I45b4gM9dLCNA0721xCJGa3FHphVD1BGSHc+NAB6O7zH+YsX+YvNTcFBYIIZg3Vof59HNJren8FLmh2HtnS9GILo/3uZcHg4N9FBdc5Q6wgq5S4tUESy+jqlS6mFMK+rx24O76wenn9JaXXUWXxQYRUJjp+7JTP/gemXKeYANEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660280; c=relaxed/simple;
	bh=hApf5LvO5MwZb/cOd2RwfH++mx8khCaLl19APJCK9fE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gIrpWvZ43wVYMcHdRLsU/9IYeUJCT7Yl53bks1trzk0Bvdpomk3n4hMPWoInRRbQHVxJldINL8gAp2f10FJ3bNsDWkk+CFG2rsBBSyZ+gqfc1SsHrI3CljrA6COHrk3/crHHPnQ653rQJftQPDHSWz/hhc7aTYVyUGndi7EsbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJv4w1Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087B8C4CED0;
	Tue, 26 Nov 2024 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732660280;
	bh=hApf5LvO5MwZb/cOd2RwfH++mx8khCaLl19APJCK9fE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RJv4w1Fad8+lq4GV4UgCRXBJhn6abzh/h48DxrZCwYfcWdnKiEKFA21YW0qVr4M8N
	 1jU4gFeneNyG8U9clAmXAhN2DqgLs2aWr7JW/4LmDoj89C3f1V0WHiWqg18eFnspzK
	 +LvZcvJvHLKK0MQ91n6Q2Vt1TpY39QcP/dDhFHhCyES+1BSMN8tExKrwo48eUqwiFq
	 zlC1KqBeqJEmt1CDox7L1UwMHzC8MtNmLVpJ/0Vgl9Nc3YV4ba9KAItsPeS6P5X5ma
	 TXtaekPZWTgqCaIR2/bz0eGwIhyPhNFtQeePuIhW80Mfk2UvMi3qWy0DZTrSKSOJcB
	 OOplMQ4QhzVzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EE53809A01;
	Tue, 26 Nov 2024 22:31:34 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126022500.718070-1-ojeda@kernel.org>
References: <20241126022500.718070-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126022500.718070-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.13
X-PR-Tracked-Commit-Id: b7ed2b6f4e8d7f64649795e76ee9db67300de8eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 798bb342e0416d846cf67f4725a3428f39bfb96b
Message-Id: <173266029265.560344.16998043372049860884.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 22:31:32 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 03:24:58 +0100:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/798bb342e0416d846cf67f4725a3428f39bfb96b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

