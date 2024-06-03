Return-Path: <linux-kernel+bounces-199384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A778D8659
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633401C218D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09840131E2D;
	Mon,  3 Jun 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM11dwwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE9320D;
	Mon,  3 Jun 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429651; cv=none; b=RdRpwHfc6Z1FSs0cbc54agrM9aI4S/kukBiTaYjgJ/hqQrI09PzZRkALUbF1C5le3AIxQUpz6OWMIlr0AAaDpJR6dibILbDpx4Wb0vX2ABQmZ54CS3f0rfuGoyVl/QTw9z+sHSgXqdObAfudM7ZNnFqneD2KXQNefK/0VhXkhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429651; c=relaxed/simple;
	bh=b+zQs7Ud84kKrfcUQbsWSU0w3CdVTZCIcIp3j/qc7Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2zJ+yvc2DpCZ3gZ4cgb4jhIFhP5yEb7igqHz7hXohEN7FSZ2RBWjP9RDwu6h2rks5fV+CKOLI2rxH2MtrrZLRv3eYvnp7rO/TVvNKfUaYr6QGQIcTPssJEtHf+MCnaKAmNsV7Rfhp9sANOq2VADB/XJP2olBsALdw7Ys9nqdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM11dwwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591F6C2BD10;
	Mon,  3 Jun 2024 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717429650;
	bh=b+zQs7Ud84kKrfcUQbsWSU0w3CdVTZCIcIp3j/qc7Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM11dwwxoZ3cpJsx6QRpjaFEQ1IdRa5bT1iAkAmiBkqDDDy60RciKWYGe/lO8ynu+
	 PInTAgvm4JRBCTKjeQQjWZwKMcDoYSro+lPDyabMDT8CYltX5gMH2+r/8JM4TAOjS0
	 3PXHhnuY4xYsR8RclFWyTFotekETcMlW/4U/X+fksX5ELMIeq3pNDBGfhkZ6R7kK7t
	 7UO0+WwU+bLQ70R0TdAVHXmNbZYlrca7Nr5OXgIH9W5nbGT+i0mymPEXgzwh6CNT3x
	 QYrFtcJ0b/OrVTXoUVnxbeuDBKDH9qjwPid6/09E+dRTkwzHd5nvwFuyF6qQJc/cIj
	 1OhqEhhsVDiog==
Date: Mon, 3 Jun 2024 10:47:28 -0500
From: Rob Herring <robh@kernel.org>
To: Amna Waseem <Amna.Waseem@axis.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ti,ina2xx: Add alert-polarity
 property
Message-ID: <20240603154728.GA480397-robh@kernel.org>
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>

On Wed, May 29, 2024 at 08:07:14AM +0200, Amna Waseem wrote:
> Add a property to the binding to configure the Alert Polarity.
> Alert pin is asserted based on the value of Alert Polarity bit of
> Mask/Enable register. It is by default 0 which means Alert pin is
> configured to be active low. To configure it to active high, set
> alert-polarity property value to 1.
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index df86c2c92037..a3f0fd71fcc6 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -66,6 +66,14 @@ properties:
>      description: phandle to the regulator that provides the VS supply typically
>        in range from 2.7 V to 5.5 V.
>  
> +  alert-polarity:
> +    description: |
> +      Alert polarity bit value of Mask/Enable register. Alert pin is asserted
> +      based on the value of Alert polarity Bit. Default value is active low.
> +      0 selects active low, 1 selects active high.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]

This is alert as in SMBus Alert? That's handled as an interrupt, but 
this binding has no interrupt property. And the interrupt binding 
provides a way already to specify active trigger state. Why do we need a 
second way to do this?

Rob

