Return-Path: <linux-kernel+bounces-207426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6CE9016F7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ECF1C20A97
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B34653C;
	Sun,  9 Jun 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiPTZOxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F214265
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949525; cv=none; b=iuM84VvkZV8H5crjCLpmzEpGaPvDuP6yM2/HxcG10ycDCrkYlt2CD7kcDiWBIw2xSPIwAPGkIgQK8/XJwIZCXwsjRcpbripLbWc14mD9GQmzQHL51ZQkeTdNcXcTsvtMsdATM6RLmcpvUfzz2IR4DrBWZDNhRdraIaqcjh97dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949525; c=relaxed/simple;
	bh=AVXukoZMhdK9FG+d67cVBaKd4rMbAati93y8QIY9ihE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nxmcsbcxFMICkx76l/gwtAvMV4onL4S2F1KeGftprBwYQzVeSP+5NUx+nnjmHWfp4vq5WKcDYJdKjeuQoOAsBbR1SKTigcG9GJgtJ+Gpav8e8VIwXdHnEib8+bJ4+LnATPVrWnGhbklNPOZ8pRBE1p3UsaIxh9xk/FLd/FTCjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiPTZOxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03302C2BD10;
	Sun,  9 Jun 2024 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717949525;
	bh=AVXukoZMhdK9FG+d67cVBaKd4rMbAati93y8QIY9ihE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AiPTZOxdUPowkgEnYWTxUzQjpsNGIo0wkFphUULFFhMV1TzHAH0Ni46fIoFSx84zV
	 F7nHvfwGW4rxGZsiJbyM6WybRz0b93giEgWUXZ344YxSM7GCfPAatiQf30GlxHkysY
	 sR/FFahqSgNHr7HOIawsLKFTkRGGvCPy0gBDbFtdo3TmlUDyRizk892DyAfmPhYNIp
	 EeqDiaDG19WQH2MV9sV1GOQk+fvfe+xkMBGEvM3kk4A6w9PGGWd0fPVTWXm0EPM86d
	 01D3xJv5HhtJ08tE9wtnaHY4Mv2ti0YqUgADtFNz/0U8Bk1aFY7oev5hmvmpBdJIMh
	 6OLi1Fvfb4RCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE682CF3BA4;
	Sun,  9 Jun 2024 16:12:04 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240609092933.GAZmV1_Q8VbuAw_e7-@fat_crate.local>
References: <20240609092933.GAZmV1_Q8VbuAw_e7-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240609092933.GAZmV1_Q8VbuAw_e7-@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.10_rc3
X-PR-Tracked-Commit-Id: f8367a74aebf88dc8b58a0db6a6c90b4cb8fc9d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 637c2dfcd9f5e194ab2e879704460840edcde537
Message-Id: <171794952497.28618.8783490578312173975.pr-tracker-bot@kernel.org>
Date: Sun, 09 Jun 2024 16:12:04 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Jun 2024 11:29:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_for_v6.10_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/637c2dfcd9f5e194ab2e879704460840edcde537

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

