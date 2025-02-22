Return-Path: <linux-kernel+bounces-527454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB1A40B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDFF18891A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E332139DF;
	Sat, 22 Feb 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IphUBTTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D282139B0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252170; cv=none; b=qa0OcSk7jFP+3u38ijBDjuIZP+fo4WK4917yUCAI03Y0m8bOd6a9x3AXoqgm0CStePRgIzjy+sAukGTr//RUKFwAQQ/cno/+kwWX3G7ufRfcl4Ra3YFUYtNKFRXTfsiCSC91eZFcBdt+xiKv68Wb02TXd6JQ2o2cuLXHV/tGo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252170; c=relaxed/simple;
	bh=xPCBZ1aR5L9eACJmsiYxtRpzNwNm0bty5Z1yAwhJiqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Oht9hgZO86EtdCPxLn1RZsvqrqQqYBokxxBMj2euuMjbAbiCNhYm6atunE75tIaPzuWANiTR561GkWBZgQZxX8zAnplTaS+TgdUbCqM0aBX+MPAYO/hcuirSfKZcC5REh668bZoDZO0W2Ff3NxEqvbhP9hH57w5uNPVH/b5zUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IphUBTTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D34C4CEE6;
	Sat, 22 Feb 2025 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252169;
	bh=xPCBZ1aR5L9eACJmsiYxtRpzNwNm0bty5Z1yAwhJiqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IphUBTTTLz/1hdn2u0YSIMVofBu52Q5ve1YY3bxl1VD//tcDq2bsEKKj2GYONzeZq
	 AJHDkfZkwQCVPdBn2nxCxRRD4VhhIke+6rbW9x66qtGwEaqDuJ+6foS+7uqTfO9o5a
	 EocwjVAHnkG0F06NsQUBgowHNZzdZE2WqMZX5Fyf3EjNDJ2Q5Xl82kauqggGqCEWxG
	 /bLNtMNkcWMAEfqdevPfIP0myguaPmWS3Ght8bFt+JapADQBpqWjnQprFXW+zvf6PM
	 LiawykrVcgUpESwSi7qFe+kzdwP2ojF0SUIcQ7qVpK43TPU986+dqWo/VNLe7JaKmB
	 3GgH4sBoEENQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34152380CEF9;
	Sat, 22 Feb 2025 19:23:22 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7naGFRn755UP0Ke@gmail.com>
References: <Z7naGFRn755UP0Ke@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7naGFRn755UP0Ke@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-22
X-PR-Tracked-Commit-Id: c9876cdb3ac4dcdf3c710ff02094165982e2a557
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cf80612d3f72c46ad53ef5042b4c609c393122f
Message-Id: <174025220078.2429034.7867049260010443460.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:20 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 15:07:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cf80612d3f72c46ad53ef5042b4c609c393122f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

