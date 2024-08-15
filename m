Return-Path: <linux-kernel+bounces-288209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F2953757
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAB11C2376F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DCB1B0108;
	Thu, 15 Aug 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV+V+HSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3CA1AD411;
	Thu, 15 Aug 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736051; cv=none; b=STDB2rS9eyjACcphYxil/G/kQ4ooQ75oUu7dIhNSpe10rJLo0BOFM7AYXxPp25ERDTFOElDwvgd3PSb8+ghyqK9NOKNK0psixQIfhZMSLbVO9XcoQOy/fRwSCL7twby0Ws55wuYIeiDtIIQXwufH2b5C6LL2GcApNtktEHMXeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736051; c=relaxed/simple;
	bh=NWCUB6vP2/nJNJuu+FosPQqpp6/x8RdAq3UiVtjp2wg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VPvS4vi3Dio80dmd3AS77YQujfrzIczNuHAhn5x9FN/aCfA5XesD5zoYtp0tf6yy84gX/u1dVHDEJRxxZ5OLtOu+7NylcuHaZThBlFFULeOnDZgTGLoKS4+C+PWOGGvfk9aE39Qcl4W8RKw+dWoL44D4bZbYBC8v0iZmV7E9BMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV+V+HSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1332EC4AF12;
	Thu, 15 Aug 2024 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736051;
	bh=NWCUB6vP2/nJNJuu+FosPQqpp6/x8RdAq3UiVtjp2wg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BV+V+HSRMGCyhFmmQreBBvO6Ri4se00GtFU9q1tNouss2ug3Fnt+a6UUztbX7bz6q
	 EYQ6JkEgbVhvxOxv9HsWR045bgVdNVen50ziipNkrVorhY6COT9KHaIwJ7BuFfqzgi
	 ZD9Cisw+MJrBo1DR18r2G8vsWP5qZbufuSrDsOPUwHEp4hY6gRUzL17/9lQIDWM0RL
	 5EAZmm7ADuENcAVI0BlpoMdZ7C8tJu0U4W8wunuRlpxxjWuEeVsuUdprkW6UHxUQsx
	 XY/5nUf+0J8I9zUuvxirjJZqCrCT+PrY9OB9/IV5D8pYhbt5wUYdBdnVbqv4w95PQF
	 sML1tNj1Iu/bA==
Date: Thu, 15 Aug 2024 09:34:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240815-premiere-given-1dab82e67eba@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-premiere-given-1dab82e67eba@spud>
Message-Id: <172373604837.1948390.3086850523957574490.robh@kernel.org>
Subject: Re: [RFC PATCH 01/11] dt-bindings: mailbox: mpfs: fix reg
 properties


On Thu, 15 Aug 2024 15:01:03 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> When the binding for this was originally written, and later modified,
> mistakes were made - and the precise nature of the later modification
> should have been a giveaway, but alas I was naive at the time.
> 
> A more correct modelling of the hardware is to use two syscons and have
> a single reg entry for the mailbox, containing the mailbox region. The
> two syscons contain the general control/status registers for the mailbox
> and the interrupt related registers respectively. The reason for two
> syscons is that the same mailbox is present on the non-SoC version of
> the FPGA, which has no interrupt controller, and the shared part of the
> rtl was unchanged between devices.
> 
> This is now coming to a head, because the control/status registers share
> a register region with the "tvs" (temperature & voltage sensors)
> registers and, as it turns out, people do want to monitor temperatures
> and voltages...
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/mailbox/microchip,mpfs-mailbox.yaml       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dts:27.13-38: Warning (reg_format): /example-0/soc/mailbox@37020800:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dts:25.28-31.13: Warning (avoid_default_addr_size): /example-0/soc/mailbox@37020800: Relying on default #address-cells value
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dts:25.28-31.13: Warning (avoid_default_addr_size): /example-0/soc/mailbox@37020800: Relying on default #size-cells value
Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240815-premiere-given-1dab82e67eba@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


