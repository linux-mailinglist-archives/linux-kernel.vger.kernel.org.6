Return-Path: <linux-kernel+bounces-415039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3129D30F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AAE1F2352C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EC1D3197;
	Tue, 19 Nov 2024 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7gHFl4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718E1D7E4A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059217; cv=none; b=Fhnnka0xt57+sGcCebApydsBqcmw+XZstucgpE/QFY3A8ZU8LUxsTIf79HlEJ5Eu523qzPw4WG278eF6/56vxyXEU9E5bgGA6lDA3bV8QjlIJrg+fIb3s7KwKU9xTQ4am2z7gvvilQR3fFTzNaTyfPbFb4pTUNq5VIbZ0josJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059217; c=relaxed/simple;
	bh=qWXkIyYCdAc/JNvGXeC8WFHvcTCAOSN9cDWcg8PwX9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oMtdj36L0dGTQoussf4ETbz43Pnm5bINOdpgOmKMqPhFAe4j99KMm1Utetj8xeV2sgpJz03vbxfrqNdggLnMkbnbjl4Ckwr4NnLQc8i0gtXOxo4BZzU0FvfUYY9YcpVrgdHl0DNV7NkjGSdj/4cZEy96PMSRaauXm9fpJAPeXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7gHFl4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF3C4CED2;
	Tue, 19 Nov 2024 23:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059217;
	bh=qWXkIyYCdAc/JNvGXeC8WFHvcTCAOSN9cDWcg8PwX9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I7gHFl4k9cXN3a7cf+elbopzcqk/664a+dCh3Mpmwo97qK7fZ7Z5Mp8pUrEMjQ87n
	 B6uyLcAS6hHXzCUQDTuxG3K72nFnyEI1b/h8KIhshGxGE2F52wc/wlMwFi+aqYAPZq
	 sbXW1obyPeFDbrAO1S7Pyw0SrwjhrYGoXakN02Nucn7ElJVzCpIZxHeYuwE15IZJvc
	 8WViIMD2Qhxe8qXQ/X4BM2pNMVKSBfVYJXESV9D22CuGn2d3LCupoz2qdUA089DYOP
	 aGJIu88JXD6BOl/gY4gKDj9j6xkwX9zuzov9G1U0Kcg/W0jAI+Z87w0tIU2T+hNjCF
	 T7Rt0lefsAdSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A5C3809A80;
	Tue, 19 Nov 2024 23:33:50 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cleanups for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzuCCVRjI3BRklvW@gmail.com>
References: <ZzuCCVRjI3BRklvW@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzuCCVRjI3BRklvW@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-11-18
X-PR-Tracked-Commit-Id: 97ecb260d9c19aa044871ae2c89408c340717b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89c45f3823d05fae1896ee2d1adb6926ab6be3c2
Message-Id: <173205922873.720598.15418759800656944025.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:48 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 19:06:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89c45f3823d05fae1896ee2d1adb6926ab6be3c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

