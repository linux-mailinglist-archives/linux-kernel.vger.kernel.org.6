Return-Path: <linux-kernel+bounces-245668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B133292B5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19941B24D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6531586DB;
	Tue,  9 Jul 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kBam262B"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FE15884E;
	Tue,  9 Jul 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522009; cv=none; b=VCwvCHCPnIEemLf98MhIT91OhwY2akudHJYF8fqrjQwykgm06fXGu6ddDKPWc9J/rG1OsBZqlVji9UDEvpykKXlK11Cv/QBZveMM5WUnK4PXUFe2tyQ4KnO8SrJCmkzNaFw1EVYkYlBP2Hi1I2Dyl21YRUZSmrVwudz0GtvKpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522009; c=relaxed/simple;
	bh=cg7AhZmeWk5N9xWjq7as8vdozigU8aTMRed2yz+QDxQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XpqmIubAaQcgx5w4u5krDZvnwusWeYD88Ti/xAI1aTJ3BASa0x710maJoQicLzcz8D3sfqvJlccUe25IHN4WoK4k7b1xYMFDbOaQNx4Sbc1LNEZuoPNaBw6z/aCg7q7DV3m9SHwaSeBln+DFxlZD0QAp9HWA3AZQbcHoaDyC1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kBam262B; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6764FF80C;
	Tue,  9 Jul 2024 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720521998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CXbzUma1zkNzQTIijTVlpg1CvjyFMrqWEgyHu/ugEQ=;
	b=kBam262BVsnC9ZEzHppU5OfoIvXxcbpBftI9R7F0IkjStXxWBYVTOK/qZV2wIG+DPJk03r
	hK775m0cfIsMMEnX51OATZxEayABlxgaKtSJNVZmYWV9nnhEybKD5XNZHY42AphwcEau+1
	WSL8oBz47lh9QyWWEDYmv5WZ4TiZ6+7GOO4H3JBE+TcNB4SoLPObxLH+wNEkgNdnuZWBB0
	jc34+W19U84845YPv44cEfyhX+eX02h0wzVEjoAQqlUghJbdGFozZY5pgq+oghQRUPO0I2
	7TfNFj0DYytTcfMtitmvHmfVVBRyIm6QREW6JTQnhN4WI++HUnQur6yNPpEO9w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jul 2024 12:46:37 +0200
Message-Id: <D2KY5A2XRUQN.6IO8XX1FL19H@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] of: replace of_match_node() macro by a function when
 !CONFIG_OF
Cc: "Saravana Kannan" <saravanak@google.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240708-of-match-node-v1-1-90aaa7c2d21d@bootlin.com>
 <CAL_JsqLBmpEQVgZ1UciAdxdiSj6Ly4bpYtYPvazr9m=vRj7qEQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLBmpEQVgZ1UciAdxdiSj6Ly4bpYtYPvazr9m=vRj7qEQ@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Rob,

On Tue Jul 9, 2024 at 12:24 AM CEST, Rob Herring wrote:
> On Mon, Jul 8, 2024 at 2:55=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:
> >
> > In the !CONFIG_OF case, replace the of_match_node() macro implementatio=
n
> > by a static function. This ensures drivers calling of_match_node() can
> > be COMPILE_TESTed.
> >
> > include/linux/of.h declares of_match_node() like this:
> >
> >         #ifdef CONFIG_OF
> >         extern const struct of_device_id *of_match_node(
> >                 const struct of_device_id *matches, const struct device=
_node *node);
> >         #else
> >         #define of_match_node(_matches, _node)  NULL
> >         #endif
> >
> > When used inside an expression, those two implementations behave truly
> > differently. The macro implementation has (at least) two pitfalls:
> >
> >  - Arguments are removed by the preprocessor meaning they do not appear
> >    to the compiler. This can give "defined but not used" warnings.
>
> It also means the arguments don't have to be defined at all which is
> the reasoning the commit adding the macro gave:
>
>     I have chosen to use a macro instead of a function to
>     be able to avoid defining the first parameter.
>     In fact, this "struct of_device_id *" first parameter
>     is usualy not defined as well on non-dt builds.
>
> We could change our mind here, but I suspect applying this would
> result in some build failures.

It appears like it would and I did not think about this edge-case. It
doesn't appear like it is a lot of drivers. I'm seeing 221 files with
calls to of_match_node(). Out of those, 22 match for CONFIG_OF.

Out of those, only 9 have their of_device_id table guarded but not the
of_match_node() call. Remainders fall into two categories:
 - call is guarded by #ifdef CONFIG_OF as well,
 - neither of_device_id table nor of_match_node() call are guarded.

The list of remaining culprits:
	drivers/dma/at_hdmac.c
	drivers/dma/dw/rzn1-dmamux.c
	drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
	drivers/i2c/busses/i2c-at91-core.c
	drivers/i2c/busses/i2c-xiic.c
	drivers/misc/atmel-ssc.c
	drivers/net/can/at91_can.c
	drivers/net/ethernet/cadence/macb_main.c
	sound/soc/codecs/wm8904.c

There could be build errors on drivers that do not match for CONFIG_OF,
as well.

> >  - The returned value type is (void *)
> >    versus (const struct of_device_id *).
> >    It works okay if the value is stored in a variable, thanks to C's
> >    implicit void pointer casting rules. It causes build errors if used
> >    like `of_match_data(...)->data`.
>
> Really, the only places of_match_node() should be used are ones
> without a struct device. Otherwise, of_device_get_match_data() or
> device_get_match_data() should be used instead.

I completely agree.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


