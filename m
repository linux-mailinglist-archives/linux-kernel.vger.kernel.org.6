Return-Path: <linux-kernel+bounces-404882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43AE9C49B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48565287271
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F81BDA89;
	Mon, 11 Nov 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToT/OOOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FA1BD516;
	Mon, 11 Nov 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367824; cv=none; b=YbtIIT+CA+C5W5YCpxdqcUSQp423YemBf2CoqYLHGScDniURboa20rQzanP8t5jOlJ0+5XtfMGW5yneQTqhUU8SKYBsgXVaWvTNP8Swaz/S27JKL1cMgJGE+NdZTJNmzQZfAOhyis2HMBJF/WC+V4TtQ+E9uAWUaeC9xgIuCTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367824; c=relaxed/simple;
	bh=oEYBznALtCFOdRUSe7JqcSLmq8rWZD/GQMlij5FekxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcgPJcGWM6+78jIsZxq65gc3+80wa8e3z5qrzgfkBbqrJZgJmekp/o9Fhki+eL+hSaA+/NC+osIWptKs/9osBsM3q9UU9pLf5uXoYqc0cTgAQSadM61LPloDAHucnMbj6xwa+VzbLkuXRaMyxqcRgaJ56VId1JZpg6V3x1qQe6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToT/OOOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F1C4CED5;
	Mon, 11 Nov 2024 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731367823;
	bh=oEYBznALtCFOdRUSe7JqcSLmq8rWZD/GQMlij5FekxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ToT/OOOQgjs6hQi+35sQkmp84MQPaiLbahO7PqLU2iMutfJTBZqynAPoGOGD78eA9
	 AnNuny9Z2wKBP9zm1kAkc0dvlQGRmyBJCbGGjtkxgQ30fdFNNRD63dEaWRfk1yF8//
	 Gl0e3Rq3ZbtPLWK+S0b2UvU4FAT/+0Sj+jWF7PuxAifjZMg/s8ceKSplHB5llh5xTE
	 UmkBl1/NCZx65dXaKN67LguReMAbYsyFL2QI0S6DhR/MHSU8EbZOLNeaIM1hQrDzoO
	 uuNHtucNkhTHC8ZYGvOo9dI5E/nUvaVBt9CTd/wG3uURcfi+Gr8MOpdFJTIIs06fFw
	 PMiuYYB/6QM8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0C03809A80;
	Mon, 11 Nov 2024 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rxrpc: Add a tracepoint for aborts being proposed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136783351.10093.16359133763788877491.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 23:30:33 +0000
References: <726356.1730898045@warthog.procyon.org.uk>
In-Reply-To: <726356.1730898045@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Nov 2024 13:00:45 +0000 you wrote:
> Add a tracepoint to rxrpc to trace the proposal of an abort.  The abort is
> performed asynchronously by the I/O thread.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] rxrpc: Add a tracepoint for aborts being proposed
    https://git.kernel.org/netdev/net-next/c/8b9a7bd4d6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



