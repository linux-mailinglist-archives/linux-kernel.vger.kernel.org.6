Return-Path: <linux-kernel+bounces-370942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E469A340A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C22280E23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CC175D25;
	Fri, 18 Oct 2024 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LooUSCfM"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A933987;
	Fri, 18 Oct 2024 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227767; cv=none; b=KD1fp6gzIlIA+dp9jrMUMMyLzGO4goMXtLZbktvIX/L4DCrh+wfEpRUmFHzIeYc/129plcLZEVIS26lh8bs6Nu6DxhVev5TGaB0YH054MG/cIOR++rBlhZSjVOwt2bs9e/cSzwjT3NPxSPxKNkNjyBDgDVRavArDD+JfqTOT4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227767; c=relaxed/simple;
	bh=qBt0DeGZ/e1q0jP7+M7lt+s7YlOFJDrpHI+vFiBdSeY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sgB7q6T9XLZCUV1AFVo8UWJlpDs7FX74yPwWeQ0PvBWhhniSnrObBKBkDPFnVHwQLkzY087akhywOP3ACojA2glGswOtijOY2Q0NiEnSO5piD37fnnFotZq7b90V+0gDpJ3vgQl11N+50c//8EuN5XiJT7hJDjtHkrilLBOHq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LooUSCfM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729227755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJWILMVfgDcAgwD1GXhEWso78YUpRlKwkxHJzQiuPHg=;
	b=LooUSCfMS20nW1+kMD16XatHnO5DWvpkihvGSKzw65oyL2CyPPIof843W9XPpwPc6guK0Y
	MJVoL6p6kAJymYGWUJvE3NshwhYKqtaT6IniG7w5qFbC627eYsAWEpK6lrXDbx4AY27+/5
	4ucxA18bkmzHrs83tx2W/PGHyYRXIOr6Tuxq3rIwwDhFdBojavci/sZoxaCYwogTu7fBW7
	0U4EPWYJl6OdL0Gtz7QuNwqHEnK8Jg73bvk3ItYl7f8Pfea4JJO+33lhKf2qz6mHDxQF4B
	ABYWSsWw3+54Y5eb+NkcVfVBxiBjPO9YDjQwCCgocyHljBb4jK2sWMyIbD0Kqg==
Date: Fri, 18 Oct 2024 07:02:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, Frank Wang
 <frank.wang@rock-chips.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf
 syscon
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Message-ID: <ca0ee8752791f53bac23933e1582dd86@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

On 2024-10-17 04:52, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
> configured in usbdp phy driver.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v2:
>  - This is a new patch adds rk3576-vo1-grf syscon.

Could you, please, clarify a bit why is this additional patch
needed in this series?

> v1:
>  - none
> 
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 50d727f4b76c6..fd42217ab85e7 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -33,6 +33,7 @@ properties:
>                - rockchip,rk3576-usb-grf
>                - rockchip,rk3576-usbdpphy-grf
>                - rockchip,rk3576-vo0-grf
> +              - rockchip,rk3576-vo1-grf
>                - rockchip,rk3576-vop-grf
>                - rockchip,rk3588-bigcore0-grf
>                - rockchip,rk3588-bigcore1-grf
> @@ -283,6 +284,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - rockchip,rk3576-vo1-grf
>                - rockchip,rk3588-vo-grf
>                - rockchip,rk3588-vo0-grf
>                - rockchip,rk3588-vo1-grf

