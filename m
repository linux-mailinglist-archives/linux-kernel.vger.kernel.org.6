Return-Path: <linux-kernel+bounces-283373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0BB94F1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00501C22143
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA418454C;
	Mon, 12 Aug 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsNctblT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463B183CD9;
	Mon, 12 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476465; cv=none; b=QdOOSoWclCREUB12PFy8OCXxAacxQQ2bHhGbVXjUCbrB4wfKW+5pJusqfjc7EllZfOfmn7fYY8jrt/A5OxEcNqkqq374zgF99XF+iwROBa9IqjCpStDRLs6c1rIKPcJmiOdym5nxb0zMqQ+/tYvKuflDsKimaXC9P3Bf7Nwq6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476465; c=relaxed/simple;
	bh=V1D6R0+dZB7uDKkvnvszvptKad54FHrXXOuUdXqew0U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HO9vDcfpCWDdXZGeRnEUyrAEUnDGidczTvj1AK4acAn8ZNaxljEMZbpy0EyjZK/KsOlI6HDPgA940r1YiayfN7V8AriZ882tujQmpwecrFhEbpQCuWsQUemUB4/e3Ga66U3T2TylThTh7nDH89cyVFs6Cpqu7UfIJ808P1kmz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsNctblT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF87C32782;
	Mon, 12 Aug 2024 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476464;
	bh=V1D6R0+dZB7uDKkvnvszvptKad54FHrXXOuUdXqew0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UsNctblTEuB/wgPRzTqZs2bdhAyh3vhJMjtkhMm+70zYc1MYjW1cZRpyQdoXFujNs
	 P07BGtTMH6osys6z39GrZoZV1Xs1PtS6KTj+SSR3eZ+BDYW9AzI/cOVc0kJrCp0UDs
	 pQHWFe5gXqeeCxY6ya23iospefqgAXhUeevnKoe6BvY0OvGO3rA5sTJmE67hagWeo0
	 SkAGRMHKDs+VO05lZg7xUuD11XPhNJkoBdb+xj2xmocnxF9pwyooRFswKBFm9uIzkS
	 yugPeHUZuHRk3vlOWM/NsJ/tKOf4q/4z1rfuiLjcSwJwyy7tWOodY4CQ719WPU2h3p
	 UVJNsSkapDd8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8C382332D;
	Mon, 12 Aug 2024 15:27:44 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240812110914-2175928819@linux.intel.com>
References: <pdx86-pr-20240812110914-2175928819@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240812110914-2175928819@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-3
X-PR-Tracked-Commit-Id: 7cc06e729460a209b84d3db4db56c9f85f048cc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d74da846046aeec9333e802f5918bd3261fb5509
Message-Id: <172347646331.1056983.12159166289553375196.pr-tracker-bot@kernel.org>
Date: Mon, 12 Aug 2024 15:27:43 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Aug 2024 11:09:14 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d74da846046aeec9333e802f5918bd3261fb5509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

