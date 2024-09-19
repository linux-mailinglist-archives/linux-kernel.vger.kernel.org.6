Return-Path: <linux-kernel+bounces-333219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957497C581
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461E11F24020
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCED199929;
	Thu, 19 Sep 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sonc8PrY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67E19AD78
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732819; cv=none; b=tzYi6g/q3pMdczl6zUCRhuFUpDJ/hAYwQHRTUM8Aw2ZrBAmxXosfXBFs3CF+EqndQxIO8NKYhtYcTA+28cYktKHYrvGtbkOOXvfoOqZqtDX14Lz+fZTuxPhgXOosqPc+rpQXyUs6ZWv2kBf8Glj5Es9JFmDu5sbP4EYHEb/6GJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732819; c=relaxed/simple;
	bh=M5nq6DLXvVlby3WtMINJmP4F8ZqVXXjcCmz0VScL6II=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qf8gXhJcBA7x9+wzH/TghcpGaH5EeXGLxRLkFrySG5O29YKhiFqYJsD/eiUJLUNy2PGpgNjVHbJwDQwlewRWWfyqubzpFUPc5W+n20M1C03J6qGGWsg3ZdytCc85zsNTPrDaJJULdoFrJUXbFIT/1ZwxMZDXFb/IF6APmncGo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sonc8PrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532A1C4CED4;
	Thu, 19 Sep 2024 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732819;
	bh=M5nq6DLXvVlby3WtMINJmP4F8ZqVXXjcCmz0VScL6II=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sonc8PrY82DSplraPjWFy+IfH83PfzgaxuoTvJYfy2FSh+N9U7o6n8+bmqKDPcEHY
	 evmaIfoP+NujMew+dTgq/OLKZUdSB/FNi452R72tHA+Is6pDwCjTqU7C37AwZorz3O
	 x0NDsrTFzy7cZhZAw+uD/RMYtG+ATFrhK4rZWkNrsrOBQC7cvQ9ipH79xfZi/bBCac
	 q6mffFLz2RdHxZY0P2ul5sXBgjGdQVHfs/xHhVCtTFzez74qB9muu2oWYDatbgSCbG
	 AwVKC8WGnMvQX/p2ILi/Mw1+Rn2BDmwKNw0MCQLJkLq12S+yXpoACXCP2SJRr80mR2
	 raK7yywPtJjKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6BB293809A81;
	Thu, 19 Sep 2024 08:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.12-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <dede57b5-3ef2-4451-a496-537f3c05a1d6@redhat.com>
References: <dede57b5-3ef2-4451-a496-537f3c05a1d6@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dede57b5-3ef2-4451-a496-537f3c05a1d6@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-1
X-PR-Tracked-Commit-Id: 837acb691c844d0525f4ac86f2a2ce55a9706908
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84bbfe6b6435658132df2880258d34babe46d3e0
Message-Id: <172673282095.1388805.16177148451681953785.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 08:00:20 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 16:19:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84bbfe6b6435658132df2880258d34babe46d3e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

