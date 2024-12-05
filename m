Return-Path: <linux-kernel+bounces-432778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA99E503A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89EC1881DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20B1D5141;
	Thu,  5 Dec 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0ZtQ6DJE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991C1C2323;
	Thu,  5 Dec 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388513; cv=none; b=k3eeQw4EMqM87IqdaU+pCzI4QiUOTnxyxfGz3gocNF93TPinFZUvcYB7m8u0ckKvS+x5h/37HpGVetk9ffwuj6yI6O3qH49HfaaRgL55iBAJIHx/QlUkO9kz6ahPrcaIcI+unJDPDmGyXUzGJaEPi1yqV5ZzSoY7heL/RuO+qaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388513; c=relaxed/simple;
	bh=AUn8/aAHyVbsysI5oIbofwlY0V0h1c3DllvJCGQWvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0j6dBFFHMlqGez56qmnW6yUVQvVDirZCVMChxuBxq+NjGNEmv3/J9Wb0AUVE5M0Cxt0+1c4dbXoJWOFs9AdGcMc9pN3rc0COCpJs2U9+jfD5E8AUsunTxcRm+quEov4McqW4fSWeYwe1OXJMC7YPhAICalLiX15c+nCZ24krt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0ZtQ6DJE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vkoVyy6uCpLzlhwSnm1vHxEsbOQ+nXvkDsqoKqIAe5Q=; b=0ZtQ6DJEFHGEmBh1Tww482lN82
	Vej40ed98V17Tt6bWDap4Tpmedv9HxkoQiHuimmhMGDGmNn/+fK0cqEL2k1vz9Jv819Jrs6Z7Lva0
	7G4cw2t76SRONtp8KTTDxO9Aoce8kvvAcUq4SzOHNEr3rx4ZvP3pFPsQTixTivhmNnE47qVWSD0NM
	twujlr47srFp0AI9EPCQl48iZF4+bnCqslssmnvlvbEfI+NYRtMyokpPV4Z6cTdRWsGOBIYAt8vf/
	P9mYZjdcHuJbsLLd9iezUv+i2D7tCE4yHAqhOEqDxzaJtaPk3iqKnmgwa2Rp0fPO9FiymiVHbgMMA
	TU2AdtIg==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJ7Wz-0001jK-VE; Thu, 05 Dec 2024 09:48:17 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Val Packett <val@packett.cool>
Cc: Val Packett <val@packett.cool>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: add clock ID for CIF0/1 on RK3066
Date: Thu, 05 Dec 2024 09:48:17 +0100
Message-ID: <5336726.6fTUFtlzNn@diego>
In-Reply-To: <20241205055122.11613-1-val@packett.cool>
References: <20241205055122.11613-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Val,

Am Donnerstag, 5. Dezember 2024, 06:50:46 CET schrieb Val Packett:
> RK3066 does have two "CIF" video capture interface blocks, add their
> corresponding clock IDs so that they could be used.
> 
> Signed-off-by: Val Packett <val@packett.cool>

please split this into two patches
- addition of the clock-ids to the dt-binding header
- setting the clock-ids in the clock driver

Thanks
Heiko

> ---
>  drivers/clk/rockchip/clk-rk3188.c             | 4 ++--
>  include/dt-bindings/clock/rk3188-cru-common.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index 684233e72105..81e94b338d0f 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -344,7 +344,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
>  
>  	GATE(0, "pclkin_cif0", "ext_cif0", 0,
>  			RK2928_CLKGATE_CON(3), 3, GFLAGS),
> -	INVERTER(0, "pclk_cif0", "pclkin_cif0",
> +	INVERTER(PCLK_CIF0, "pclk_cif0", "pclkin_cif0",
>  			RK2928_CLKSEL_CON(30), 8, IFLAGS),
>  
>  	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
> @@ -602,7 +602,7 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
>  
>  	GATE(0, "pclkin_cif1", "ext_cif1", 0,
>  			RK2928_CLKGATE_CON(3), 4, GFLAGS),
> -	INVERTER(0, "pclk_cif1", "pclkin_cif1",
> +	INVERTER(PCLK_CIF1, "pclk_cif1", "pclkin_cif1",
>  			RK2928_CLKSEL_CON(30), 12, IFLAGS),
>  
>  	COMPOSITE(0, "aclk_gpu_src", mux_pll_src_cpll_gpll_p, 0,
> diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
> index 01e14ab252a7..dd988cc9d582 100644
> --- a/include/dt-bindings/clock/rk3188-cru-common.h
> +++ b/include/dt-bindings/clock/rk3188-cru-common.h
> @@ -103,6 +103,8 @@
>  #define PCLK_PERI		351
>  #define PCLK_DDRUPCTL		352
>  #define PCLK_PUBL		353
> +#define PCLK_CIF0		354
> +#define PCLK_CIF1		355
>  
>  /* hclk gates */
>  #define HCLK_SDMMC		448
> 





