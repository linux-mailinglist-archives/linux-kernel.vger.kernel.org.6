Return-Path: <linux-kernel+bounces-325871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FA975F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D228B22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AA126C19;
	Thu, 12 Sep 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ilUpuQ+B"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85846126BE3;
	Thu, 12 Sep 2024 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109625; cv=none; b=VNQYYtNH0NBDOMYqjzutxwHEoodgCwl4PMvyIxUG3jp+kTPPvgvHiyD/obfd+oL6avGDHYoGhrrsSIKPvrkbgwjqHmscijKODRSJcoTckK9lh2p9W47ps+DQUMP+Wc/YBSHC1P4i8aEiXpRECUatcNmp71ZcbT7Y11ylc2Tp1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109625; c=relaxed/simple;
	bh=WnVGALMfYAfkhn1Js5rmU0pWrT9KA6F/yYAZk9iVwIc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMpCu3UxqY2qgzjnavzVmO+UFjfTJeLOs9hLXer7Acdc7Hx3ELZApkFxxytpo6Nhqa12Uz07/9bJMf9gg+B8uoTkQ5avFlcWWHr6c90rFW5SlQfMFbYS8/d+EF2B+1OSQ0YoSZJ2NvZ8i0wOvLooWSsFh0QOgHXzE3+JiKIe8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ilUpuQ+B; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726109621;
	bh=yn+wZNBElEbo6z6rUQ2iwm+eHVU5SkpgkGRmFBHXQcM=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ilUpuQ+BG4JQkm0ACs1v0T8cQFZBf8biCQCHBV9Jn7knEyQxdWd0LmQgrsAmSBw6o
	 VliAn36FHdSeEZmEnADy+XEPbWz+VM3csvcecFsiQW6xW7fxREpQjDjiJRIDxTyTvF
	 RpwRy70gazvGGFpPZrGjFMyuTsSeP3i7rkeM4DgDoK8/EB4szIE3AM8uwWuP5/w7Jg
	 rgXTljqDMFYwesL/d29Ca60cLlXpF7g84YJv8zRjLG71aMG7KP6VFDtWHmsB+ZGYer
	 k7zfkdyXZJcnylPpOzCWrlGTAqzHx0lTgtX1k+inZTXjC6iB40UllEuFveEddIM5j0
	 dwDy2VeMgu8HQ==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 236B3650D6;
	Thu, 12 Sep 2024 10:53:39 +0800 (AWST)
Message-ID: <908b7765584f96299c720c0d8312839a520a0e48.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Harma: revise sgpio line name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 12:23:38 +0930
In-Reply-To: <20240909080459.3457853-3-peteryin.openbmc@gmail.com>
References: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
	 <20240909080459.3457853-3-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 16:04 +0800, Peter Yin wrote:
> power-card-enable
> power-fault-n
> power-hsc-good
> power-chassis-good
>=20
> asic0-card-type-detection0-n
> asic0-card-type-detection1-n
> asic0-card-type-detection2-n
> presence-cmm
>=20
> uart-switch-button
> uart-switch-lsb
> uart-switch-msb
>=20
> reset-control-cmos-clear

Can you please try to be more descriptive in the future? However, for
now, I've applied the series to be picked up through the BMC tree.

Andrew

>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 36 +++++++++----------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index 92068c65eae4..9cb511a846e3 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -393,12 +393,6 @@ gpio@31 {
>  		reg =3D <0x31>;
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> -
> -		gpio-line-names =3D
> -		"","","","",
> -		"","","presence-cmm","",
> -		"","","","",
> -		"","","","";
>  	};
> =20
>  	// PTTV FRU
> @@ -422,12 +416,6 @@ gpio@31 {
>  		reg =3D <0x31>;
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> -
> -		gpio-line-names =3D
> -		"","","","",
> -		"","","presence-cmm","",
> -		"","","","",
> -		"","","","";
>  	};
> =20
>  	// Aegis FRU
> @@ -566,7 +554,7 @@ &gpio0 {
>  	/*B0-B7*/	"","","","",
>  			"bmc-spi-mux-select-0","led-identify","","",
>  	/*C0-C7*/	"reset-cause-platrst","","","","",
> -			"cpu0-err-alert","","",
> +			"power-hsc-good","power-chassis-good","",
>  	/*D0-D7*/	"","","sol-uart-select","","","","","",
>  	/*E0-E7*/	"","","","","","","","",
>  	/*F0-F7*/	"","","","","","","","",
> @@ -585,14 +573,16 @@ &gpio0 {
>  	/*O0-O7*/	"","","","","","","","",
>  	/*P0-P7*/	"power-button","power-host-control",
>  			"reset-button","","led-power","","","",
> -	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
> +	/*Q0-Q7*/
> +			"","","","",
> +			"","power-chassis-control","","uart-switch-button",
>  	/*R0-R7*/	"","","","","","","","",
>  	/*S0-S7*/	"","","","","","","","",
>  	/*T0-T7*/	"","","","","","","","",
>  	/*U0-U7*/	"","","","","","","led-identify-gate","",
>  	/*V0-V7*/	"","","","",
>  			"rtc-battery-voltage-read-enable","",
> -			"power-chassis-good","",
> +			"","",
>  	/*W0-W7*/	"","","","","","","","",
>  	/*X0-X7*/	"","","","","","","","",
>  	/*Y0-Y7*/	"","","","","","","","",
> @@ -673,7 +663,7 @@ &sgpiom0 {
>  	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
>  	"presence-asic-modules-1","bios-debug-msg-disable",
>  	"","uart-control-buffer-select",
> -	"","ac-control-n",
> +	"presence-cmm","ac-control-n",
>  	/*G0-G3 line 96-103*/
>  	"FM_CPU_CORETYPE2","",
>  	"FM_CPU_CORETYPE1","",
> @@ -685,7 +675,7 @@ &sgpiom0 {
>  	"FM_BOARD_REV_ID2","",
>  	"FM_BOARD_REV_ID1","",
>  	/*H0-H3 line 112-119*/
> -	"FM_BOARD_REV_ID0","",
> +	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
>  	"","","","","","",
>  	/*H4-H7 line 120-127*/
>  	"","",
> @@ -700,7 +690,7 @@ &sgpiom0 {
>  	/*I4-I7 line 136-143*/
>  	"","","","","","","","",
>  	/*J0-J3 line 144-151*/
> -	"","","","","","","","",
> +	"","","power-card-enable","","","","","",
>  	/*J4-J7 line 152-159*/
>  	"SLOT_ID_BCB_0","",
>  	"SLOT_ID_BCB_1","",
> @@ -716,9 +706,15 @@ &sgpiom0 {
>  	"cpu0-thermtrip-alert","",
>  	"reset-cause-pcie","",
>  	/*L4-L7 line 184-191*/
> -	"pvdd11-ocp-alert","","","","","","","",
> +	"pvdd11-ocp-alert","",
> +	"power-fault-n","",
> +	"asic0-card-type-detection0-n","",
> +	"asic0-card-type-detection1-n","",
>  	/*M0-M3 line 192-199*/
> -	"","","","","","","","",
> +	"asic0-card-type-detection2-n","",
> +	"uart-switch-lsb","",
> +	"uart-switch-msb","",
> +	"","",
>  	/*M4-M7 line 200-207*/
>  	"","","","","","","","",
>  	/*N0-N3 line 208-215*/


