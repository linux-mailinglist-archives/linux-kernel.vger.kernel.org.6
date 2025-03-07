Return-Path: <linux-kernel+bounces-551949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27685A57350
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7AD1793E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2CF258CD5;
	Fri,  7 Mar 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuuDZDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5C258CC8;
	Fri,  7 Mar 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381430; cv=none; b=qMp2rGwFz/Gwg8ug7bNM23Bi5SKz92zE5KIaDaHEddh722TokF8XzvQcds90eIznGYbD9RJnJ6Y4AEYDdNsyK1CIeidIdtwYrLg+u7mbrJ1wdUwtayzikCGS8jxnaLPWMSaY6rHmWZF8tDbDUxIrDoT2SV2xWXqwqIEMD/6/iSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381430; c=relaxed/simple;
	bh=F6ApWp0uPt4EKR+PmPeYyxQ8w+hfD4kuTYdVpN7C5f4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iJ5l/9cj5HyzLSLAtzGFbQn/bUFY/FsagwCrLdocXgGeO6ITuMFwo74+WyRYHaY3aX5ERT9PNpBDNL2RS2CBjs6KB3K18E2eO5CMbVfI6wbVafHrUubQzycyUly23PPA20o7/PZHHp/vHqJamdzeDsVbPIiv0Qp0/F8R7VKIQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuuDZDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317DEC4CEE7;
	Fri,  7 Mar 2025 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741381430;
	bh=F6ApWp0uPt4EKR+PmPeYyxQ8w+hfD4kuTYdVpN7C5f4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oOuuDZDcbSL5gS4mNCWayv9c/WE/dWHDx3D6ykiChayEi/NAjDpAc/CxWuexE3MvB
	 KqbeEdYD+hl0uEIH/Ij4LClkkbnkev4UovGj2G2eRMH/44dSX+ZnMwTPCEienRdROc
	 g69uc1AgOfVsXRdyjZ+OocZklcnEhwupwZ78/fjAPN4ITymIr3InfWGKEQyF0ZmzNu
	 KGts6VlBegG5Y6eePTMXqwLymU4ZZZtY0DHHKY06uzawdk7cByczf4vN8PiLUEtrIk
	 juBi+bs5Fqd77gj44aX/IRUK2SMbZTjFz05z23QwlbLOsD0Hxk59rAm+PhJnHcVCT3
	 POWXDZZgaDsJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB2380CFD7;
	Fri,  7 Mar 2025 21:04:24 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250307150347.3784204-1-linux@roeck-us.net>
References: <20250307150347.3784204-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250307150347.3784204-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.14-rc6
X-PR-Tracked-Commit-Id: 10fce7ebe888fa8c97eee7e317a47e7603e5e78d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8287dfc2915368092e98ef0caef9c03e8e0f7aa9
Message-Id: <174138146362.2483503.9491574669390027491.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 21:04:23 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Mar 2025 07:03:47 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8287dfc2915368092e98ef0caef9c03e8e0f7aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

