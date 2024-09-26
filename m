Return-Path: <linux-kernel+bounces-340776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B559877B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA52896C5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292315B57D;
	Thu, 26 Sep 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXVPe7lx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137F14B959
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368686; cv=none; b=HPYSlRMex5CH/z7/zNRTsoVmZyYDWUNPn22E4VC+n7md8gmAvJeiSlS5NW8UZf7hdvIdYEH+YnqYrhgzw797A5/0qcvi7pejf64S5zpMX/0Ii5hcOtRtiRfV+ZtohRSLYUw1uuITu+/bdEH8+UKzukB/D9rIh5K09hVtxtlb5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368686; c=relaxed/simple;
	bh=W4pftUZZNG+uSZsZfEqDj8qUDvkhqLWoLRFPK1Hz5gI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qET6JGyVNFqoZ6+UzVYpurH0P2N+ZU4Se+NmJMqGraa0NkVM7w1S4J80KXjWrBDh9GOxy/9qhgqaUhNX0X1Kpj+zBeLxVmjEC6V68zc7W0ZZCiafhD11grtHLW5DgMW2eAVr1vCR8qT4vV2n7jVEz1zo8MRgguUJMVahzlDSLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXVPe7lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0653C4CEC5;
	Thu, 26 Sep 2024 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368685;
	bh=W4pftUZZNG+uSZsZfEqDj8qUDvkhqLWoLRFPK1Hz5gI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nXVPe7lxTGo+OjYXh7Q+TjjGopkHvl7652BAed0QNPNANU9mQ6yvLZ4rTQ5BIxIBI
	 DICPBRzHEq0i9XvNylchM0qZwGOW47B8fWRztwql8vIokZps7uD1lmKGZEPkGK7cFt
	 TYwFt1pCG/WwOiYUiPUiDtVSnrjNsoRbHZseqPAm1rN+ybBhynt1+Zb7ai7AuBW1ZG
	 uOLPbsD39YwCIz6kM+hepQhaTi2UzYZtCsQ0tmjy0RkHyWZqKxAK4WU4cxOA6byxjJ
	 kczpKiAdxhQmwrP5ok8nbPE8bfmLBsxN3FaBi+fYcYaOwy35sgWTQ577HenCFVGuAS
	 KPRB74XC8V2hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE77380DBF5;
	Thu, 26 Sep 2024 16:38:09 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240925233156.20824ba2b21ff5d9a22c2baa@kernel.org>
References: <20240925233156.20824ba2b21ff5d9a22c2baa@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240925233156.20824ba2b21ff5d9a22c2baa@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.12
X-PR-Tracked-Commit-Id: 4e78dd6b4c27c5a6d057f179ff6c1ddd75a7a2ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5159938e10d876fd23d3a5474689a9f6e18a446e
Message-Id: <172736868829.1312674.13872116784108600118.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 16:38:08 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 23:31:56 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5159938e10d876fd23d3a5474689a9f6e18a446e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

