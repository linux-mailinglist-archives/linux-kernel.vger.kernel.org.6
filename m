Return-Path: <linux-kernel+bounces-251835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC3930A69
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD371F2199C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2BD13A252;
	Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncYYCFT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79563C8;
	Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968096; cv=none; b=k4pXOSNd6AIjjTVIa3A9waK1r8XXQPd76ch03ooqdFoBG5ORhlQJK1CTEFfnnzjX2F/Z4SoZHoh79x4+G2/+VLJpDw1Zv88RmPjsm37vDQPdaRvADmg4XS/iHdnCWetD7fvG0ggsgWCiI+x2u0Bksd9Y3e0hKS+AoLSglXX2Fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968096; c=relaxed/simple;
	bh=AdOhLUrd5pkToxj3RfzJnpWjxeeBOLwo/FGLq0sUyG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqSq1VEAUBmlQjMVmGe6QHiJACh36QzPsA19g/YImlJotudCdt8DKTN9UXZjgUhisZMx3mYY7nK5zDEjQoFhzmkObOS4Xjc7+FCe4Dlg6WH99xZYP0/Rdgg+ruBjl8hiJ8Z0vmkN3k5luoSWNx/s4rqqfFdjzYd0TwoICKYA/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncYYCFT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0FDFC4AF0E;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720968096;
	bh=AdOhLUrd5pkToxj3RfzJnpWjxeeBOLwo/FGLq0sUyG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncYYCFT6qWx/eFIq/ISywXR1wri9P9BKhpnEJCwi8EWW08DDgK2wy+eiZBc6Fcav9
	 CoAnrEt8XjpFwBmsWUARwB+v1lKC0zbpry1Z9YVSvFvLc+KxmANZidgt+BDDwp/JZo
	 SKXRSVzjouDPDy1EBBKUDoPWBGEtag/OTq3z8893npCEsF4TJ2QqY9TxY60Tm46Kfe
	 S8jhqQXr1/f1/HtirPAPSh2txQi+kW0yFeGsSkpkWAFg4lSMjrCPnMaFnyWu1q0eAw
	 n5e/Z1lt7iJtM2C/U6l2Tx+GEVSFETokqidKJ6SElj54l7dQKfA9p4Y2hhZy8k2Klz
	 b0x6Ozawwi3Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C661CDAE940;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: pse-pd: Fix possible issues with a PSE
 supporting both c33 and PoDL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096809580.533.3628542682652839668.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 14:41:35 +0000
References: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
In-Reply-To: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 15:55:17 +0200 you wrote:
> Although PSE controllers supporting both c33 and PoDL are not on the
> market yet, we want to prevent potential issues from arising in the
> future. Two possible issues could occur with a PSE supporting both c33
> and PoDL:
> 
> - Setting the config for one type of PSE leaves the other type's config
>   null. In this case, the PSE core would return EOPNOTSUPP, which is not
>   the correct behavior.
> - Null dereference of Netlink attributes as only one of the Netlink
>   attributes would be specified at a time.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: pse-pd: Do not return EOPNOSUPP if config is null
    https://git.kernel.org/netdev/net/c/93c3a96c301f
  - [net,v3,2/2] net: ethtool: pse-pd: Fix possible null-deref
    https://git.kernel.org/netdev/net/c/4cddb0f15ea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



