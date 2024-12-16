Return-Path: <linux-kernel+bounces-448194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337AA9F3CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B7F1889B69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8721D516C;
	Mon, 16 Dec 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3RUgDMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EC1D2F50;
	Mon, 16 Dec 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384140; cv=none; b=hApEqeO7B6o3ls8AzXXkf+m18Ppy+By//Ir30x3JrbI2aZ2zNuZ5Ibc1CHXALR1OjjZRCr+i1ZRuAd4jmYyQlzPK8Q4C+Pi2TdxxFHkQyHOTrj4TekQYRWSh7Uev7NTQSZV0c7PR1SacYfMfQEJLuDlEHz9ssFpIzrrTPumwNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384140; c=relaxed/simple;
	bh=jZojmtXHufRgbzWMrjWR4aDfvOcVvp9CTufxRktoDq4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eBpYj0UA3eArD6pDyKLpY6RUNKXdXLeW79vasVIaGY3GNiTeJuzd4Z8/KrYx93D2lKneAyt2nyn4m5zugtZ3Fp1hrnm7eWiO7jE7TcgJq3//+VNiN6GejpKncZ+dcpanbj7ZV4gj5XqTMZTeBN0wIXCMGLGq5niHh7ETJP+NTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3RUgDMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25568C4CED3;
	Mon, 16 Dec 2024 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734384140;
	bh=jZojmtXHufRgbzWMrjWR4aDfvOcVvp9CTufxRktoDq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E3RUgDMBCJ9ZN43azsGcG/6AdjmKUv4C7QW5r8aTVuLr1pmTv7EopJuHSQlpF5duW
	 o3QPmPgGsUiakQ4a1/QXZbh2kNE0PwByaW240KXaycnEpR9JYtwCqW61WcLLi9KaDR
	 RHW96xT5XFUKjxg5C0Aw04Bc/SjL0N1ak6msqqFeG9JJECGoMhWkgDUEPkC1ZX9Ze1
	 Og1sJwW9oGbboqOgarqh5e1h6cFjRZW2bjZ5r0gkDToq+ZwNBIyrQWUY7CTi1ZjCw6
	 5+vv0sOSfix9cw424t02II2o7i6WCpOgyml63WiUwawX2CbPGXwgKyGcdIWLAhSgDi
	 o/LMKTm7ZheKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712133806656;
	Mon, 16 Dec 2024 21:22:38 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.13-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20241216172200-163654424@linux.intel.com>
References: <pdx86-pr-20241216172200-163654424@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20241216172200-163654424@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-3
X-PR-Tracked-Commit-Id: 83848e37f6ee80f60b04139fefdfa1bde4aaa826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc690bc256edd9da6596fccf978327309173f44a
Message-Id: <173438415707.354515.9227962370538541702.pr-tracker-bot@kernel.org>
Date: Mon, 16 Dec 2024 21:22:37 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Dec 2024 17:22:00 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc690bc256edd9da6596fccf978327309173f44a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

