Return-Path: <linux-kernel+bounces-327250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5839772DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EFD1F215CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687ED1C1738;
	Thu, 12 Sep 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbiQcff7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205218BBA6;
	Thu, 12 Sep 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173995; cv=none; b=n8beNuRhUiCCuz+lTZz8dAYvBDsBMsWkPpaF7tjWhV42qLQPdIsxLo5ZMi9C/KBNNAqBIMTJSMlaOi7xJN52HxsjB32v9Z/zoVhEo7GO/AkrTyb+QtdpBro2bJA8JU9VDPmANsa3TKv8CzTWpsyydzf03bmwUXvyfi1p1Bn9NVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173995; c=relaxed/simple;
	bh=/8mYsICaaHJ87VmANn82Ajaf8S9WX3W34K2q93jvVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6YW2GRElRudss2oMgtiAz/Ug/vkCxA+vc7bEY2dBbOnws19QWq+9W+5fz0nXuekMC8c2HGm3CY3ocpolIHPITSzbMLHI4B8r0WgwV08RuWXsyViSeO1xyMRCtqbYKgZ07wuPhiNz5EiqgY50OyvdfqTwWgEJedPYmx3Ytpmk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbiQcff7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E77C4CEC3;
	Thu, 12 Sep 2024 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726173995;
	bh=/8mYsICaaHJ87VmANn82Ajaf8S9WX3W34K2q93jvVw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbiQcff77jrTb4JWVWXjWyCEEgNsTfCsrK9K4IKf6IrqVrevVJ4PAK9MtLsFgXgVg
	 Xt1IXQl7DFG1UIwwLuBinZN8ypLCdfGPJBapkmfpvv3MQs6Y3FpqrvrpbAYBDjDcr5
	 wm9amAxwftwJlrPUb9zA1jVwUNaulIHdEAbreGgIDN6htXymIc3WnrzwskpbX+GQBD
	 j5MjFBpNPU8ZaOmmaDT+bdv+wmAkK6Sgch5GwD9Ko+ysoDXxnoPEx5UsiFGpfuTTHe
	 HWKO3kRu9AqcqiABfpLhEpk4YFqpXxciqculD7Ypa21BMCLHNo5qza7l3MvfYfMQ22
	 4YGERTSwMaHHw==
Date: Thu, 12 Sep 2024 15:46:34 -0500
From: Rob Herring <robh@kernel.org>
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, yoshihiro.toyama@sony.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] driver: core: add probe control driver
Message-ID: <20240912204634.GA738361-robh@kernel.org>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>

On Wed, Sep 11, 2024 at 07:53:19PM +0530, Nayeemahmed Badebade wrote:
> Probe control driver framework allows deferring the probes of a group of
> devices to an arbitrary time, giving the user control to trigger the probes
> after boot. This is useful for deferring probes from builtin drivers that
> are not required during boot and probe when user wants after boot.

This seems like the wrong way around to me. Why not define what you want 
to probe first or some priority order? I could see use for kernel to 
probe whatever is the console device first. Or the rootfs device... You 
don't need anything added to DT for those.

Of course, there's the issue that Linux probes are triggered bottom-up 
rather than top-down.


> This is achieved by adding a dummy device aka probe control device node
> as provider to a group of devices(consumer nodes) in platform's device
> tree. Consumers are the devices we want to probe after boot.

There's the obvious question of then why not make those devices modules 
instead of built-in?

> 
> To establish control over consumer device probes, each consumer device node
> need to refer the probe control provider node by the phandle.
> 'probe-control-supply' property is used for this.
> 
> Example:
>     // The node below defines a probe control device/provider node
>     prb_ctrl_dev_0: prb_ctrl_dev_0 {
>         compatible = "linux,probe-control";
>     };
> 
>     // The node below is the consumer device node that refers to provider
>     // node by its phandle and a result will not be probed until provider
>     // node is probed.
>     pcie@1ffc000 {
>         reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
>         #address-cells = <3>;
>         #size-cells = <2>;
>         device_type = "pci";
>         ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
>                  <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> 
>         probe-control-supply = <&prb_ctrl_dev_0>;
>     };

Sorry, but this isn't going to happen in DT.

> 
> fw_devlink ensures consumers are not probed until provider is probed
> successfully. The provider probe during boot returns -ENXIO and is not
> re-probed again.
> 
> The driver provides debug interface /sys/kernel/debug/probe_control_status
> for checking probe control status of registered probe control devices.
>  # cat /sys/kernel/debug/probe_control_status
>  prb_ctrl_dev_0: [not triggered]
>   Consumers: 1ffc000.pcie
> 
> Interface /sys/kernel/probe_control/trigger is provided for triggering
> probes of the probe control devices. User can write to this interface to
> trigger specific or all device probes managed by this driver.
> Once the probe is triggered by user, provider probe control device is added
> to deferred_probe_pending_list and driver_deferred_probe_trigger() is
> triggered. This time the probe of probe control device will be
> successful and its consumers will then be probed.
> 
> To trigger specific provider probe:
>   # echo prb_ctrl_dev_0 > /sys/kernel/probe_control/trigger
> 
> To trigger all registered provider probes
>   # echo all > /sys/kernel/probe_control/trigger
> 
> Signed-off-by: Toyama Yoshihiro <yoshihiro.toyama@sony.com>
> Signed-off-by: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>

This is wrong. Either Toyama is the author and you need to fix the git 
author, or you both are authors and you need a Co-developed-by tag for 
Toyama.

