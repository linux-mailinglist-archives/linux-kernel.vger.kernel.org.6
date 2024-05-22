Return-Path: <linux-kernel+bounces-186675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F388CC764
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B22283F24
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C41146D67;
	Wed, 22 May 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNdgG/MV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF5146A8F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406697; cv=none; b=B+4nShsxQEqnjNDGisRCK8Km34hap92wVhGe4YJTVG/40DZCPLYICu7Vk/luktjVwY6Vtng/LnL+K52Fi/MDgc/5xNf7/yNfoJGI33sDAdfvH7Qg1jXBs0Hd44Ynvtuf6g/i8INi7Wg7IvwbMeHesu8W60ZpGU8577E5+gtSWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406697; c=relaxed/simple;
	bh=aKDwZ0aIouo4erSKmc5l/JecG66y/g9Lmq1qWOPimRI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=deCt6cFsJUh0LYZyHkO6gFPDChDplgxku2U77gXLbrrsg+nsILlPCr/A20iv8ZnXUac+KH3/SZLhYRtD+X1AT5nfYSfYH0HDLAitmFSg6U3dRh5MgK5NVGTdMeIq0b74TLNiA9+qdBEhbF911PIWd1JHlAGmvIUmzcxxATKazs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNdgG/MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9902EC32781;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716406697;
	bh=aKDwZ0aIouo4erSKmc5l/JecG66y/g9Lmq1qWOPimRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DNdgG/MVcvePnbRniXz6VFZoYlSgEym6CxEkJIWk3QXvyVm6hVOJSmUj/CMTCPwcs
	 B826mHqTUzZl6aLx/4DgngdPn1XanBrHR++O0V6RtrV3HcyGtulTtHWH7shYjYhwnI
	 SuMW2YECcMPSdhpaMCemgKkg7DpP9MiItmu+CfuUaDqpAPtB9f+AZrAQ8HCH74Xr/U
	 bPag28p0HLy0Q9z2ZjxfWUPmUTbNfJwQsAhHcD6kLqKISgGeQp3uUXSIO5fHlLBSgz
	 hgcZcklmCrnNM68XbC73V7SihnaG63CEpVD6jSVD5IqIlg0yyOe4/yJT1KfD5jBdn0
	 VwxJoR4ePjmgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92307C43619;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk4GVrHOXfnw5kl_@kroah.com>
References: <Zk4GVrHOXfnw5kl_@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk4GVrHOXfnw5kl_@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc1
X-PR-Tracked-Commit-Id: 880a746fa3ea5916a012fa320fdfbcd3f331bea3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d90be6e4aaf23cd4a2c202891399cbafe669aaab
Message-Id: <171640669759.20241.6726774917239231801.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 19:38:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 16:51:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d90be6e4aaf23cd4a2c202891399cbafe669aaab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

