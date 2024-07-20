Return-Path: <linux-kernel+bounces-258010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67593821C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C701F216D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991F84A40;
	Sat, 20 Jul 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYnxXu4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEB12F392
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721493012; cv=none; b=F5SD1AWizJMGJ+ABLtAW30e57hvPzq/WcP5Z75FC9O1RDrtjrFqBnTOqX3jLmjmQfKheKvo1n2QPZQhr7kkDxVuPFmvrH6RzqCCor9eRRAtYWSbr1H4Buuq+bOgBelc0mE3mExELSJ0Nd9YzpBJ6/yJtlkWfgQcWioLkgvzgm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721493012; c=relaxed/simple;
	bh=LwG53DGu+NXuUTEEJa6wYuCfAAhA6hkxKYBg6Qe1wdA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DkL1AU001z4Ck7Dxwh8KUv48l9ivsKYXrEsZBZOiV/bsMeLnnhezd9FlkZUNMnVLhHGSnqlfhr/XJJo/Zxr63z1QmWWbZizqeJ2444ZOuikiQUepeJI+dyNTwVWfGNEucHtkT1Yz68VUSldYCddFhSH6hAPIwzTqgtQyZp5I49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYnxXu4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EB21C2BD10;
	Sat, 20 Jul 2024 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721493012;
	bh=LwG53DGu+NXuUTEEJa6wYuCfAAhA6hkxKYBg6Qe1wdA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bYnxXu4CUo9KZQocUJs6CgcOFctCstaATLczTSekTP/UQE0n3XH2JOj4ZIpDW9/lm
	 sHS7xORfvAcZgWGiCs1rlJs3UYtAZLgba+IsfQHFn3r/5GXigZIx1dN17rBOUfSvKO
	 jfOqKmn+0z4ARDFT6Zh19EQKiEa5Dc1E2bSZi7dDnHynyzqd0rhDfUlRlEaEIN1wKX
	 EgO4JQnt0Ij3Ab+GIhE0GLlGnRBYvfJ1yghiWqZs10wFYIIX+9ak+GtmYHHPT+mG7G
	 f9o5cyEj4PsUailyX2aGy6jVlc4mBzu43St+R+4srJ+iidUNCL81xaAVe5i3x+leky
	 O0O4nRkBVnc/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0670D63008;
	Sat, 20 Jul 2024 16:30:11 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-099fa737-a1fc-466d-bf27-9ad62173bb45@palmer-ri-x1c9>
References: <mhng-099fa737-a1fc-466d-bf27-9ad62173bb45@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-099fa737-a1fc-466d-bf27-9ad62173bb45@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw1
X-PR-Tracked-Commit-Id: 93b63f68d00a0483b450b446e2ea5386a1b94213
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f557af081de6b45a25e27d633b4d8d2dbc2f428e
Message-Id: <172149301196.6110.13606531128454287157.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 16:30:11 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jul 2024 06:35:08 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f557af081de6b45a25e27d633b4d8d2dbc2f428e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

