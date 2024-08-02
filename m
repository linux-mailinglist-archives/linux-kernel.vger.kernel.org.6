Return-Path: <linux-kernel+bounces-272873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC094621B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EE1B22ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0915C15F;
	Fri,  2 Aug 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS2QhEBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A251537B4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617593; cv=none; b=bbdMarDdzxwJYAwNaWIgqJjiLIcwtRFaOsDug10+vEhNQwGxdeErFldVS16vjIVUa20VQgTlddmnBgSWZ2bq4unYyic4oFcDom+vN59S7DakyEXQn0YoEg4SZwaiLwRZIJ/tlLJzvhODwBjpetRhsi7oCPnmDzseyW54IVrlOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617593; c=relaxed/simple;
	bh=8Dg4bJ72oqnQWu5tlfNzixvGk6LmkB0QrVhR6jU1j+A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VPwUZpSMNIeTAqYPfHu9scgq9F5uxdcpbrDSmgqOB5/OvckKIbG4mHWDHbS+eY6uoe7TpEqxcOky6de70NMXrZGL7/md2NsaZJBYsmrIbE/tR6kMyVqNb8nRTYJA19smNrO//TLV6EJWzxmaSqgpzgBM5zPAu0/9tzOxPQ5bd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS2QhEBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B745AC4AF0A;
	Fri,  2 Aug 2024 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617592;
	bh=8Dg4bJ72oqnQWu5tlfNzixvGk6LmkB0QrVhR6jU1j+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fS2QhEBXQ7E33MeL/Xto2O82bHsyjsVJ1W1Lnxn0pUekTKCG2CYdtRI6O9SkC9wvA
	 ohDqbFN7Q/0muE6ltGo28og8T+WfId5OUqtke/GW8dr4yYGEAqpzENg93PnYql6ngI
	 X29ACVbEiasO/4sdeEHTPdTsrs90k5Xe2/3DD6Ri2KlIOTsM9ENco01a/ysQljs02s
	 oy/X6OAFyIpTPc5xvOSHlP5NNzGiWBtZOOfrnwlnJ8rTzwCPMRpXS0C46pVInlF+26
	 2LNjvO2s9hXprU4LpFeT5Yn7OkBBUXN5W5R8ndVq+LsSKJW2GQyG+i63kmzhDkTff+
	 9HQB7lh/weCkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADB92D0C60A;
	Fri,  2 Aug 2024 16:53:12 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw0tAEd9LQuK-ANW501UATMrCDJvyAube9N_umUBBWFDQ@mail.gmail.com>
References: <CAPM=9tw0tAEd9LQuK-ANW501UATMrCDJvyAube9N_umUBBWFDQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw0tAEd9LQuK-ANW501UATMrCDJvyAube9N_umUBBWFDQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-02
X-PR-Tracked-Commit-Id: 27ce65f65258cf2f2855162cbeef59659a81fac4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29b4a6996c244f0d360537d6a4a0996468372c17
Message-Id: <172261759270.28369.7704885635755720689.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:12 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Aug 2024 15:08:04 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29b4a6996c244f0d360537d6a4a0996468372c17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

