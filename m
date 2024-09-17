Return-Path: <linux-kernel+bounces-331551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5C97AE33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C272884CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C71865F5;
	Tue, 17 Sep 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW1ioOhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49136165EF5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566490; cv=none; b=pMzdV0gCtMx8NF/B0jz8+HPbtCiyZvRaQOVgx5NQw0rYcCarsTQzpIAK1799tszu+93BvRR2df0yxhZS0B0q+SEilwyrFNatFSm73ehStBgOjRRdlFjtqbJQC6Y/m4Xr1T50fn45nr1PY6EBcdamQD4t+4d8n6zF8GriR4SHQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566490; c=relaxed/simple;
	bh=Tbr48trGrA0RbkctzdcdRXOpQU2rnpjRN0LO9fTT90w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Js7yQopHd+LpQPoI7X8etq3N2rSBNkC/8LN0jDz5CLbAkiRhVQMwLuFGCcYnVY+qw4/rSit5NOTNU7e6+nxC0K0mrMN1NqINft1VVWh6GEKVQO5jQOiOUF9tlpsmKmBSSQ6Kv0/qO3/UIQZUikpskG0viuGfkZx9vv4Pf+Y22dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW1ioOhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8703CC4CEC5;
	Tue, 17 Sep 2024 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726566489;
	bh=Tbr48trGrA0RbkctzdcdRXOpQU2rnpjRN0LO9fTT90w=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=sW1ioOhVxhvb0TXtApIlDTswYCnY9hpeWRwVmoWzBtkRu4kFo7ps3721LDxneJBXN
	 +DOl/lMGU8R/SxQUxbnh+GwZzPR8TW34DF8/xUmMGwe4Lj6o4yx0cIf5qyCCjI9Tzc
	 jxiD5a4OL6R1TiUcFsegXtAEepL6wF4ElXZxt1hUgKaSIAR6AK4TlnNDPCkOZDqdB9
	 9Lkpohg0E2BSpc7tsQJbaIlXqtXCRqsWcDLI68GXClF1XsKQ2z3Ab9eri/vk7186wY
	 EI6HXDGoQBP9Ws9cumnVJ8/tlNCpbvgV+0qe8b55kBj6bJkwfDI00dw8/H+nJOgeQM
	 EvNHUbXmM2q5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F163809A80;
	Tue, 17 Sep 2024 09:48:12 +0000 (UTC)
Subject: Re: [GIT PULL 4/4] soc: arm platform updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <4c6e42ce-7919-4031-b2ac-ffa3a10cbaaa@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com> <4c6e42ce-7919-4031-b2ac-ffa3a10cbaaa@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <4c6e42ce-7919-4031-b2ac-ffa3a10cbaaa@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.12
X-PR-Tracked-Commit-Id: 46d2efc4efc00e09a47e41f753af69a9fe169ec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a940d9a43e623d1ba1e5c499aa843516656c0ae4
Message-Id: <172656649110.78027.12581162429584129397.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 09:48:11 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 16:33:54 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a940d9a43e623d1ba1e5c499aa843516656c0ae4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

