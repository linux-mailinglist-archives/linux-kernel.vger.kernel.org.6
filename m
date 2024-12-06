Return-Path: <linux-kernel+bounces-435713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2A9E7B52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F5281DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA5213E72;
	Fri,  6 Dec 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6kqNKpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820322C6C0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522468; cv=none; b=KLzWb2nMwMWPVzP8ZInWNWYCho+BZqVa0BqmvoipePoqBma1sd9WAp8yNxdzlh2VITNIv1BHJncR461/+IJDVHlN2VYyN0m12tGSWkGfsV172t48ewR6cM5jb48CaTBSofhdKF6NC3oqxePfmhJp5Yky/4Rt1XLDQDDxYP7fzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522468; c=relaxed/simple;
	bh=pcLPAQj/DtyCaHX5p5S8WhAi0TPgRLQVGXMw7FFRQpg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ivsg5U2N+VC0k7efDGrAp6g6ITEyGqVCkq0bRiiy5pQ68/pCsvFRa/2GndDbaqRTqztmQsvbkq9StG4dh8S1QDyupoJAT9Pe53ZsEuKSr105m7VE1hL6GgLiq2CB5JekDvouJBXiYJK40ky54ke5SGfsbEBThCwl/XnYanwhS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6kqNKpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99CBC4CED1;
	Fri,  6 Dec 2024 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733522468;
	bh=pcLPAQj/DtyCaHX5p5S8WhAi0TPgRLQVGXMw7FFRQpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m6kqNKpt8hyd79KdOBx+VyJJaj4YQvXleBr36T7ONsBHlkU5UD/qydY0YzX62vn3D
	 McS2UGKKTKPta4muVHS1ZMfftXdWcT8cWRCpNGwPvdq53B30JRhqh2uNolkJh9q6/U
	 FBHxgiBINXjbtS1rh9VGYenZv3Ra4yjHdGO3d3YEFB3u84o0u2Zg/ySTGS98nJUYSu
	 RZ1EZnw4ctU+jpvwue+iavpe2C1JK01jaVsiRdEv9OCRQcEgccGanqD/4Dr8sddLZc
	 ebBZ1pV1fXakW7FYrVFvITHQ3+GX0t4f6e3u50Wg1T7f84L0bfZy43vewX6Iyv3q90
	 xbN/hEpk3rqXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB165380A95C;
	Fri,  6 Dec 2024 22:01:24 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: restore check for node validity in arch_numa
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z1LRTHMT2as5VhEU@kernel.org>
References: <Z1LRTHMT2as5VhEU@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z1LRTHMT2as5VhEU@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-12-06
X-PR-Tracked-Commit-Id: 180bbad698641873120a48857bb3b9f3166bf684
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddfc146ed500f9aa071f3d913312bdbb0c9eaae0
Message-Id: <173352248364.2810195.13571857277787435260.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 22:01:23 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Dec 2024 12:26:20 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddfc146ed500f9aa071f3d913312bdbb0c9eaae0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

