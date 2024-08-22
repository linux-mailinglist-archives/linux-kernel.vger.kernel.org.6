Return-Path: <linux-kernel+bounces-297458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684595B88C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964211C241C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98E1CBEB7;
	Thu, 22 Aug 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZdXxCsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE71CB329;
	Thu, 22 Aug 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337303; cv=none; b=ALjfE92JdSoxBR2o+nj9ZuxZTW0ZFR779Y1XM8jELnvgjfvSOQzKu7R3lZWe3OGzKK8o+oz1H7qI5dHdp6J8jf8WtKlB5QdEIjc6doCGECDIgc8uCIrhwyu6jtm9Egn7LJJbpCbCSg5rnmyHcaRAsLVzHFQm+uFz1DQ3N/F6lWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337303; c=relaxed/simple;
	bh=BB77FZ0jb2DyQbAaAZkUTDrQr9nXdQKIJ+deD88VVV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKU+YC7uU5vr9r+pmq4O8AYVgs2ztCr4zdXx/z+rqAFBhzC0+5nou4+MJphb1HU2ekhx1gHtZHmaxDC5zfpG8aOi7eKtbesRhqwD00U3B0BKlH+/lsQcJJTym9LzB+aoUzUNS2rZnFgkGqADBYNejAQLU9kjwivOxPlkAMHJIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZdXxCsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0975CC4AF09;
	Thu, 22 Aug 2024 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337302;
	bh=BB77FZ0jb2DyQbAaAZkUTDrQr9nXdQKIJ+deD88VVV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZdXxCsMAykjXKhauU+G46Xd1aqlLBGX/DbTAUDH+Xb2NlUaCdPaW8CX7kaBUqw8f
	 qMRn7c6gzUdnyBGwzLM52hbFEoN8fKmCq3kkMbLzeAUEIjDJgb4bTWR/g/KJ/+jU1f
	 FrS9BKB+hyQs56dK5I2XlQiqNCElCyNJ1gHnQYYUtoIdk7IZGUOGlUgopJ+TIdm5yl
	 uMGC11Xo+h5mwxAgNMJDATQ9pGGbrpEeVcKEPnsuqgd/aMS3GqEoo7SAqgqxd5oRU1
	 gvzvIAN4QGsl761s97e/Uq9QkpyLNt5s2iNHA2OFwFLzEvLRJyLAeXTZqV7vSUb8IH
	 kJCZIcftOKuEw==
Message-ID: <7620f6b3-347e-418d-b90b-487afa2ec32d@kernel.org>
Date: Thu, 22 Aug 2024 23:34:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] dt-bindings: extcon: ptn5150: add child node port
To: Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER"
 <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240820143911.444048-1-Frank.Li@nxp.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20240820143911.444048-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

24. 8. 20. 23:39에 Frank Li 이(가) 쓴 글:
> Add child node 'port' to allow connect to usb controller to do role-switch
> if id pin of ptn5150 have not connected to chip's usb ID function pin.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - remove extra empty line
> - fix Indentation in example
> Change from v2 to v3
> - only add port to existed example.
> Change from v1 to v2
> - add example for id pin have not connect to main chip's id example.
> - commit 095b96b2b fix "port" warning, but add new warning "connector" is
> not exist. And follow commit revert this change.
> 690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
> - I have not board in hand to debug why "connector" is not work.
> ---
>  .../devicetree/bindings/extcon/extcon-ptn5150.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> index d5cfa32ea52dd..072b3c0c5fd03 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> @@ -37,6 +37,11 @@ properties:
>        GPIO pin (output) used to control VBUS. If skipped, no such control
>        takes place.
>  
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the usb controller for the dual role switch.
> +
>  required:
>    - compatible
>    - interrupts
> @@ -58,5 +63,11 @@ examples:
>              interrupt-parent = <&msmgpio>;
>              interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
>              vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&usb1_drd_sw>;
> +                };
> +            };
>          };
>      };

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi



