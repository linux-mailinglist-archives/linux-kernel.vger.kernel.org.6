Return-Path: <linux-kernel+bounces-516369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD64A37036
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF982189358E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B451EDA23;
	Sat, 15 Feb 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upd2DLhY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49323BB;
	Sat, 15 Feb 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645223; cv=none; b=Lvn3zW9vWxBB7Bsop2EQl7osC0fEf+UC7/8BIL6CY9959oNJ1i7AuYxmf6YJB6f0JSdWgLSrJGJTudFQONhgTXw4JpIYdX57UsT/QE/HX/KyZOktXP1JBM6hC587ooelmL60WISjVuSp52/hGXtK127cDIvmh4vweDqUdsLPRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645223; c=relaxed/simple;
	bh=b0XijXGwAewhE83Fhwfl29YWkJGlmue8T97ShV3+oV0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fXwfZEoqVaJoL0dzT0WOmQr8qIBGQhML9Pi+hx60Jy+YHMEDA+KqZuMFv7TE6u1DCWkdrJQIAsQtJgNh4R14f1JRusXkPIcsqsuAlBKqkb84L2ZmV6+QjB2g6tggHX+JvzX+A3KkA2xKcrlCc8C8rzVg++dzwoLLKcy+Xc9oV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upd2DLhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C88C4CEDF;
	Sat, 15 Feb 2025 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739645223;
	bh=b0XijXGwAewhE83Fhwfl29YWkJGlmue8T97ShV3+oV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Upd2DLhY6Cov714cLGmmS3zyExujW9qAOtagQad0oyuq+pGq1GvGAVO0Xuc3tJHk5
	 vC2zR1sjQ1W/2MLVy8xwB//TyiZvoCZ+cM7CXMuJpn0yGp07w86rv65VdQ6xvf4PfW
	 eap1SktzJJQbuzdHGHK3xaqnInIW8Y9NdjDTWWY4RZK8dAm4wno0XmFjPTf0SPGBNe
	 9RxraoxXvaysJ2PG021CIp8eUGDkyBmoc9QhkIQv7m7pFYd2QzAHeaNFq8r6l+Pi0r
	 s/YwuPEYF1oH9qzCHgeYXdiNVhVWahMVBtge/k9NtDS/e6mpPvtBZhprxzQOItwwBp
	 xMqcmoiMBdsQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DBE380AA7E;
	Sat, 15 Feb 2025 18:47:34 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.14 (2nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250215170845.80764-1-ojeda@kernel.org>
References: <20250215170845.80764-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250215170845.80764-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-2
X-PR-Tracked-Commit-Id: 2e4f982cf392af2f1282b5537a72144e064799e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 243899076c3efdf98d8e922a802896424a597580
Message-Id: <173964525310.2320599.3728754433248657249.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 18:47:33 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Feb 2025 18:08:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/243899076c3efdf98d8e922a802896424a597580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

