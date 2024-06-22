Return-Path: <linux-kernel+bounces-225882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E39136AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72621C20BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DA7B3FD;
	Sat, 22 Jun 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0DygJhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C0757E0;
	Sat, 22 Jun 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096124; cv=none; b=OSvsw57SuUCSbI05MqwnY6dcXA1w0T8VnDEEcE4bn3BsQ2Tqc/ulP0UkUyZI581kgiXagDw9hu1B05X+Gpvkl+oOk1bMQ8wC7RzMnm40fYKK2fRaLgCnhs+Gx9kgazmH9OTufi+z8MyDVHao3OuLxoXUpVX3LCvqjofk0RcMJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096124; c=relaxed/simple;
	bh=EvkD4OfgkyPKDN5ZtMQSaWXlm0oSJRU057X4EFQlBLM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YjSAp6RIOvanmR4D7zROm5ys5Glg5kFbwB9eYWRdYGEpE3dPhhMhCkiC++njmXN1XqyNWc0M50gBfOC11PdzWKk4PI2a/OcivatrvAeWIyNL7O+TIjGiRxZ0P/GqkJyM3G+/2rV7VX1RUNA5WSH95wjP+zHV3qGNUjc6R8gXs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0DygJhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09668C3277B;
	Sat, 22 Jun 2024 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719096124;
	bh=EvkD4OfgkyPKDN5ZtMQSaWXlm0oSJRU057X4EFQlBLM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H0DygJhyGmINoJChIk9MgyR29POlgkxOUX/dbf+My5Pp1enkOdtUI6F95go0SS+Af
	 T92NmQO7WHx6YlfB1O4B2CwqNc+jg2KfllISlpqfAlP/hsOi8qfIFt0ZH3vHni4Wcx
	 +Bq6s5gs6mWuIuVoercdi4IpdoDNP0Dc8X6373S+OrgKJIEgNRxoLJR/W3+Pvbdh2O
	 A1yRjsQrVAiZcLsspiBLMG0+GrSJICjZONmNrKC3h9w7n2yAftYORdLW5oH2LJiEVh
	 j2/ABximpI37m5K4cgBitGm95dYn0gPJCZlVSqciz7xw37ssiwTeAvu8IlrTseSQtD
	 OSEDbtXQ5r+6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1B69C43619;
	Sat, 22 Jun 2024 22:42:03 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240622215518.198080-1-ojeda@kernel.org>
References: <20240622215518.198080-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240622215518.198080-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.10
X-PR-Tracked-Commit-Id: a126eca844353360ebafa9088d22865cb8e022e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f583a3162ffd9f7999af76b8ab634ce2dac9f90
Message-Id: <171909612397.10621.3557477494621826003.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 22:42:03 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 23:55:18 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f583a3162ffd9f7999af76b8ab634ce2dac9f90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

