Return-Path: <linux-kernel+bounces-417486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955169D54A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EA628230E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2781D95A2;
	Thu, 21 Nov 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCeX1k6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217B1C8FCF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224031; cv=none; b=n2LsIidz+OYd+NhjCicqmNU/BnRh/OSHeLf/hIDSOF2MrN0Vdo6O0lN55wfjSg5l1WLYUVHWQJgo4mEsk1u1p9gHj0jHqC79nu0Fox4F8NLPpnR1sXfp1DVjTOp7qkIOtPVql+9z35pq6xZg+Um66PXpd2XziEWHXDaya4mM6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224031; c=relaxed/simple;
	bh=hjB7hGiRI1B3zgRH/cJj75oU8tUs/C5k/s1NO6Yj3g4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LQFNp3CdPXQX7OJq3Um5VHhXTc6ZtnY68VVfxavJdSko0SAke+Aj/cxAgFMMgLhYg/6Utwp4CP/YxzyOmXkW5BibwH12stxtz+he8kIl/46D3g7wlFuLsc+ActZACQRcduqYgewgl7EbyckGLthqvmIuDWHSlaI4SbfyVlfpOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCeX1k6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BDEC4CECC;
	Thu, 21 Nov 2024 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732224030;
	bh=hjB7hGiRI1B3zgRH/cJj75oU8tUs/C5k/s1NO6Yj3g4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DCeX1k6FOtlgVqyvnJNXXa8e30CNh80S0XiOXTXROioAsfOy1XVd+wVYlQFnULRQg
	 AYX24B6uw9bIt4B9SNIknSzVxc7dReXFhm/4LLXiYL0sRsMR55Ur0UBCIi3TGxexeP
	 0oXVpM8i5ap98kSS3l1yWE5LcVEH1KYbZZfD9gn3iLONoTTpevJrMSI96fz/4dyWQx
	 uiVonVZcoIAc43c9+5SfApmiCexTIt3ti2oUnpguQwErna+XmVhqlteZjto8nXlKp8
	 DUBNFIC5t8D+xdGwqkTunxKKTohqUvMTxmPPoYa6sapTiX3uLSN9bvIe7mJvy7w/mg
	 s8PFpne/hiOzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A53809A00;
	Thu, 21 Nov 2024 21:20:43 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for Linux 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzzETmfaH0rI6keT@infradead.org>
References: <ZzzETmfaH0rI6keT@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzzETmfaH0rI6keT@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-6.13-2024-11-19
X-PR-Tracked-Commit-Id: 84147f4e84c4f4822006161c5ad43612ac906407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f48f82a1390709207ee6b06939dfae5521316e
Message-Id: <173222404339.2113520.781463950177063405.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 21:20:43 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 18:01:02 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-6.13-2024-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f48f82a1390709207ee6b06939dfae5521316e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

