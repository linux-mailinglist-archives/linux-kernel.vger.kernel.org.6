Return-Path: <linux-kernel+bounces-386390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32079B42D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A337B218BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C642022DB;
	Tue, 29 Oct 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPaku7wJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B72201272;
	Tue, 29 Oct 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185693; cv=none; b=TFl4GLwBS65qrAMkO+KGPC02VEeECzOgbJhLE02ESZyUmvgsOj7IHgTavxIApXwxy8sLU6ymcOuihp8Wls0rKYdtzqXRC9WW+g9E8bKg6Uf65+Wt3wqNPM5YWa6r+sbHl+iNhNQ/SaUbUOC6mHoplau5bvei4aNtRJvWoR5AqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185693; c=relaxed/simple;
	bh=QqdGwzdWyWYq74j5nbJIhBAwMAafnAmcF+kHTe/tBUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXRDj3GSZAm6s0mRdITmjLHJpTcYf2pcgAo1MRQF5vviWIOjTlSaqD5PUEpn4m6LQhMutVAU3FbA7PNh/Eg/Mcuy9XTUJh0QYRtj5/s9gdFqhF/B778zgTQOUeyyBEPfDdo524pkd5m+yzL67JbIhiSfCqUzPgu9HblQwNiZxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPaku7wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD8C4CECD;
	Tue, 29 Oct 2024 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730185693;
	bh=QqdGwzdWyWYq74j5nbJIhBAwMAafnAmcF+kHTe/tBUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPaku7wJpXWqF2oxU6uHuPaIVg5kAMGPba80eM3QFVEtRWTx23ej69uaGtqnA1TUt
	 mIJeJZU6TCCFFY27CsVisof5XL4y/pteJLyrW6wX4woQsM2kWoHEqhlKQOUnAzed/c
	 3h1HFssX7G2oLspMibuEThvbXam8OrB3g0nmrLZtIJDXdUy6qiqcmnM2P2ugJg9W31
	 sLXAAKM6LNgcQWAvAzJNsKpDWexzpeM4de2/rx7mNeXhlDgGMIbT2U6AM0Nc7lGRz6
	 OpqCQl3NYvA+XhCpn7VP+IzpLqCYDj4hhab9zJ9yMfQAsNNjHKKks6/7Kn8tlbertA
	 fCYFKJ8aK63ww==
Date: Tue, 29 Oct 2024 08:08:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <j3a76pyolo66bcqemeo4o3gwzfnftcfjc6grg3v33u7ipztwiq@donxxbveypjk>
References: <20241028105413.146510-1-francesco@dolcini.it>
 <20241028105413.146510-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028105413.146510-2-francesco@dolcini.it>

On Mon, Oct 28, 2024 at 11:54:12AM +0100, Francesco Dolcini wrote:
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
> v4:
>  - add $ref: usb-xhci.yaml
>  - description: wrap to 80 columns, add that the two variants use the
>    same device ID
>  - revise the example, based on comment from Rob and taking
>    marvell,prestera.yaml as an example (this binding was reviewed and
>    amended by Rob in the past).
> v3: use lowercase hex in compatible
> v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> ---
>  .../bindings/usb/ti,tusb73x0-pci.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> new file mode 100644
> index 000000000000..e98a2e0bfcbb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
> +
> +maintainers:
> +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> +
> +description:
> +  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> +  The TUSB7320 supports up to two downstream ports, the TUSB7340 supports up
> +  to four downstream ports, both variants share the same PCI device ID.
> +
> +properties:
> +  compatible:
> +    const: pci104c,8241
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,tusb7320-pwron-active-high:

Drop tusb7320. There is never device name in property name, because it
is redundant and makes it completely not-reusable.

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Configure the polarity of the PWRONx# signals. When this is present, the
> +      PWRONx# pins are active high and their internal pull-down resistors are
> +      disabled. When this is absent, the PWRONx# pins are active low (default)
> +      and their internal pull-down resistors are enabled.

Best regards,
Krzysztof


