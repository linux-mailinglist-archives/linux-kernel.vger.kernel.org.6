Return-Path: <linux-kernel+bounces-216549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E290A0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A9D281E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2623B1;
	Mon, 17 Jun 2024 00:36:44 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950A367;
	Mon, 17 Jun 2024 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718584603; cv=none; b=C357lhsO21QNH53teaCP8hBZZHJ77VfRXemQ7n27Tvsfqgp3CxPFzeLWq0ndznXXmvvAkoyzdP4105nD2j8pVsYDcNOCUG16yytv1PUFdYlEs1hhlgd5UCrwLar8JIFg/3tjz7bIOb3ieJmAN0Z2i0ltMl62zmBQGkTE35eh1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718584603; c=relaxed/simple;
	bh=FSTrkmPqB7kV/laFZhD4Obu5qYpn98EuvgTejYEZ/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUw86+G8ytK2gJMH/aATgeDE62bwrGy5DQdmS16uWROenyTaG1sv4FWopNLZkPvit/GZVewwja/71T3JD1zLhW9XNM4SDBoN27gUzi68CUjiRQONzrjZAyknesLiBtbIRk2VJBs59wtbARK9qXGYqD0cHvnNe1JSokWuHPbkkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 17 Jun 2024 00:36:27 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller: Add SOPHGO SG2002
 plic
Message-ID: <20240617003627.GA4008871@ofsar>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-1-1b6cb38ce8f4@bootlin.com>

hi Thomas:

On 12:28 Mon 27 May     , Thomas Bonnefille wrote:
> Add compatible string for SOPHGO SG2002 Platform-Level Interruter
> Controller.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 709b2211276b..7e1451f9786a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -67,6 +67,7 @@ properties:
>                - allwinner,sun20i-d1-plic
>                - sophgo,cv1800b-plic
>                - sophgo,cv1812h-plic
> +              - sophgo,sg2002-plic

it's not necessary to introduce a new compatible name, as sg2002 use same plic IP as cv1800b
I feel it's wrong to introduce sophgo,cv1812h-plic at first place, but that we can't revert?

same reason also apply to clint in patch 2/5 ..

>                - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
> 
> -- 
> 2.45.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

