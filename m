Return-Path: <linux-kernel+bounces-446110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFD9F1FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9BF16685E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148B4964E;
	Sat, 14 Dec 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRZws376"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92138DE1;
	Sat, 14 Dec 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195959; cv=none; b=EkM8jOQolfHv3tUDpTQIlX9rbsqFao8Ldh0RKLbBG4O6qllM0VDYOkCTRlglyeUx+iYIf84eRP6fz2QrAlRirOuRM+RC6Rpzufu6eHNrSVJKYDgQ8ABui9tLPuqQus01BTF8MS3FGAbSzOcfIlzSrUa+PwQStWU/l3iZ1ge+7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195959; c=relaxed/simple;
	bh=+DCu4r5mxOtfxGHi64zlIxjM5Cmhhr81L4L4/oQ+g7M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O4WQGK4x83WhWsHN+o17nANAv9Va/ElnCFkaoUvGTSgkVGtlN5teTFtkwI+/40aWp5QO6pwQwcVeXV3Kf9uQ2EcGTB0CWiof0/9tLLe9nfJwW/0FzhlSVzE39PkOdiq+eA39H4aM0K34gmAWxf1/QA69i1oeM+iJ5pQLQjNTNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRZws376; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5196CC4CED1;
	Sat, 14 Dec 2024 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734195959;
	bh=+DCu4r5mxOtfxGHi64zlIxjM5Cmhhr81L4L4/oQ+g7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YRZws376nO0ZpnReD7qdYWWizXxxKp2fwmzDoCMUCsU68N9NzR3QUa3PUjdpR//R6
	 NoK2Cf6502cvl6dMRc2QXkIl8JnOgvWfqi4lJvMTuOfDCEdIXXyXfC3s+dsDHdHBIu
	 x7w6bzibIB1k/3MY8ByiTkEatJgpLfAqaCDoN1OA3EzgfBWCnfdK7GT2EByt9c7lnU
	 7IAVCbePJntjBzDj65KvPDTxQLi21MDFA5nEmRX38n4MztGP+uFfo7EfYeFXgr+UQI
	 GnVk2cRD+lNuha6xIESX6rpob4ILMTGre1FYyvxdJG8ptZPLxJ+zs2Fsagi1SBzjRM
	 eOHCvjy/4GfdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34D45380A959;
	Sat, 14 Dec 2024 17:06:17 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241214065217.195385-1-ojeda@kernel.org>
References: <20241214065217.195385-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241214065217.195385-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.13
X-PR-Tracked-Commit-Id: 7a5f93ea5862da91488975acaa0c7abd508f192b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7824850768aafe0e69ec6586900cc5c1dac94fe3
Message-Id: <173419597590.3359607.8070490146368872321.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:06:15 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 07:52:17 +0100:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7824850768aafe0e69ec6586900cc5c1dac94fe3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

