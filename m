Return-Path: <linux-kernel+bounces-318082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F396E81E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51426B230B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07E4437A;
	Fri,  6 Sep 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bItryljU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334113B1BC;
	Fri,  6 Sep 2024 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592808; cv=none; b=J/STDBqlJn9Vb3jZoQSWEyGfJueMitlcAIK+V6lPYWAIJuxBMjLwLaTlG1+myBEg0kkO6ktbYzH1Q7aTKht1LUFbXYq07sSYHuu2iL89/V2aeAeXhiVCHNZQpH4h0QGQe1KVAXxoihXzisqc5BQmE5I8OJGK34igBtnctu6+Bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592808; c=relaxed/simple;
	bh=8c/8Wgi2rJSdCiIs7EaEI1dZZNdI0HFt+Vm3zC/Ev9w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VtXxuDt7P0wLmGGGxK9C+9Ys3H8MPdAufb9XFBdvbadUTjOHd8qVlgP/DjD6I1GrANEFLCM+OJLjNhlBegUACuMMcK45LO7CuRamqoI4G/Mp5Z4dNFGnP2xpjf3zcWKCqyPv+4ME9R+aUHhEEFeDGKirzRIIkIN7CPQ0xRDLsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bItryljU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11ADC4CEC6;
	Fri,  6 Sep 2024 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592807;
	bh=8c/8Wgi2rJSdCiIs7EaEI1dZZNdI0HFt+Vm3zC/Ev9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bItryljUNqyQ9LdI39eBFLqwRKhnSiCm5T5Fm98TVCAR8qYrggRzYbkR6++FyzObC
	 jwVv/5cdw1cCyl9LBPOJBK0inBz+dmfoUliA3rgq+nT5D3gQ517FCCvNIwYBbuwhtm
	 0CCH33uZnSErYpuPm41fqQa37CH926zvT7kSMo8vzLszDBO/4d1jGXM/l4zA3hI5Gp
	 xhS5qN6stbocJyBW5jiOLlfqJQgZZjskhmxngrMLj6IkAH0MbqwiHw3kLP4cVEuo8t
	 f0p12hZ5u549vxHfpWjdkGcMH4w+TXDbrMcY+60avZQU2F9O3MAsPr9MP8vx6YlwQt
	 lHv8G8kl/H99A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF9773806654;
	Fri,  6 Sep 2024 03:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.11 (2nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240905213425.253828-1-ojeda@kernel.org>
References: <20240905213425.253828-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240905213425.253828-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11-2
X-PR-Tracked-Commit-Id: cff56ff737e2da095ca9f228e2c5afc903bfca69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c5b3e30e5854f121d2e2cbb2d5ff7350ef7fdfb
Message-Id: <172559280858.1917326.988525702640406803.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:08 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Sep 2024 23:34:25 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c5b3e30e5854f121d2e2cbb2d5ff7350ef7fdfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

