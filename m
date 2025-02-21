Return-Path: <linux-kernel+bounces-526795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54068A4036B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE09A3B2130
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70825209F4B;
	Fri, 21 Feb 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNU6ghjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590817CA17;
	Fri, 21 Feb 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180223; cv=none; b=VZWs+OpmQFnhKULAIjddPSRpAx+dUzHoHojaxAqOeCOBIR1MKhu8XP1M6qqTOgQaEFOxOTSAKQb57N1wC1AzKQsZsbw+9gKG7uWfR+QJ7CGHLo41E46ZlcIMy+ryfVGEJ8V491ZXdhIEcNJZTuivFEJfcZB3tH4xm1bOddJxy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180223; c=relaxed/simple;
	bh=+xduFCwtrl+bhoxnbvomXra6JaOzL0UrXGBuJPoIqCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIZRiVAj/r2ilrmETXe1Z9Y/kki6jp24Iq7jHkmwjahKRRLsDawqGnNKLRut4boeEztTMO4g0sztNxc7ikOVXlJNB9AyK/MFfizawKJXKlU10HevLeXIv/9WR+rdI9pLTFsvWkgXbRoAL52nB50YX1+sCtvCfMaCYDm71TPb5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNU6ghjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09604C4CED6;
	Fri, 21 Feb 2025 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180223;
	bh=+xduFCwtrl+bhoxnbvomXra6JaOzL0UrXGBuJPoIqCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNU6ghjPWB3w2kkqzvgtaI9p8FOB2PcQVhDW9Y/TpzK1e71JUG49KycQ6tUAlKyG9
	 xK4ZoQn3ooHbOWcfthR03CRpYrVKD15xQGRydLvmmLX9fEInxovew784PhyAbWd9OD
	 /hmHiJKePCqxh8GG8An2VLoNynlDaQZT6BctSLqwF/LdKWQj37pmnnmpJAX+GyNz+u
	 SW6Z1/wdh/Rs0sBs7hyM15wok00KHzN0UvPg+q1KSQHxkG+WlEFnkHu64yYnfwPaNb
	 Edf+4f7szMt2sIHcagnW9vKQxv7cJfcamC019K+uzUQbA2Kgx92136zVKX0Ym6MpZ/
	 tUvdhVG6jGvyw==
Date: Fri, 21 Feb 2025 17:23:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: net: fsl,gianfar-mdio: Update
 information about TBI
Message-ID: <174018022084.372294.8853853099533842467.robh@kernel.org>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-2-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-gianfar-yaml-v1-2-0ba97fd1ef92@posteo.net>


On Thu, 20 Feb 2025 18:29:22 +0100, J. Neuschäfer wrote:
> When this binding was originally written, all known TSEC Ethernet
> controllers had a Ten-Bit Interface (TBI). However, some datasheets such
> as for the MPC8315E suggest that this is not universally true:
> 
>   The eTSECs do not support TBI, GMII, and FIFO operating modes, so all
>   references to these interfaces and features should be ignored for this
>   device.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


