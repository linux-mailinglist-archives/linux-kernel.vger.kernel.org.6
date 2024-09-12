Return-Path: <linux-kernel+bounces-327228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D20977297
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306511C236F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6E1C1AAA;
	Thu, 12 Sep 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCs55wI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829B1C173F;
	Thu, 12 Sep 2024 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172100; cv=none; b=CASGiUJzuXF30bkBWSS0DMSei5ueuauQgt3YHO9FdjNO6CfHX0n0A5pDbilqFlfdk1EOblMz+GhZITYiuvC/b5u2tdvh8x40XMfBmw8rwLsMaQJdHIPcXS8RRmmDpHo3I47Dmhw+grb4C/Hy4axlEqn93jKjoLkmymU2+c2d09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172100; c=relaxed/simple;
	bh=FkZni3UZLfArRvjFJ7S3xugaI2/CPJ4WSlS67PAICgY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AQPGcLMBfhJb1q3BBn1J1Dk8P8xAfMbmpe3kfMNoOuotlSLdwN/uzCUaTEtdYE+NjYDUAOiK42USngQIYY/MMlnxeYr+K3eSWyNUDlMSBhNRQuiQ4cQ5neqnXKI9RXZ6L59mRxHAg5+RS12jwtyJf1chsWzSzyx3HW+vZtcta7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCs55wI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C161C4CEC3;
	Thu, 12 Sep 2024 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726172100;
	bh=FkZni3UZLfArRvjFJ7S3xugaI2/CPJ4WSlS67PAICgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rCs55wI/pWiIVTD+QxIE60tZ3RMzYJl32yJO//DtffFwXVfNXrQohfxalrWwMTS6K
	 VpECr2955ceJX5FOg7SW1hb16vTe/S0ZeTobxfNq9zQlg+usWoEtLWyC1MumsSdVCQ
	 uaxLurRbywpPmWtU0Ng29dz3jbLKFWMOamabhSeNU+p0Mau4rL8Y+JDmCta1V2m6l7
	 3tsanntft9aIlMcJBooqodjhU29eev8cQOo1ft1m16pq8IkY7cKL9rFpyvQWKGUTxq
	 JlkEN5GpMpOORyrIaS827eq64cyLe1bwFr/tP5kgUBQ2mGQNQIpz8S2tCo0t7Cp+aS
	 Y3OO8JPmhmPdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71DB83822D1B;
	Thu, 12 Sep 2024 20:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-7
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240912121414-1198713421@linux.intel.com>
References: <pdx86-pr-20240912121414-1198713421@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240912121414-1198713421@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-7
X-PR-Tracked-Commit-Id: d6de45e3c6f3713d3825d3e2860c11d24e0f941f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42c5b519498820e95d96311b1200eb4b854fc2bd
Message-Id: <172617210098.1705632.15950535317619928080.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 20:15:00 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 12:14:14 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42c5b519498820e95d96311b1200eb4b854fc2bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

