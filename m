Return-Path: <linux-kernel+bounces-393139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8629B9C4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF011C2134D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3912F5B1;
	Sat,  2 Nov 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATCet/gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D6249F9;
	Sat,  2 Nov 2024 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513830; cv=none; b=n/tH149Gt/LZ3zLuOuTq1r6JEdOcV7dKwD3tp8cLy1qfB5//vqEAx6MoKtwwng0p8fjgKTuL5iiPRn/fZrULDBVam7Q+x2PgcRiSaENz7MjBrQ1J/l0lVpYiDFYnNfHheD0RsnKHqitMv55nsdb+HQdMfOw8wUbGrLj+hifdsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513830; c=relaxed/simple;
	bh=RolD3BghUkjh7TtR/e2VSKgQqFAHC13Zko4qAzXY/5M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OIskQUriR7URn3XkMb6vhTjpaZ7JI5YhJcGLjA2kZlMtX7c2uXesp76p+2sJANTaFoKZIn59Y/fETLGPlk3UPE149oKezrx53IFMHh6QLs6l/mQrC5UhT2T/9/iRGtRqZ1s+V+n1sRYu01q45JiUEctBO5DStTQsOexVn8InoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATCet/gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D2CC4CECD;
	Sat,  2 Nov 2024 02:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730513830;
	bh=RolD3BghUkjh7TtR/e2VSKgQqFAHC13Zko4qAzXY/5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ATCet/gqbj7zQ0ZftlzqifjvDIN7mFlLpMKTQvVICn2KPUJmdEkzvDKH6Shg36ePy
	 zEgbvxrpu7xxXOK6ASc0svwnYOqwlO1Vo0u91ZrdBlheUpYATCZsS2R+Ke134fbZx+
	 +IMlREOMJnWDqLFjM4yO/2jUz0GOYxny+lVJqrYAwP+YbVQ6EIFYhFmPpNnTi8ipte
	 Lw6PXY0+EeafLI9aMBYHNvxiKUE3deMBzuDxc0kDUp0sb/ZluOwSNqNkCoKNpDh8e0
	 rnZ9qijo7JpFp/KCugaZVx5gBA8z2LFfP/+I3uNjtnlXOEmipg2soU4jUDrw+5IFcr
	 bmrGWpwPFJ0WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0793AB8A90;
	Sat,  2 Nov 2024 02:17:19 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.12 (3nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241101202258.233057-1-ojeda@kernel.org>
References: <20241101202258.233057-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241101202258.233057-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-3
X-PR-Tracked-Commit-Id: 2313ab74c3004089ecac5f0f91f7274829f3825b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7292c0934a848a3fc52c0926203417b5613c69c
Message-Id: <173051383844.2894442.4642291924364385368.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 02:17:18 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Nov 2024 21:22:58 +0100:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7292c0934a848a3fc52c0926203417b5613c69c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

