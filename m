Return-Path: <linux-kernel+bounces-395832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F39BC3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE57282FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169031632F1;
	Tue,  5 Nov 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiHh+TMZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A152F9E;
	Tue,  5 Nov 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776221; cv=none; b=WI7pnCw79fyUOTpwB14jfn+OIAFlaVLRB8x745ymxnnVjCz/XvpI69TOhzwjYyyt1iGwLemfilBPrRDNc/234CYITVRRv7gCFCI5KcajTWxklg+JjLpoc3PfuSCjC52AqeiVOn6l9gAelBfP7A17SioYOoqaMrKJBoO/XIllA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776221; c=relaxed/simple;
	bh=9LDC91LMilMxXjCTP/fsGGlz+9VFe99Gy7W8ZsIgP18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lptt/ZckDA2AcdUZuWSc5KsYUnRiK3J3V2TLrzsEQisQK75DtsPT0DBAvEm485JhaxBiwmjVVqHDrJGrzPUXgoeEKoYris6JPbR7ArTxXajR7Aag6Kohd1eehLe4OrS4AlAk2vOdG73fCNL9/WNJG+tOAfQf1/RwKFJwprptyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiHh+TMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085E5C4CECE;
	Tue,  5 Nov 2024 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730776221;
	bh=9LDC91LMilMxXjCTP/fsGGlz+9VFe99Gy7W8ZsIgP18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SiHh+TMZhp30Fvgu5Hk5vbLHACsRQ9BkRex/T1O0xiHydSasP+8fwv8v8ktwQyJhr
	 JsfOKAnXNwOIJuTFBppn5NLBFYquL2ol7OjUMdkUKoGsrN69WfMsKO935qgOiunpzc
	 99wuKGhMnFGzlYjvDC+ZQ0HfqT8AN7KCDkQU5cbRtPSWq3WMPfgmtIXMBee85c+FlP
	 Fa5zlaYycskdvds6wYxO3rtBuVRJCm7iLaZ3eBizT09MxFhkD+wGAj5mVv/omNfOdz
	 ZqzMsZ2NYw2w/uGoGgEBCJCAPjEzTKGqqiSL7B2sds8Puz8NH0Eso0BM5QdqtAzZKc
	 zW5A6/S522uiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3733809A80;
	Tue,  5 Nov 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Fix sparse warnings in dpaa_eth driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077622975.100940.17453964424124667340.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 03:10:29 +0000
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241029164317.50182-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org, madalin.bucur@nxp.com,
 ioana.ciornei@nxp.com, radu-andrei.bulie@nxp.com,
 christophe.leroy@csgroup.eu, sean.anderson@linux.dev,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 18:43:14 +0200 you wrote:
> This is a follow-up of the discussion at:
> https://lore.kernel.org/oe-kbuild-all/20241028-sticky-refined-lionfish-b06c0c@leitao/
> where I said I would take care of the sparse warnings uncovered by
> Breno's COMPILE_TEST change for the dpaa_eth driver.
> 
> There was one warning that I decided to treat as an actual bug:
> https://lore.kernel.org/netdev/20241029163105.44135-1-vladimir.oltean@nxp.com/
> and what remains here are those warnings which I consider harmless.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] soc: fsl_qbman: use be16_to_cpu() in qm_sg_entry_get_off()
    https://git.kernel.org/netdev/net-next/c/a12fcef429e1
  - [net-next,2/3] net: dpaa_eth: add assertions about SGT entry offsets in sg_fd_to_skb()
    https://git.kernel.org/netdev/net-next/c/81f8ee2823f3
  - [net-next,3/3] net: dpaa_eth: extract hash using __be32 pointer in rx_default_dqrr()
    https://git.kernel.org/netdev/net-next/c/0a746cf8bb6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



