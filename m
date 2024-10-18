Return-Path: <linux-kernel+bounces-371745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E629A3FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2EE1C23A08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F21D7E5C;
	Fri, 18 Oct 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es909GmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D020E335;
	Fri, 18 Oct 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258421; cv=none; b=i1mqcnC8sLAC9X2E89AXplmA5SOkOigD3p5CjXAQsIzyxMEiFZIWMzab9Y8TekyIFLa9wIv9ApZw1zVEI+1YHX6FvM/WdwO7Bp3yxfRR5AtGImYx4jXcB7Kn4QMpgV8dwhLRr4R80DomHc+GaDCA8K8qkHhLmZSuRRjbn4PFbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258421; c=relaxed/simple;
	bh=nwqVYg9FZxvkSWfFuD0XeXYk+OpqSn4JaMEIAODptlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amfEZASpmdolYqUzt6VxnSftm/SPq5ljh3hG0aJbRMzpl7CtJx1j82ZEsNwRysMGUW7pLHyTjMl0F6WxP0AzxS5+w5RFWIe189I7Kez+20pY9M++HsLkzZTNEEX0HxuDy4Unpwfn7kYBG3waSN4+9ufUCHygodUPybr3t8pMRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es909GmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F12C4CEC3;
	Fri, 18 Oct 2024 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258421;
	bh=nwqVYg9FZxvkSWfFuD0XeXYk+OpqSn4JaMEIAODptlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es909GmGYuFgkFVb/Bhn2p7pUJOjy8hzXCeT2nmEATrjU51VIMQ2FIuBmzgXTpi1Y
	 EW3qyiofuNHMypkZjLNNWlDpSEKOyB7tgaB4Hv19C+I+UPCJYMZ48l1Ji9P88Cpm4s
	 XJQtNgLOGhTh/8cQg/Tg5MY9dzkLJfH7cTUunoI+4H7oNKcR/RmyBhpnL5QODtxSKk
	 P62T1EUeXeD+Gno/lGEfnZRd+6kZUDW5AWf00+Vp1WZBXlFJrvlJ6xzoJw/SWhucBs
	 C6ipnLWfSEWZVW7p20yhJ+5suYN2VVtaYCoQ3ThDvso6c/9+XiJiKlDUiyVJmTHeQX
	 VXJqcGahFEgyw==
Date: Fri, 18 Oct 2024 08:33:40 -0500
From: Rob Herring <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: arm,scmi: Introduce more
 transport properties
Message-ID: <20241018133340.GA72220-robh@kernel.org>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
 <20241018080602.3952869-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018080602.3952869-4-cristian.marussi@arm.com>

On Fri, Oct 18, 2024 at 09:06:00AM +0100, Cristian Marussi wrote:
> Depending on specific hardware and firmware design choices, it may be
> possible for different platforms to end up having different requirements
> regarding the same transport characteristics.
> 
> Introduce max-msg-size and max-msg properties to describe such platform
> specific transport constraints, since they cannot be discovered otherwise.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 54d7d11bfed4..42852ed887f2 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -131,6 +131,22 @@ properties:
>        be a non-zero value if set.
>      minimum: 1
>  
> +  max-msg-size:

Vendor prefix needed.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      An optional value, expressed in bytes, representing the maximum size
> +      allowed for the payload of messages transmitted on this transport.
> +      If set it is recommended to be greater or equal than the minimum size
> +      required to support all the messages defined by the set of protocols
> +      implemented on this platform.

Sounds kind of broken if less than the minimum...

> +
> +  max-msg:

Vendor prefix and could be a bit more specific what this is.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      An optional value representing the maximum number of concurrent in-flight
> +      messages allowed by this transport. If set, the value should be non-zero.
> +    minimum: 1
> +
>    arm,smc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -- 
> 2.46.1
> 

