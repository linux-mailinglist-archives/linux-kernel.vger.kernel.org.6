Return-Path: <linux-kernel+bounces-264873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5B93E981
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B78280E69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B98762EF;
	Sun, 28 Jul 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2rwlrG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C45F876
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200536; cv=none; b=YWfsy1fNpjnpXzIwk9zTV9CUd2//0IzcW+Of9kIx4AyYbc33eEKv3BytvVoXq5zfBgu5q9J7pz9so8OedHJPaRf/v2osRBVtbo4GxRChpRxdh6+zMdhDILo45tZ+TATsCa7LN1jL3mg7h4wBrX2ejJB2t1yxXXwAg5OqmpdCSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200536; c=relaxed/simple;
	bh=oj4MkOG/whLmSwmUrInW8/6lkUfxTEUE5reoXr1APFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ef+5ky9huTHLw5UzagEpHxEiCI8mvadm9r+kLNz/dRsm+PMTzVjQt3xhA590ZATqjfQIwXqL0xRydL31bXoiLQq8uzcKE55+lsdgTlo2ewFmMplFu/NzT2L9kFhpnwvvDFfdM7HIEUwnvyK9rFKlZZhVrSCZt8WDqEIeJmtkev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2rwlrG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3BEC4AF09;
	Sun, 28 Jul 2024 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722200536;
	bh=oj4MkOG/whLmSwmUrInW8/6lkUfxTEUE5reoXr1APFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f2rwlrG1CbAAl65MJN/KNNQfZjooN7eB48avCrHbc9xqhe4NgjmB1o3O/oHjRgIPm
	 JOgGYcztF1gy6iT2fiJdv1+aX4cNa8BnXXgTTaeYr7Q3vvQOZYybi/xxoV2xsgRG0O
	 NvBFOe8i5lLUBTjUGcCfK/TvNAz414/zISlXq4mGReKUyzFdQ/CZx1rO18NbJQb9PN
	 Dv5zus+UrdgEkGkQwCDrq9UF13XoenmZJX7lnlK6uqPGMnAwYKBmCQq/Eha2ReZdwN
	 NSwzNNqXBmiyHyJGSw3p0CrnFp1lK70aZcL6c2vxtTgxVodcRCG6+UW0169OcncSJW
	 8wDWTPwTS7TPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21BECC4332C;
	Sun, 28 Jul 2024 21:02:16 +0000 (UTC)
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.11-rc1, take 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <589372570.132198.1722191188516.JavaMail.zimbra@nod.at>
References: <589372570.132198.1722191188516.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <589372570.132198.1722191188516.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1-take2
X-PR-Tracked-Commit-Id: 92a286e90203ce3e6c3a6d945fa36da419c3671f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e2d0ba732ad649c557b49b0a3ef69d54df256d0
Message-Id: <172220053612.30183.15430153093934775027.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 21:02:16 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jul 2024 20:26:28 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1-take2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e2d0ba732ad649c557b49b0a3ef69d54df256d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

