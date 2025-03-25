Return-Path: <linux-kernel+bounces-574752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CAA6E97B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349A816ED05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C82253F0F;
	Tue, 25 Mar 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNOtzCBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491C253F00
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882855; cv=none; b=YPpd4xiEvCoJNXZ9huyADHpOmI78kVdcvU/kc/2Z7AgknnhTBfwoGDhZ5QWZustqjLdDtuJTkbbE4PG0Y+eBxBGKqqAy17EapR0bVLsEGGq7H/6DOinGRBbVOzs8gHdZMDwvXnHLR9fut7cRLVf2WqjC+Kzy2cGnzdiFHrXJUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882855; c=relaxed/simple;
	bh=96EBCgds+bQy618L3x7gZe/P+rsBLYTHkjqTKtfo9jg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MMt+UX0o8oEmK4SB0h5NIezRWkApDDWSUigqvjrY4p9Ch+RMJWM0Wn7UhE4H9/qUjoAJyhb0YPVcv8ERZ+3IVcytY3UGqnxgRb8rm/JDCv9zUlhbL+rlLiwWfyKojGjomPRG1vOHevo7ILbgO0VCw5eeJMYhvd5whUT+FKsy8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNOtzCBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD1BC4CEE8;
	Tue, 25 Mar 2025 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882855;
	bh=96EBCgds+bQy618L3x7gZe/P+rsBLYTHkjqTKtfo9jg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RNOtzCBmiH4Sn9zS9lf1cgksA2/amdEBGRT194crT1UbQlT8lqO001hzB2BH+L941
	 yc/acEPDtuHdYq5+nQhTVbsJkPC+gfuxOiVKEjsGpPtl/UEHLVOb873Gdsti8WteN9
	 WjCBxYADKDJYf0fufJNxRGnJh+VR3m0p9aati0DN8B9s6yYoPgJpjIbBneusPtMt/A
	 g0ES2/HmphPwcbAbUcbBTImjCtVEJIylr7jOzwfkdvLyqMsBDy8i+CXJLoJQ+x572U
	 qBM/eGkoeCRheNaShZxANUOqeWSkSl6pVs2QrJiE/WSyTCLZ0odihakhoXThm6Ir5i
	 1tmt7zuKh8awg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F84380DBCD;
	Tue, 25 Mar 2025 06:08:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96nQRHujehne_Sj@gmail.com>
References: <Z96nQRHujehne_Sj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96nQRHujehne_Sj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-03-22
X-PR-Tracked-Commit-Id: ef69de53c46a4b526442f6bc5970fc14f7a0bb32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 001a3a0c6a3fdde75548ed409915ebe1c80ac817
Message-Id: <174288289097.109792.12086583446145273318.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:10 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 13:04:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/001a3a0c6a3fdde75548ed409915ebe1c80ac817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

