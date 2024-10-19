Return-Path: <linux-kernel+bounces-372939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A915C9A4F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0E3B25794
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8417C228;
	Sat, 19 Oct 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqg2r3Ft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83332F3E;
	Sat, 19 Oct 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729353661; cv=none; b=uKUql9uI2OCScDU2zB73EVBEKgQvhdA+XT+5SjOcHk6IzcanKL7e+CdWD+JCHNxoJ7BbN/yv7tmlzTwHJq2RBa1dXZLfjdBhITPdiS/PZ8EyurCKM3bfJ6U9o4svTa5cHXFnPWTNxcO9AD7qHfwtNJIBi6lEIoNAoIo2n0Eywp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729353661; c=relaxed/simple;
	bh=d3LCAwT3b7ZATkM23962Bq9EtN/XygmkUvEsZ61ynDU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lm36bu3fnoZZDgiEpiBhC9mwcNs19DKDCgwzBrGT6ndR47b3ZGZXQq8ZwMuFdL2HwTI8aOaTQOeTSWUItp/9r5NAXSry/XidkxLJmLlSLR2n/F66/0J+zuYDXG+56pu/pJBtStxRMcTvUgfGYN9E8hHp+okD+cbp80f04P9yeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqg2r3Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFE7C4CEC5;
	Sat, 19 Oct 2024 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729353659;
	bh=d3LCAwT3b7ZATkM23962Bq9EtN/XygmkUvEsZ61ynDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uqg2r3FtjlALlnAl3H7fsqP46J6j2bgRacLeXYfY9bVT+VcAKSVMupdUuQrs/glKQ
	 6t2eV3r5pSwVgR2v+DGBnUdpQS0qxnuCWFPiTVwytwlQOH+fr6qAvsneZR/UTWopC6
	 3H/7/tG2btKnnaVKZ7IA8XAbhI3Um7HUCiuzUYow5GQ3GRFSgszvQihaMDm3hHgzwr
	 DOqD4CcEazvoMBr45i3bCcx5/8qMQmjVhkecvKufR/EaEU6WrZLt/O2/kTdb+lg2kl
	 3JkwRoDfPofMWgeu3zD9T+m4C7T3h5WVCZ/5uoBf4z4gqnXkHMnURy5d6b0tQ+6DJH
	 oXblxDWjYZ76A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717943805CC0;
	Sat, 19 Oct 2024 16:01:06 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.12 (2nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241018225329.235175-1-ojeda@kernel.org>
References: <20241018225329.235175-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241018225329.235175-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-2
X-PR-Tracked-Commit-Id: 8b8ca9c25fe69c2162e3235c7d6c341127abeed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e6bd4a33a6cf4d2dce9725630ada847a3947c7c
Message-Id: <172935366509.3434115.7119420782674548994.pr-tracker-bot@kernel.org>
Date: Sat, 19 Oct 2024 16:01:05 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Oct 2024 00:53:29 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e6bd4a33a6cf4d2dce9725630ada847a3947c7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

