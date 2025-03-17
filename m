Return-Path: <linux-kernel+bounces-564179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF7A64F90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED70518897AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52623C8B6;
	Mon, 17 Mar 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uwTmUe6w"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CF3FE4;
	Mon, 17 Mar 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215504; cv=none; b=lYBPN85KO1O6gxftrTIEjIWU8IQI1TBEyTdBAZoVhPySGWhmEMu27UPRHIM1G8nn4YRh9ITGfFCMZiBGNNjj9+2AoY5K7woTMNdLKVdhXV1yHbbAQs3WBEU3R6vpre9EgR/oqNhtOcMCIhhfBoKEbeoiX+FBckPX3KJrjDa5rMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215504; c=relaxed/simple;
	bh=r0gsV4Khp6e9zp+A9RWe1pYdgYloIA21s9D3a93iN34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htif0QXJ+7bsa6FBXcp81/wI26YNfchBLy4P8BLRF8v+wudHn1T9o3w6K/t+rE8GzRTv3WlhDeJLpEWq74I/q48ebg/6s2px/UQpYSxiJQi8A4OUb9oTa7kVskVAcwqwO+A6QQqR2/t+w02oLGmMRLggKGGXoSobiyKGoyK+RhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uwTmUe6w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zjV/I2fEfxjcoP8gAnydAdTVwP1+scv9m0uCGjJEH5Y=; b=uwTmUe6wsrJ41nfKAKTp0Yu0hf
	CfH6FmTXxj4xWQt3NWyGIJxsrJHrc6CvrNQngk8V2Tu7/bmgNxWES97qeznElbW5UQ3RepjVLvL9x
	rN8PEO2jFnMmc8/43/rpWwfg0j7BNOoZQgNYIqGM7OHdQBOgbtgly58cwIThnaMwI318=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9pd-00680C-0H; Mon, 17 Mar 2025 13:44:37 +0100
Date: Mon, 17 Mar 2025 13:44:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties
Message-ID: <27927166-d73b-4837-90a9-ed15661b0a6e@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>

> In Aspeed desgin, the RGMII delay is a number of ps as unit to
> set delay, do not use one ps as unit. The values are different
> from each MAC. So, here describes the property values
> as index to configure corresponding scu register.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..c5904aa84e05 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -66,6 +66,20 @@ properties:
>      type: boolean
>      deprecated: true
>  
> +  rx-internal-delay-ps:
> +    description:
> +       Setting this property to a non-zero number sets the RX internal delay
> +       for the MAC. Use this property value as a index not a ps unit to
> +       configure the corresponding delay register field. And the index range is
> +       0 to 63.

You have to use picoseconds here. As with all DT binding, you use SI
units, and the driver then converts them to whatever value you need to
poke into the register.
	
    Andrew

---
pw-bot: cr

