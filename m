Return-Path: <linux-kernel+bounces-555085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FEDA5A54B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38174188D074
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36781DF258;
	Mon, 10 Mar 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0LWc7VR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEC1DED4B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639870; cv=none; b=hfYSUMBVrbwQEoQNBdpSrFApZZc+gl6f6Q/ThAiATR35hAMEsBEalUeYbapOYidCs7FIpH3oau+7caRpsn9BopHqCZyWYhVmCb/2+w/ut24+yK4T9Gfa50eqIiIAsejzlv4NckWbYaCvdTtUsijAZzPeimtEmy2Gt9BuZBsZg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639870; c=relaxed/simple;
	bh=vwYnqaJ6V8gjuQV7aFah34+viTT6zEQRet1hjvprP+k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=brIiD/4KtSq4LM+fwnbyxt3fW7eKKMttd3E2OeeyoXJqbz/kvz2e4XOazHw75U7ozhAGH5GMwhHp7Y0C2/0UC24zHQpdEnriDuDQx/cRmoe+RUReMfQKNED4T09u9S65LTHpT2kceaI+ZH5PAJkft5O0yMAzcR/nanBcRIBlrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0LWc7VR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBDFC4CEEA;
	Mon, 10 Mar 2025 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639869;
	bh=vwYnqaJ6V8gjuQV7aFah34+viTT6zEQRet1hjvprP+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r0LWc7VRIOKwSdWEQGRpye30enQW1cFKUSvomRYC7BL43EykYY8SUvparGvW1lGp1
	 P7V+W+HL6rJDF7zNrZ1rEe2Ua2hkk46RrnLwPsGryXsVpvbD0gp7xmUFfRxxvgKt8C
	 zEdfXZc02Z7o9JSyh8mDKRYAxCynek2ORCSxeJ9SV+PxsZRapZZEFhryrI9TirY6FT
	 h2ZfdQ9Hkr4BKItoaGDrMZlbJftk6E7Jwd3m+blnnXRvzmY53BXnmIXctOO3Eb/QJV
	 XGD+BirWOUA1R41PyKCC//sbjeIqnQ4v8i20i2zPg36k8As4EqBtNfgsZvS0kXK4T9
	 6lb2Ookll6kww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE18F380AACB;
	Mon, 10 Mar 2025 20:51:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z89ELs3yiGe6kdml@gmail.com>
References: <Z89ELs3yiGe6kdml@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z89ELs3yiGe6kdml@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-10
X-PR-Tracked-Commit-Id: e3e89178a9f4a80092578af3ff3c8478f9187d59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d872d51bc9d7b899c1f61534e3dbde72613f627
Message-Id: <174163990325.3692111.18184384203241241628.pr-tracker-bot@kernel.org>
Date: Mon, 10 Mar 2025 20:51:43 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 10 Mar 2025 20:57:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d872d51bc9d7b899c1f61534e3dbde72613f627

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

