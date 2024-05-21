Return-Path: <linux-kernel+bounces-185312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331698CB35B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AD3282BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B8148858;
	Tue, 21 May 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtUMi28A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4B14884B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315226; cv=none; b=AnPsA4pFECQjOnVbgB2V2M2xueiOHO/XWscK2tHO9OuAXzycElYbNeoWoBfz4ojY+bqG4gbt/BkPK8t8uESBQ9s+waSYvbn5mhqoUAwPs1xaG2cfvyzhqe1fZP8A3T97qEmfByxD30mVpIQ4raELVOzoDIFC1XcWOLRQJDsxSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315226; c=relaxed/simple;
	bh=23Z0a90iCACesgd/jgpjKZIrYYGhx1jRiBTRv1gzeq4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g3ke0PiysAEWvLOmairxrIgbwgFq4inEESbxyvNjA5OhjF3j7dYo7FGaiCtnXbURf2CQtzHB2XSDMqSkqfjlPZJGKuidc04gtuySoM+YdIek0kwalRIXB9b6RAwu3PEt3PxngrjsTapQB259zAezdqf/0PyGWfTwawhyln/xZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtUMi28A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35297C32789;
	Tue, 21 May 2024 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315226;
	bh=23Z0a90iCACesgd/jgpjKZIrYYGhx1jRiBTRv1gzeq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jtUMi28AFna9/T0w9XMQANKVU8Hk/AfjSy15iOkpPnonIbHmDrsv9y5mklaDamO95
	 Wc6ifYSvGktktdjRzZtJpGY5yinmAIweAa0uZP/re1itHlvndUMbi9sSinvcT+oMxt
	 TV+L6tcnm5pGPQs3nCrpGc7l7B2OncFOX/0JqH3vDtii2EYVhgC1T3pQf0mK4bVcQo
	 YYcPGBztIEO23iKgTkfl/P+MlGfTRaUT51fsqr3rOgojDDjeVK/Yh6VWLCEAoAFn0F
	 LsP6UWLqZzd+dFt/vIjQASIHDCds3VaU54ATUhTf/2ej71Ml+h9UbqslpvMUvHrY0p
	 yCpouiHpvmIQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D3E0C4936D;
	Tue, 21 May 2024 18:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2nxEXZkRt_Myyqh_e0CTkVemPwLUBaqt7AWvRB+94pfw@mail.gmail.com>
References: <CABb+yY2nxEXZkRt_Myyqh_e0CTkVemPwLUBaqt7AWvRB+94pfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY2nxEXZkRt_Myyqh_e0CTkVemPwLUBaqt7AWvRB+94pfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.10
X-PR-Tracked-Commit-Id: 10b98582bc76a65b7c9dcee82b7918d7949740de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34dcc466103e1de5376db85b043bdde19fa0c0ff
Message-Id: <171631522618.20025.9984678763013497489.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:13:46 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 09:23:06 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34dcc466103e1de5376db85b043bdde19fa0c0ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

