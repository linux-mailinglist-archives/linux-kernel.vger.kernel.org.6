Return-Path: <linux-kernel+bounces-225169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7EB912D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C53288297
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9217B406;
	Fri, 21 Jun 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bELKIVjH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6049178CFD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993447; cv=none; b=Gr1nOpYdepbZGTyOEPAC9Z6Gz5I+aJdzwMHut/QJO+aX9FhgGUkYSSXThRiV6AsVylnBe05oBvmM9V/7/n+aefXhh9TsW42TkQfcVw6p/XhjjWe3YVXBmG2hY5Cs7NBGbnMShBC8es7XvifWxSNOrzie1lwNwU2L0EU9Kpxkk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993447; c=relaxed/simple;
	bh=WzkU2CgUnebrFkWuQkPiTx2gUVd6nBmogOfWTQqLylQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MnDZMTnaZ8VYZLLLOndLauehZ/s2ep6nZscaAfuXVNkniMMRB/+5btMs3QbJLIQPDH3QM5ps7uXvaONa6apVQHGiQ3W4T/JJqRpjc68LIj5OZWrdmNJqut3zd19pS3yVmI78KQcJoxl3KfnhiMrDqVdpVIvUVuuB8DNTIvFeUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bELKIVjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95767C4AF09;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993447;
	bh=WzkU2CgUnebrFkWuQkPiTx2gUVd6nBmogOfWTQqLylQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bELKIVjHoP1+y7oIOmd79f4RJnhljnN8Hy3o+OBCJV6PkLMvS3I2uRcqqFcXL11Ky
	 Alj1Gig7gurK2bzXqLMM21Ayielo4wNHU7wJIIBfGWbpIbLHMO7xru0Z7hRQiBBLXM
	 SgQcpk9PHpyfnaRHxBaWGxavtRNIrNQXuQQLAEQ4WVrc+2ctVF0H9aYZGh2ClK7vj0
	 +DY5IqEskiM3hIrLrv7BVj8zveZ9Rdc/w4+s94BkH6PwxtlyhqO7sPOKvKSbHb6op6
	 8fByNfykClEYks8lPAyE4uTzfJKrvjeYj/erdNhhwKJ/J6fHjidsI6rLn/WzD1o4kh
	 pV4SSKM4YlVHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A6A7CF3B97;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZnVNdBGN49EjDfM_@matsya>
References: <ZnVNdBGN49EjDfM_@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZnVNdBGN49EjDfM_@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.10
X-PR-Tracked-Commit-Id: 5422145d0b749ad554ada772133b9b20f9fb0ec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66cc544fd75c70b5ee74df87ab99acc45b835e69
Message-Id: <171899344755.17423.11099130617063949230.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:10:47 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 15:22:52 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66cc544fd75c70b5ee74df87ab99acc45b835e69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

