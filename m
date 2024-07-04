Return-Path: <linux-kernel+bounces-241681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93195927DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB9B245E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B351143880;
	Thu,  4 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDu4yuwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A155137764;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121821; cv=none; b=lnsnvsHaPPPzsWGZys6dcLZwb0fYpOOdy4T1YUJfnwmZAWZ4cDfHIBBEuur30MoeOcGkTO6aC1WDRR+Hj4N+7b16691bkH3wtCZHR1rZr8+ZqgG9k+7hCUX+ffNafJjJ/SYQIJG9BU4S8TQ9oRomwk/yDCOgdaZ1D30ouiPuJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121821; c=relaxed/simple;
	bh=9DxKuiJjN2QzN1KLGa8xlFaNen8MLS5THovua4Gm/Fo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k4WHCmNVneMQksYbR/AB9R/2wFyLe+kQN8sXVEbWCnszy9kq844VazHPuCnxfIW1lU0rFEko7j708K6X4ON1jSBHIcpOcWQpzbMTKNyqxAAYY2xJUt5bSbd4dygpfw5ooxScxUJe8z/AgWVWYDNSpfeSndXXxkzc5REiWVB+UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDu4yuwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2CDBC32786;
	Thu,  4 Jul 2024 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121821;
	bh=9DxKuiJjN2QzN1KLGa8xlFaNen8MLS5THovua4Gm/Fo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KDu4yuwx1Cnp3dr2bKPv/E4SIo0XKLQCvKRpmFlvWnJso4lUifIkN5AwCGo+AI6xi
	 dq23+Wv+UBR0hJfuWoLke6G6aqa9SJw03tFszD+x3+A6gpKvxz/nE6dNMMm3kS5vVv
	 Yypb1IqUhh42Oujoa3m8aEC49InXnTk9NYd6BVjwpNZIlvhLN/0droL+mEt5NWjhpk
	 peshKcEOVaf3xyxwJdlbsFHFLzhUhIjHMjfIevSWTe1AQT3nM39/PNbQGp1ACBeXK2
	 rbmpNEA7EN9aRPpEy2IOdI8aDCjQQ6QRC2nLxT+AlI6UbXCeUMjqn2bH76/u4E7XJ9
	 Ki6HtbjgjAq8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E729EC433A2;
	Thu,  4 Jul 2024 19:37:00 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-5
From: pr-tracker-bot@kernel.org
In-Reply-To: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
References: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-5
X-PR-Tracked-Commit-Id: e527a6127223b644e0a27b44f4b16e16eb6c7f0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d19be0952a3dc974e667633946c9ab7643eb082
Message-Id: <172012182094.16688.8777584119954593538.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:37:00 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Jul 2024 15:05:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d19be0952a3dc974e667633946c9ab7643eb082

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

