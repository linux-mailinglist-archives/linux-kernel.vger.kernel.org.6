Return-Path: <linux-kernel+bounces-312286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A42969481
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9A1F21D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579C1D6C48;
	Tue,  3 Sep 2024 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoaO+Z6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C31D619F;
	Tue,  3 Sep 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346887; cv=none; b=HNGHiCccCL0xnw7+dlHkK3alYcsTawKabPTJVt7Ganvar4kRb0TfUEE6SBOGjIdYLmeW3wYXF+ve4psMl+dDuO8s8h/07j8XTwxzZhxMBD48z6wXmuJJJJcO+rt79NL7VXVtdzH2LpDCvRHf0OdhjdsAiaUEul9fMvu2R0Rnm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346887; c=relaxed/simple;
	bh=z4o4Vbhv2nQKqOwP2fyIKUZP8tr+sHTg/BrF44u8DKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMluYd2Z3Ymytn8zi8SwVLCrU2YWstByH9FWCZHHZj9KAepXsJWHN55sHD9NtsxuJVrgGUGsog2DeTVlSNKQ6cbRPlpiEAMKngnQ9ksmaZNXf0YhltKkrxIZqdWs678W4TSy2Z4oPgwWiAFo23d+a9Ckn9juqvW4gEG6IfNd5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoaO+Z6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D0BC4CEC5;
	Tue,  3 Sep 2024 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725346887;
	bh=z4o4Vbhv2nQKqOwP2fyIKUZP8tr+sHTg/BrF44u8DKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoaO+Z6XEsUt1RSb4jXJmrnpsZqWnnOGoBEwAyfjSe5wd5nlvZMwtqe0vaXXp2Ad+
	 towNRx0tVYDk2r9uukuvL/JhSsU6ERDuwcbga754ycInqnUBc0ZqtxJ5NaX/mvCW6l
	 oLh9OZFvIsNm3qz+bGUJNiIVKrj4NL5xQE7NsMeyy4Vs3qYd3AEo5kD29upz4Q785r
	 mFxaKi3fexoGn2lIXKjU0oKq+GHVXf4i4F5MxzYXgFCWdtHMwPXiq4fDn4eAAYdAme
	 rTMvMK/SOhO3YEl3Tm1Xgj9ZU9k7VWfHfbDZPdTcGJ/vfNQ2/pzcW3Q34zISuAa6O9
	 RFcYatw5z7s9g==
Date: Tue, 3 Sep 2024 09:01:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Add MT8186 Ponyta
 Chromebooks
Message-ID: <7x3ldly4ohwl6jgfdtgt2szybzicrftuvy6c5ah6sxovzsqfrc@snlk7mxfnxad>
References: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240903061603.3007289-3-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903061603.3007289-3-cengjianeng@huaqin.corp-partner.google.com>

On Tue, Sep 03, 2024 at 02:16:03PM +0800, Jianeng Ceng wrote:
> MT8186 ponyta, known as huaqin custom lable, is a
> MT8186 based laptop. It is based on the "corsola" design.
> It includes LTE, touchpad combinations.
> 
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>  .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
>  .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
>  .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
>  4 files changed, 97 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8fd7b2bb7a15..50b5cf04d3ae 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -58,6 +58,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-sku1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
> new file mode 100644
> index 000000000000..87e8368189d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-ponyta.dtsi"
> +
> +/ {
> +	model = "Google Ponyta sku0/unprovisioned board";
> +	compatible = "google,ponyta-sku0", "google,ponyta-sku2147483647",
> +		     "google,ponyta", "mediatek,mt8186";
> +};
> +
> +&i2c2 {
> +	touchpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
> new file mode 100644
> index 000000000000..203ee109bbf7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-ponyta.dtsi"
> +
> +/ {
> +	model = "Google Ponyta sku1 board";
> +	compatible = "google,ponyta-sku1", "google,ponyta", "mediatek,mt8186";
> +};
> +
> +&i2c2 {
> +	touchpad@15 {
> +		compatible = "elan,ekth3000";
> +		reg = <0x15>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;

Be consistent... Look at your other node.

> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> +

