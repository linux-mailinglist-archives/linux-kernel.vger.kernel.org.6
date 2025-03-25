Return-Path: <linux-kernel+bounces-574619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D46A6E7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DDE3B87B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14F6176AB5;
	Tue, 25 Mar 2025 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STntwQNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E38161320
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863502; cv=none; b=HVcx86S9j8uQNwB7PJyVSbScRSEHGOzH/fzR7CHxApFb5nggVqTIautk8HboupWoWtfuRBWoaRCWAnJNqEgRwrQ9erAk1rX5vkzWZPO2JXyBO7lsiWmYYsDJT1Cvw4a8Bu/MIghWKg4IlKZ6xvX9qO1nU6Yo/ksyUeKMEtryV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863502; c=relaxed/simple;
	bh=Bn0qM9FlnJrnTWHkbINGP6KuWzdzGb/6NENsQTMXYQk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cMy1tjZxrUCvlOub6mHxIMan62ZoI9Z4HC64YGEmleZCqcqOb2K4qxbTpWMRKQJjLzV3IfUaR6v+SEMDP79dA9CGJ4lK1ziF5hLIJI6ZqAbn12V2maWkAUR1vOT37UdgVSg0D3D2fE5B61/WnFuwFkiV+53clZha8+W4bFLHC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STntwQNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13504C4CEF0;
	Tue, 25 Mar 2025 00:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863502;
	bh=Bn0qM9FlnJrnTWHkbINGP6KuWzdzGb/6NENsQTMXYQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=STntwQNAxmjUQJDEQWFN703bedOmkzUVdeGA/XXhMwGaMqbOJjjRGsYSTgsjxEg0o
	 3W4wZ1krmrpWKy0MQX1GGZnJsxqaaLJvScnZfUMCI+YSKSGPpKHafgBecdCDUVPDEd
	 Mx18zUdNE7dbIsVlrmjeFSLA6RW0djMipgKYelo6Ntye10Pk4J1xudfxu2KiB2hGxd
	 rl+OhgEGYcFHYSAbuEGQwfh0hW+khQj/Gg2Lcx3PvepZGCscEwTqN/DWbha1/iRs2Q
	 l5s61bBPKeyu5f5ObOn+NNZndomuU4MGN9/Zw429SpHAKCnuF86gowLNmg9VHp0JVo
	 o54lKr2FpX7pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72E58380664F;
	Tue, 25 Mar 2025 00:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503170909.7FBAC1E@keescook>
References: <202503170909.7FBAC1E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503170909.7FBAC1E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.15-rc1
X-PR-Tracked-Commit-Id: 8f19331384e6ca816f5bea20ab45c4b72a5cd05f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11c2b2e3322b23b3e54120b778119d2d09db4421
Message-Id: <174286353792.36585.13233570631803674818.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:37 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 09:09:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11c2b2e3322b23b3e54120b778119d2d09db4421

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

