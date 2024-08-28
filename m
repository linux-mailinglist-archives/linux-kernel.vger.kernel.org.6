Return-Path: <linux-kernel+bounces-304363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D2961EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F821F25104
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D01547E6;
	Wed, 28 Aug 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFXatulY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7B14EC62;
	Wed, 28 Aug 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824670; cv=none; b=IuNCRHrcrj8+zaZZps4b0a4Fy5qe3EErTHNhxOyyJSBr0HcBWxuSMv3HJZCypJclTiQLKwT1SsFtnC+OlD6QHbqNgtbhvy7KMQabtJWQjZUJDJhAnmbjNm2ckpxT/h7gYMq4pqJ0RqDgacOb4gNzjJrGUeJverUaihkMmzyzNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824670; c=relaxed/simple;
	bh=hJGiN1TYYdF0d6w75y2dv8nncd2Q7CRBoK+l2x2XjsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/QlXzoOMDs4/9Qr2UFeQvLyHBxSaV+ARuyd5bYyWYxLjPnUlrqAxoS+0Ei5dGxUqn4eN3z9ohP0zBD+Xf7FqQ8Ic3MkOt7//NHxfEUVn0Q1iaW0XWX0oiJFuX0spW5ijTkzXt9kgzqx9ntDVZN+LGnuHRSxkDzu6FpNntuFwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFXatulY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F7C4AF0E;
	Wed, 28 Aug 2024 05:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724824669;
	bh=hJGiN1TYYdF0d6w75y2dv8nncd2Q7CRBoK+l2x2XjsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFXatulYPQlSvAc3urxL9L2SfGb3W1fD0yGmmSB0aNahSg2hFBKZMQxJCykkcJfwS
	 WqSsih+Fmmrv/Q9j+yjT5AKBMWL+vXYFFwVxF0a2seg6EEhWOz15+kE/yX+eqbPPRr
	 kUvRb/8GSHvhDX5CQaJokZ0FB13W/w/aVXN41LWpJX4DRvzFe8z/jmiq2s9ESED64t
	 GUMpyYUMscoy3TD/iqk8gR56PcrYKDmZHTt10TTNA83Epsiw0n/XPYl2W2CUK8y0It
	 tHVV2odL7KO9bjAdFmVioDdsERYTNG+pV2GxBuDA4jpwGngDPXBViNMuhO0n/p3QdD
	 uI0y5ORyRMSJg==
Date: Wed, 28 Aug 2024 07:57:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: rockchip: Add Hardkernel
 ODROID-M1S
Message-ID: <stxymvczkbkxicsbqy2eav5dg3o5d2vt5swmyw4o2mncq5mtlj@zabv3krorjqc>
References: <20240827211825.1419820-1-jonas@kwiboo.se>
 <20240827211825.1419820-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827211825.1419820-4-jonas@kwiboo.se>

On Tue, Aug 27, 2024 at 09:18:17PM +0000, Jonas Karlman wrote:
> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
> 
> Add devicetree binding documentation for the Hardkernel ODROID-M1S board.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


