Return-Path: <linux-kernel+bounces-219457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4290D32E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C31B243E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3F15ADAB;
	Tue, 18 Jun 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXTMvx27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEB1865C;
	Tue, 18 Jun 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717431; cv=none; b=nZ+gh30a79bop0gDljNebrzalJ+197cc5zyhTZuabMfFsRLaaaMoWzdcqVgbbkWQZB3v9qMpeTxtURZCuvxmL8ml1NZ6jEKBoakYIYrP6eehxNW/RGo5cegx1Dxj94Dqq8o7x8kAXatGCa3hK2Zh3uIsl61q9KFICoSUQq9AOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717431; c=relaxed/simple;
	bh=mCy/oVF4ICSRB/Yh3OGp3+lcxnyY+CSQ//CTQNIgHOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWKXEfv1X1O7iYD0z4JywqqmyUHqjlr+8lMtd9VkJcVe5ywZss+RIYMAor7Pnfll5YPnfpH84UuKUV9zJ0PMmxyAy9WdDfn0vLfiHyBT/IgAVTs0iJ4YeQnnVcutjrB88XIfii4nB79/gSkKlEWy3iH0uHHxDB2ZVFDNeyLZDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXTMvx27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1806C3277B;
	Tue, 18 Jun 2024 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718717430;
	bh=mCy/oVF4ICSRB/Yh3OGp3+lcxnyY+CSQ//CTQNIgHOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hXTMvx27OADw0Kbw5UsDxxLqaqXAyG7cgso/3KLZ99QhSx5YhDY2XS3rfNFzrrWsI
	 gPX+kAQxbIUOFyJ6HfxyZVzHbwEycutevwZsbGmGYBoCAGbdg6HXTY5wNh2QwtWVzg
	 J6ktm21IaS8CfnLiO/E2M9F32XDndP4b84Y7fDRAV/izdg1bCuIKzGCp1cin5exiKh
	 gPAvjzWrjgs2XhshqEfh+PRwUFU3tX2GqWVYDI0lv4Nq6wcee2Ns/aDfV4yEek8qYQ
	 IHDhNOKIug5SGcArL26mBCMaUEGoyBfgxxCONXEVLaw/kz7tR1oxGHuEg6xqHuXcjb
	 666bsKItl7j1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7163C32768;
	Tue, 18 Jun 2024 13:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: Constify struct vcap_operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171871742994.9870.13970058134666207593.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 13:30:29 +0000
References: <d8e76094d2e98ebb5bfc8205799b3a9db0b46220.1718524644.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d8e76094d2e98ebb5bfc8205799b3a9db0b46220.1718524644.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Jun 2024 09:57:56 +0200 you wrote:
> "struct vcap_operations" are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> In order to do it, "struct vcap_control" also needs to be adjusted to this
> new const qualifier.
> 
> [...]

Here is the summary with links:
  - [net-next] net: microchip: Constify struct vcap_operations
    https://git.kernel.org/netdev/net-next/c/8c379e3ce404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



