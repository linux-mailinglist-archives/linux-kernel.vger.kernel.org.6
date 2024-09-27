Return-Path: <linux-kernel+bounces-342150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61D988B04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F8F1C22F61
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF91C2DC2;
	Fri, 27 Sep 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnlIOCcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5B1C2DB7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467233; cv=none; b=ngxF580iy0yYY44/lGfTNTtE9P6dxJJIOkrM5M/q53BVqEqXFobWTD4OFnzIHDO7P2Dcij71b/Ck3g6ZL/xzLs94MPhsKmYc27rZmwbquLpE/Ohd+DnRneNwuGk/fERsuF11jkcjp++sWn/V4t8FKKh9vbr9bM1XxEpcnJSGqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467233; c=relaxed/simple;
	bh=Ald/L+MUnUUUGljTxo/zBZ12ySrRjiaLmzmpK6amXCk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZEGow2VmIgMtQPSIsJOCXdf/Zvyq1VlnGZoVqPEdSAb3a7ejoIhn0DdgLQlTHmJsdKNmrrSPbs7abfTzdmcd9KbPF96EdgvwmzdddHccupGehHZBovNGrfX5e8ov0YxLr4vjBysqIa9Wx21lMP2z9gtKIFjj+hmWLkGzQj5YabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnlIOCcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C610CC4CED1;
	Fri, 27 Sep 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467232;
	bh=Ald/L+MUnUUUGljTxo/zBZ12ySrRjiaLmzmpK6amXCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YnlIOCcg7Eb0OYSfnjSIMD5uHGcdMMGTyVrNMCEQ2GMNQD9xgq4ttNqOJobljmqbm
	 VsZbG3hvnXXTFdnjumtb4YXUbQ0oiAF82em0fJm3ivjOcN/Htsa6x9nayHPsibCfHj
	 eBeR3NYTJttZ5fAEpRjFqepQCUBepNL27Idy2UOCp1I+AUhGd3F38ORv4ExGSDP4tt
	 yfEnEzatTNqtb+rmMukgP88XjcmnB7EUx4C6/9hR/Ja4l+fmnVFz9RpgNLJfeoKFsi
	 zDwoqbyDp0xC6sV1G9H1LaxPwY40tV2mm30jpkwLivKBBjU7lGu+S8cEMY6K+F5taj
	 JVcJ7EyUWHNag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFD3809A80;
	Fri, 27 Sep 2024 20:00:36 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap changes for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
References: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
X-PR-Tracked-Remote: https://github.com/norov/linux tags/bitmap-for-6.12
X-PR-Tracked-Commit-Id: d7bcc37436c7d373a715d48a7cd74cd3b1724a68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c44575c78dbcdf89bd9f9bc3869ce8ab5cc1272
Message-Id: <172746723525.2065565.3336280005318764405.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:35 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Anshuman Khandual <anshuman.khandual@arm.com>, Brian Norris <briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 09:32:24 -0700:

> https://github.com/norov/linux tags/bitmap-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c44575c78dbcdf89bd9f9bc3869ce8ab5cc1272

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

