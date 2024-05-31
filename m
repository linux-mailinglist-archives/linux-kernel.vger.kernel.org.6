Return-Path: <linux-kernel+bounces-197314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E534B8D692D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914432851D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD942077;
	Fri, 31 May 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2zFRNTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EB1CA89;
	Fri, 31 May 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181180; cv=none; b=oX4+jxLzTh/3oEtyMjDDsWvNUZMOxxjsa+HZp2Z++s0alQwpDg13QPXbKpTcIw08/tVUz5h+P1853oW7cmEVJSqGZhMNMMh+ZLhEDk0WISqbL5QW/DF8wvBQmF5tZcFrhtGXwutq3vhKWUj71ByLc3GVrpHjxIwQEdaN4yR0raU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181180; c=relaxed/simple;
	bh=5w8WpKnhnypQ9fps9kEe5UrgGrJSap02f6Px39IAGy4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qL7QjHMo0tj1Cch9NZcFnVTc+Ff0Ctsiik0VNzgHYGHqEpqYondbvVwhPvKZ3AHPz8Hsm2XRi2oI7aA+YA5TXZBPQonVZd4ZqBvaGDYSVaGF6x7eP2yeMdzBrxISoo5AlblDdrtonoMd8jR72FZmq+Ro/Li7qmQxJuNhhL/sT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2zFRNTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F9F1C116B1;
	Fri, 31 May 2024 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717181179;
	bh=5w8WpKnhnypQ9fps9kEe5UrgGrJSap02f6Px39IAGy4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P2zFRNTMjop8+6utR6AhK0Vg6n9Skjsd+IpGret4jT0KvC9GE/l4qDrZFRUbAcDfE
	 QE74S+b8Yphq+oGINMIKn3mVjLtTZQIXM8nFbqI6NYRGdw8Hb5QSLciKWOuMVoUe2x
	 VPGtc3y0KqK8yPTchpxgbSm6zWkmNMYu4rXMei2IztjjYIcOlsVII0jZH92tiwpP+1
	 Ikvrgivclp5TWEk3KtoJMF54YtqULcI/2fjyMocQD+EuNGJenWy6XaEG6ViZaJrzE2
	 UjXUUdRG/NBSMohcMDGmwePiNXyV2lxMCDrIPFqUIOPx1DSHdwKwcU84FI5KI0gL3o
	 kUFmVIGRzZ5Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96F69DEA710;
	Fri, 31 May 2024 18:46:19 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240530132944.37714-1-pabeni@redhat.com>
References: <20240530132944.37714-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240530132944.37714-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc2
X-PR-Tracked-Commit-Id: 13c7c941e72908b8cce5a84b45a7b5e485ca12ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8ec19857b095b39d114ae299713bd8ea6c1e66a
Message-Id: <171718117960.32259.11784216389309914917.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 18:46:19 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 May 2024 15:29:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8ec19857b095b39d114ae299713bd8ea6c1e66a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

