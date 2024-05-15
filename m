Return-Path: <linux-kernel+bounces-180200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E28C6B66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F0A286297
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FC156861;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcpyKTRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8A156657
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793613; cv=none; b=nAOXSHBOw12byHUj3Pg2eNt9/Ebik767bkLdmrwcQcJITMI8ZUi5fZAqILLjL60mAXBNmcgazAJVC8K5K3BUG1NzR1aoyr69lBrYIcWfnbxG7vol1iqkKwDim7/q9RGC9qacSowHbVCCV5MY6YU5A6mPbEL9GvCpoJrMWOxgWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793613; c=relaxed/simple;
	bh=evynaZF+OdsmiraBszgjNj6hgX4XcROF8T2Q9yrv3ds=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YUW5oTalq/QFM+WxH+/lXfG0Po6CYscvxluBZcODvJ1EuNmjQQ3orcETdEfPN4gFlOK5qRGw04R/l8fKLt7vI3eKlHLuJ/LjDPx8uy5tdXw2cZr6W/N9DqMqqvb3QgDwh+TUAtobWJ+hCfbH41rv9EA5CCtPvTBtUiDITqjs5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcpyKTRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11947C116B1;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715793613;
	bh=evynaZF+OdsmiraBszgjNj6hgX4XcROF8T2Q9yrv3ds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GcpyKTRExXUD57W/csLHMlk4AGhEijnP+27w4WQJR7tz2emsnDW5BV+zMOwsvoVMG
	 mvIQ7lUYTtp76Og/PumJYFICR8zqoYHM5jVmPyzHNgNy4+ENGmyCjqEo7EX6kTXSjM
	 kRw9ouHmguxOYzWxgp+d04Bl3SYx/DzVzLVEuEFZ/eqlb1WUI4A92/RQ9gJaT9i7G2
	 c7dEbSNmH0ro51Bdr5OBLxhRD/i54tRDkoKJ5LyhrfprgU5XJDlB0RXLO5PdybzyxH
	 bi09YQ7OEMJzdvHUBTCqL31ozDMuqepV6l2Dv4w0m7sPJcjSEN3ZRtknPf5m1xvDcz
	 I/Ch3QIDTpgog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08C2EC433A2;
	Wed, 15 May 2024 17:20:13 +0000 (UTC)
Subject: Re: [git pull] drm for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-15
X-PR-Tracked-Commit-Id: 275654c02f0ba09d409c36d71dc238e470741e30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db5d28c0bfe566908719bec8e25443aabecbb802
Message-Id: <171579361303.17791.11513989633899043227.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 17:20:13 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 16:20:56 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db5d28c0bfe566908719bec8e25443aabecbb802

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

