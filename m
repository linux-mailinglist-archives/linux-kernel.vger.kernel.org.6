Return-Path: <linux-kernel+bounces-237531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B338923A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C593284F32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A115572D;
	Tue,  2 Jul 2024 09:42:42 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2914E2FB;
	Tue,  2 Jul 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913362; cv=none; b=QkyKbmX8o9UonHHcyuMWzUt01FGXbq7YgWmaZtIAk5AUlCLzfRE49bROCbNkFMLzcNK/3oWmqDJEZHLlGcaYoLq0f+drUiYRwG6IfsJOvalnDkQuupW7Ck+VhII6K7ZvIRM6QUw9V5DCaKrxca0G9wT4nJo17b5cprOVc2X2gWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913362; c=relaxed/simple;
	bh=eEipO0eOiE/f2CIFA7wvUWVXg4f0TbJAAfs+ySTN0I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJxaLcKjr7cKpI6HdvEgw+hK/AziPEt3EgzZreMyl6CREPi1adAkCM89LB939X38UyC4vDT2KIAMSYQ+vEEuV2RCwKPZBFP5iuj7/Fsa8e4+s6NB9MtanUhEN9jIhwGtXLwP1s30MplmUyv8rHEHlnT0yc+dsrZZY/Js0nGGui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Tue, 2 Jul 2024 09:42:35 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <20240702094235.GA2506224@ofsar>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
 <20240701-undercook-flatterer-7f18f7420a6d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-undercook-flatterer-7f18f7420a6d@spud>

Hi

On 13:24 Mon 01 Jul     , Conor Dooley wrote:
> On Thu, Jun 27, 2024 at 03:31:17PM +0000, Yixun Lan wrote:
> > From: Yangyu Chen <cyy@cyyself.name>
> > 
> > Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
> > Pi BPi-F3 board[2] which used it.
> > 
> > [1] https://www.spacemit.com/en/spacemit-key-stone-2/
> > [2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> > 
> 
> Please make these link tags when you resend, like
> 
> Link: https://foo [1]
> 
> and don't leave blank lines between them and the signoff.
> 
sure, will fix in v3

> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  .../devicetree/bindings/riscv/spacemit.yaml        | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > new file mode 100644
> > index 0000000000000..3b151fd02473e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SpacemiT SoC-based boards
> > +
> > +description:
> > +  SpacemiT SoC-based boards
> 
> Please work out who is gonna maintain these SoCs and add that here to
> resolve the bot's report.
> 
sure, talked to Yangyu, will also add him as maintainer
this should fix bot's complaint..

btw, thanks for all your other comments in the whole thread, will fix them all
> Thanls,
> Conor.
> 
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - bananapi,bpi-f3
> > +          - const: spacemit,k1
> > +
> > +additionalProperties: true
> > +
> > +...
> > 
> > -- 
> > 2.45.2
> > 



-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

