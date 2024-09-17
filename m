Return-Path: <linux-kernel+bounces-331490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0097AD71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7BD1C21C45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89552158522;
	Tue, 17 Sep 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Kf22Ac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99441581F4;
	Tue, 17 Sep 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563630; cv=none; b=igDyRqi5XQLm/L7kYbgwyjIwrt0epuBClI8yz+Gw+IHm951qsKigTCVmLyaoaopiCtl6GbnO/6AYHmmVZ40L3jCO7HwLmPCc7Cxb5wnL24YCYM0ET1gvkqoANTkGvJZPyNRp3lS6szxHaREEzdlBJO+9oFXHYJBXD/RKLSC+ErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563630; c=relaxed/simple;
	bh=bylRqLvpte95KDB+rIKaU72XufqIzcho94KPX37KWSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SotXY4HlyCux2Pu94rnWud8liT1GYNHot7O9EGg8wO8DA3fwDcdtlF89t8ykJ33RrrGHHUVOx6q9uzSgLiUvbP5tVYCjTNAYLEkaitWAptbZJ06NnttSxfqIRkPinIiO4bKkfsx320KMtT+A3ovCKnTuKBX+8vzBqguZ+7OjtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Kf22Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811ACC4CECE;
	Tue, 17 Sep 2024 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563630;
	bh=bylRqLvpte95KDB+rIKaU72XufqIzcho94KPX37KWSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B2Kf22AcWi8n7QZe0kUovmYLR0PjYqz12U38N8Ee9dM09PUEhIuY/jNC2hR86CG9p
	 yO+n5q3EfN4JFATcPJLhDTu+vH1OUNkQ9Yc+PeHhtnkT86Dg4iY5uLmWpj/nLZNjs2
	 5ONUfAFjMvv8WiHKatsLUxzOVa4MWal19NZOK+pFPrhYsuyHX2Ma0S6B62v7XP+qpi
	 NZy3qP9yrJdH/9SCsWlRHsi3vFcz4fWuSRump2FAop/WeHOhBlFEyvPRddPIf3yAvz
	 Eghm8lYHaedqMZQJxKuyz2Rro1wAqyWPR4WFfWVhT/k1IZEv5nSxksdUIFM3Zk538V
	 9rsBCf2YxVDpw==
Message-ID: <cd4ff3c1-ece5-4508-93f0-2806cc6e76ba@kernel.org>
Date: Tue, 17 Sep 2024 11:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: probe-control: add probe control driver
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org
Cc: yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-2-nayeemahmed.badebade@sony.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240911142319.3435746-2-nayeemahmed.badebade@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2024 16:23, Nayeemahmed Badebade wrote:
> Device tree binding document for the probe-control driver

Describe the hardware, not driver...

> 
> Signed-off-by: Toyama Yoshihiro <yoshihiro.toyama@sony.com>
> Signed-off-by: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
> ---
>  .../probe-control/linux,probe-controller.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> new file mode 100644
> index 000000000000..1945a7a5ab3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 Sony Group Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/linux,probe-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Probe control device
> +
> +maintainers:
> +  - Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
> +  - Toyama Yoshihiro <yoshihiro.toyama@sony.com>
> +
> +description: |
> +  This binding is for controlling the probes of a set of devices in the system.
> +  Probe control device is a dummy device that can be used to control the probe
> +  of a group of devices. To have finer control, the devices can further be
> +  divided into multiple groups and for each group a probe control device can
> +  be assigned. This way, individual groups can be managed independently.
> +  For example, one group can be for pcie based devices and other can be
> +  scsi or usb devices.
> +  Probe control device is provider node and the devices whose probes need to be
> +  controlled, are consumer nodes. To establish control over consumer device
> +  probes, each consumer device node need to refer the probe control provider
> +  node by the phandle.

So all this looks like not suitable for DT at all.

> +
> +properties:
> +  compatible:
> +    const: linux,probe-control
> +
> +  probe-control-supply:
> +    description:
> +      Phandle to the probe control provider node.

I don't understand this. Regulator supply is not a provider node.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // The node below defines a probe control device/provider node
> +    prb_ctrl_dev_0: prb_ctrl_dev_0 {

No underscores in node names.

> +        compatible = "linux,probe-control";

Where are the resources? It's empty?

> +    };
> +
> +    // The node below is the consumer device node that refers to provider
> +    // node by its phandle and a result will not be probed until provider
> +    // node is probed.
> +    pcie@1ffc000 {
> +        reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
> +                 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> +
> +        probe-control-supply = <&prb_ctrl_dev_0>;
> +    };

Best regards,
Krzysztof


