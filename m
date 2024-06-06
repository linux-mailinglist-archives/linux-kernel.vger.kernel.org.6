Return-Path: <linux-kernel+bounces-203461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CBF8FDB92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A86D2854AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745210A11;
	Thu,  6 Jun 2024 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAgjRwqr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F8FEEDB;
	Thu,  6 Jun 2024 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634404; cv=none; b=a6jrXVSgtuNqunSHlEc6UvNCnRPNHPoZIyGrtMyMV29+JRIRPpHLPHlgtOVBHFVlAGQW5nHuJO5fFeNvHakPUqMCn412qJVexN/BPmNnM1TUaiyj1UXKu42AR+PD89FjB8zBXfCV2/ZeWbFQuYiDvFtBy/52WkcUXcy1LZDph6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634404; c=relaxed/simple;
	bh=FR0+k6fv0YnpKmp2vH2K4VsZGW8MvdlAWv+l1JC7UJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/iH9x9s0mFtzBYb5pvsyPljEaX9jXvNFWHJB2d+UZjILA+u+Du1Y6aImuYkNOEjz29qof34bITKK1pUyjl8Tdhwj1GQ/wiTmkqyPvtlnGzJhMx1jnIjCrfAeodu2mQx6z+NbCrn5AKiGxI9mYWDkimpp4dykH9xbtnv/Zomc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAgjRwqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BC5C4AF09;
	Thu,  6 Jun 2024 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634403;
	bh=FR0+k6fv0YnpKmp2vH2K4VsZGW8MvdlAWv+l1JC7UJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAgjRwqrWzEPptUYHbBnsVG3lZp2/U/ycBwESN9sWpxiU2iSEw4E89NHXsoqOtlA0
	 5c0I4y2k/w4GXgzREX61XYl8HdgKnriPv52gNERkcVTPzbBfkGuszU9LkhGtP06ud9
	 iP+LY0vXlGVU6hc7eDYYkiIEW3UYqUQyFQkJAJc4vGXPXc6idT0sSsi2V23VfTCKrb
	 9FEc4uuYQH4ua/uLamse3syG02/I46EM+N4GX3Pu41tat377zNu9WCpVxeIwwbQjDw
	 PWW/yrR/Ihw7kqr+IaODXyfScRcHJifbhuoM4kYKmgyruuAjR5gKtFCFa2U6bczH96
	 runBA4Veoy+jQ==
Date: Wed, 5 Jun 2024 18:40:01 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc2: allow device sub-nodes
Message-ID: <20240606004001.GA3525173-robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-dwc2-subnodes-v1-1-915893e0cb20@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-dwc2-subnodes-v1-1-915893e0cb20@linaro.org>

On Wed, Jun 05, 2024 at 12:01:20PM +0200, Neil Armstrong wrote:
> Allow the '#address-cells', '#size-cells' and subnodes as defined in
> usb-hcd.yaml and used in the meson-gxbb-odroidc2 DT.

Doesn't referencing usb-hcd.yaml instead work? Or you need 
unevaluatedProperties?

> 
> The fixes the following:
> meson-gxbb-odroidc2.dtb: usb@c9100000: '#address-cells', '#size-cells', 'hub@1' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/usb/dwc2.yaml#
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 4f36a22aa6d7..9e737f587664 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -177,6 +177,13 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]{1,2}$": true
> +
>  dependencies:
>    port: [ usb-role-switch ]
>    role-switch-default-mode: [ usb-role-switch ]
> 
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240605-topic-amlogic-upstream-bindings-fixes-dwc2-subnodes-4a68ead79624
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

