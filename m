Return-Path: <linux-kernel+bounces-291085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAC955D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933501C211AA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069D13B293;
	Sun, 18 Aug 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+RH6GV/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE382D94;
	Sun, 18 Aug 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993027; cv=none; b=PgCKxvu7sM6BJGXVmwbEJ6sQPWThAqvzENc35hcyB0mby9fjCql73v88g+rG2v9TGF2S8zUgCnfwCBcbnyukkAUoLCLIrcG3rOoOyY+TpLzpa2LirNKtVifxYwJX84rVfdZTbd6CF7oE33IGrQe0a100R1gfX7LknDihE/se+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993027; c=relaxed/simple;
	bh=0G+hL49xb/gmZWd3G3wUa+WmKoWp+36O8M1Fh6zyxho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSIX+wUcPqMb/lg9NERPq7oi7CO1HavUfxOIYiXERT7Ua7cdgE1IeJbF17ZqmnuCyLtwvjkbQWq0W23gFENd21HrjR8h51DyS+dpv0N0+yZ4KCYUl7nNgvLiUUmHdnm6l779kRKExt/68ufWVjxbcvUZcRsfS5/EpClI7C++iJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+RH6GV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C560C32786;
	Sun, 18 Aug 2024 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723993026;
	bh=0G+hL49xb/gmZWd3G3wUa+WmKoWp+36O8M1Fh6zyxho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+RH6GV/xD8LO6MvgOeuDcbciEd9+9C6uk4m5wxj87s7KFN+74oHGnJ/+5wvn2eG2
	 R6mPLwvUyp+ays0dz8CuICrXjVlTsnyvmUQbszmws8BNdMMf3R5jXqHz9wSiTzHMiH
	 FC0KowBzcZbqhWtUYvcvsr2hrJrDxVVWaFqFe+NXeNYyT6lWFkXzmHhmhtzEueFYmC
	 7KnEwG+dUysqotVFFVvPw2B/Bo4r/gLKH0Qw0KnL99sLWnQ9Y18ZlFpe26LobFHfw4
	 kan5zWX5xJI5EIDai59Glr/VfKq0tQO2BJ2KOR8QosljLq//EdDRau/hhMuVjAHaGP
	 0bTVce73rdh9g==
Date: Sun, 18 Aug 2024 08:57:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: extcon: convert extcon-usb-gpio.txt to
 yaml format
Message-ID: <172399302453.69217.2940442172515377504.robh@kernel.org>
References: <20240812201754.3830198-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812201754.3830198-1-Frank.Li@nxp.com>


On Mon, 12 Aug 2024 16:17:53 -0400, Frank Li wrote:
> Convert binding doc extcon-usb-gpio.txt to yaml format to fix below
> warning:
> arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb: /extcon-usb0:
>     failed to match any schema with compatible: ['linux,extcon-usb-gpio']
> 
> Additional change:
> - rename id-gpio to id-gpios
> - rename vbus-gpio to vbus-gpios
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/extcon/extcon-usb-gpio.txt       | 21 ----------
>  .../extcon/linux,extcon-usb-gpio.yaml         | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


