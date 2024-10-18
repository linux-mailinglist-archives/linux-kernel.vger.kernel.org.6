Return-Path: <linux-kernel+bounces-371030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2A9A355E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A001F21682
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F815185B76;
	Fri, 18 Oct 2024 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo+Ri8yX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7B183CBB;
	Fri, 18 Oct 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232856; cv=none; b=lWSAm+b7xWa7+8bQ6Wb/+HlUhjUleq2OswucCbsK1xMPAW+xMdLMs/4Dx1m5kqdgJJClBEdBW2KcMzjVt4rsVkv8eyyUFoQZWc3cTDaKQ+SFKbxpIcYjFHRoF5IBoSTwKF9hWMYfa+Jnb+9UafjI5Ge4aSSBBa7yAaN+VdxUjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232856; c=relaxed/simple;
	bh=atv7BrdRaONTCagKXG9yPnrfvP+k64GtF/0tHBoRiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtk4z6pORgWTuf4mkFvP3quYZG01KPt5KhB/Xw+gW+vAlXgycvG1n4SvscT4CY9lrlQ0xaVkv9Z9Jepaau7T5UsGkBGifaPjjDhsDPoM6IQeXYb9imrdb/T9Jh9UMGSdadsY+IL5J8ZZcHz+i87VEJ76J4XHDGORgzTkQZumDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo+Ri8yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF0AC4CEC3;
	Fri, 18 Oct 2024 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729232856;
	bh=atv7BrdRaONTCagKXG9yPnrfvP+k64GtF/0tHBoRiwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xo+Ri8yXBdAaJL2c9J3nlgPFv6xiqdzm+8eMMMfL40UFF1jKFX0d8Wg+KhnS4nqlL
	 D/MJt9G3Id1Vft0nOKGdKiniMiY/maAj7CuY1Y9N6NRCdQckYcpB113Hl8Tc59KJ/q
	 UF7Ygoffd0b+4Xro/YNuBRs/DZspcmIrt/T+FMXVlAaWbNaIr5LMzVO5m7OHnBJewo
	 DOs5SuiAJxNXzK6liEPkVsc6+xep/nR3SKk352uP//E14j4jv0G2yzJh2oYGgeQV2G
	 ignecnwgNMy+/HqSLypTBGSVqFemuVKVQowU3gKvHn1gFpr2rbJl46GmxIM54SFXim
	 c7aN0lLAFcv+Q==
Date: Fri, 18 Oct 2024 08:27:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add
 snps,filter-se0-fsls-eop quirk
Message-ID: <gclvciv5cmrcut6qvo3kh3ycutqt5sot5k4i2nwics6myhuxvq@cf6ajwflxdlc>
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
 <20241017114055.13971-2-quic_uaggarwa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017114055.13971-2-quic_uaggarwa@quicinc.com>

On Thu, Oct 17, 2024 at 05:10:54PM +0530, Uttkarsh Aggarwal wrote:
> Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core to set
> GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch on the
> linestate during transmission. Only two or more SE0 is considered as
> valid EOP on FS/LS port. This bit is applicable only in FS in device mode
> and FS/LS mode of operation in host mode.

Why this is not device/compatible specific? Just like all other quirks
pushed last one year.

> 
> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 1cd0ca90127d..d9e813bbcd80 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -180,6 +180,12 @@ properties:
>      description: When set core will set Tx de-emphasis value
>      type: boolean
>  
> +  snps,filter-se0-fsls-eop-quirk:
> +    description:
> +      When set controller will ignore single SE0 glitch on the linestate during transmit

Does not look like wrapped according to coding style (checkpatch is not
a coding style document).

Best regards,
Krzysztof


