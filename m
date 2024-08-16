Return-Path: <linux-kernel+bounces-290218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588C9550D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990121C21A32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA3F1C460F;
	Fri, 16 Aug 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqFRf2OR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46B1C3F29;
	Fri, 16 Aug 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832905; cv=none; b=WUL6ps2DeUSVPTInHXfU+Vcupw0PB8YaE6S61AEjciKOH8xoffHGusnpcr5Y5LINCpxZtzO4+8f22jjaHzCSS82WYdBD4skrc8QcMRsISmWyoljkv0FQMxNq3Vk/8f3sReJQYRNEvHdwYMrrrHF5uY0ZtQ3nThznlbYuHP/rhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832905; c=relaxed/simple;
	bh=kX3YMPSvpA20Oalv8GKZljCzR1U73PxVujwoBWvgrT8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E/h/OtzhKSNncKzn27wG8QvnuV4mPqJWsX9GtPYahcHIT7DJsn5zDXWO5yIWQmnJsiSJL4tsPUaUGmbxzd2SjzGbSTyjdgQdn4rSJrZR1zsmIjVgFUpPpe7Jx3b4fu+Mls8bsUtK+2epK/PR7zd6xHejmKgKFQKhUCtTPxhEGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqFRf2OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBA8C32782;
	Fri, 16 Aug 2024 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832905;
	bh=kX3YMPSvpA20Oalv8GKZljCzR1U73PxVujwoBWvgrT8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZqFRf2ORhaWnR+ayrJAzzP8+eEOqGsRqr9TF+qKNOATlL91KQf3DoeET1mMBRYdFc
	 d4tMan9HStNQVauu1bwGn40QSOs4MRMTUvBn0Ywv/Mir6QuJIQGgQ1FGUHhFRJmR3a
	 OBC/MVmGbMEHf35+bK5WThWiYcNIVerShbo4dSbaqDKSvcpwbNc4bqefy5qaSQYNAT
	 LVK3/N5RrZyNL+AxnxnQAXODIWA5eFu8QacxNrEjj5NvCs1YnxowdLXgTcQOaPlmJ5
	 fvJQcOJZRD2wCXaX3Iz5avokAI1LXFRDAfcG/A9/XLF0ftrUwzlfNiCcsyC5vBND0H
	 kQlYSjcANjT6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB07F38232A9;
	Fri, 16 Aug 2024 18:28:25 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240816171622.41357-1-ojeda@kernel.org>
References: <20240816171622.41357-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240816171622.41357-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11
X-PR-Tracked-Commit-Id: 0eba65f0310d3c7d5516c7fd4c172d0bfa8b285b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60cb1da6ed4a62ec8331e25ad4be87115cd28feb
Message-Id: <172383290467.3597757.16293959490652502308.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:28:24 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 19:16:22 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60cb1da6ed4a62ec8331e25ad4be87115cd28feb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

