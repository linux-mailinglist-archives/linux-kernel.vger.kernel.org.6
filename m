Return-Path: <linux-kernel+bounces-184212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6F8CA463
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3771F227B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177331758;
	Mon, 20 May 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juAMYDYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501912E6A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243331; cv=none; b=LgKXA4tQ/KjpcpG4AlqSqX+Z48lAsmcfwqwiIzgtc/s9UTyt03YLh4xopQuvy+TKJ3zt0DTLqlWYACJm+x6gACr8/TT+rWw+yNSIWMdKzTnLIPsSah9N+bP5h/EFp8QWExM8voLCaoo88lAZYvCxltX+qms/gURKAK2xGYLCCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243331; c=relaxed/simple;
	bh=426rdnFhOzmZGODgfSzTjGDMs/RniLV9geTTwINhcgI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bx7Wka+q/LfR2DNdnF25APGEh/b8SGxgD4sepU4+T3SqEh/Piy9xOoDWTEFpdbiSDSvojbefmYSB9dWUYXVVf9w+KqLhz7KWik1kLToSs5i3d9AYJJlyPXFYLpvj15Vii67ffyytvVkP1uxaUSRZaF5GpFUVTdWvCkSxIvfjL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juAMYDYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C8EBC2BD10;
	Mon, 20 May 2024 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716243331;
	bh=426rdnFhOzmZGODgfSzTjGDMs/RniLV9geTTwINhcgI=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=juAMYDYswiJ3BVDHfGdRR51rNdcJ+6eH7AT5MyopUhrxWkk5XhvdqM43TEUljtdc9
	 c0Kloni9j7kqYguMw3ykGXL2wJB6w5yOLi2JqeqrbASodbY3oiDnspSywpKzqoERqK
	 U8RbYx4/YN9Web6JcL+ZSnO2Qzq6l6hBrohgmVfVigD10fy3ijdscKyLNxoxjyM8TG
	 2Wm04pvQo0+sF61KANVDkvyI+BhdRqKd+NZ60Ezayh2BofSiVPoPi2DL0f3U4tlGj7
	 zVs0mSor6BUfFKx0t6YEjC+sz+QPMM+DX2NeZU8E50bRHDzF2lVmavwtjvXfO0Sxs7
	 iAzrwn/U30f5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01697C54BB0;
	Mon, 20 May 2024 22:15:31 +0000 (UTC)
Subject: Re: [GIT PULL] soc: devicetree updates for v6.10, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <7b555e52-a83b-4218-9251-27dcb4e93268@app.fastmail.com>
References: <7b555e52-a83b-4218-9251-27dcb4e93268@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7b555e52-a83b-4218-9251-27dcb4e93268@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-late-6.10
X-PR-Tracked-Commit-Id: 01a7f9e1a97ee48ed187b040afcda23886b9f48d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b036162097060e7e762b601de6517d9f2c7514e
Message-Id: <171624333099.11553.4340948832769130968.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 22:15:30 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>, Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 21:49:14 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-late-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b036162097060e7e762b601de6517d9f2c7514e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

