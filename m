Return-Path: <linux-kernel+bounces-331548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403597AE30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C128847F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92D174EDF;
	Tue, 17 Sep 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAnA4k52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FC176248
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566485; cv=none; b=XJ0YLT72KlH8iTpjJplzMkzLfV7taSeAc/wmlDbi+kmOe1G82PT1p0xZtUZCYXnV0PtLLMyfn50bfp/aHVtSPrFIUuogO3xiBXtaAx2Tv2Dkq4pMjLIbIHHe/41MrYP3OlPeeK7b0ugUrTDQcazNWdTB1NS730nG/DR7MsKN1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566485; c=relaxed/simple;
	bh=in0240nTWtpue0E5W9ePuFa+MTZ7JrJvOvZGw3gdGU4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UZAjf4x8u5r9UStuqa3BOL9F/3vkjV+hA5uhQPcadPCSA1wZUZ+ynNQiqjwJYYKQCwShMgwlt0S2qxLMZblw2+dvqWRAH/QILzu63HTM5kyyYdQvPj1GbuCL9IW2/V+wI8cMrqnYnwmUbHEJsg+46meJzsxcLoTio4NsTReenco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAnA4k52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B70C4CEC6;
	Tue, 17 Sep 2024 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726566484;
	bh=in0240nTWtpue0E5W9ePuFa+MTZ7JrJvOvZGw3gdGU4=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=dAnA4k528xoZo59QqQXvF4CXWid+dw3WuYXDi6tH8mwguTc0Iz0TbxjSrPJRzrt3f
	 VOEmSRZmr8SO7z7iAhAO0EHWx6zPAzwBbpeKUkG0IBWyhb00wtdB051DOZzeDhmiPD
	 4xns9R4SIg/484Gmf1ka7UNX54JZTdDJLRMe5O5cV5To5I3Ze2ZootPa7c7Zhs+jqh
	 S370+ZfVN/NiM8O/JfqnuiggjPTSnptGdvwVoRsfBg5yXZ/gF7PIuGJiToxNANNBFK
	 9KSXoNT+r1TguQiydJH4zQ2VLacEkKcuvybJdIVpTsmgDGgxv85ZXzO1Z6uuydG3Qa
	 4Pcc6Lc8yokqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2323809A80;
	Tue, 17 Sep 2024 09:48:07 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] soc: devicetree updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com> <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.12
X-PR-Tracked-Commit-Id: 168c3e0d443599dd370710243fbf5c815fad7890
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b17f5ebd5fc5e9275eaa5af3d0771f2a7b01bbf
Message-Id: <172656648638.78027.25795316916626812.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 09:48:06 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 16:31:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b17f5ebd5fc5e9275eaa5af3d0771f2a7b01bbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

