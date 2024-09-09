Return-Path: <linux-kernel+bounces-321731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041A971EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A121C238D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18461BC39;
	Mon,  9 Sep 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd7tt4XB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630913A240;
	Mon,  9 Sep 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897842; cv=none; b=ijEpVMDvjEeUZVaZAVXUzH/i4rd3FWGSRSvlIx5Nf7KKO0k+iL78wD+HqvQwQmoUAYn5vxVgN88+QR4EtzZA0++CLuOqrXHT3W7KRP3SGFSoXJXkSHjcs0bjxsw0xLHO52iRUlRW9FWXKNVO1g4ovxzpKHwM6xNlizKSw0u2npE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897842; c=relaxed/simple;
	bh=XcUDm/k+911vW3FZtkVePJXLt22j80SWvX41/HfoO3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIV2fXVoj83cUG6dv3i5zHOjDFA/1L5w7/AwlVbP7Ch0m5d4GlswuiYJdu01ycNWb36UFHA+NIXTe1R0C63F+R2q4c7uF9gMJHEC7yjHGwKRZFlKSZJgyVDQ6jX0OM/1iC8lm3q2iLZ1PIz9DDeQb/7DFg55dElG8BqUa5VjWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd7tt4XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B7C4CEC5;
	Mon,  9 Sep 2024 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897841;
	bh=XcUDm/k+911vW3FZtkVePJXLt22j80SWvX41/HfoO3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd7tt4XBxV3SFOwaiRoDq9Bwimf/e2Z6oHXS6IplUIbZRoBGbllmWvj+4TSsOx2yr
	 poSh9WS6+0+OcteGNXurFGmDxl28P5JVLHJznBh/4lgCSvCd8ErA9LsSLpGb3KGhXi
	 Z9Qo4SVvIrjEpIOSA0y+oryXRehmY05vLxF2y5BnMYCyt7+UcpEB4hKwJd8CPEmxgU
	 V4XqCoI47JBNuwM4CO+HyafDV+BhsYilNMCMhVxr3oDhsIDXLa21KAXfLi3RdGirDW
	 qAEq61fzbhXRUbxR8jaUDCNn2XcEyVkSW8vx8qsj9AqGQNErQtYsVOVAU2IMVfksqF
	 4TfB4V5q5da6Q==
Date: Mon, 9 Sep 2024 11:04:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, devicetree@vger.kernel.org, davem@davemloft.net,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	pabeni@redhat.com, hkallweit1@gmail.com, f.fainelli@gmail.com,
	krzk+dt@kernel.org
Subject: Re: [PATCH v2 net] dt-bindings: net: tja11xx: fix the broken binding
Message-ID: <172589770898.219234.12343458471539869016.robh@kernel.org>
References: <20240909012152.431647-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909012152.431647-1-wei.fang@nxp.com>


On Mon, 09 Sep 2024 09:21:52 +0800, Wei Fang wrote:
> As Rob pointed in another mail thread [1], the binding of tja11xx PHY
> is completely broken, the schema cannot catch the error in the DTS. A
> compatiable string must be needed if we want to add a custom propety.
> So extract known PHY IDs from the tja11xx PHY drivers and convert them
> into supported compatible string list to fix the broken binding issue.
> 
> [1]: https://lore.kernel.org/netdev/31058f49-bac5-49a9-a422-c43b121bf049@kernel.org/T/
> 
> Fixes: 52b2fe4535ad ("dt-bindings: net: tja11xx: add nxp,refclk_in property")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> 1. Add more compatible strings based on TJA11xx data sheets.
> V1 link: https://lore.kernel.org/imx/20240904145720.GA2552590-robh@kernel.org/T/
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml  | 62 ++++++++++++++-----
>  1 file changed, 46 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


