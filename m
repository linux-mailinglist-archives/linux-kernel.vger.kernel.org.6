Return-Path: <linux-kernel+bounces-337485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E20984AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80247B242B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF31AC43D;
	Tue, 24 Sep 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxm43OZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA601AD419;
	Tue, 24 Sep 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201048; cv=none; b=fHonjb61+Gjci3kSu+h96qLKgqsBX7bwkIWVJzPD6REMv9iKXTA2SMVS+onHNBGQ+lTukoN6YJ8rPlEYwrDXlhxjLRkmAJw9PnxMwwed9mGEpk54XidnRYY00iQVCHnkBPHDoUedqirrhAq6l3At6CdeWZHYAUtx3sjhbRANouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201048; c=relaxed/simple;
	bh=md4Q1YC8JN2kS7T8FzUnJ2LFDZEJMiHbqPIU6eg6CaA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N6YCOymizts+Y4/AdAdnylwRjxAdPQlCnnom6vw0Xwv1FdAUHt+UO/wp9/7kniPqOGrXu1RonZivQvBsqNtAucjqEnkx563hbLlTzWe6vweq+nEWyWyooYeD/MEBBNx83gEBS7nAwVh99s2HCMOEjdsg66IpY0JErkRVknSQHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxm43OZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C46C4CECF;
	Tue, 24 Sep 2024 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201048;
	bh=md4Q1YC8JN2kS7T8FzUnJ2LFDZEJMiHbqPIU6eg6CaA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xxm43OZGzeMUB6mZ8fuy9R0ADrC1CRR4+xP4Ml4X/xI8SN5qmZS0EDuE0lDc2pLV9
	 ueebEitRzBiMJLotZgJ9QedqQcfnUpt88TUWgPNjeVq68cqrPcTgPCHXFoMEcXuiZN
	 asr0MrJlQUN+b3w9PV2tAYY/GyPvj5w6DmWgj6PQtjkKGRd+JMyzF4fHfP1/bf26e4
	 nOCW1ZipQxSFPicL5YSwz5L518FTl9vaYKgrk0R+TEnWNBL8TLCbGdW5P3+49105FH
	 DVs3ufFhZqVvQ5EUM6Qm1p3pJQ4Hx5F6coYbZjScV0EWJUAtKa7Ugc/ECyBJ1AHQSP
	 qWm/YrZJXR72Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBD3806656;
	Tue, 24 Sep 2024 18:04:11 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <f9dfef64-a4fe-406c-9daf-1bf46cd23d65@linux-m68k.org>
References: <f9dfef64-a4fe-406c-9daf-1bf46cd23d65@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f9dfef64-a4fe-406c-9daf-1bf46cd23d65@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.12
X-PR-Tracked-Commit-Id: aa99969ef591ca44cbafb320ceceb106792baee3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7108fff8848bc3bd958789f4db6beff94bdae521
Message-Id: <172720105069.4145686.16699549352438342361.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:04:10 +0000
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: torvalds@linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 14:44:18 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7108fff8848bc3bd958789f4db6beff94bdae521

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

