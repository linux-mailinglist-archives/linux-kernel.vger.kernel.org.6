Return-Path: <linux-kernel+bounces-178270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B058C4B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FA2B23F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30636122;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F32MXeZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956A1CF8F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655090; cv=none; b=SuxdmdeKLS9/3A/60pHJUx8xI32iBlY3tAfDCH1R2m8XGCOPEELuhvFxPSZAYcCVrtOL1Q9XynQ8ztw5ozUMc+amPxm0AdEYyIsWdkuYmvmeCxtLdb26KxlaRkg07qErJRIh5pjtCTM9WMeOeVk6Pbo67Ijxj0uf41NrORzIfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655090; c=relaxed/simple;
	bh=VmDj2goJFyBb28Prmzk96n+QTJGkWZa0Y4db7vhlaTU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m7ceGGBFEoIH/GKlyRyJFKTYxO1sz02qR5RcXUMDVH7Y721wyMKkcnv2Rj7Al5PdHLYJJByzocIVfqcdmW3jslURlGdp7zeezu92mYMB1v949dD0UoV1uX2Hw7qwGBFHxrmLbfs8E5KTbEi713KfGVl7ihVW8kZaa84pzsuc5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F32MXeZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C002C4AF0B;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=VmDj2goJFyBb28Prmzk96n+QTJGkWZa0Y4db7vhlaTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F32MXeZdFksu2Yde7XRMj2vLADV2tx9xH6cIvjsBjMrcbuQs/Qay+noFCReVDHQt+
	 J59OkscFD5Sct0pBiL8oNzGbW+BZlY0URW1iRZzgE3S73tfvk2VzMlT5Yfj2yUt+Pl
	 x7g/0RYLi/aoGy74MZiwsYxJ6OFBjPLikMm6TkT3ScFGcRFlnyrBnTOmymTdfbKSu+
	 oAUtyksydtcdGB9hK27+xkPNIpCgJnJaN6uCAtgo/5tre+1241yyXRvM3hLeYNeVOF
	 Zn5kzoNEm72gYiEvIl8GhdW7qK+L50XkROdRWWpShePNmy7iCXi/+zGmwDbXRDwdGp
	 bPL+YjTt9kS5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34C2EC433F2;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHBjIwLlEkVD2Vu@gmail.com>
References: <ZkHBjIwLlEkVD2Vu@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHBjIwLlEkVD2Vu@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2024-05-13
X-PR-Tracked-Commit-Id: 2eda374e883ad297bd9fe575a16c1dc850346075
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecd83bcbed7ad657c80b784eaced84e097e63de7
Message-Id: <171565509021.649.9588554998877558452.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:30:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecd83bcbed7ad657c80b784eaced84e097e63de7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

