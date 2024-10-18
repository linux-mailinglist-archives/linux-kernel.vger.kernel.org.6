Return-Path: <linux-kernel+bounces-371284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD59A3938
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27697284F42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B1190075;
	Fri, 18 Oct 2024 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Ts3wArq0"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86919004D;
	Fri, 18 Oct 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241677; cv=none; b=rSTTh/bOXwjK0lOLOhTtCopEm5FNi9WvRFcq5edRl6Za0MFoIGDAVaelscN/XmZ0Z7hSyeqq6JZCbPTDWRe9ZMFba2wKPs7zcvC7741fLE/CRcp3U+atlVqAkjghpa7DFYRXKHz7K37lht2PssBLmZlzASs1V2/QWKH2DX4ODhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241677; c=relaxed/simple;
	bh=qb82Yg8Fdqnw+RY3rXjqZM1qgoHvmG5HaQaF2cDokIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4jUMosFtnKm/J4dzZ+h9OMxoha/CJk9jsv8AbyUXxDPkNvWcvBMIpzMpTl3WNaj4C8DhdgmHUr5aIlOS7Yl2pMAyMTHzKxnTyIUOsnt74RLhYPgVuh49ZfMmum7josDVTuzApAmXnrSEKCgt+nJiXhuhdTVRdc5H+lQW7IOBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Ts3wArq0; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2EAFB89051;
	Fri, 18 Oct 2024 10:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729241666;
	bh=5Qs0SWsGldehu14a5NIkehI/ZRU/ytjR1IveSQ6ZAvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ts3wArq0oZXP0gf5Lg/ZjP6dCpk4K+gOQqdi+E9L9cfl39vYdPq9CpHz29LrqeAYa
	 wf/Ru7+vNnAMby5uaBffoDfo8Tp06fch6gayZ+YLREfQBfKcLhy2XQUiQ+ThAgN2YJ
	 8w8fWtA1VUkXbGlzyacC/xUdkEVoUa7Ke6gq2jFpDm2O62Y3v1u9dSHdOP7NKO8k6W
	 eMKaDt0Kn3zWz92vkgjucQVuN4c0C9gONFd4dU5oYqbxu1S0GBLs8NkOenLzod5wzx
	 ALp+YeeHw49wP10oY5dfAtdTldB7bgsQOXkVwHAZukTpgKazWaeu0DMm4JNw5/bJdi
	 M73iqZrT/R1Nw==
Message-ID: <69cc9c59-99c0-479d-8143-63698cc56111@denx.de>
Date: Fri, 18 Oct 2024 10:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp-msc-sm2s-ep1: Add HDMI connector
To: Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 stefan@agner.ch, dmitry.baryshkov@linaro.org
References: <20241018064813.2750016-1-victor.liu@nxp.com>
 <20241018064813.2750016-4-victor.liu@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241018064813.2750016-4-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/18/24 8:48 AM, Liu Ying wrote:
> Add a HDMI connector to connect with i.MX8MP HDMI TX output.
> This is a preparation for making the i.MX8MP LCDIF driver use
> drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag.  With that flag, the DW HDMI bridge core driver would
> try to attach the next bridge which is the HDMI connector.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> index 83194ea7cb81..b776646a258a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -15,6 +15,17 @@ / {
>   		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>   		     "fsl,imx8mp";
>   
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
Shouldn't this also have a 'label' property ?

