Return-Path: <linux-kernel+bounces-264459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B723093E382
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40439B21563
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96F20ED;
	Sun, 28 Jul 2024 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px2g014S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B21184D;
	Sun, 28 Jul 2024 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722137411; cv=none; b=vE3UySfJ21rEb2dzSmVQyXduuzj160ycuzJI/h5qGZlSlcUt0pxjM1Daer3Cnx0RKTGKaF8S5Z3+ECWxfvYjurp1LaO8HLvPUAoSLHESUDNFWaBdjg9c0HWnRfT1EA1YLXkL8PYq4FRWPBLeAIZRaCoyl8S1FbruP2sbHci699c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722137411; c=relaxed/simple;
	bh=QUMOa1ctpXiLlL7RHIN/1XidbIb+xpSoka0Tmzy7kWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rbj85EkGngR9Ud7ofmHp5swXlevDKK2ro7k2QvpBtkW+XqU72a4QOFftqCVen/7D10M+B/kqS2kc2zIBlQAeag1gVyTBEC8VBMJKBYvR87SNzGYTqE1wICuCAGUH7jWPYi/cr51j7swxIfFhH3+dcnrPkyp87LEvShl23zh1dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px2g014S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A839EC116B1;
	Sun, 28 Jul 2024 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722137409;
	bh=QUMOa1ctpXiLlL7RHIN/1XidbIb+xpSoka0Tmzy7kWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=px2g014SRjyDCgj5AzfPl3HIQH4nkgeEsEQ5EkasH0YELJbjCQTGpU7FpXxvwywt8
	 I35Jie0jjWK2XRRaJEw3S/tn30PS5KBPwjTSlky4baB4VfZQ+crt6WR2nnFIhO2pw5
	 ZDLgX181I8hIjUPznkkFAJX4fIpR6YTSEgf6uIMkE9D2P9Wkv6SNYmt+iVUJukLDOH
	 o+0FnWR7R67jMCp2I9jBbSrwfkYHJxlrwpiaBY89QzU8YAPztrJ6KWnKYL4RtoJsMw
	 4n6pkhl7g2eH8Tiy1D9p14Lv2m6znMUbo+U+RggVkXdf1XAGssClw+2RwkiDtgDIgh
	 IeLPWEbdSZRuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89477C43601;
	Sun, 28 Jul 2024 03:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msuLY9XywuKvnggezTdjCBQx8HDfYhHNstS-Yijz15sdg@mail.gmail.com>
References: <CAH2r5msuLY9XywuKvnggezTdjCBQx8HDfYhHNstS-Yijz15sdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msuLY9XywuKvnggezTdjCBQx8HDfYhHNstS-Yijz15sdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.11-rc-smb-client-fixes-part2
X-PR-Tracked-Commit-Id: b6f6a7aa689f1c255e06fee3ca13c9f9e5c12780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5437f30d3458ad36e83ab96088d490ebfee844d8
Message-Id: <172213740953.10876.7243981808419736368.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 03:30:09 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 19:35:08 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.11-rc-smb-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5437f30d3458ad36e83ab96088d490ebfee844d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

