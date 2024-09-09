Return-Path: <linux-kernel+bounces-321718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0245971E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956FD1F24012
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA177110;
	Mon,  9 Sep 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMJEENKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD13249E5;
	Mon,  9 Sep 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897272; cv=none; b=Jef/Zz2AI4JItazRAsVqlEauA6tzqcOF8OFwqBbbIdrCMWEXYKvkyDwfSGHlBa60+F1tRdv+gjSRyjrgVGqVMaswXMWPDzHOlSoFAPmPxGzJEE1NnLtnCq5ULP7apgLJnJr+gsaDEiK2mZjkXvdGCkMzMfnnC8ykEAuVAIlwulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897272; c=relaxed/simple;
	bh=2oJxDDyBiy9iu1Fd+wPaafH6mWwC5OBCMSIBpxg9bKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/+FCb7bf8wanaDQyfkgR3Pn2TC+brcGenz0MFlCxvHsseIVsjcWs0qgdeSkPCkfgWyy3/JqqQD0VHHFJkaV1ueBVHT21eCQBrH1LK159DvwfHWj4gjRaaARZmR/spKaEh59EEFC70eElBQ1PGy7gSe1R6Y/eDsSadzCloCn6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMJEENKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AF0C4CEC5;
	Mon,  9 Sep 2024 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897272;
	bh=2oJxDDyBiy9iu1Fd+wPaafH6mWwC5OBCMSIBpxg9bKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMJEENKns2UTyuqVXJKhiHEcI8zZmFqpOzl5Wsv+JoJmyjO6AR6rsZMB/3MmRzXK0
	 aUpqyZg1gG0ED1l1GZObrmSkwRvnvH27fiMb4kLHTMqK1y5oQgBGj7kjF8cCuRMZ9e
	 MnagOiPi99eTS4BoZeLnSjJawxJgbv8WaQUcomy5sPQWzHI5jLqIxM6EXBSFPHKn88
	 KASlm27bDVCVacCEOGS0DmuZv/oLot8oOHlF5Af4HQx9kIrtnHGLzeFKFyigatDH01
	 lY8RYwYB8OupwZfHPzwsc+Pe9+teXQR0GHhCdU/BIsfjZ/XBETJpau/u9lq6yM0J8C
	 SNIfkHAXt4XRg==
Date: Mon, 9 Sep 2024 10:54:31 -0500
From: Rob Herring <robh@kernel.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@quicinc.com,
	quic_psodagud@quicinc.com
Subject: Re: [PATCH v3] dt-bindings: arm: GIC: add ESPI and EPPI specifiers
Message-ID: <20240909155431.GA207498-robh@kernel.org>
References: <20240908010205.863701-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908010205.863701-1-quic_nkela@quicinc.com>

On Sat, Sep 07, 2024 at 06:02:05PM -0700, Nikunj Kela wrote:
> Add interrupt specifier for extended SPI and extended PPI interrupts.

Are extended SPI and PPI a GIC defined thing? What version of GIC?

Yes, I think I already asked these questions, but I only remember what 
you put into the commit message.

> 
> Qualcomm SA8255p platform uses extended SPI for SCMI 'a2p' doorbells.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
> 
> Changes in v3:
> 	- Removed the patch from original series[1]
> 
> Changes in v2:
> 	- Modified subject line and description
> 	- Added EPPI macro
> 
> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> ---
>  include/dt-bindings/interrupt-controller/arm-gic.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/dt-bindings/interrupt-controller/arm-gic.h
> index 35b6f69b7db6..887f53363e8a 100644
> --- a/include/dt-bindings/interrupt-controller/arm-gic.h
> +++ b/include/dt-bindings/interrupt-controller/arm-gic.h
> @@ -12,6 +12,8 @@
>  
>  #define GIC_SPI 0
>  #define GIC_PPI 1
> +#define GIC_ESPI 2
> +#define GIC_EPPI 3
>  
>  /*
>   * Interrupt specifier cell 2.
> -- 
> 2.34.1
> 

