Return-Path: <linux-kernel+bounces-209008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F70902BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1D287674
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFF15099D;
	Mon, 10 Jun 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyDeenfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BA17545;
	Mon, 10 Jun 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058799; cv=none; b=dA2LsMAgfqBao83lzWxckdlOb5/v9ChUMq5ejg3MjfkMKm7yeJoKBYh5VbtWxT68vJYEVx5EkgpK3O1THqEH8K45CPKND5lITppuoB1GRBGBDQqXZWVE+UslV4ANOWgyBYYf77rwlsb2cjg7tq+AwkJ3mYIWq3UYEB5rKx7O0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058799; c=relaxed/simple;
	bh=V4M8xyMpvVuGZw+7KmrDMOe+gOwKdJYj1FuW8XYeck0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhEgkvCtfZjviPlyP3l8XjOrb6PKiswkPPPBn4zuYzbKM/oJPw1o+V06jwO2eF3+nnAElKeP3mfh+Jo+YjQbokMDrta6uF8iIQleAH8/B4aPIEhCkIpsA1/509WjDpryKdYGii88avZ5XAQ3Q6QQ25bYLfn4Jh4cbP1LLFO+apo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyDeenfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD87C2BBFC;
	Mon, 10 Jun 2024 22:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718058799;
	bh=V4M8xyMpvVuGZw+7KmrDMOe+gOwKdJYj1FuW8XYeck0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyDeenfZOJLC6lQNy5Rw018q/D1QbIa52nJhmqxz0hpwL3+c1ew8Uj4CwqKbFxEuc
	 F01lCGy9aW1npsCe2KyTiWtze3Et5J0rpaWBT/hpKrFoH0aa6zWqv6wqiR38hBoBrn
	 FJG0XC26EXZYq5ObCuxr/0fal7BDlLHKkaFaIhDvAnQ6E42m+oEcwISqLNHEG3g5wu
	 pKzCr8/ud2wgLXUGnL1dbwlY+kXh6trwEVOjTjxDMnJRUqlSA5HOvoTAOn3XzAPPEW
	 /z6rZKx1EzKBbEnUHRIzyur5pxGuHKZbIN1AQWbLO1TtWJDkm/nQayXxnpUzBfmRYN
	 cfwfoucbYP+tg==
Date: Mon, 10 Jun 2024 16:33:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, rogerq@kernel.org,
	gregkh@linuxfoundation.org, krzk+dt@kernel.org, pawell@cadence.com,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	peter.chen@kernel.org, linux-usb@vger.kernel.org, krzk@kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: usb: cdns,usb3: use common usb-drd
 yaml
Message-ID: <171805878268.3179069.9958902658134682829.robh@kernel.org>
References: <20240607154119.1543290-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607154119.1543290-1-Frank.Li@nxp.com>


On Fri, 07 Jun 2024 11:41:19 -0400, Frank Li wrote:
> Use common usb-drd yaml for usb OTG related propteries to fix below
> DTB_CHECK warning.
> 
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Add "port" proptery to use connect type C connector and fix below warning.
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: Unevaluated properties are not allowed ('port' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     change from v1 to v2
>     - add dependences
>     - remove dr-mode : true and usb-role-switch: true
>     - update commit message
> 
>     pass dt_binding_check
> 
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=cdns,usb3.yaml
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       CHKDT   Documentation/devicetree/bindings
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/usb/cdns,usb3.example.dts
>       DTC_CHK Documentation/devicetree/bindings/usb/cdns,usb3.example.dtb
> 
>  .../devicetree/bindings/usb/cdns,usb3.yaml        | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


