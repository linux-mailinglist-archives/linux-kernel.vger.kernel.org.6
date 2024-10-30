Return-Path: <linux-kernel+bounces-388180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4A9B5BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10ED1C210CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058071D1308;
	Wed, 30 Oct 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT6tMBXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4A1974FE;
	Wed, 30 Oct 2024 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269320; cv=none; b=R04Y81BKJ8tRBq1Rda4RxtHkHwl96yIbUX107d0eCktX/fVwaEu9cJhHZA1VYaaZTjkwC5PhU+zPU028FHJReqqEkJodgbt+8t2MNv0Tqw0dd/AspQH1KB0y5k6WPKyZYaI3vFSS33yJDSe4w2StyQIRBHTv+0mJX+mGQY/DR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269320; c=relaxed/simple;
	bh=c1vbI+0Nm6A51Yq28Zq6LF1zof5ko5uSHSBIZKEfhys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZou8I2nUMACrrNdZce5q2kWk8RXHKAlYamZD3UcomSU0Hlt3eYbwBw29Ds8Ojub6Dt+Mg0/YMQ1Ro5D9mU1lofbyBs8whP+nWsswIeJ3cWMF4pODTwrf76G+yUOObqLhNTAiGxLCr+yKNff7f3Lxm5GZmQPhel50/nagL7E9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT6tMBXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B79C4CEE4;
	Wed, 30 Oct 2024 06:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730269319;
	bh=c1vbI+0Nm6A51Yq28Zq6LF1zof5ko5uSHSBIZKEfhys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gT6tMBXZd/djWCdKwzozufEJaR7mWtqoZ5kTfjL4OVYotoTsz1OWeh1lGnRhp3HtM
	 BAPn9iGIUlCaBJRvseR5mrBp6xstImFynCgCqRydLDLYYQvRSIwioRTLzNlPS+o58X
	 mdiH3KDopbjftkoIWpXZtwxavIMh7uev9Os1zQTEgx9s11Ul8FvTcKAEr0PhBU6BqD
	 dgY8tQ58LcnVDM5rrLGjo/KdGCrb9KRN9+h+7bLXc0vZmeLFfnuHZrS+tBjxreHkLK
	 iipmIYhYT12U5dVaeOOdqyWPepirScrmsyp/P368N3GYYJhLXU2tIVhAC/EGO+Epvo
	 HA5U0pkSWkbdw==
Date: Wed, 30 Oct 2024 07:21:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <g23hvybxed4ztz5sn6htdwonbwbspmfmtdbjbymwgiljaxc244@g4hylxid2k5x>
References: <20241029072444.8827-1-francesco@dolcini.it>
 <20241029072444.8827-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029072444.8827-2-francesco@dolcini.it>

On Tue, Oct 29, 2024 at 08:24:43AM +0100, Francesco Dolcini wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> host controller. The controller supports software configuration
> through PCIe registers, such as controlling the PWRONx polarity
> via the USB control register (E0h).
> 
> Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v5:
>  - s/ti,tusb7320-pwron-active-high/ti,pwron-active-high/
> v4:
>  - add $ref: usb-xhci.yaml
>  - description: wrap to 80 columns, add that the two variants use the
>    same device ID
>  - revise the example, based on comment from Rob and taking
>    marvell,prestera.yaml as an example (this binding was reviewed and
>    amended by Rob in the past).
> v3: use lowercase hex in compatible
> v2: rename property to ti,tusb7320-pwron-active-high and change type to flag

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


