Return-Path: <linux-kernel+bounces-428373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A411A9E0D71
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697132849EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB511DF247;
	Mon,  2 Dec 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTcGLgss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313021DDC24;
	Mon,  2 Dec 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173144; cv=none; b=DgIsUbFIYT42dbfKZpz9Vx4kbkw+FrMLnno5g4hmAs1G58Sbl32H/lYdLkXFJn5QedyXnPxKKAdzU5gBeDqHY4I7tC23tTJsKHweOPL9d7JM7C1bZRwKdmtguWtuyOe+K/6uE+7uPm8o74rrc6QSyXLAV6j6D+YN/1eFH7Hl0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173144; c=relaxed/simple;
	bh=BqWecxSXgQIa8giUNeZ2BAp4YD5tR1OQ3mAJHBxTKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYFIQeQBYSFqxpIOlySS9DuN5pJkssK4dAZXJUhgEIFZVDEDnx67Xp7Ki88Ksm4VyTMybNUbr0tR94ruImAqX6O6BR9lF4iGnZzMn9HPo7AEXGdIgTrPFMN/vvzIQpqk0vyIQpJBcHNG+YwNSya7qwvXqN/PMFeha1rvhNzINVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTcGLgss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47996C4CED1;
	Mon,  2 Dec 2024 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733173143;
	bh=BqWecxSXgQIa8giUNeZ2BAp4YD5tR1OQ3mAJHBxTKik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTcGLgssR0iDsOKrcFy5f2jhrehoim0WjgkUIfZ8MC74zgng7L60W7kqT3Qa4Zxv1
	 SxUUslZkPERVEJVmZ1tHp7hbkwHZE13h04GK4ZJrhYnMM/TD8I+zMnNT9Q6s9LNHyt
	 ROEQYFd/AsyM8wSwJ4Hxqc5XmvlvnTQi5wGiPkRMMkHbA5FTr6kHBgHiFf4zrhXzyU
	 RdzB1k1PYdJmOvS/MmU9PLcH4kjgHyxOLwlzjbNS1cSpIHH0xxlAo5A0D1TenYClkA
	 xccj0DKwHmuiLL6WRFi33hjhnuSyPqjnKiXBo+MMn6ujpGvigZJ4LbDNXVqodidtkv
	 AHxuqZtLeT8hg==
Date: Mon, 2 Dec 2024 14:59:00 -0600
From: Rob Herring <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonas Rebmann <jre@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, kernel@pengutronix.de,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible
Message-ID: <20241202205900.GA3155769-robh@kernel.org>
References: <20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de>
 <20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de>
 <20241202-stereotyped-otter-of-agility-44b71b-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202-stereotyped-otter-of-agility-44b71b-mkl@pengutronix.de>

On Mon, Dec 02, 2024 at 05:53:18PM +0100, Marc Kleine-Budde wrote:
> On 02.12.2024 17:35:21, Jonas Rebmann wrote:
> > Add a compatible string to support Fujitsu MB85RS128TY.
> > 
> > Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> > index 0ff32bd00bf6aee279fa78c624d8d47c6162f7f1..973f06b665dbbcb9ea1090418eb18fbe2285acef 100644
> > --- a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> > @@ -18,6 +18,7 @@ properties:
> >    compatible:
> >      items:
>        ^^^^^
> I think you need to change to "oneOf"

"enum" rather than oneOf plus const entries.

> 
> >        - const: microchip,48l640
> > +      - const: fujitsu,mb85rs128ty
> >  
> >    reg:
> >      maxItems: 1
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



