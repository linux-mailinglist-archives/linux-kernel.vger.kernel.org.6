Return-Path: <linux-kernel+bounces-276721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A294978B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3908D1C21711
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460D762C1;
	Tue,  6 Aug 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYgd80pm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5B136330;
	Tue,  6 Aug 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968748; cv=none; b=pe8DKK4G5tHouPeuFhxuwWUW0Js2otaufUYa1bQDBjhO4y/6kgf6eDGh3YN8gnW9ztFJLi6UrAzLv9bqmqNKl+CegTFDv60pwtiAlYL2qWv0cIaMk0Fjjl2IaTjnACzkJFKSY0iJ06cOpzO6AXeh2bgIksttY60NVs0WQJX6OXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968748; c=relaxed/simple;
	bh=u92X0gQ7+Kdf32kfkOXmeNJ2gqqNbI94BerZH4lTBzY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SfH8t403HVZeZlq6l3M/87LeqHvyMyLOEz0Ts6OSl+2EP+0P6LI5z/XW9/NobiWmtHv+Re+H9ZwoFGQkvCMdNUvFe22O1moiReocGkHYN2yZbVW3jn29r0iouMVlhqj+dC1fDEKZOCen4rVYHTk+SKjgOWeJPHdgzrE+aPhRVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYgd80pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A67C32786;
	Tue,  6 Aug 2024 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968748;
	bh=u92X0gQ7+Kdf32kfkOXmeNJ2gqqNbI94BerZH4lTBzY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PYgd80pmEBqCOKDhm8JJsDJYZGdiup8DKRT5T1O6bs+sHx7EFGC5OUOVSmZAGU2Pl
	 UwaZwcfVJuodu1kEBQvfvitMTrPP0JjGwY99/hRlioR+Uj0EajSdwfa+dPejIMMvh9
	 /Po+b4dtMxBTXlB2XHsPGyfNxrQwhMW913Gy/LVre4xIZE2vURh8l11FeoLJYdRiyp
	 fe4cbGAEM2IwmDZUpBH3zrJd9jDc2PV6w3Qt+rwatWyLMaf3FOo1vB0CnNfI0zW8Yf
	 UVQGYuW3RPY+gJHgJv9/vZiOXqgBmTfQDK89nEW+7EykHUo82SKmLKoj2sl9pfgafn
	 hPDFmuTCK/K6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE9C3822F99;
	Tue,  6 Aug 2024 18:25:47 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240806094038-269710364@linux.intel.com>
References: <pdx86-pr-20240806094038-269710364@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240806094038-269710364@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-2
X-PR-Tracked-Commit-Id: 3114f77e9453daa292ec0906f313a715c69b5943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb5e56d1491297e0881c95824e2050b7c205f0d4
Message-Id: <172296874645.1388134.14700883905599877361.pr-tracker-bot@kernel.org>
Date: Tue, 06 Aug 2024 18:25:46 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 06 Aug 2024 09:40:38 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb5e56d1491297e0881c95824e2050b7c205f0d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

