Return-Path: <linux-kernel+bounces-199394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3A8D86B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C679A283CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719C132C39;
	Mon,  3 Jun 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VljIBWF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45511E525;
	Mon,  3 Jun 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430179; cv=none; b=jynPtsd/d9naYq1/HZlP87dUbqkk0amPLl1R25u+iMZ1/1VxRvqRA+NiDuaoAL1sjBjQIw7Y4JNFYKvw3nGojDSONNvr/+ilH4TQvNc0eKyYsC1Xv/udiIUUMkYIda15vXvq0UirDcCtcc0ZIu8B8EuxNr2ZnpLsjmEKW+dzgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430179; c=relaxed/simple;
	bh=futJcvAhuekfJi6Omn7IDi2rhi/asO2I+BKkZvgElD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkRjDGGyUbDxMVwt+pV0TnCErnA2BP9Fc04De9siXhDxj2EhiCtH9YKepXrQ6Gp4MnIj66W74INKebmpeW1N8UoVTzZP5ghI7d1gXjH/pf7IOww1XG+hUUAoPByzCr7ESuNdLyte7aY8eFFYuY7xzw644+GpqGawnzD8ERqEXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VljIBWF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EADC2BD10;
	Mon,  3 Jun 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717430179;
	bh=futJcvAhuekfJi6Omn7IDi2rhi/asO2I+BKkZvgElD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VljIBWF+dF5NH50qa7/pjnUwX8u4zmTFEdKqAtElPselZAWfTQWGquNldjtc6QorB
	 xLJIRbYv5GblmgpQVMRgzkud0jMZaO/wXyoaFCxSL4YB/8kVpXIB6/BuMirHRkTtQA
	 PSwe4ewy560D80s3uy6x9rz1FK439Z+Fjv4dSs7z5/XwT6JkLHsQnvTUjlfRObv9oH
	 O6qA5r4omEBw06am6z03aXxwI/2OCfK4uyvmypWvQ9Z2lVn7LpnAMTWZYSOoQ0xuzv
	 cli7XbUcMs7hjGScsIeJYyAx4Y3ejoybgJyEDZOCWNKhtIrpVqoFDQ1fYFJUDi1fyH
	 4IYRNNw9eqabQ==
Date: Mon, 3 Jun 2024 10:56:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, Xiubo.Lee@gmail.com, conor+dt@kernel.org,
	broonie@kernel.org, nicoleotsuka@gmail.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	linux-sound@vger.kernel.org, shengjiu.wang@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, tiwai@suse.com,
	lgirdwood@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible
 string for i.MX95
Message-ID: <171743017410.508888.18301786325836336214.robh@kernel.org>
References: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
 <1716972002-2315-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716972002-2315-2-git-send-email-shengjiu.wang@nxp.com>


On Wed, 29 May 2024 16:40:01 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
> 
> The difference between each platform is in below table.
> 
> +---------+--------+----------+--------+
> |  SOC	  |  PHY   | eARC/ARC | SPDIF  |
> +---------+--------+----------+--------+
> | i.MX8MP |  V1    |  Yes     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX93  |  N/A   |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX95  |  V2    |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> 
> On i.MX95, there are two PLL clock sources, they are the parent
> clocks of the XCVR root clock. one is for 8kHz series rates, named
> as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
> They are optional clocks, if there are such clocks, then the driver
> can switch between them to support more accurate sample rates.
> 
> As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> clocks and clock-names properties.
> 
> On i.MX95, the 'interrupts' configuration has the same constraint
> as i.MX93.
> 
> Only on i.MX8MP, the 'resets' is required, but for i.MX95 and i.MX93
> there is no such hardware setting.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


