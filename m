Return-Path: <linux-kernel+bounces-280462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60F94CAEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B59C1C22175
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53DA16D4E6;
	Fri,  9 Aug 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VGjNi0Fr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426A2905;
	Fri,  9 Aug 2024 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187168; cv=none; b=bzH+J2mO+xd5tSehSa3R97HdLva/hLW7M/rSGYqUvN6/ZYGlQUWI8At55TD6hI8MGOuA5K8c5rwdTA8VH1gujLw3G0UuUMPSZdQJyKJaMO6zKr0Z0sg7kjeLDiyNRBvlOLSwiMgvQrNlonZq7/jf/hobLZHtYQeFxXBLzmwsAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187168; c=relaxed/simple;
	bh=8NzGtQEk1djIjdQwNEp9FntFkkxEYN7OgLvWBCDKTNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4eRdDtVP+FiGqbsgjrj4apvoWb54wUXevWro7mofFOEUcOVCOWdZmV3FA8/EEVgiKRR5jVaC5NWlwbQMYi0qqghrj4T90KcNJ9FIwCmRr4/gmXxEVJjldZBtKARnUugNYyM6GCT1jrW/T+PpNWfhVHhhYNhQGtwuv1oCjUqBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VGjNi0Fr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723187162;
	bh=+Plf4ZWD1RmGz+3DAbjeVsVnM/ML3T/p7cds+xmG834=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VGjNi0Fr51RRWjZ85KwHn4LpSxGwfFn0x0KJYWbBgbau5d0F2NDAsZLLoK4xjYoHb
	 Kz/YPn1YOsQc7IprBQko/zOuC7dCMYzXe4hRlx86my7Tk/XkLsLLVZBtvJ706c7TA2
	 8CMOeOm+WLZdXu4UdTNxPR9cFmlKZ4Ze77IWGovesolHj4eNrMrBjXQW7EbuxR48dk
	 G/o/fNIhd6bxM3blbK6M/FnZGTRIW35GogfKWY+uyFUzjNvmhjf1ywjc1VeO0pKtiv
	 cyiZ2elprPghg041ZFDk5NBx+sk9WfYfnmWN5bMPIgmq97zGbKvGTbbkW+GskbxaTK
	 0QBd5QB5JW2JA==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8308D656AB;
	Fri,  9 Aug 2024 15:06:01 +0800 (AWST)
Message-ID: <3ace8d9363265449acc124316b9a76b9f8d095a9.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/7] ARM: dts: aspeed: Miscellaneous devicetree cleanups
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Eddie
 James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Aug 2024 16:36:00 +0930
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: 
	<20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-02 at 13:55 +0930, Andrew Jeffery wrote:
> Hello,
>=20
> As mentioned elsewhere the Aspeed devicetrees are in a bit of a sad
> state. This series is a collection of fixes that make them a little
> less so.
>=20
> If there no concerns raised in the near future I'll queue them up for
> the BMC tree.
>=20
> Andrew
>=20
> ---
> Andrew Jeffery (7):
>       ARM: dts: aspeed: Fix coprocessor interrupt controller node name
>       ARM: dts: aspeed: Specify correct generic compatible for CVIC
>       ARM: dts: aspeed: Specify required properties for sram node
>       ARM: dts: aspeed: Remove undocumented XDMA nodes
>       ARM: dts: aspeed: Clean up AST2500 pinctrl properties
>       ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
>       ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

I've applied these to be picked up through the BMC tree.

Andrew

