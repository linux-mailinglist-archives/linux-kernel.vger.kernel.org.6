Return-Path: <linux-kernel+bounces-233057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1091B1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D0C2826FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327FA13B286;
	Thu, 27 Jun 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgVPDYpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380222F1C;
	Thu, 27 Jun 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524807; cv=none; b=lMxs1QMyEt/keBYjpTsNDY1Y4rcoeR19y7wPkVmTGB4JX2sY3jyEXs/sa/99M31dsQNocJ2CpblF/kJaWAOHaNX5dOPR5C0TB0UrutszX/JcKKNp0o3hmcr0hnNdMsPLfMkkwxIPL83cWKqi/Bj0gZaY2fOJQI5DtU9BAkzOZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524807; c=relaxed/simple;
	bh=eT7//ofd5tzteAOzE4U68eAT4KD8yHlqWwSSc1NQ8fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLOSaBGDM55WT3tqb8fCdFzEmpWM5SwJhkxaY6vPk4DCMSwMMxltO4/+wkceivfUrLNk3jad3g50XoDMoB0/ejPG4fppCpOPCIWxedz7IFSrhfsF2QNqabFwvy2l9UKGUM27WMoeb+L3ZS1lXX0Hq+BRTSay7pJRw1nHJl86XXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgVPDYpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9AFC2BBFC;
	Thu, 27 Jun 2024 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524807;
	bh=eT7//ofd5tzteAOzE4U68eAT4KD8yHlqWwSSc1NQ8fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgVPDYpmfniVXzDq7PDl/rvxdO/4gQUDvQTkdhNVajevCk2nhz95jetooJ8+detL6
	 sXMVmg/Qjf2yPmpGHRijY1HOtF4EP82g/iEACxQle0dkFlHxzU/KdkWZR+KfIWic5s
	 dQp25Cz7vRPCLFYtCwawZhN+PjLvi7nCNmceM5hjouGadbQj2kd/LDzj4VECcWSi3G
	 4tyuRG4V8Z60d+k0N1DiNaweoDS9mtr/E4ZA4jI7J0uPhxqKz0Um/rnnumEsnkmNj/
	 KE5Rva5qpWpcmwi0OXrhA55KCaRehf2h6hs5PenaZDt+c6U5l00RTruHg7LJ+RYEW0
	 o8T3vV41faddw==
Date: Thu, 27 Jun 2024 15:46:45 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce property
 mbox-rx-timeout-ms
Message-ID: <20240627214645.GA614300-robh@kernel.org>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
 <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>

On Fri, Jun 21, 2024 at 08:46:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> System Controller Management Interface(SCMI) firmwares might have
> different designs by SCMI firmware developers. So the maximum receive
> channel timeout value might also varies in the various designs.
> 
> So introduce property mbox-rx-timeout-ms to let each platform could
> set its own timeout value in device tree.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 4d823f3b1f0e..d6cc2bf4c819 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -121,6 +121,12 @@ properties:
>        atomic mode of operation, even if requested.
>      default: 0
>  
> +  max-rx-timeout-ms:
> +    description:
> +      An optional time value, expressed in milliseconds, representing, on this
> +      platform, the mailbox maximum timeout value for receive channel.

"on this platform"? Doesn't every property apply to the given platform?

> +    default: 0

0 means no timeout or response is instant?

> +
>    arm,smc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> 
> -- 
> 2.37.1
> 

