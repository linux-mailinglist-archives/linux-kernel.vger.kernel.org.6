Return-Path: <linux-kernel+bounces-179073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876F8C5B46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C405283AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5E181D00;
	Tue, 14 May 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdxWfHJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03038181CF7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712124; cv=none; b=DcAAc30o95Ulpnpvyy9qW2e4R4y57qj0NI21s/7TVO44jb46kadLnFj+TRo5tGXlHMb54n3FgppwSL/LiCsv6bEVfq4w6pLicfUSMYG6KLekQLO83Fc6Xck641eeLke+PvsL42rRXGXDHiHzXJqkRgTJB28xPDEMKJVp4BNAf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712124; c=relaxed/simple;
	bh=ECjrpwFzTKDnR+41KuvMr/OJdN4HUw4TKCDLSGbjIZM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gfKVYzqDfjF9iORcxQuEDxxulbGixpP6m7F6ZS3/oo29qc6fgtOYkAsY6b/pMV2FPlF5MUIx5mXfknfVdtqEwJOIeusKiJ0SvKBYhuibWf9YGS/+NDfAxDgQfOP4jhmGbr+AEjiEUkcsVoqiHFYh5Loo0KSIJJXGD3O/r8yTM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdxWfHJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3724C32782;
	Tue, 14 May 2024 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712123;
	bh=ECjrpwFzTKDnR+41KuvMr/OJdN4HUw4TKCDLSGbjIZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kdxWfHJWN+lmBFNwiRVjnxAzQoxqLM/VhwoY24uPKg9FYZdzt9bnkKboQw9WaEIcs
	 ljwDAfSKmdHz7C3U9xSQSgKPdl9aJixor3s8cFtkJ4952pyJeoPxAlkjvbww+yYuxa
	 XrzEzA2X+9g0GC6NxVtuskJUqMM3RNkVi+3L0Sq66ygC5QIKBfQtiIxBMxONcZ7V+t
	 sMazic0GN0/gJ/Ah7IxrZC89JX4aQwIwDkHs2j88K5dEItW88kOgvfdQEPnEtFMQ+E
	 d0oeLpcbSBj553zPxM5h6jcw6hUwVIpd8D3x8zPMRZVW3WxbZgwjTysvduYq97JknG
	 r1pM+u3Kp4WgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC30EC1614E;
	Tue, 14 May 2024 18:42:03 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513152955.GA28901@willie-the-truck>
References: <20240513152955.GA28901@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240513152955.GA28901@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 54e1a2aa61a7bf4af2799baf7ab2dc2712844245
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 103916ffe24969a4c938ccfe89e956fe7d9339fd
Message-Id: <171571212382.4202.9122673186616794449.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:42:03 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 16:29:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/103916ffe24969a4c938ccfe89e956fe7d9339fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

