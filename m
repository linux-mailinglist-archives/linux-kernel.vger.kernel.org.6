Return-Path: <linux-kernel+bounces-371794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26D9A405D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577991C22365
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3171F4260;
	Fri, 18 Oct 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFJo4vrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF442ABD;
	Fri, 18 Oct 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259243; cv=none; b=nTrUtTF0qfyojkta7Fa2QJSHDuWd0pk3+cLFN9xx7DirQQ7ovAATUZG48c007teTzGn13FcSsmbyWjjvtbshk++Gtm3tLymveQdlefUJ+aiwgB8i3/bOLVrwwzP8ckoPyz/qPNGyRZ2cKQ2wABLAfKXxOQeqDsz5KvDnUqrSFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259243; c=relaxed/simple;
	bh=ad1r6xJeTIakYrG+ZigfRB3Jbt0z1F0o6v5ISXwzHs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnlvrKY0MZMk7dglyzO1ypIJnT6BMLbxIbwJOqU3ZWkPqatIxxDasjEtbsjEqQUa6xULDqXQ8YI9StmN2nqJmJmEXPR37PmzDf6rgok1FOmMsdaBMt2jE2aRfDLLtYVbs2UHe4Wm2QeoZdqpVxDJNfnuCq+ffTOcYw9fLOARaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFJo4vrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB1C4CEC6;
	Fri, 18 Oct 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729259242;
	bh=ad1r6xJeTIakYrG+ZigfRB3Jbt0z1F0o6v5ISXwzHs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFJo4vrn4tnFRukoYbGx8OI6/M2sT3OqUTr8ub1b2yA6AqYuwbN3eWkr+heTm/CPr
	 dwBff5wxhJknaasJRHsIA2+PP0BQW6oQVaIgs/1KxqYr9QTkJZSl+7D2Kwc7E+9suU
	 9gLGIcKITCgTkk5mJgx7sS4E4bnhlu6G7NNYPCpvnTSM/4kzkEjLAvaRKx+eU+I4cd
	 ePfSPrqU/lYzwUoWE2MEMEf0nv3ejCjfAvEhcGmSfODTzLM4bWwqyu2mQs6nypdukr
	 6Clzo+89c2+7t8WhJKv8Fs/i0/aSStrqNrMvpIxbxadB0UuvhJfzzZpyb86yGNPElj
	 T+lc7yDdNxiZg==
Date: Fri, 18 Oct 2024 08:47:21 -0500
From: Rob Herring <robh@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	rf@opensource.cirrus.com, neil.armstrong@linaro.org,
	pierre-louis.bossart@linux.dev, luca.ceresoli@bootlin.com,
	arnd@arndb.de, quic_pkumpatl@quicinc.com, herve.codina@bootlin.com,
	masahiroy@kernel.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, yijiangtao@awinic.com
Subject: Re: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
Message-ID: <20241018134721.GA90231-robh@kernel.org>
References: <20241018094320.113477-1-wangweidong.a@awinic.com>
 <20241018094320.113477-2-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018094320.113477-2-wangweidong.a@awinic.com>

On Fri, Oct 18, 2024 at 05:43:18PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add the awinic,aw88081 property to the awinic,aw88395.yaml file.

That is obvious from reading the diff. Please say something about how 
this new part compares to the existing parts.

> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> index ac5f2e0f42cb..b39c76b685f4 100644
> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> @@ -20,6 +20,7 @@ properties:
>        - awinic,aw88395
>        - awinic,aw88261
>        - awinic,aw88399
> +      - awinic,aw88081
>  
>    reg:
>      maxItems: 1
> @@ -57,6 +58,7 @@ allOf:
>            contains:
>              enum:
>                - awinic,aw88261
> +              - awinic,aw88081
>      then:
>        properties:
>          reset-gpios: false
> -- 
> 2.47.0
> 

