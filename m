Return-Path: <linux-kernel+bounces-522677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305DA3CD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A218898AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2E25D528;
	Wed, 19 Feb 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY2CMqq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC52417C3;
	Wed, 19 Feb 2025 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006880; cv=none; b=AQX08YUY8O+zSsOrv8NDWOgQ1eK3FG3szowdbYzHkv+WHm9cGk0KYKbuHZiBCEJ7qpeQipcZ387loFcytdxA2ufUsR0cKALA/lwzRbLyRGl5Vrc3sVCGiOw/0a9IS4CGBEC8Vu9CPWDpkH0s6Q8b11tDP8Sae6zvqAAETumFCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006880; c=relaxed/simple;
	bh=VmordyIhW2jsBJrIyaa7b8c8pt16sf7W9iv8wIfp9E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI8aUOaC8MrWcRsCEahITuYuQwZl+oihYBKeddwvkK1DfEarlrRf1VvgdIUaa3wg0n6t1W3Ghusv+HmRMOXbulzMrcABz/ejwDjrIAqoeQC0KC9rRpRiIxdzJsvWDoutWd2ridzW2M+zsVWgQNnKmEaXrKzf0S5kTBcZFpXShTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY2CMqq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7EFC4CED1;
	Wed, 19 Feb 2025 23:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006879;
	bh=VmordyIhW2jsBJrIyaa7b8c8pt16sf7W9iv8wIfp9E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nY2CMqq2OZGY70thcRvYniLFFxRx9A0uBmD63qmvu+SrQ9O79w9JLgMD/OnuNZqyF
	 wMtWdlABL24Jfq33zG8i7FaCY5cnuGZr0M1ymmxG8WPmXSmiEruNAWduLSA6UcyZnL
	 jnPUpuaIIpuADlHuKLRfvo9oWWwcn72jUKY3EacgqvT7OFgfwQSr2LOSF8Bqys4YZp
	 vPm7cSeMuggaLIPvHtyhIthMQDM00pT+kGE6DXzHWzecLRBP+FemVTU3JhwMyCvi1z
	 9Eq1ngna8nwuDNGXMel7wjvTe5Y50SBLaRMNQCP3I+soDo1iH/pLSwYeMcdEauKDA8
	 hqZNrVQy9+RhA==
Date: Wed, 19 Feb 2025 17:14:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claus Stovgaard <claus.stovgaard@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>, claus.stovgaard@prevas.dk,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: b53: add BCM53101 support
Message-ID: <174000687793.3153374.474074963070616968.robh@kernel.org>
References: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
 <20250217080503.1390282-2-claus.stovgaard@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217080503.1390282-2-claus.stovgaard@gmail.com>


On Mon, 17 Feb 2025 09:05:02 +0100, Claus Stovgaard wrote:
> From: Claus Stovgaard <claus.stovgaard@prevas.dk>
> 
> BCM53101 is a ethernet switch, very similar to the BCM53115.
> 
> Signed-off-by: Claus Stovgaard <claus.stovgaard@prevas.dk>
> ---
>  Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


