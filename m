Return-Path: <linux-kernel+bounces-328744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9197882D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2154B2515E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540AC145A19;
	Fri, 13 Sep 2024 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HByWxDx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8731448E4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253477; cv=none; b=K9N+7EcJl+dQT8+g7kJOsXz9ANTjYj43+wnNbdY4iOqe2KXF438hedTcYJ95hZzqtb41mo3LrMfIr6ujDIaupY0+zKM5GZr080+BX0Qhwyh4Bo107WjyticwSb2nKKfPXVE3xrFSCjTzMEs9PLH0BnQyALhAZ020uzmFLHokKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253477; c=relaxed/simple;
	bh=eGyNf1ejbPCdMX0JaBesX9i4cIVe52DncS21m1/DSmg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZQ3gxMZ7U/vJEdNfvSlfMu7hMYVHvSnn7CYUvyPchYhnJJpbXFeWUaRJyYYlkSRsI0Zr3ncO3XobrpZzQR4WTjz7BvH5D84hodlaUVoBhZz15FYE9/6HsRnraRc+D5Fa0A1Q/ZKqhv68eVc8NH3EUsNTUvIo48zQRwCJmME8CIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HByWxDx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF97C4CEC7;
	Fri, 13 Sep 2024 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726253477;
	bh=eGyNf1ejbPCdMX0JaBesX9i4cIVe52DncS21m1/DSmg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HByWxDx61NymPrAAtxKx/0NV+qDO/wvGwH+8xomRZNLiKkPzPSrw+9Ox1BeNYhGgG
	 2DULeslsivV6nVj3r6gNhBVxPeICeb5ONsdJYthbzuOpPYiXnat+DfTJVReOZFte0L
	 srzDtLq6n5mlZ5Ei+gpGDh44y0Q8cJqlmIZtIbTOZS4/+QVTA3TC0nCVBsKCczyM6e
	 pPqs6n9wSy0xAatS7LoUhrheRRA3NO59Sjqm9CZ0Zn4tUSLurqkk4av84LOTDBwO0q
	 mMwxSK1Waja1yRNdZafSdPzyi5AfoUZxCuEKkHUpt2MXANPdk7JPCeLoLEfsYnzquV
	 z7x3IuodLDhZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA03806656;
	Fri, 13 Sep 2024 18:51:19 +0000 (UTC)
Subject: Re: [GIT PULL]: Late fixes for soundwire subsystem for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuQlvMewKJWzVVgP@vaman>
References: <ZuQlvMewKJWzVVgP@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuQlvMewKJWzVVgP@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-fixes_2
X-PR-Tracked-Commit-Id: 233a95fd574fde1c375c486540a90304a2d2d49f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1136ced48b6842065064ff28d2955cdf01cece8b
Message-Id: <172625347825.2331887.2272953230991764186.pr-tracker-bot@kernel.org>
Date: Fri, 13 Sep 2024 18:51:18 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 17:15:00 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-fixes_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1136ced48b6842065064ff28d2955cdf01cece8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

