Return-Path: <linux-kernel+bounces-176045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC418C293D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE01528720D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202D18059;
	Fri, 10 May 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8AtDk65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3B18030;
	Fri, 10 May 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362148; cv=none; b=N3icIqSHTLzkEaNLwss99EEWxwdGmxg0UE/8N5A/QvgvuAEO7IPsHCCAOnHR5um0/shO4FodwoU1hM6RvdFhI2JHjuP4mp42NtsenDEJ7SKuU88njsdbTOGMegsQ8T+CzmyIx+3Uwl+naNUWbGYfnCPdQg7NRuNYRuijswtwrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362148; c=relaxed/simple;
	bh=e1S1GMOez5jI9J8BQm7ogkHt9qf03HSbbIfGytjuXVw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ri9mXqQcxylRGtuhUz7rUQ7gfVT9Zv5qn+FCDLhuASjVUjXVPTPEPYuKRhnuoc2b7vQ9PincfSIH4qfq61CM4L+B7+ePIyTiEZmO4EMCXjPeL/QT8hythb/ZecFFrTre4JQqT4y+Sn0tFXQDH8WhGPDtf4fu+THs1KGnkPj1SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8AtDk65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C9A3C113CC;
	Fri, 10 May 2024 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362148;
	bh=e1S1GMOez5jI9J8BQm7ogkHt9qf03HSbbIfGytjuXVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o8AtDk65c+UrCGm+2+7jko1ETU6lvEMkyRL3ApzwlXjE/2w85nTEvDGIypaxt9aEQ
	 XhKVWqbq+u77YZaJU2UmsTCr9kEtlguquPAAamJf92GiMsb+sspN5+kqq+wgoQq1g8
	 M2JeNO2cdyzsDz2IN3VGiakx5HCMdLhTuXbh+PmZnZNXa4GuAUyK2gaTPrQ/9tamvX
	 rzKmCjgRJN0eD8TYy24W+Cumu0YPxec5lMD2L5yB/Yi23EmpGtoItjdTBk7eaPPrIz
	 eFmeCislOo5jFLGNISCEDN7VG5+vdWLb9RRtdZQANCyyyzu+qRXXKk7wsyEpcp1ugP
	 2coJ5c9MxqnGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CC6EC395FD;
	Fri, 10 May 2024 17:29:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <275b918bbf12753d81537f9697615900.broonie@kernel.org>
References: <275b918bbf12753d81537f9697615900.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <275b918bbf12753d81537f9697615900.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc7
X-PR-Tracked-Commit-Id: ef13561d2b163ac0ae6befa53bca58a26dc3320b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed44935c330a2633440e8d2660db3c7538eeaf10
Message-Id: <171536214804.32093.13039464225232443615.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 17:29:08 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 12:58:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed44935c330a2633440e8d2660db3c7538eeaf10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

