Return-Path: <linux-kernel+bounces-402117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975699C2425
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332FAB250C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B11C1F2B;
	Fri,  8 Nov 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQv3My95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745431C1F1E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087553; cv=none; b=cKZGTShKxW5DljUJPrbVnjg3+ocQCRH5S3DoDGDqjrbU/ohggi925TgMCMxME+AQayDkXOwZzghKXriI8ZU1OH2losWhENUs5oQklvgyqpBOblS9pEnPGTFB/5cc1Pb/piJapd5uPiUn+ogfLDqn72mah+hJps8GqZ2G+mll3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087553; c=relaxed/simple;
	bh=FBA1UHsrJLyViXGSn/Ke5BMq01F452+XsuBz/VNu1Po=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PxiPFwDdcYJZHzFf+ODT+eVMHkl5pQDNbQ2bAlOAF/eGVAeXa3vgCbDFbyUQ5Igxl7iPDQW7l/nlrdNUFs4shm8DMeHYwu4+UFGsNOMMGjMJ7cCjy2Brx64mAUA7sKJGPE++Ih42Jx+cgXo4nwfiktB94IsI+EGI25Qe75kYaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQv3My95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2B3C4CECD;
	Fri,  8 Nov 2024 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087553;
	bh=FBA1UHsrJLyViXGSn/Ke5BMq01F452+XsuBz/VNu1Po=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WQv3My95Sd0PTGhU1Dlr13/6F7dZND5Roq900EdNeZAsSR/XG5cQiIZixflfRIwVp
	 O4uLVlEOgUJCg8TRilF7ImkGKwpWxVxOW0l8BPrsGFKwIyky/A6AVqYZ3ygxC0HAUI
	 170MHV93ACZ/FNhsMNKYLFqjXOOGpwxh9Lv76iJ4Yvre1FR2XAOy8zVBRjsCN00H77
	 YBYCALlh3zZblcuNaRNE44baUhAKIsOSOfJKrUHxIi3GDoTUop2fjgFB/yPzCzCOnA
	 cmnNe2Kc7F/kHlhhXcHoebIVBCG76fpwemQC7ojph0dPAIKvZS6qb4aiDQ0je6u0yG
	 rSMFTku54tqNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4E3809A80;
	Fri,  8 Nov 2024 17:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-6 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <375850de-155a-40cb-819b-fe21733e3cb0@linux.ibm.com>
References: <375850de-155a-40cb-819b-fe21733e3cb0@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <375850de-155a-40cb-819b-fe21733e3cb0@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-6
X-PR-Tracked-Commit-Id: a373830f96db288a3eb43a8692b6bcd0bd88dfe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51b47860ad8058ae54e4789b5f9b253fd555d2e9
Message-Id: <173108756275.2704280.5311647402414328585.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:39:22 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 10:54:41 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51b47860ad8058ae54e4789b5f9b253fd555d2e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

