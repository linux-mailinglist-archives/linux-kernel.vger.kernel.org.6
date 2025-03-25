Return-Path: <linux-kernel+bounces-574751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB22A6E97F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344F83B1079
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DBF253B60;
	Tue, 25 Mar 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk4Ryt9T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D0253B4C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882853; cv=none; b=Nqko61PFAHGCLhIkGQL+qOUqOkyYtjwiooZwAyqJh1B95sBEmgvCXzZerl3uvZ8/54DELHsKzbvPEdcN4142r+L0cdIdxRjwoMVJzxGn4eAmbfcI30GMJR3ogLRIFkfrtLKYBkOe9IkkTcLpWFvrCTZhC2YPsHOmtfI6B5U8YMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882853; c=relaxed/simple;
	bh=tEicqaj9znlO+pCbrgeuWCedgoBgUcCkqScDEBS4Vh0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cw5xL+/AGfetfpIeoBvG4X8M9pW28gbkMrq+u4YuJTeCW/lfEHiGAKabxDuBMRYAjhK6Ec0MbXED5du4JtqA6A0xc0ccE0DryZt1vdMpDgOydJV/LWrFaxEdiJ9yFLcid+VlV+XycVh1ouYJjrGqiKN9jv3YqQ8na41PIuKLSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk4Ryt9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30391C4CEEA;
	Tue, 25 Mar 2025 06:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882853;
	bh=tEicqaj9znlO+pCbrgeuWCedgoBgUcCkqScDEBS4Vh0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mk4Ryt9T4Q8qvvUS/r8Dj5bDg6R5cPgx6POfgxyEe7bYd35v8qWkIaWBPywg6xmX/
	 vIzqfona7e7Xs6t7Fnvn4/KlaNmnARN3Ti7DTJ8VA/4u8uen6QTJS+GxmMpO0BE1wp
	 +E1Sp7rce6T2wAaIXuqRVW5+81ImiFkzPE/91Az7BXzh5Gw3L4DEvdpa1N+77eQUK3
	 dOE/HwzcahNFr/l97isXvA1zPNgE2NxF0KWHFrzbAOArX0xtpaK0N0JIikIa8nQKSB
	 S5HwLFPn3dn3pIcOwVPWJSBG1uOrmC1wt8sqO1LvGCqyCDBRqn0ye6BdakTqVLCnfe
	 fadAlYtliAEFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC13380DBCD;
	Tue, 25 Mar 2025 06:08:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96mVT2u3MMMbtN0@gmail.com>
References: <Z96mVT2u3MMMbtN0@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96mVT2u3MMMbtN0@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-03-22
X-PR-Tracked-Commit-Id: dda366083e5ff307a4a728757db874bbfe7550be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71b639af06ef1c422df87be36ad411bc31abf1ce
Message-Id: <174288288931.109792.10377073190393563505.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:09 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Eric Biggers <ebiggers@google.com>, "Chang S. Bae" <chang.seok.bae@intel.com>, Oleg Nesterov <oleg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 13:00:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71b639af06ef1c422df87be36ad411bc31abf1ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

