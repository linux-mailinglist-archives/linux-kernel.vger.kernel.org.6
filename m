Return-Path: <linux-kernel+bounces-291140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A471955DDD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0141F213F1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76A146000;
	Sun, 18 Aug 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Peoq4uvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA04748F;
	Sun, 18 Aug 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001806; cv=none; b=h3o6nsyrJmJ2AuUeq0rFdASg0E6OTdFAsIz4f3HHp2TiinkQOHomqITY7TDF2WiAxkyk0L8ykg1XMIm9AQDOPfdYLrixU05BEJf8rzKDulGUrRY8Q0nuWRDtaJXd3ifdHdjCYxmPk3sSUCm/8ItJt7sCWJJX8ZlHA35F6qg5pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001806; c=relaxed/simple;
	bh=EaU9ZIq9S1SYp+5jalBKb03YJIqr7nzt9Yfnawu0/wY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t4PIn2H1w5SwNOYIaEcBJcggeLRB+dCUiINA7FBhM/nalLnhtUGxP48EE+gKa+6PHTlYQwoPVhNQB4i7KhmYk9oJQKcnywzWlSbqNY7LF8Ksn2CGpwUMFmw9Cw8pu2R3CRoKDgJzO+vUYOJAPFk+OZTwv1u+4JyuIl6MuEVF3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Peoq4uvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3176C32786;
	Sun, 18 Aug 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001805;
	bh=EaU9ZIq9S1SYp+5jalBKb03YJIqr7nzt9Yfnawu0/wY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Peoq4uvtOWyYeXSTzD1nvFf1WvS8+pP7LAbZ7pyuaLRQNEpdcwdBbWs/CHOMaAxI8
	 /au3jrLSJT7qxqDwwPq+j+I6yCkXcG9kGyKaq9bDyPH2SK1kBRGeiRbLkZDL5vIaqc
	 vwV9tmPvJLJjDXCA35M2oZcBu8nBBJovbstcAcamqnH9OyUQGRwaqjFpjiAXfwA5eu
	 p8scGUpnXsjY2pK8UWdHkkhq0mbyxpkAem/caZSnlpKPc4ubYLO+rAI2cdTDrFv12f
	 TPuwiGoL+iQ4K2ry4enU/uUPT3bbIfrCp+4GINKGoS8zr0LGLFUcwzCdYzuvKMdV0O
	 Xl+dQbG1xUERA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD738231F8;
	Sun, 18 Aug 2024 17:23:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsIVd2smm0EX27rL@kroah.com>
References: <ZsIVd2smm0EX27rL@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsIVd2smm0EX27rL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc4
X-PR-Tracked-Commit-Id: af8e119f52e9c13e556be9e03f27957554a84656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d9061d22bef282dfd993f9481a1f0cb755bd7f6
Message-Id: <172400180502.3949564.4798834681059342898.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 17:23:25 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 17:38:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d9061d22bef282dfd993f9481a1f0cb755bd7f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

