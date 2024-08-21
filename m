Return-Path: <linux-kernel+bounces-294751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED6959210
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28260282DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D61E504;
	Wed, 21 Aug 2024 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Su3KwTWi"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1A2B9AF;
	Wed, 21 Aug 2024 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202620; cv=none; b=WyYp8rIqO/ct9qRm41RUFISYxtKcB7ELQAykY2xwkNu5QkN+Vk2iBJMt5PaCJ6qO0+fw5lgyVbI2OlvgjDNMwFeKGcaWi/d1rZDgOFzmNRwlCFI3HibKuU0svKMQfSsBOtrK0bZZOT63R57UlSkcqSyAChlI3NgDOMrocFWu3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202620; c=relaxed/simple;
	bh=5FFAFoi/w1JxY7gzZZ3F2zSRsQZSDvg5tC+q9ck2FWU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toCBeB/bof1tN+VjjpKAbMIk//HX1SH6W2uMcd07Jm1NPOg77/TRTk6zTV9SSjJU8FBWMI/sR4H2+UEuX70LsfFTWT6khFSVmvbDhZjgaLTuTRoStF1ewu8ZaZurvqBjWMQ4zA0YXy9KCA4V6kuUhmDz/wEkBymFtfR7QW3/t94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Su3KwTWi; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724202609;
	bh=k2UhMuq9AgfXwSrjsV/wSrCsHwkjK+ktJnm72iPp9Z0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Su3KwTWi9rBdTnvNA9jisdV652D3jy5sfW+7SNmyrK8jcvNPV8YpQoBreCgwp6dBC
	 swJxgLOk3iYgsNoWJN5hjIKVtKxuj+Nv6/r5MsSGJDpplTVrzMJ0tu7NiSs+ABWQY+
	 H0qmi7Q2wSrOxa9bIIQFeaoCiXr0DSm1Zg77OgZ1lQRMSLO3cqwiNGxRrDVswejPxx
	 uZPhvjPK2fMOilxvfPc4KerkVGdU4HyhazgcgiELkGRUvrFMHmsyX5999q21RTxdbF
	 E8QdrDStMFKCN/m4sZpipNOr99ICNltocyyuUGcQ/2uxRQDrkZPEwFe7lFuZuGzhEm
	 kjXlamWEyY78Q==
Received: from [192.168.68.112] (ppp118-210-185-99.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.99])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2837864B84;
	Wed, 21 Aug 2024 09:10:07 +0800 (AWST)
Message-ID: <4e49f0c3a0ec4f1e508cae289f82ddbd02f9c0a6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/2] ARM: dts: aspeed: Harma: update sgpio line name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2024 10:40:06 +0930
In-Reply-To: <20240820102904.1756785-3-peteryin.openbmc@gmail.com>
References: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
	 <20240820102904.1756785-3-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Tue, 2024-08-20 at 18:29 +0800, Peter Yin wrote:
> From: Peter Yin <peter.yin@quantatw.com>
>=20
> power-card-enable
> uart-switch-button
> power-fault-n
> asic0-card-type-detection0-n
> asic0-card-type-detection1-n
> asic0-card-type-detection2-n
> uart-switch-lsb
> uart-switch-msb
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Can you please your author email consistent with your Signed-off-by
email? Currently this generates a checkpatch warning:

   Executing: ./scripts/checkpatch.pl --strict -g HEAD
   WARNING: From:/Signed-off-by: email address mismatch: 'From: Peter Yin <=
peter.yin@quantatw.com>' !=3D 'Signed-off-by: Peter Yin <peteryin.openbmc@g=
mail.com>'
  =20
Thanks,

Andrew

> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts   | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index 92068c65eae4..9db95a791128 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -566,7 +566,7 @@ &gpio0 {
>  	/*B0-B7*/	"","","","",
>  			"bmc-spi-mux-select-0","led-identify","","",
>  	/*C0-C7*/	"reset-cause-platrst","","","","",
> -			"cpu0-err-alert","","",
> +			"cpu0-err-alert","power-card-enable","",
>  	/*D0-D7*/	"","","sol-uart-select","","","","","",
>  	/*E0-E7*/	"","","","","","","","",
>  	/*F0-F7*/	"","","","","","","","",
> @@ -585,7 +585,9 @@ &gpio0 {
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
> @@ -685,7 +687,7 @@ &sgpiom0 {
>  	"FM_BOARD_REV_ID2","",
>  	"FM_BOARD_REV_ID1","",
>  	/*H0-H3 line 112-119*/
> -	"FM_BOARD_REV_ID0","",
> +	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
>  	"","","","","","",
>  	/*H4-H7 line 120-127*/
>  	"","",
> @@ -716,9 +718,15 @@ &sgpiom0 {
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


