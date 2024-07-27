Return-Path: <linux-kernel+bounces-264280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800493E109
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AD71C2115F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44FA3A268;
	Sat, 27 Jul 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR+mbDjM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5422616;
	Sat, 27 Jul 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722114604; cv=none; b=Ok/WkvBoJAQUgg2PVU+7jg2fwxIsvHUEABP9YYUoJUIVFMw8kitziyVJC7kpLeyMZErp5b1hhYFOcDkjDiPWuK/G6a1P8IRd4/cURZUx/eyHMo8r3WzrH0maEC/f5P5ao9wM834ja1Dzu159pvg/biS4cfjFVxm0nE2ycdq+Yn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722114604; c=relaxed/simple;
	bh=YQmmHajiPe+XRNLc5tU7o4a26QfaiHdzXYv37l35npk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KFXYSLHWguLxQTavFwYNCRfpRsRl6HZ172Jg+Y11alk/SIvLXojrCfpN0b6cpyDAdGZv5rpYzIgX/ZHwj1SPpwMvBvCxMurTXuX9+iMgAstFaMuP+/XmYNC3iWi0ezANvd8rd5Azry1s0WTSvPe8K6Skxjj+7koy12ZwWQMv1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR+mbDjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBDA6C32781;
	Sat, 27 Jul 2024 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722114604;
	bh=YQmmHajiPe+XRNLc5tU7o4a26QfaiHdzXYv37l35npk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CR+mbDjMgeh5MQWkC4Tn247ZwpdgY+yoVI45pxwZoCJhyqCWu5Rd91Xl2zXoNBzUA
	 myxDFpzDqtD0e/pJoK+N0/vAttSW+PC/YUo32D38Bq4/wE1w8H/eJwesZmJk8zCjgI
	 9S0fGPjK9zreiP26Jqwqko6adAphOe/huRNN43CIMd+Q/xENsylwzIUT2RjSL7HOww
	 yTDvl+gWPENLXP9ubZJ8P01alduW8WYpLMd2JmgWle66bpKAjPWrBFvOQLfhGndHVB
	 j4qnoHNnBy+8c77DEKjdn5DZaVNb5LlkYCNKuC3HqGEKSQ88464vSJymY/EF+x8CjU
	 G3cBfZqMZX0Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1066C54BB5;
	Sat, 27 Jul 2024 21:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240725013244.69532-1-ojeda@kernel.org>
References: <20240725013244.69532-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240725013244.69532-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.11
X-PR-Tracked-Commit-Id: b1263411112305acf2af728728591465becb45b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef
Message-Id: <172211460384.18070.14798476787395303124.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 21:10:03 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Niko Matsakis <niko@alum.mit.edu>, Sid Askary <saskary@futurewei.com>, =?UTF-8?q?Emilio=20Cobos=20=C3=81lvarez?= <emilio@crisal.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 03:32:44 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

