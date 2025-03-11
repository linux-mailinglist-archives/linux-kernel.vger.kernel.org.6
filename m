Return-Path: <linux-kernel+bounces-556587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBDA5CC02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1F8176981
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62B2620C3;
	Tue, 11 Mar 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBcUTIAZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF672620EB;
	Tue, 11 Mar 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713666; cv=none; b=MyUm0L3+w/xTzkffXUo+iLbSuGk+W0iYyNiKWGvbNfvtEbEo5WBH0MrE6Kt+3GbfTA8IxcGfuoTCl5fTqFuMo9MjcX1AwzLYVL2hyQNoQan64+K6FWLbuGwm/4S3ofCA0joJrgcPCwr43opz6jZ3lDbGHWZWJAAruRFdWgksKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713666; c=relaxed/simple;
	bh=j/ih8rqykXlfvr4wDQtIJsf0OUfZm5pMBVky+N7i0ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsMZxQcN+JhH6CEDCPnoqZJThZRNHlHhckXzlDJSLo6se9EgKTWYFsBcLJ3gSZD/ViPa9JX5QEMPE2ZpMp/TX9mIYBhtJuV8bB6imgszhp853xvSms2oJPwK8GGbx8D+pXti9BY5kEg8EibEPjrw8FNeK/JM0h44T/9pQT+pgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBcUTIAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76502C4CEE9;
	Tue, 11 Mar 2025 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741713665;
	bh=j/ih8rqykXlfvr4wDQtIJsf0OUfZm5pMBVky+N7i0ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBcUTIAZ2CvLD+/K/Mxe6qT1pABS8vM3u3BIG7Ywu3U5ybndu6p/hp4p5v0r6xbfP
	 HAUH+AaL61wYeV3wf6ZJyGtVUmgFd3Wp7U9D32Iy/eSuqXBGpQ42ogzxGb07tegxzh
	 ixEzffwd56jZflL473kvkScK7mTXDBb5xkgmDKqMuD0tVpvDGnQJ2SVqeRz6O7M3zr
	 cIgK5m351SsE46SMQFtalG6F78ySBpzMdT5SvaOq2IsaC6KolrqmeJMPzWYeha5ZGe
	 mqb6LimbAVrBb8kAznqC3LvTbCd3EVG/vPEde+TGMwHmP9rrd8IqFyE8wH3YVO3Eu0
	 K6beb6flNG40w==
Date: Tue, 11 Mar 2025 12:21:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/14] dt-bindings: clk: sunxi-ng: document two
 Allwinner A523 CCUs
Message-ID: <174171366302.3801768.11391725958696311975.robh@kernel.org>
References: <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307002628.10684-5-andre.przywara@arm.com>


On Fri, 07 Mar 2025 00:26:18 +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> the main and the PRCM R-CCU.
> 
> The source clock list differs in some annoying details, and folding this
> into the existing Allwinner CCU clock binding document gets quite
> unwieldy, so create a new document for these CCUs.
> Add the new compatible string, along with the required input clock
> lists. This conditionally describes the input clock lists, to make
> adding support for the other two CCUs easier.
> 
> Also add the DT binding headers, listing all the clocks with their ID
> numbers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../clock/allwinner,sun55i-a523-ccu.yaml      | 103 ++++++++++
>  include/dt-bindings/clock/sun55i-a523-ccu.h   | 189 ++++++++++++++++++
>  include/dt-bindings/clock/sun55i-a523-r-ccu.h |  37 ++++
>  include/dt-bindings/reset/sun55i-a523-ccu.h   |  88 ++++++++
>  include/dt-bindings/reset/sun55i-a523-r-ccu.h |  25 +++
>  5 files changed, 442 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
>  create mode 100644 include/dt-bindings/clock/sun55i-a523-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun55i-a523-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun55i-a523-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun55i-a523-r-ccu.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


