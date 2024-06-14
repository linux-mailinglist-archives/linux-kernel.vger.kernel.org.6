Return-Path: <linux-kernel+bounces-214701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6C9088CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A18291554
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AB192B96;
	Fri, 14 Jun 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRrl2UYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEF192B95;
	Fri, 14 Jun 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358823; cv=none; b=PiaEKpT1fS6Ap5/SpgbL1Ta3GHYTPT4DEwop/3apP0X0C2tA7I8KjpK0h4SvjROJdOEhOQ3ETne+vFiYK1EeWzGg3eyg+cLvxPD3NYbflFIlc8YvKAzLfVAkS2C5VbMsHUTsgdEXDa7gxmNBf7waORNTcHCR+RPNgTPCsKOQxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358823; c=relaxed/simple;
	bh=KP5sU71Ub4NDd6MuTjj+FSw1EBvUDTPavNerMRFz/Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pem/E/6vRfpzt1FitQtoKRbUzA3ScdTt7OObFb6hruePSgMy1aWloCC6ruNSAdxTBJ1FmwlI5TO1no30/CLh13Zvot2+slObDSQLBhUvLWmD36y3lczNMaWZR1C9tG15Jl1i/qyC7kOvB3DapDDG7Mw9/JMx3ICs+v+zhZotl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRrl2UYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D905DC2BD10;
	Fri, 14 Jun 2024 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718358822;
	bh=KP5sU71Ub4NDd6MuTjj+FSw1EBvUDTPavNerMRFz/Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRrl2UYttCSTe2uk0ZqPbqa0kNvQSztuPbEPwu0E2UZAHNMclFACcb8jjrhMdbeys
	 lAjrn/bXHp+dIG4Mb8dDHb/wF0t+QM/pBacPCNzb+PMBQbh7SvV05v4QYH2Yzi3NRe
	 3bTmh5LMe4So4YzG/bsuvW6X9jxtxK9120gyCm9BJToRfXdz5rlQYV0u7WxsQL6kVe
	 K0r6l5oBbRoX1ztPJt7E+nH5gLe6x9SEBx2uPYg//7Pyk8DrosSE5cs+3cpIRh9FKQ
	 R067cW0Ja7ZFJXedB+xl7JukUmYMVaDSZX/1409ZhhoYBALKov/qzGXzVY2+9G31p0
	 RTbs/KYPAFyzQ==
Message-ID: <d4c33ee4-1e91-40e5-90c8-bd793bcf34ff@kernel.org>
Date: Fri, 14 Jun 2024 12:53:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] arm64: dts: ti: k3-j722s: Move MAIN domain
 overrides to k3-j722s-main.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
 <20240612132409.2477888-6-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240612132409.2477888-6-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 12/06/2024 16:24, Siddharth Vadapalli wrote:
> Since the MAIN domain peripherals specific to J722S SoC are present in the
> "k3-j722s-main.dtsi" file, move the overrides for the MAIN domain from the
> "k3-j722s.dtsi" file to the "k3-j722s-main.dtsi" file.

Overrides is kind of a misnomer here. It looks like these are J722S specific
changes.

> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> This patch has been newly introduced in this series and doesn't have a
> Changelog.
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 11 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi      | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 84378fc839d6..b75dab8230c2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -38,3 +38,14 @@ usb1: usb@31200000{
>  		};
>  	};
>  };
> +
> +/* MAIN domain overrides */
> +
> +&inta_main_dmss {
> +	ti,interrupt-ranges = <7 71 21>;
> +};
> +
> +&oc_sram {
> +	reg = <0x00 0x70000000 0x00 0x40000>;
> +	ranges = <0x00 0x00 0x70000000 0x40000>;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index 1bcbc9152ff0..14c6c6a332ef 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -232,14 +232,3 @@ cbass_wakeup: bus@b00000 {
>  
>  /* Include J722S specific peripherals */
>  #include "k3-j722s-main.dtsi"
> -
> -/* Main domain overrides */
> -
> -&inta_main_dmss {
> -	ti,interrupt-ranges = <7 71 21>;
> -};
> -
> -&oc_sram {
> -	reg = <0x00 0x70000000 0x00 0x40000>;
> -	ranges = <0x00 0x00 0x70000000 0x40000>;
> -};
These are originally set in k3-am62p-j722s-common-main.dtsi
which cannot be as they are not common to both SoCs.

Should we be moving the AM62 specific portion into k3-am62p-main.dtsi.

So they are no longer overrides but SoC specific changes?

-- 
cheers,
-roger

