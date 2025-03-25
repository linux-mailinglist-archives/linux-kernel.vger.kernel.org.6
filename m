Return-Path: <linux-kernel+bounces-574617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F05A6E7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461EF175387
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB6614900B;
	Tue, 25 Mar 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7+5VjIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACB140E3C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863498; cv=none; b=sHfXc3pW/A0VscefHB+JDPr9ZJLAELJ88rjc/tny3cw7pGfGGKdy5WWkXurdr6o6Vy/PCTZHNCNeyLvv/MNnQTnkObaBnGoK9Oy+mrUCVqR0Nlh8W675AYyaZ/Zdb5B9P10hqFsbV0pC8Y/PA1RRWlQzHPZ6DdCNQk/JZUnrBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863498; c=relaxed/simple;
	bh=JXG5+1eJ7K1v0uAhOsa5P380eGiB+C+BOhrHKTiPnWA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C8EZ695b9T+YW5hrEOsNayThDWxhgCKL6Ul2EluxSMO5VknEcfXJ6UEPOnUjKrcObVzgDTeAhVpR8nmcECbrZZeSVDrPD9LjO5jVvGcXWCx9h4jbESN2rfBtwXJtlEDq1IJHeiNofWwEjKauBC68M4bHd5EHKW4AYOO2SjnCLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7+5VjIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D76DC4CEE9;
	Tue, 25 Mar 2025 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863498;
	bh=JXG5+1eJ7K1v0uAhOsa5P380eGiB+C+BOhrHKTiPnWA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r7+5VjIG0peCKqAB7xZ99wFsAtIFPBgWtUDW9mYOvtlmTFn3ekgm5spLHiUsJPTyg
	 motqiUIlVtNbEogMKEhHM6NbufTRFLSmgPr/sjbX0T4G2ZGXB5ZQ9tyqwcpguoJ0QI
	 VbaUYtsDIVWF+B9zVckpELRV9iW3cD5p2TdFFYpU+FCspgU1ghHXKf0QAI0O1XDTea
	 TML/BH0OD7zgVab0FmQeBc65FneQE0DRxa+IJGNqyWPBRovbD5kriw8rEDx9wWbS7l
	 yk3Z4bTxWLen6YD6HpFDZAdMk4KxzHWZIPV86dNY5ci/Y4g4snQDxl/nutFtjRISSG
	 /kUVWwOlNeGig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24F380664F;
	Tue, 25 Mar 2025 00:45:35 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503170859.6188E2CEBE@keescook>
References: <202503170859.6188E2CEBE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503170859.6188E2CEBE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.15-rc1
X-PR-Tracked-Commit-Id: b688f369ae0d5d25865f5441fa62e54c7d5d0de6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc13a78e1f68fa5ca41280a397a046a6eff6cc9b
Message-Id: <174286353447.36585.8084404523934217982.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:34 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, David Gow <davidgow@google.com>, Ingo Molnar <mingo@kernel.org>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Mel Gorman <mgorman@techsingularity.net>, Michael Kelley <mhklinux@outlook.com>, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>, R Sundar <prosunofficial@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 09:04:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc13a78e1f68fa5ca41280a397a046a6eff6cc9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

