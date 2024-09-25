Return-Path: <linux-kernel+bounces-339516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DEF98663A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B8D1F26745
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6BA13BAC6;
	Wed, 25 Sep 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg09ZNYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556C13A25B;
	Wed, 25 Sep 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288632; cv=none; b=O1EZGtfqULmcv1IFO3DBby8Kb8YySn2zBrZsXg09iOeXbYJw7leczcONTWARxA2rLZ0B86QH9Byvij8ql/yHSm7UYdYbXcQPAr9raYnlNxRyOYWOnxAvrFWRgkaDeVDbJ43fSdIO0312YuIClnSPi9KC0nrb5HUq0J3eIkgO8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288632; c=relaxed/simple;
	bh=4b5e/lcbHJGLJmbQdNnJRl9bA7qRLTJjfw5yh1V7U0g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RoUGech2FgRh5WwiYeCC3Oh9walo3pRW5hMJZ7QQL7a+zEpP75VNDb672cKf/1QbQYFC7+W21IzoJr7TLdDQZ9ZGWatjUeFsIZ65iPs9CqwoC9nqL72TSYUIrbSFonCXtJBSUVpIjVZ6iIKyBZNHk2ugcyrZ6VLMVpsocJoo/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg09ZNYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E70C4CEC3;
	Wed, 25 Sep 2024 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727288632;
	bh=4b5e/lcbHJGLJmbQdNnJRl9bA7qRLTJjfw5yh1V7U0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fg09ZNYt3hrRwJofgUckqs4RGSQdrnufHgPXQYd35EhOrEaKJ11SBpkljdA6pjnFV
	 n6/B7S2rArRmi3XEkUlV0L2+PAGliZ6E6Ii66VqLwk0gDdR4rMzkV1i5FXLHBTrStk
	 dcQ5D0HodlQgKjgdcguweotLZiUhJ3IC+oedoqfc3DYUlwCMScnaG5zzfVmYRUk55B
	 Vmrd3mlVzJYw78FQeoiIlzgCLeNW7wx1hIb1HT5m5UUeO7f236qyUsCBiv5Tq7z+nI
	 xVb3X+2yot0zac7puYDVFBnbjqCIsd6LDyXHx1cr5AdpCOhA2f1IC2oP2Lbnalyr11
	 /u1W6d47oSxIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE56A3809A8F;
	Wed, 25 Sep 2024 18:23:55 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240924221023.197610-1-ojeda@kernel.org>
References: <20240924221023.197610-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240924221023.197610-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.12
X-PR-Tracked-Commit-Id: a2f11547052001bd448ccec81dd1e68409078fbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 570172569238c66a482ec3eb5d766cc9cf255f69
Message-Id: <172728863414.682824.9814808100238149341.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 18:23:54 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 00:10:23 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/570172569238c66a482ec3eb5d766cc9cf255f69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

