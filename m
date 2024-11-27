Return-Path: <linux-kernel+bounces-423892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6F9DADF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B228016441F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8428D201268;
	Wed, 27 Nov 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbmRD5LX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2253201029
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736220; cv=none; b=Xv0VQUZBhjauZMjBtarZd8KcEwtDvyupFTFL1L0ur7TCpscx8rVe1Dmvb6wXYfJknqwJcbGqB5H9jtFz5iq3zMSbgeMrqr0Tk5Ey50H+Ztybj8bEiCDNwbFKm0RlIMSobOWO14nqXUFhADS/8SIoVcrKlKLkaXToR0Troh/kZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736220; c=relaxed/simple;
	bh=ZzX7oKXy2Tdp/Dmbid7+UFmOK72Wd7W9l1+Q2D83x7o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lvo8BbfaGXZ8bSCmwsBGxAPGHZOi0cpj9oDo8Vptd/2ya5cuO8xIZyUGA1/BPh9UZfI9iacF5OLFlnDYid67VbWUgABRoGKXna/2NFwLm/TaXQRhGXx9TvbZ6ME01w6I4eqCO/Q4GIIhwVbkrKGflFFPkDCvWdkEvypVt5hocMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbmRD5LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C7C4CECC;
	Wed, 27 Nov 2024 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732736219;
	bh=ZzX7oKXy2Tdp/Dmbid7+UFmOK72Wd7W9l1+Q2D83x7o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EbmRD5LXDAgDQHIvFlqudUM0R6quL2TGkZ8P+fphFPjwQ96iz9ie1gMFZaG2Fg9RP
	 bQSdPcit6iGL2p2czFpl0unt0zFVHM0mJ3na/7wUhV372f2bCHQwicSBc+2wMR6ath
	 iQUxtxVv724HqsFIr7B9rrRxrbUqXS214hzRfHRUQKuEoRIraAPub/xPsFGfktV/dU
	 F2JM2ylC+phYxKEldtzeFKWBKjdOzxGOB/01NkbOaZTJhgU8wuj4V3ykqSdRbSsI/I
	 JNlGuUh4XMcVGiUEzBF/Lup4HkVsX9LUTj0cS9E+sQ0FwTEdVh99ftFhVklpowxUNc
	 8W0P55JiddsGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC0380A944;
	Wed, 27 Nov 2024 19:37:13 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Paches for the 6.13 Merge Window, Part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-5c0ea89d-908b-4009-ba23-e4fac45618b4@palmer-ri-x1c9>
References: <mhng-5c0ea89d-908b-4009-ba23-e4fac45618b4@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-5c0ea89d-908b-4009-ba23-e4fac45618b4@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-mw1
X-PR-Tracked-Commit-Id: 8d4f1e05ff821a5d59116ab8c3a30fcae81d8597
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91dbbe6c9ffe5eded9a3e75d773ff92da8d2bc57
Message-Id: <173273623222.1191875.109864199559601828.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 19:37:12 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 07:30:53 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91dbbe6c9ffe5eded9a3e75d773ff92da8d2bc57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

