Return-Path: <linux-kernel+bounces-333758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8597CD7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A44728423C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03F81E;
	Thu, 19 Sep 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTRxMoUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499418C3B;
	Thu, 19 Sep 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726769916; cv=none; b=T9DVGRsrxhOFiQpaE124yTYZTMH2K7r+C/k2EjD3lJNncU+66XFbJ3EpWkTJiO5YSIe/vFOSB56DkWTc0rXXlnDHXfRs7nJHa5f9nTnuFEYBVVN9uUHEwV6aCasXXtcoGgY5VAPRjd0wjLGXk24VYpeRZlMOdIAfr1kF2+miE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726769916; c=relaxed/simple;
	bh=v3rpimedUNi4pi47RIlHL/6lU7cCNgoVze+n/fIKNLQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=O9jF/Qu76sIx43TFp3qqSqn2wgFq8KiUyuxCxvx3PzCZERdpaEeVc7Tbf8CSoTI47p6hbcT6jCKy4NscQEmobEUb2CqUzl5OhtFy3dlVjiUV1BZUKuF9Psv6MGKHGeN7gc8G8tWK7x2DnGgoPev8tzi2fpPhBR+f9FKQxx+htSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTRxMoUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C5BC4CEC4;
	Thu, 19 Sep 2024 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726769915;
	bh=v3rpimedUNi4pi47RIlHL/6lU7cCNgoVze+n/fIKNLQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NTRxMoUHtPCO8/v2+r07fYTT4+EW9CFPoskxQbJ0v6xLonlt8dfFbZrsP8t0r2wbt
	 ckofs47WbK3KlTOWXBznMbpkfAH8UPjrQ/8ciDLG10ZRFUed2IHdXf2KElnKkAL0Ej
	 2Q7p0O7J1MaDW9GPJGK2tNWi03Za2H8M2PBeT5rmGbeUN14U8hEFpjAO4wZ9AYrj9E
	 UWuXjxXEV71mCaF6bTyK53hs7hGCv5CqUeUrdoKFP2iLzH0Pluv2wMF/9HK6fgRyXG
	 HULlj2/GtnQmKZRmx4tVhUsMVvqcyN2rY8hyVk1RzJfW/HwBzrTPFb0iP5WLIk/aKt
	 QIwAslHOib2tg==
Date: Thu, 19 Sep 2024 13:18:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fabien Parent <fparent@baylibre.com>, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240919094212.1902073-1-treapking@chromium.org>
References: <20240919094212.1902073-1-treapking@chromium.org>
Message-Id: <172676985046.765320.3471835988677145017.robh@kernel.org>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183-pumpkin: add HDMI
 support


On Thu, 19 Sep 2024 17:41:49 +0800, Pin-yen Lin wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
> provided by an IT66121 DPI <-> HDMI bridge.
> 
> Enable the DPI and add the node for the IT66121 bridge.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Co-developed-by: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Update commit message and fix formatting issues
> - Fix the label name of vcn33 regulator
> 
>  .../boot/dts/mediatek/mt8183-pumpkin.dts      | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y mediatek/mt8183-pumpkin.dtb' for 20240919094212.1902073-1-treapking@chromium.org:

arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: dpi@14015000: power-domains: False schema does not allow [[76, 7]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#






