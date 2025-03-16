Return-Path: <linux-kernel+bounces-562812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F8A6333E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF891892B65
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA483596D;
	Sun, 16 Mar 2025 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apZ/N5nk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C733F7;
	Sun, 16 Mar 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090306; cv=none; b=mEVw3ZTdS5Faw2mT6qcHzV0eWr/YxHxzpoSjr239t4JZHnIaqd+ZKlvOcw9skioYkA51fU312Gb6ty6dz4nByxm5CfIuqJLnraVwVmTey9BKJZpquG4UyJZIbrb435FcOTCrJtpOZ4SKrXLuCsuq7k9p62QPdcdnkP8r3jZAMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090306; c=relaxed/simple;
	bh=v1KE9oAM928b5kP4pShhW6cmQJ//Heq1qh/A/aHiams=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GiH79bAWYeERU5mBHf1Kr58neSU1iz2veb4vwbqsFy069ushV62Cfx+BtKWwHmczKkBhuZYbPgqkW1FmD7J99hQUN4HxXhrwAFUG5EVMTH6KPEjlDMDiszJterddKKNTpMqs0NXQ2hlMTo0zbYRPv8NzBWUWPBGN2jr26w+RlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apZ/N5nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA582C4CEE5;
	Sun, 16 Mar 2025 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742090306;
	bh=v1KE9oAM928b5kP4pShhW6cmQJ//Heq1qh/A/aHiams=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=apZ/N5nk26FAfTrEJflmajspYzM9XbLvdL0f5UdLXlqwrAUyrxn7sRRj5WBTbnHYU
	 GCdMumZEFqTZ6cYx1E4nJ41VgUWxHTVnld6puZGTsVCSIK4ClZRypyZufjwVLSuOgL
	 o11DAJQKX+bN4ekL6TtViT9++0W1iQmAzxK/xjs050/viF8DKNmI/RZ6BOPTMC699p
	 3OZmw1SQi52Lb7kE9Dh3VJ0pv3xDzZEiPD/9KeQBn2d0ZylDzeL89xK9oqECZztgJF
	 cGVjCd92K1F03SHWCxL0NBOPIdTVTnFKyg3P+g175gFexYkWKpo6j1EiQt31lC5rZg
	 lqp5kUGscts2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB0380DBDD;
	Sun, 16 Mar 2025 01:59:02 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.14 (3rd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250315212232.2360641-1-ojeda@kernel.org>
References: <20250315212232.2360641-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250315212232.2360641-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-3
X-PR-Tracked-Commit-Id: a1eb95d6b5f4cf5cc7b081e85e374d1dd98a213b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd3a56ac2d132beea747f7b41cc085c82fe2eac0
Message-Id: <174209034082.2697047.18078857949357461008.pr-tracker-bot@kernel.org>
Date: Sun, 16 Mar 2025 01:59:00 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Mar 2025 22:22:32 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd3a56ac2d132beea747f7b41cc085c82fe2eac0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

