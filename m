Return-Path: <linux-kernel+bounces-515683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0BA367A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6109A1896766
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610161D7E47;
	Fri, 14 Feb 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7uns2QL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47717E;
	Fri, 14 Feb 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569188; cv=none; b=G5dnKp/p+pP4gIu/9uIi+RPQqi2CLJPwPPbpceodTnlsdOHtDgLyvyEA09Laj9FHer/5w0MVRUeg6metXJhmOaGX5X9nmOD3S508Dt05EBFCcg8eV+uWR5xq6S+ATLgAWhV3S5Fq5rn/zGwn/UClSHoiYQT+2p1+aUpLElY0QGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569188; c=relaxed/simple;
	bh=VzkB9qap+1n17Gpo5YQ5v9RQPiib6OD1lTvBAlIEUKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ikfNCYYhGL+F4yoy5DExhgomSFzJ+LbSBhYidkn2dEJyeSdCdjFlDnJFD6XVMhBg1hIgwA24VE5i1/d3y8jCO7f7PNX8WhNAdvqfv0O1xR7193WJ38xkwSR+sJFK38kdNPYG1rrUCoeDnYUY6guhx1FBKJduvL9uvuXLNIkOtyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7uns2QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3CC4CED1;
	Fri, 14 Feb 2025 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569188;
	bh=VzkB9qap+1n17Gpo5YQ5v9RQPiib6OD1lTvBAlIEUKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K7uns2QLllvT+SY8fJ/YHqgLpmMMliDpeMvq1PyBU2C4Lg7hmOWSpwILm1wYhkKIP
	 pyUFWF/xAeq47gpFoXOlXXcsqRzRYonOGMr5Q+AsqWfwhnwh8hsTVhsehbr74fRgJL
	 Qqenu+JXfnbTW27IrzXUlWiKzFNBcSUlXLsarZOlcqtQAP2X9OL//ayJSxaPIO/mZ4
	 /jlN8xOBUfbrTknRlOU0DPNCFRAR7k1yx0in2h8+isWl0kFsVLiQtlCSSJGC+8P8Z2
	 COjb22GUElm71R5D/Zel4CQ25zoGyFzQhOxRBmbF2dPIZHVuGraSMuTOFbpx6kGhlv
	 +Im7xwQ/tzAHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2E4F380CEE8;
	Fri, 14 Feb 2025 21:40:18 +0000 (UTC)
Subject: Re: Re: [PULL] alpha.git
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd> <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git refs/heads/master
X-PR-Tracked-Commit-Id: a80099a152d0719e2d8d750e07f4ffa991553d30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/for-next
X-PR-Merge-Commit-Id: 3447d220155bd9f4b5435ea6e9d58b536c7e94dd
Message-Id: <173956921724.2112695.11506562234571397782.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 21:40:17 +0000
To: Matt Turner <mattst88@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 16:36:43 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3447d220155bd9f4b5435ea6e9d58b536c7e94dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

