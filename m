Return-Path: <linux-kernel+bounces-178144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A38C49A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A971C21ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0884DF7;
	Mon, 13 May 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnBERj3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BD134BC;
	Mon, 13 May 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639895; cv=none; b=TLj0cBMeCqqwsX8zoMEW5WdQrszsCRyVhcLenVmRq+ud7mnLEE6/nigu+sbwxnS5T3WO8B8kRQnb5mfC4l+S/oPmxiDL8El1FFSIG09JlzXCnY0JTLSQfQ67fM00d0jUWffMTbOT0e1NINjM98QSM33pC7OJ/sxryyXWPPUYsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639895; c=relaxed/simple;
	bh=84c/WI9fzUQdA7skvrfIepjlxRZR+3xuluOx0DyQUyw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wa+mINDAedkptT3MAt7e9z8RdbBKZnKwNN8rIoq1WdU/u2xUq9gaLDSeLwFUJSBmXgftmVAwHdu3y11gciZoU09MjXvJWNgh9MAJb6qjIbYMn/Sn2DdTDD6C633yVWNqgsvOGMq3CaByic4FNgSX55cpx99bcnUMbqiFbYqFcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnBERj3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06E41C113CC;
	Mon, 13 May 2024 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715639895;
	bh=84c/WI9fzUQdA7skvrfIepjlxRZR+3xuluOx0DyQUyw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EnBERj3WRAQlkGlzSI1AQWXScuCu5Xx5joa6bWBWeL9qu8438/r2GU9pNmq1Xvj1X
	 deYVecQ35zVhrMrGl19I5nDP0ilS3dMA+T7vdA3xHB2C3reUxClRee825ZS4VHivoz
	 /577b0ueiwGt+gZLBDz9TSoPtTUJtO/m+ll4kzM7GqrkZwjd7N+1rq5K9r4Iu1EuOf
	 4C73kpZ3hFM4xLtcAyXNufnWamuIp2mJcexOpNNT376sp2xirdAjnA5yT8YX4rK/j6
	 tDxXUgcY69AxIm3deApg2wNcpNjE4y32YKR9d6/HdMHTXIEv9lxeB2Rw0AvlJ9uZwx
	 KFLbvrqJz5EhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFAE9C433F2;
	Mon, 13 May 2024 22:38:14 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240512202215.67763-1-ojeda@kernel.org>
References: <20240512202215.67763-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240512202215.67763-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.10
X-PR-Tracked-Commit-Id: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f5b5f78113e881cb8570c961b0dc42b218a1b9e
Message-Id: <171563989497.20499.1178947658634490338.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 22:38:14 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 22:22:15 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f5b5f78113e881cb8570c961b0dc42b218a1b9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

