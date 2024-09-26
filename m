Return-Path: <linux-kernel+bounces-340821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B76987840
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396C1285EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37E15B12A;
	Thu, 26 Sep 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVv3oHvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47271136337;
	Thu, 26 Sep 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371531; cv=none; b=NU4oM8XgOk5RCbeYPDgR/sAAtu43nXecNpS+3ODvjTUWTqWash8eiO6tca7R3YPYT3tEF1FaLJqugbOrygVMEnLdaTqptHfl4Khc1RKLz9FoA6mskuWbjYOzbukCv/SrCllp/CxRLVIbM+Z5W6ZA/iDHfucQ/XFe8XKwGO33THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371531; c=relaxed/simple;
	bh=2+c7ETv7UM6TiuuOrVXVzya94vU1TRsAQGrkGgKMvdE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=byr+l/aV9n4uS7Jj7NotCAL3dTGrnr820FtStmPO2s75KReTc12DMmOXe0LdZBT8cLRlU+6J9vOu1UokrULCUKNSmjg+ii1brCCROhcnhyNR0tyCT6hgNwVPN7EWrPJR8fci4aBhIsENbGDxfQuL4eDzF/uuYFp2QEq7ddaEOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVv3oHvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2514DC4CEC5;
	Thu, 26 Sep 2024 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371531;
	bh=2+c7ETv7UM6TiuuOrVXVzya94vU1TRsAQGrkGgKMvdE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VVv3oHvPcZSjZJNPIOI30Vv5noixiAk7eypCbirFAF8acyjjaeqdAeE9KfejO1bBU
	 /aZ93f2DP4Hh3UoYgCYG4Vv7RjODJ9I8kr24zP/m0jAVlgDPM/y5PpsHn5wKC3bKom
	 jBEpcOR49IMJtl1b7CnMdWBykiLrJ+gzeKWSvYzqQb+pjN6sEmq3h7WuoADb7HuwFp
	 SlZK6upnZNCGLYf6fzUgprQku94ODk+c4RvlZPq4EYfl+XdKauQEGU12R46YXrb1pa
	 Acqfj+wsxMJyaU8LuiH66aVpVb7RFk8MY5yY27wNHL2+qaxGdjhLksHPg8W+R+mEHu
	 2aAA9ZT3velfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1663809A8F;
	Thu, 26 Sep 2024 17:25:34 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvU13hRnFM4PbH73@kroah.com>
References: <ZvU13hRnFM4PbH73@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvU13hRnFM4PbH73@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc1
X-PR-Tracked-Commit-Id: 68d4209158f43a558c5553ea95ab0c8975eab18c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4965ddb166992557a25848049f1a70e56050eb7a
Message-Id: <172737153362.1334950.13681698271692121059.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 17:25:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 12:22:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4965ddb166992557a25848049f1a70e56050eb7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

