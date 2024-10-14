Return-Path: <linux-kernel+bounces-363098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 088D599BDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D81EB21FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11384E1C;
	Mon, 14 Oct 2024 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbBXHmND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD681741;
	Mon, 14 Oct 2024 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728873546; cv=none; b=f9sY2PKvbjcUPiRzZeg8ZhEsG4wxpTJPOmGGk+sQgQxNLGE0rvW2k5MKiXw1f2or9opdxq6DBUFlZsqRLDsnZqG9bMm0F2WXp8ddoMfJYM3tt/wkTKxjoFvxbOAqrqTw2CK22InZ330gzMQagJOk9Ngk8TsSdUM+szyQzqjVDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728873546; c=relaxed/simple;
	bh=GRC1mis6VQen2rVTEIPDOkTYu4cw2GcYXcsNx6yRaiU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ApfItdchyjCe+7DmyjZK4FBDYF4ZQFtB+Wls9x7Z1ygVYrV9u+sYoStE1IHwNgA+gd331WfOrMzZPcR/6CABF5JfqvSPH3c1wBE/VeFkuyxbUZU9UuwvlBn4MbGLIh/kIQCpc8WSynGbxRz3WzqNuEiQYWdKbcYaWE91Ia+KWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbBXHmND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA389C4CEC5;
	Mon, 14 Oct 2024 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728873545;
	bh=GRC1mis6VQen2rVTEIPDOkTYu4cw2GcYXcsNx6yRaiU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DbBXHmNDhP/hbNDBp/e8DupTN8FATLYpKcZcJy+zNTlOS+fqEnqR3EJpq3prQz6m7
	 +glH3Y/iDYl/aT4CvX1p12ohf3T4eB2Oix4tM0ieRjiBrqsTXjTaq2ur8RQk1/KvQK
	 +oxqKkw3+XWocHHiwnuEpcUhOJCqGu9NxYLsk9X2M6Cf/4lohJ4allbPyWgEpV9lIF
	 cLjWIR5AN7Bs2/GSWnfl34r/boKoKxi3Lw4Wehh6tefQmjgq4ZnGKO8lhKZJWexrrj
	 VX87XR9sV3Jw8LPZRGXYd5nbiDbWf4VQIraBMD+LpStjO11PL6EnOdZ7oCBo1ZvPh2
	 UihDTXIAT5enw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADED38363CB;
	Mon, 14 Oct 2024 02:39:11 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241012012850.1580196-1-linux@roeck-us.net>
References: <20241012012850.1580196-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241012012850.1580196-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc3
X-PR-Tracked-Commit-Id: 2d6c668902e5834f54d7eb673318455492730cbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05749ecf5d52e28a1eeb494498e2d51ebbbec11a
Message-Id: <172887355052.3903120.18256100472276740107.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 02:39:10 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 18:28:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05749ecf5d52e28a1eeb494498e2d51ebbbec11a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

