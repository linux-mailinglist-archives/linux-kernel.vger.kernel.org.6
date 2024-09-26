Return-Path: <linux-kernel+bounces-340824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72375987844
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9971C22E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4BA15D5C5;
	Thu, 26 Sep 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZoAHgvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2C15C13E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371553; cv=none; b=QCyKKNRHWvHtLWpAVzeG6z2om3svXfRIXAz6YHPgjgy6RzKG2xkDdF8rkLWXI3hyce1n82SNAOWN5xeMNnSD4gTDoCnK8LJGN9aJWQNphojUUp2HhFVzAVuIvB0M9azK9wETAa0fTfZLTyBXAtENk4NjyZtMBj5xDHlwc9v8H2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371553; c=relaxed/simple;
	bh=xLvGes+1LSoH4VNlpV3D8JVWBJJJ8DIEwfoGtJ/jPHA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ud1NmDEWhg2rKtvHvxWerteduzyx02lvUzcemVaLO9JEtVzH2xvpN1siRuRtSSaiUu7UQjy8jAzd0JmZ8/oAZcMjji3+fqGbsNA/86T/b3rZ6MgSRT1HZ50GUX8gc80LWlBC6EbK1/Sh3KcvC/mzfpoITKWBneQyV+3yWWW7VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZoAHgvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6842DC4CECE;
	Thu, 26 Sep 2024 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371553;
	bh=xLvGes+1LSoH4VNlpV3D8JVWBJJJ8DIEwfoGtJ/jPHA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NZoAHgvTn0R9/Rqo5bJC4qoaw6RjxlR9cPPqfDgiRyqntjw7QFKGoul/hnnSb8CrG
	 07Fjo6BHOJmL+PpepUFaZ6sG6ytFa4M7BfNqCZsI7WnkPqNio0/MGZHKGikg5hOqWv
	 cCFH9w7dPYgJuIkKw6tNiqUsgcRVuu1PHQQ+hGFHJb7v6q3dFRcxPCqZwSsFEUp+Q9
	 sKA65Jdmz689GP1MAHBpXebij4Hwl4X2oOgW9wz2D5Ri8fYJ+UZrk1+ery3asJBeTK
	 y8+nTAPSEFWDsLkGOO/1+U+M8WY9wKwQrx2OoMeIsHpVymW7LzmsYRIi3zgyjVe4Pq
	 1PV/UzfFs28og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E113809A8F;
	Thu, 26 Sep 2024 17:25:57 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvU2LBnU8jwgOY00@kroah.com>
References: <ZvU2LBnU8jwgOY00@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvU2LBnU8jwgOY00@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc1
X-PR-Tracked-Commit-Id: 0cf7befa3ea2e7284d8ba5b8f45a546865b09edb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e5466433d266046790c0af40a15af0a6be139a1
Message-Id: <172737155570.1334950.3630412241191831637.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 17:25:55 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 12:23:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e5466433d266046790c0af40a15af0a6be139a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

