Return-Path: <linux-kernel+bounces-177811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90898C44E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8617C282AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF0157A5B;
	Mon, 13 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUDtJgHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620E15687D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616907; cv=none; b=CUvXK6CKgoTXFTglajUpHPRhp1cqk813fKIAAhbnjRgu5OZEEx48oW6+Y6NIS8SYwZW4bUVORpOtIwW/5mKfPknCIlEVlll0mrnwJGnPCaybP5IwYlQqoemlYf6O8GBhnl1ijrK/OIOj4mQZKsmqtX3r6Zow/mIaCBA671qI05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616907; c=relaxed/simple;
	bh=UiTGQxTTI+3PMZ1KNaByzzSNJwDUA5uEkbfPMtcGsDY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0MtVPECiZlH1YM0vETRaHmrBtCWc5BZ5wZCShC6WzHwuflVdDxrcZRUedEyzmaI2bb8nd0IIc8rF+BUCO5Abn9P/IwadT0fFQJnzQOBO3ESNWRwkKziVrt9K7cjf27yYtkII4yy710XM68KMckDYBWqlU0wA8d8vmxlKRRofhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUDtJgHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79488C32782;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616907;
	bh=UiTGQxTTI+3PMZ1KNaByzzSNJwDUA5uEkbfPMtcGsDY=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=TUDtJgHbVN8Nsvwq+H+6lliTBpjIs+CEKO5+kNdI/fQ4NXHzJg3Y9TJfwevni+O0n
	 Je0KN+yYRHv3hhorcMTbVQzgoDWninA5jw4XxM/wypzbm7ygiimT30YKp9fZbei9+Q
	 WGPajBjWdB5qTVEqJJL5LKIGxLTeXLM/Da4IGdv5foliJheAcnvLx4eZT8IId0mMAE
	 AugoGMpiIa7STYf1ZM1W5kF4p+5LdrtWl8ZQEAQzVjptv2qBMuZI/ARCV8I+WsoIVz
	 r2XBKW/Q5cZT8223A0ULT04bCa6fNgmhDvcOdp7WPOMyqC0/lXVwVIMq8/mgYunLM4
	 BpzUZCYkOy7PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66A9FC433E9;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] soc: devicetree updates for 6.10, part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <54b241db-fa39-41d4-8a2f-d44c18745249@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com> <54b241db-fa39-41d4-8a2f-d44c18745249@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <54b241db-fa39-41d4-8a2f-d44c18745249@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.10
X-PR-Tracked-Commit-Id: 0cb7e0c617c6aa3da46514ee5982bd7de11a2b2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c60000f0b9ae7da630a5715a9ba33042d87e7fd
Message-Id: <171561690739.7727.1818536666593784751.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 16:15:07 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:11:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c60000f0b9ae7da630a5715a9ba33042d87e7fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

