Return-Path: <linux-kernel+bounces-328366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DE97827B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F61C21377
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC6E567;
	Fri, 13 Sep 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjFjKh39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5DBE68;
	Fri, 13 Sep 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237466; cv=none; b=iQDxH1wlc9lLQdaKgB62rbbN4p/6izCwXiWPAymMCRmgM1KEj5s6V8PKsvOtGJrOnPnzciY/rLAe/KDZK0S9Z8vNMvE2dDfLKObzi3Iv/OlClvzY6eeDfJjns+4TVs66hTZP0kVg1FXcuoYFRZ5QzIRW/tZezqqg6PesPi+SmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237466; c=relaxed/simple;
	bh=CQBAbFrO+Yye4O/yy6p6cNcUXg4T9wjsgQNnXsGVLcY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qrY1CPzFy5PbUvXzfUKncLAZPJsd78bXpJ3A70iA7hG+vwuVj8LKW29ubyHaWzqvg7XSBL/fZp9nogm4EH3CJTJ3Q+TyaflQFl32USgVFQ6FjhGuXan3wTpJtjvAS/DBMP3Dk2n0NRyl3qYog0uNfwEd4YqCjTjj+tYv55Cprfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjFjKh39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DCBC4CECF;
	Fri, 13 Sep 2024 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726237465;
	bh=CQBAbFrO+Yye4O/yy6p6cNcUXg4T9wjsgQNnXsGVLcY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MjFjKh39C4b+me5ss60BUz+OCYMJsr9TqjrAIpOx2UxJzxMCybH6XLqwsmxMtEyZW
	 Ez9PFNv4iCIiJOVCI+fusE/5AGCqA6RVYKXHifhyPVmZlMffPP3+IwtGIq+AW++a/T
	 rgHE2B3+ucH6bOMubG+5tOumZ1Hp6+zHpojqZLnxPWoWIopFePdB8i4k7N6XN9/KWZ
	 50FjQzq+5ucznY+rxTecaSQePN34zBuXYtTJ1vuQcRYNOTvYj/HmzwC85e8fEvSNeV
	 NXP/Y4B4spAeJ2y5rWnipnOJ8nyyQlxi2oRfc7g6rKMGUo9zDLTw92EFaOsHmpVHEf
	 RrBHYUCbbZ5JA==
Date: Fri, 13 Sep 2024 09:24:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240913104845.4112986-1-uwu@icenowy.me>
References: <20240913104845.4112986-1-uwu@icenowy.me>
Message-Id: <172623730520.4076253.7175037716930825765.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: document RerVision
 A33-Vstar board


On Fri, 13 Sep 2024 18:48:44 +0800, Icenowy Zheng wrote:
> RerVision A33-Vstar is an evaluation board of their A33-Core1 SoM.
> 
> Add its compatible (with the SoM compatible) to the sunxi board DT
> binding file.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
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


New warnings running 'make CHECK_DTBS=y allwinner/sun8i-a33-vstar.dtb' for 20240913104845.4112986-1-uwu@icenowy.me:

arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dtb: hub@1: '#address-cells', '#size-cells', 'ethernet@4' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#






