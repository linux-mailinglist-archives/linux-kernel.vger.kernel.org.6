Return-Path: <linux-kernel+bounces-230084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4830991782B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F001F22877
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006C14534D;
	Wed, 26 Jun 2024 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="V6EVfghT"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C12F5E;
	Wed, 26 Jun 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379871; cv=none; b=KzBTW5PZaVLQWse2H4xpdngJ0Q2gv8ZKq3blYigaTJNy4IIoQhgK/HPzCkmc6CGpaQ+V+aHN7X2CTFLbIBr307qDWciMtHTHmtrMNpuBZybIVQE08fN1VoECbco7cBR6NPa24Y/44S27WY3k5WrD2pl+5F+zTKnGE6q4Qyj9Lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379871; c=relaxed/simple;
	bh=NIIeRlWHaxb09V9dg0z4qNkA9Cj1y8ioeds9a+gbdOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFghx+3a//apixCgkZo0hd4Z876VQUHFa3Wz+GhgtQuJBQnKultMKFjOd7zcmz/iTiF3O9OWo27AucUOyLgoHQFYQnB6h9Vt88AZ0EsAsliyJvHGYkRaAPjBZ5FZEtfG7YRK1C6e0P6a/9tT2+1GFJgBQ6mVBC1vfn3qqZZSjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=V6EVfghT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 11F26200EE;
	Wed, 26 Jun 2024 13:31:04 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719379865;
	bh=NIIeRlWHaxb09V9dg0z4qNkA9Cj1y8ioeds9a+gbdOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V6EVfghTHDYqGTpn9rV2DeCzb7jid9YDiNqslxOtmFb334Bf6lz+HvLz2UaW7xErs
	 0w42Zuj8mtkbxxO988asuqmkpQV5K1KeEqjAAvuTVljsNY75yPZ100zG4KCcGls2p/
	 pq7DTjetBT8h8F4BvKX88G6LlSofEFbDYeGVSS+bT124fFkednk7Oe/XgW+JJsLzUr
	 T+AYOHo4fmXl6GFZXHHqqTw85xOE0UmTUN+wo9apNsneiOjA9kFrnS0nstNmMUa1hR
	 x/gGi5BAC6Lxbsefro46+tqQT3xO23L9q7gKjqcJ+BtMIVD+cRwx4CCB0bbzmQeqdf
	 /4ANhcRlmcPuA==
Message-ID: <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Aniket <aniketmaurya@google.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 26 Jun 2024 13:31:03 +0800
In-Reply-To: <20240626052238.1577580-2-aniketmaurya@google.com>
References: <20240626052238.1577580-1-aniketmaurya@google.com>
	 <20240626052238.1577580-2-aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aniket,

> Use this property to select IBI related ops in the base platform
> driver. Otherwise the driver defaults to return EINVAL for any IBI
> requests.

[...]

> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -25,6 +25,10 @@ properties:
> =C2=A0=C2=A0 interrupts:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> +=C2=A0 ibi-capable:
> +=C2=A0=C2=A0=C2=A0 description: Set to select IBI ops.
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +

Wouldn't the compatible string select whether the hardware instance
supports IBI or not?

I'd imagine that each specific synthesis of the DW IP would imply
corresponding hardware settings, and so would warrant its own compatible
value.

Maybe one for the DT folks: would this work better as individual
properties? Is there a policy here?

Cheers,


Jeremy

