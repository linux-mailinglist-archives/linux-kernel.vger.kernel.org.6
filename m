Return-Path: <linux-kernel+bounces-354095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11D9937B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BD11F234B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123301DE3D3;
	Mon,  7 Oct 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuRRTf05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F315B97D;
	Mon,  7 Oct 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330818; cv=none; b=NuS84Olid0LPCIlJ+d0qQwJUhvLaj3lRzm2rlgWBLRQIi/VKZJ6G1MWmAZw4Ryr6ikPzNWZD0Shmyse2UlRiDURgJrVjOvUMzdVuvL3ZjgRA8Ne3rNON209MIHhCHCtGBTHoQnE+nRMESR6IYo3BPIDRezJBsMcvTkKbwiiptXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330818; c=relaxed/simple;
	bh=Wf8VAqHP1h1/kaFqesJQCVp/zkSfqqJZiKYeNJ66IfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU5ztlJ3Cc4aXegMjggHHnz/9yA2YXQ+QfoC69baillzzK/Zb12e9ijJ32YrwBO/3t5gRsQT5U7FxTPnMdBrIj60idwxY/4nnmNdrFfG75jWuzSDDxs0dEL4EltSykJHVg5AgiaodKtKBSrR8blwF92Z3z20wITMr81T8i8YKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuRRTf05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44BFC4CEC6;
	Mon,  7 Oct 2024 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728330818;
	bh=Wf8VAqHP1h1/kaFqesJQCVp/zkSfqqJZiKYeNJ66IfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuRRTf05DbP8ak7i68eQcPlcRfbpiA7gtvfbzVCUCJ8b4+wzPdRuLq7+AEbwvSlcH
	 h/L8k4wdcd/80Xl1+2Sm9C4M4GSf2PNL/XhQmb9igDnMXe4uoAi889qSbrmgxOhjkJ
	 Hau7MOGAvje6TR7SgmG00PkZLmy4HrDNsu7ReduHTGM7E/1NG6tnezEUIdaWhLI38H
	 mMcMgxpoj8v2LlAnEqMJMUH5Gbarw5H0z8dc23YnZtW5kbbWACyZcFCJSiqT4Q9Myx
	 zEglIuWVzCoyncyIC5Ol1JDsYxJpaaFmIvuyWHwuAi53ZPNlzhm/s0GtJ4QuJKuA3y
	 q0I37OYUScy0A==
Date: Mon, 7 Oct 2024 14:53:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, stuyoder@gmail.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, laurentiu.tudor@nxp.com
Subject: Re: [PATCH v3 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for
 msi-parent
Message-ID: <172833081510.2293257.11172832997537740739.robh@kernel.org>
References: <20241007153047.807723-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007153047.807723-1-Frank.Li@nxp.com>


On Mon, 07 Oct 2024 11:30:42 -0400, Frank Li wrote:
> msi-parent is standard property. Needn't ref to phandle. Add maxItems: 1
> for it.
> 
> Fix below warning:
>   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - Add krzy's review tage
> - send include maintainer, because file name change, get_maintainer.pl
> have not return orignal fsl,qoriq-mc.txt's maintainer.
> 
> Change from v1 to v2
> - add maxItems: 1 for msi-parent
> ---
>  Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


