Return-Path: <linux-kernel+bounces-423149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035B9DA37D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E466DB2168F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CF176FB0;
	Wed, 27 Nov 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwqLy78w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09728156231;
	Wed, 27 Nov 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694595; cv=none; b=Vlu3oqHBkg564/CrScJnvBosX+7HA7+IZqEW32LHSrp6nDXfHKC79jgQL5kWYchrJUKi7sEil04a/dgqdPN3jcIbF5CGkHPG1noSIBhuOc8duJtPv0FTWdJ65RuO+qyBu/l7cjANSRr3J2i9+oB1M5NBijexxYsRpEX+FvDAdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694595; c=relaxed/simple;
	bh=hj4+4Ezmbqfp1vJnsXREN9jO7XtVqXtz2wnGr9Mc2kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbnXC6TNx8Z6ZoxD4tKb2s/ORp4KPXzkoJGgLfNCG5cliGu4yxvPz6fxyLptIxxmgnoGOccVmpm2hcROLvCbzaBGd705LnfhYRja90yuAu71Dpqq1t9cnHdQeY6yqBqi2UwnF7pZdNJjZMnXWOpISPIGgmapybRVBkbt0p4BYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwqLy78w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC3C4CECC;
	Wed, 27 Nov 2024 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732694594;
	bh=hj4+4Ezmbqfp1vJnsXREN9jO7XtVqXtz2wnGr9Mc2kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwqLy78ws32w5NA9fdKVRy0XL6UtXfSMQ1zuA3+KNZzfhomF0O3IrxfdauFhVzweL
	 d/LiFaHU6JfEwOPQom8SZt4B4fTtGzTSIQY1xJvVEO28bx5MWGOpjB39J5SGMLLiAq
	 MAKVWrdk2GUbBQCpYtgQIcmS3fZVcoG68wG1DVTjfbmjuRrX5aLD4/agvLXS+9F1bB
	 9K6w3jo6hfzX2E/VGvP70dZhm9RfB9SWwkUcB2IQ3qDuW71JHa5UwsTLTuXgIrnvhc
	 VUxq+p0LgxYhT6VlEb/u1564Lku77MLfkJ+ArRG8QaskwUfAofKMfBLPl8kzjfNa3p
	 f0THhjq75CDHg==
Date: Wed, 27 Nov 2024 09:03:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: spacemit: Add clock
 controllers of Spacemit K1 SoC
Message-ID: <hgtrinu32q2jtxb4z5nvjskjlkwwzxhymtf3alvaxlbqxrbzd3@2rw3uy2tqgnf>
References: <20241126143125.9980-2-heylenay@4d2.org>
 <20241126143125.9980-3-heylenay@4d2.org>
 <64bf96a3-e28c-4c47-b7b3-e227bbaa7aee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64bf96a3-e28c-4c47-b7b3-e227bbaa7aee@kernel.org>

On Tue, Nov 26, 2024 at 03:48:33PM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2024 15:31, Haylen Chu wrote:
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - spacemit,k1-ccu-apbs
> > +      - spacemit,k1-ccu-mpmu
> > +      - spacemit,k1-ccu-apbc
> > +      - spacemit,k1-ccu-apmu
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: osc_32k
> 
> osc
> 
> > +      - const: vctcxo_1m
> > +      - const: vctcxo_3m
> > +      - const: vctcxo_24m
> > +
> > +  spacemit,mpmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon managing "Main PMU (MPMU)" registers. It is used to
> > +      check PLL lock status.
> 
> Why your example does not have it? Example code is supposed to be complete.

I think I understand why - this is for only one variant? But then this
should be disallowed in your binding for others. Currently your binding
says that it is required for one and allowed for others.

Best regards,
Krzysztof


