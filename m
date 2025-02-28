Return-Path: <linux-kernel+bounces-539429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272EA4A420
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E83177F99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBD25DCF3;
	Fri, 28 Feb 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdd3ObyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04623F391;
	Fri, 28 Feb 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773909; cv=none; b=Gi0jvuiFqsQw915vyrwcIyyRsHdu5ADAz5jNU/wXnjC9VSxEXD1gCSCa+lwWLB93P/hlDz7C0OPtNdaArwArYSQj8pwD6LuDBdmf48Gxra3U1+iG+tn7vl5p/w3E6cb5UguRpUl3e5llUMg2m+ktcx+l5ZV/HgPVMv1rkO6zONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773909; c=relaxed/simple;
	bh=iGXo8WuPz9MZWdQEJLs/fObp9RRJtO0HVz65gpRrNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2KSuM7DxiFDAVSOYl1n1DTzhDi7w9TEPv/93iOdz/bn9UnTqrzlqgUcniqZW6LdRpLVu8iDUwSohUfdm7tN8o0hLAJACcEWXRWTtADWgZbMocZJLms1cj9Seb+bFxUSKPzWh2Q7G+S6XfuHvpFNkS19d7OD7bx+XuWYBImvch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdd3ObyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC07C4CED6;
	Fri, 28 Feb 2025 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773909;
	bh=iGXo8WuPz9MZWdQEJLs/fObp9RRJtO0HVz65gpRrNrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdd3ObyGaW7wnwxC0xX59J+sWL/dpxUy2gx8HZEqHrL9wyU8vHMmiO1PO0IOvVavr
	 fiBG/YMCTAMgYg7ITRUxpuXAwafWcsvpny4jV/B7AnOFamhQfzssPBbQW1m6tfoFue
	 wMHP5/TiOLamAWilT22Ha8DpuyONTW9/TGWeixT5rqTPNkU2oPiPyPEJVLVlKpOvDM
	 CAzWZ460RnuoDIFTUD5hFNOhZCPcp0t/PZx6guDububQw5VWnUId2VdEpTcVi0yTiI
	 tjp/3poqj7mzcozd1FqHM+INiwn/HjuiXHnhaXbA9T6+5IdXVn69U6iUqyKK3BV08W
	 V4smjBnxhgzrw==
Date: Fri, 28 Feb 2025 14:18:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 09/15] dt-bindings: usb: dwc3: Add support for rk3562
Message-ID: <174077390696.3604658.16411681325263588112.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-10-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-10-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:07 +0800, Kever Yang wrote:
> The USB dwc3 core on Rockchip's RK3562 is the same as the one already
> included in generic snps,dwc3. Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-dwc3", "snps,dwc3";
> 
> There are 4 clocks with different name sequency, add schema for it.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Update commit message and add per device schema for clock name change
> 
> Changes in v2: None
> 
>  .../bindings/usb/rockchip,dwc3.yaml           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


