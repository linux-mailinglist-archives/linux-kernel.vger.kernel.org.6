Return-Path: <linux-kernel+bounces-416207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0E9D4213
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF6B24DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6CD1C1F0B;
	Wed, 20 Nov 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrlUMyex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826E1C07C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127517; cv=none; b=FBCsMpSlZVo7xMYY1t5uYnUfKP4PdjefYjgAA4ykIkDtpZhQw5eZJeIiG8FaRBliw5y+xRmT2lmDCafK9fntmH0pt16thNklYef1/9syo9Dgr/NNXtABjsp3aBhTMXNvyYBzvVWp/L9V7NKWTYVdXVXkLzHCctStj3qtwE5j6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127517; c=relaxed/simple;
	bh=V6QFCdpxrY6g6eLgEZtxLpJvgAzljeuP8TJw6FIVbnQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HQMKs9SZGu+QGJCq3b2WnYYspifJdGH5avvyghWWCTTQ0QJuQcD07tF464q11Vw1IzBBXu1ZufVjue5PI0jwWYQt0fDTGW0d/UOFie4nO9tyYmmwPLyN5uhy7wcMv4Wrrb9AGsJ/SmIoFbW5Fxsb7vh0dCv480NogSGikPtTXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrlUMyex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1FDC4CECD;
	Wed, 20 Nov 2024 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127517;
	bh=V6QFCdpxrY6g6eLgEZtxLpJvgAzljeuP8TJw6FIVbnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NrlUMyexQpvVDwmyRLZa0cz9kaEdNgcCfXNcpqs7j9IeQ2em4PylXq3Nru3SYAWfU
	 w80Cd/UnEAXxymSyt04HRO3oF1WiNj2xCtIuYhUwGUbwCYF0BMmfFF3HE+7XKaooc9
	 dlbr33bxS8MIC69Gjuxov3DJP1KLCzGIUB4bAPOpe2rPH3m/CWXbKRmIrt1Obtbu5o
	 mXFLowUsRB95SeGIDzSBGtVF+TaqWRvw5uoTna4jDfr0qxYfc4dfzTaUy2OwfxTSr0
	 aRUK6vZMeLsr40IDYZDM2wmLFrCVKTkCWZghutHf4VoXyKsVIdybtb2CsCHFSTye/E
	 vUMwZfYGAJogQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE63809A80;
	Wed, 20 Nov 2024 18:32:09 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zztf9nRuKNjH34Bd@slm.duckdns.org>
References: <Zztf9nRuKNjH34Bd@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zztf9nRuKNjH34Bd@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.13
X-PR-Tracked-Commit-Id: 85f0d8e39affb7b88401b1e0542230a7af985b96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b6d39054fa3db4326e73e09576ed5f758ecd2b
Message-Id: <173212752849.1310468.16044761587671414589.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:32:08 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 05:40:38 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b6d39054fa3db4326e73e09576ed5f758ecd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

