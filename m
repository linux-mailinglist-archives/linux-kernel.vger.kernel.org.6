Return-Path: <linux-kernel+bounces-553327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF76A58781
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFF2165CA5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B93215172;
	Sun,  9 Mar 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKz8hGbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A643215072
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741547901; cv=none; b=OeVi4MnF4wY35G7j3y+7LUKjmVy7KpMpPeL8ibVr70jVwvTC6kyhBxQBqiHq/4PNWNyb7+o94kOhgLqs4OtZkANvpy4EUlfPgBFLUj6y+YBZUJDt4juGW/XY9vBUthkjniNr23WsKEwsPMeuNG5hqWqGmdhdVkFEBrYCCfhF89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741547901; c=relaxed/simple;
	bh=2hPv3vlNEQn11AiTXBgcER7Duix/I0n2ktmNifGIyYU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qyNeDQItH5LWpzrs9/+WotZYU46U3FyRqfbtGVXTA6JCD9kwpxs9ZhRxLc5qo6JXjIdJ63/l1OCojyXg/pa7fP53xdarOc6DS7FWaXPOqOi7yNJwoxrfy16TKhL73lSiUfWn76TANiFyNrQAaxNLJ9A07aF2haUJ58FJNV5Ed9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKz8hGbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F386C4CEEB;
	Sun,  9 Mar 2025 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741547899;
	bh=2hPv3vlNEQn11AiTXBgcER7Duix/I0n2ktmNifGIyYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cKz8hGbgKjbusJhsI0UVgJQXpOf5SY/dYDqH9a9UR1PjuTdX79sLDG5/PRwHAsbPS
	 v+IMVKiOQxli2mEywFnOgHDmc3z8NiCHm6idmMQtH26fExtFyaKoxfrNQhbb1rcVy8
	 4eVvyBR5dz2GTzh2BFVyNtblsPA3b8WU2VAEMB2cqahB3QqUZEj+O/M0L52WEF8GTf
	 xYZEjHnTEVeFb90l6Vxr24HzzEkX3SUYlUpZvzAFUraIezfD3JhnDS5G2bGm3H3bx1
	 ejW8zm2meS5Tcnrr9vOMPIWWCaWUF3sd1F7nVrVPDaBxZCUqCEU3S5KNnzstg66604
	 9fGMKAzZw012g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD41380DBC0;
	Sun,  9 Mar 2025 19:18:54 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z83TJkyOpMOryy2o@kroah.com>
References: <Z83TJkyOpMOryy2o@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z83TJkyOpMOryy2o@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc6
X-PR-Tracked-Commit-Id: 78eb41f518f414378643ab022241df2a9dcd008b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51b38f3c5fe23deb24e6e9bf98a105095c1fd147
Message-Id: <174154793313.2953179.7899848599719599674.pr-tracker-bot@kernel.org>
Date: Sun, 09 Mar 2025 19:18:53 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Mar 2025 18:43:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51b38f3c5fe23deb24e6e9bf98a105095c1fd147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

