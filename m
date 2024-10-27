Return-Path: <linux-kernel+bounces-383744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03329B1FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51980B20E97
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234B17B41F;
	Sun, 27 Oct 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiUmOeZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42179C2;
	Sun, 27 Oct 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055397; cv=none; b=JUqwcqqowg1ZBrduyiLQmFtFLetOsXj6B11xynDYkHYmDQ5w3lFgcP5Dx8+WoLxvfY5Ck8VyS5V+8QZSNKPvHeNaoI/l5jfsRkyeFo1IRQcvjPZh2ifG6YV8cst9N8/2TBbRkk1iKLURDJo9Jx2MrJAN7GyTmzUHXUhVm/bamY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055397; c=relaxed/simple;
	bh=VFn7qjpH5E7PBN24pwaX/mYW4iaSXnz0gUVURxEvBDs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gzBX0ADwH9AGZXOproT85Ttty9qoxRkniTJ1KIVuB/vVHsuegr4CoGOyHScyDFhJ8NBgrasCv96mhEqlUBS0Yf02dqsRgVGRZZ9W4C3xt5j8oUFoZzkoW9ENT+n0a56h/kjQ/6h4jZ493uVq/695jFq2+NZ53x5uEHcqickagNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiUmOeZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B01BC4CEC3;
	Sun, 27 Oct 2024 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055397;
	bh=VFn7qjpH5E7PBN24pwaX/mYW4iaSXnz0gUVURxEvBDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uiUmOeZQkk+fDPcniEDaGnwKNuQXHDqH6+bHIpYJXrmfH8n7o4WDEjjSpnrWtKpf4
	 eMlcGnhIu7PT8DBERkmDrTrdVCgVukXXp0sN/Clo22Hppg7N8+dOgzVeXgu0hxUueT
	 xxZdgbFoKbfUP6+PMLFcWgOKPUKKLjKmgV1mIF+K/lqCz39QpRdb1zdBgLO9f4QUyM
	 cEcN5y17eBPPPoedDNzxikQYlq4KuOUWUzAucAEvTOwkP0CjB7QCcrJcCoQogFaTbx
	 rqVHrWSM/AYTziJu9+xQq2eKeTsOp5HVUL6+hCcvvBIFjT3qVsGRrZg9Y0Y2VddAY3
	 GaNNNpa7UAYgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF113809A8A;
	Sun, 27 Oct 2024 18:56:45 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.12-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <b220d6bc-41da-4ae6-8f69-4f008f15d540@redhat.com>
References: <b220d6bc-41da-4ae6-8f69-4f008f15d540@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b220d6bc-41da-4ae6-8f69-4f008f15d540@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-3
X-PR-Tracked-Commit-Id: b012170fed282151f7ba8988a347670c299f5ab3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 284a2f899676407b5bed8c1fb37eb9d636e5477d
Message-Id: <173005540412.3429718.2436224015131590947.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 18:56:44 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Oct 2024 13:52:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/284a2f899676407b5bed8c1fb37eb9d636e5477d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

