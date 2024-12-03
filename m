Return-Path: <linux-kernel+bounces-429153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135029E17F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E807161619
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66D1E0DB8;
	Tue,  3 Dec 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hgF7n+gm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F91E0095;
	Tue,  3 Dec 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218845; cv=none; b=GlCSczQfLwevkb3B21CDUjjrEvc3NqfL6rmstoqpIQQQC+tYhsYOvBmcHvVjiOROdnjVF9Uqsg/ybPgGjUk9nvLbNYthUowx6tEakyIDx15vHUVWpm0J9VDAgZVJJfkZVUmpjwIeavnDpGRRtugujz7NCOSZ0rZRAi6Ah4hXm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218845; c=relaxed/simple;
	bh=ZBxVO4lJb5ozsNn8cHJ9HgeI9RyIWRXMkh5uooawYu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EI8PMy35hOqwdgGAQ/n2JK8dvJfZXbF7RgBGIt4JpbT3678fU2EVxdWL9wjvdx/hMAv3ic22AbS64WzDOh7mBb/cC9FnxlwAWaPAMcZJXtr/z/x0EpMe8ELGLXJwlNRSv+EvWzUum7LiXldjoKOeDw+n9yvs7K5lcaQCjyhOHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hgF7n+gm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218835;
	bh=ZBxVO4lJb5ozsNn8cHJ9HgeI9RyIWRXMkh5uooawYu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgF7n+gmRDy5ZTjkqqntz2ewArwYn6UDghZIoiR7tVDSM/0gk81kP2rEDqjUQLLw0
	 DNSKtKw7LnIPnNjGnO2aJUWUMdzUNxwI0EFsqgwkSvMcxjXGuJE1Ps1ROfwYnr2TZB
	 mAD4UhI435wzv+AaH2q/1HLNku1nt5zYsrkxQR4CGPlycfkgvpZUEX51VonO1tq9p3
	 aS36c5dWVQuLwQe/pSjC4772z+LKP6FM54y+LI+Yp04Q7tm1wgxlAX7UqkhYrUq9+l
	 GwcBY6HXLgqbg94/PedrxUd6Z0v1HADuHT8RkGSWwfhW8lovDwjksTf0OS2NO8eKZb
	 qOUfc91wMsNzA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C44D17E35E9;
	Tue,  3 Dec 2024 10:40:35 +0100 (CET)
Message-ID: <a0137698-43d7-4cb6-a69c-98a5e90b13f8@collabora.com>
Date: Tue, 3 Dec 2024 10:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] arm64: dts: mediatek: mt7988: add pmic on bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-15-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-15-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

arm64: dts: mediatek: mt7988a-bpi-r4: Add MediaTek MT6682A/RT5190A PMIC

The BananaPi R4 board has a MediaTek MT8862A PMIC, a rebrand of the
Richtek RT5190A chip, connected to the I2C0 bus.

Add the relevant node and, while at it, also configure the regulators
from this PMIC that are used on this board.

> Bananapi R4 Board contains a MT6682A pmic which is compatible to rt5190a.
> Add its node to the i2 controller.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 51 +++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> index 13ca016d6a67..bc1ec73b8ddd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -2,6 +2,8 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
> +
>   #include "mt7988a.dtsi"
>   
>   / {
> @@ -65,6 +67,55 @@ &i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0_pins>;
>   	status = "okay";
> +
> +	rt5190a_64: rt5190a@64 {
> +		compatible = "richtek,rt5190a";
> +		reg = <0x64>;
> +		vin2-supply = <&rt5190_buck1>;
> +		vin3-supply = <&rt5190_buck1>;
> +		vin4-supply = <&rt5190_buck1>;
> +
> +		regulators {
> +			rt5190_buck1: buck1 {
> +				regulator-name = "rt5190a-buck1";
> +				regulator-min-microvolt = <5090000>;
> +				regulator-max-microvolt = <5090000>;
> +				regulator-allowed-modes =
> +				<RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;

Does it work like that?

regulator-allowed-modes = <RT5190A_OPMODE_AUTO>,
			  <RT5190A_OPMODE_FPWM>;

If yes, please write it like that - if not, I'm sad - but regardless

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


