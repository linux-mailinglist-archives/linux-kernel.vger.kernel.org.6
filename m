Return-Path: <linux-kernel+bounces-552762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD6A57DD5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FAF16BF9A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F381EB5D2;
	Sat,  8 Mar 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3A3XqMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525C155316
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462856; cv=none; b=RPfSi7ApfNjLB+c3nh027ea0sAPlJDsAukjx4vxg54i0y1W+yJe2/0Kvty5CbfNJ0KOHTQg+9sIKJiYpWibMauqkhiwhqBcvL51lE0XvROf4GAaEvCIo+XSRVP7YJM/E0YeJ9/ezBlb72FwCiFlofkCyDgJqOsWrlk8eGMoxk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462856; c=relaxed/simple;
	bh=CoVO8OJRoJ0lBTIi9VILMqjrpaxFeQPylRgthdLPSfA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TEc9VT5YsER+JidbsFvnis7JLTmqsL9ifiYQsvejqgMdA2RIeXzsXy7NYfD3dvoS5J37dyBAGxobCIpN5GcKDGO2R1N0lmGV4FiE+11GIPmhDm/LTShq6RRP3WkZbE49A7zTxl9UAjufh7XImuuMC/wb30UUYnbMOZHRz/nk2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3A3XqMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC61C4CEE0;
	Sat,  8 Mar 2025 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741462856;
	bh=CoVO8OJRoJ0lBTIi9VILMqjrpaxFeQPylRgthdLPSfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O3A3XqMvmERQ3QvglbofYFW5Bcmm8BOyECNojzf2vtG5yfIAnIPeoce64/fF8gKup
	 J5RcuzUcCMZF/Ine3ohOAmAiAqzyVGw2JDDTMwWqwr3/lIGFbE3MKej0uJZUxEippf
	 BPN7utnbxoANq2FE6p3kOFzLRBTigIAb/hwMhZrRo9O53d6KmSn2w5TWfYFmM2Plgd
	 AGZPjhxbu1w2HhOTYpcZaX2Z0KBFNGaPepxYrJDx3P8swcxAhd58jb00XPRIkQGXuG
	 ZCG4SqKU/BHf9LnFQrd2CuOJa31HRCXa+Q9r2CQPe/Py8a8LCv6RdhS6HGUbKsVfUK
	 tN6juIp5c8EWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB850380CFDC;
	Sat,  8 Mar 2025 19:41:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8yYoNSdSgXf4AGj@gmail.com>
References: <Z8yYoNSdSgXf4AGj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8yYoNSdSgXf4AGj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-08
X-PR-Tracked-Commit-Id: 058a6bec37c6c3b826158f6d26b75de43816a880
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7c90e3e717abff6fe06445b98be306b732bbd2b
Message-Id: <174146288968.2728076.1555389870362767754.pr-tracker-bot@kernel.org>
Date: Sat, 08 Mar 2025 19:41:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Mar 2025 20:21:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7c90e3e717abff6fe06445b98be306b732bbd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

