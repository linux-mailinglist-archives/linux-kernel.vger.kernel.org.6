Return-Path: <linux-kernel+bounces-247163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3492CC09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EDE2802E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099BC83CD2;
	Wed, 10 Jul 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SFwA4HJa"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267B85626;
	Wed, 10 Jul 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597110; cv=none; b=VaDm0POu4/mpHXsDx1EV/qEGMqqfOcZPR5dFim5NHpl6ku5XF3I4lxQBDaJGqwLIAMQgV/y3jR5ZmJbC9gvDJatqPTpGZtcFIU3qIQ0H0hgXLmn6QzxIm6qiXLh5SOOP0c18vPnj+bu5NU/SolcmgEqeQP5pu7yL6ZILfr2slbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597110; c=relaxed/simple;
	bh=4ggLPVsp/ySWhRBTEdtIVM++k6xstOToW6SYy1qspNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqSWX7bqR4PYF2Mco2lkoFUy5Bwdw3Vv/9+r3qo0W+Ve0N5/Sk38/MbrAYvqMCXPigGrBfVmSOHvjWUS+KjvyeYLNA0Df3ZF4ge0WxNFbLf7T/iJbcyKYqOzoNH+/BE29SByetP0QGdA80VkWcg5Jk3R9QYlihynQ+EjJlMluQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SFwA4HJa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7953D1F931;
	Wed, 10 Jul 2024 09:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720597096;
	bh=m+7eG5SulmxARql1rXta82f53cuxh3ObNVc6xY7pOyY=; h=From:To:Subject;
	b=SFwA4HJaPolOWR9dBffrEa5tMRLLCcpZt3iVkG82DkooGI/u95mV/+au4EhYWp+fQ
	 deUzcuOcXxcT+Q7a8SuOyJ+xtcu8GbJlm+c7t0yw4Zwk4uKALEC42xNDurX0jbBm6n
	 KITgPwHiSmQj4Acs8/lxu8JsOTqqIFaYKYpTS6OzF/ygHYO+KdwAqyfM/I+/1ybS5O
	 grZGCvRHISntTHcEJqc1zzBgM6Eoa9pzT2fOxtqqYCczMnuUlgcRZqwpfS+s36MNvh
	 C9FLuwZW9gMTjhGBfqqEO/wUpbVXEg2mwwgiqm4tOZK/xSc4OKaC2v5t65YbM/AWMJ
	 A241MO+oBUp2Q==
Date: Wed, 10 Jul 2024 09:38:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Logan Bristol <l-bristol@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Message-ID: <20240710073811.GA4855@francesco-nb>
References: <20220321155417.13267-1-bb@ti.com>
 <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
 <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>

Hello Logan

On Tue, Jul 09, 2024 at 11:20:24AM -0500, Logan Bristol wrote:
> On 3/22/22 13:14, Krzysztof Kozlowski wrote:
> > On 21/03/2022 16:54, Bryan Brattlof wrote:
> >> Texas Instrument's am642 is one of many k3 based, low cost, low power,
> >> chips designed to work in a wide range of applications spanning an even
> >> wider range of industries that TI is actively developing
> >>
> >> With its pin-mux and peripheral rich designs, these chips will likely
> >> have a multitude of custom device trees that range wildly from one
> >> another and (hopefully) guarantee an influx of variants into the kernel
> >> in the coming years
> >>
> >> With overlays no longer a thing, I wanted to ask for opinions on how
> >> we can best help integrate these dt files as they begin to be developed
> >>
> >> I also wanted to introduce a skeletonized (nothing but uart) device tree
> >> to give others a good starting point while developing their projects.
> > 
> > Real hardware as DTS please. There is no need to add some skeleton for
> > specific SoC. What if every SoC goes that way?
> > 
> > Feel free to create re-usable components in DTSI ways, still reflecting
> > some hardware parts.
> > 
> 
> I am working on a project for the AM62 and came across this email thread.
> 
> Following Krzysztof's direction, I am wanting to submit a DTSI to serve
> as a minimal configuration for the existing boards based on the AM62
> SoC, which are currently defined by bloated DTS files.
> 
> This DTSI file can be consumed by other board DTS files to reduce the
> configuration. Krzysztof, could this be merged upstream?

Can you elaborate a little bit what you meant as bloated dts file? Why
would you need different DTSI files compared to the existing one?
Which problem are you trying to solve (make some example, be specific
please).

My experience with verdin am62 (k3-am62-verdin*dts*) was pretty smooth,
I was just able to use the SOC dtsi file and use it to define my own
board (and I had the same good experience with other SOC/Vendors).

Francesco


