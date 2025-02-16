Return-Path: <linux-kernel+bounces-516444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7CA37197
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC67A3F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC244D26D;
	Sun, 16 Feb 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXnMh5bL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23217BE46
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739669456; cv=none; b=STdtn+HqGzwNn0GjkHG8fQqbRxGmtcpC0dOj8xNvnzqMt6iIl/6mZiRn/2fxg1ZRpvTLBhk55tkUIzCfcwuflskCRusRPMSH9LgAwZofHaue3AP/Hy/GqhVSUX+6dM/FrOZd/nC3GzJMhNrbe5u3B5Q8wzN+O8dnQF+PnEjAiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739669456; c=relaxed/simple;
	bh=3YetL3Lv/olz+1YE4egUUtPuEGACFO8MJgaedyA2Ulw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jkHWBgexpabfRfGq+xqkeJf56dkac7mF+rs/L9ch0gIipou5YjiAZE0WKrqwkV6DksreZvZkcNUy+cblXUrM2/+0dWeB/FZr9eLqHznZoh734H+cvNK0pd0KghHYPQ3+AwzNGJw+Gqde5QNMp9Iym6eF+/t2P7k24ZZVdWW25z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXnMh5bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E0C4CEE7;
	Sun, 16 Feb 2025 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739669456;
	bh=3YetL3Lv/olz+1YE4egUUtPuEGACFO8MJgaedyA2Ulw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rXnMh5bLZTlwGnY41OxSogb+Ogrv2YcN2bu8rRIcRS1PBIBMTx1WfgeRudDhokGYM
	 iuncG6Mo1UeaufuoCYgQUIrORpBYtzYsdEPjzGxaOM1wUE8ZxwCzUcbhmricuzz2Le
	 uSulO4WVbz3C+V0VyNtr9i+h2oPTiIA+vK0Tpn39/0/KaUHDJno7aSCKiNjfdu6Jvo
	 ORgT/sUjLpv6yBTSGgvtHTsBa7t0bMj3Z9lGFdnEhJsHUU8eENZtfKVInX4tL/v8kM
	 99k6CXlfQaqgLoXFXEfABTZGpzFpkyJPciKd8frw5hLCOpQnSyONnUQhgck8dL49UW
	 /KVaPWjR6yUlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10D380AA7E;
	Sun, 16 Feb 2025 01:31:26 +0000 (UTC)
Subject: Re: [GIT PULL] UML fixes for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
References: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3
X-PR-Tracked-Commit-Id: 96178631c3f53398044ed437010f7632ad764bf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad73b9a17d66366d8c9198bc90f1ea99f24a912c
Message-Id: <173966948559.2369003.2899535406284130331.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 01:31:25 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Feb 2025 23:21:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad73b9a17d66366d8c9198bc90f1ea99f24a912c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

