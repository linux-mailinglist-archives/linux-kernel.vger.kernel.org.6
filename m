Return-Path: <linux-kernel+bounces-325490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F13975A50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1D228331E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C761B532F;
	Wed, 11 Sep 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="dUm2ZynB"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75861B3728
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079059; cv=none; b=Y82cu/0KlzLV0i8XpiBRuABA1dpxwgpnCF/WaiaqqZWblUss1H+6cmaHZmtnrx6SSFhN5QwDK8go+P8l0HjWNpOc2d/tLorOhl8sbBxZaErDAP2gZCGks3W6luVlcAqRovf96Kw2JmqxvU2RPlMmo0Ncaw7i3F1GVkVTbiozrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079059; c=relaxed/simple;
	bh=c8/o7QGHnJj9aGy19pcKp3H/cB0bXEOs+2Nb541rJVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkFklGZW3KTbtfchcUMvzyzxS1XCaPBWPAJQ3N4Np+OjDzrc32nkTr1D86a8bo+jmY8l2Z4xnFcHqviTlSU9i3LjPGF07QY2uBezxWkPHzirKci2U+Nt4uJDZ5+9g0wrLSkewyn3u9V2heKrG0IaE68yqALpvJUdxNWQcWIiFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=dUm2ZynB; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 608D8BFB13;
	Wed, 11 Sep 2024 20:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1726079047; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bd5kfu1lfYDdnGDwmz0B1LTYsoKWQmAbDw3iHaIKZAc=;
	b=dUm2ZynB4YIQRe0wOsBcUyNLb2QXBygt9N78hy1j09mBf8jDVH8PHq2losnvTYKEJi6LMD
	v2gu/BI1fNfRiHfvWnZ34XXqqP2OFUyRshdijqnXgnWywF0dJaLIB6bOPBoNDieorlAgG2
	WEZUi2NjlPwb1nCOLgrZBzH4VYp8L8U60r4WQxBCvmqyI30J60/LBumVDd983egRzAiCea
	U7NO7tT3zShjl+171kgJRKfdjkqn/94HDF1ShKUGDtTAghkdAdJnpopI2oxW+Gzh7WfAct
	AOtlhc2yRLVcweO0NdyyIX+8fQG+Ln29VNv30B2OYFNByJ8l1JS5uDLGUtonqg==
Message-ID: <074fc86c-6e6e-4dbc-857a-21e9abf965ac@fris.de>
Date: Wed, 11 Sep 2024 20:24:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240910181544.214797-1-frieder@fris.de>
 <ZuDjAwPxHeJTvXAp@atmark-techno.com>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
In-Reply-To: <ZuDjAwPxHeJTvXAp@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11.09.24 02:23, Dominique Martinet wrote:
> Frieder Schrempf wrote on Tue, Sep 10, 2024 at 08:14:51PM +0200:
>> [2] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator/src/branch/main/pll.py
> 
> Great work! Thanks!
> 
> I was curious about the existing table entries, recomputing existing
> values doesn't yield the same values. For example, the first entry is
> {
>          .pixclk = 22250000,
>          .pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
> }
> but computing it yields
> {
>      .pixclk = 22250000,
>      .pll_div_regs = { 0xd1, 0x4a, 0xf0, 0xef, 0x10, 0x81, 0x40 },
> }
> 
> I assume there just are multiple ways to generate the same frequencies,
> which is fine in itself, but it'd be great to be able to "back-compute"
> the entries as a sanity check.
> 
> I've played a bit with your script and spent more time on it than I'd
> like to admit, but something like this seems to do the trick, plugging
> in the regs from the kernel:

Thanks for the feedback and the additional code. Yes, the script yields 
different results for the existing table entries.

For the reverse operation I used the spreadsheet (pll.ods, also in the 
repo). Actually I wrote that before the Python code and used it for 
verification.

> 
> ---
> pll = FractionalNPLL(freq_ref)
> 
> regs = [0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40]
> # assume fractional
> if not regs[0] & 0xD0:
>      print("reg[0] missing 0xD0")
>      sys.exit(1)
> pll.freq_frac = True
> pll.params["p"] = regs[0] & 0x2f
> pll.params["m"] = regs[1]
> pll.params["s"] = (regs[2] >> 4) + 1
> pll.params["n2"] = ((regs[2] >> 3) & 0x1) + 1
> pll.params["n"] = (regs[2] & 0x7) + 4
> pll.params["lc"] = regs[3] & 0x7f
> if regs[4] & 0x80:
>      pll.params["lc"] = - pll.params["lc"]
> pll.params["k"] = regs[4] & 0x7f
> pll.params["lc_s"] = regs[5] & 0x7f
> pll.params["k_s"] = regs[6] & 0xbf
> 
> 
> f_vco = int(pll.params["m"] * pll.f_ref / pll.params["p"])
> if f_vco < 750000000 or f_vco > 3000000000:
>      print(f"f_vco {f_vco} out of range")
>      sys.exit(1)
> f_calc = f_vco / pll.params["s"] / 5
> pll.freq_int = round(f_calc)
> print(f_calc)
> sdc = pll.calc_sdc(pll.params)
> frac = pll.calc_f_frac(sdc, pll.params)
> print(frac)
> freq = pll.freq_int + frac
> print(freq)
> pll.print_reg_driver_data(freq)
> exit(0);
> ---
> yields this back (comments added manually)
> ---
> 22500000.0 (integer part)
> -250000.0 (fractional part)
> 22250000.0 (summed)
> 
> PHY Driver Table Entry:
> {
>      .pixclk = 22250000.0,
>      .pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x81, 0x40 },
> }
> ---
> 
> so if I find some time I'll whip some loop to check all other values...

If you look at the second sheet in the pll.ods file, you can see that I 
already started to create a table for verifying the existing values. I 
gave up at some point when I saw my calculations were giving reasonable 
results and continued with writing the script. But it's easy to extend 
the first columns with the values from the driver and copy the other 
columns to provide the calculations.

> 
> That aside, I see no problem with this, just one meta-comment about
> adding a link to the script in an external repo: I see some other
> drivers have python scripts in their trees e.g.
> drivers/comedi/drivers/ni_routing/tools/*py
> drivers/gpu/drm/ci/xfails/update-xfails.py
> drivers/gpu/drm/msm/registers/gen_header.py
> 
> would it make sense to commit the script here instead of linking to a
> repo that might be lost in the future?
> 
> I'm not quite sure what policy the linux repo has here, so leaving that
> as an open question.

I was thinking about this as well and I really have no idea what is 
preferred by the maintainers. So I will just wait for some feedback here.

