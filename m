Return-Path: <linux-kernel+bounces-371821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998B9A40D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DE1F243BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFE1DA2FE;
	Fri, 18 Oct 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYAHD9zX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F11D5AC7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260724; cv=none; b=RSfyGVQpNDffTGr7zHX73/79zYbLPkkoMPpYNh9rx1HOTEteewLyD0FOTMBZ+kJjE/I43f6pcpumrKC3lFbDgttql6kUcepoyDHnFmlQOVeCsawJs+Gmk5Dttkqlf0sj5E+RvD6U4EOSILBJrccOC2ANDoYODkXALDTTmOljdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260724; c=relaxed/simple;
	bh=qvcX1OXBPEMIVMStlOyuuySYG9PVfQBaNlLjwwZHk1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C7dr1liSc0Kl0ySEL4GY07RkQ8oM4b6qXLb65BTjy5X5gV2/eHUOVnUQUv3S7eUNYxVMsdPbzv2aX0jxhaA96+3+r7RPk13JkBN+hJc6wAEAumjt11StQfCdIyUZZ0PrU1qgUXRre/jHnZyFbmAlIgdT8izG6Ffh4dkS00mA6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYAHD9zX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E391AC4CEC3;
	Fri, 18 Oct 2024 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260724;
	bh=qvcX1OXBPEMIVMStlOyuuySYG9PVfQBaNlLjwwZHk1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YYAHD9zXfXMGc/RsXrPZ6vXHT1vihQD87B7nTVva4Wi1JDvlPOmoBEvQZhWL86V5f
	 usTeHZYtHwZtfPdK5eUElBel9mdJjfn38+6UsIwQPkdsNxDat6APMS3lmWtvpyN/J9
	 2cSVLfW7DtNNyS4jrvY7Y4FZUh/nY47CUAniGSaLylGbGyosxAqk/1FZ0U5WBOflsM
	 xfYSMJR1w4vBt/RgYBN4QT7brEVC0a8qildXfwhO5gumSwDP7sZu4LqqDV3pzmvPBt
	 3dIFCa8X+0goaludFaVp45Gthr64BvuFPqyKAmNPIvLHDLSgjcOMg6B9Z2HIDb6vpD
	 eCNLAKRVpCMjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2313805CC0;
	Fri, 18 Oct 2024 14:12:10 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-5 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <56940325-8474-42f7-97b4-fabbd3ea0da0@linux.ibm.com>
References: <56940325-8474-42f7-97b4-fabbd3ea0da0@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <56940325-8474-42f7-97b4-fabbd3ea0da0@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-5
X-PR-Tracked-Commit-Id: cf8989d20d64ad702a6210c11a0347ebf3852aa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef444a0aba6d128e5ecd1c8df0f989c356f76b5d
Message-Id: <172926072939.3128200.8235175194685812714.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 14:12:09 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 13:10:13 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef444a0aba6d128e5ecd1c8df0f989c356f76b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

