Return-Path: <linux-kernel+bounces-332747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E697BE44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFC282AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86471C3F1E;
	Wed, 18 Sep 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0h/TcEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B231C32EB;
	Wed, 18 Sep 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671318; cv=none; b=GHR4xzNh3U2rsU6mKIkhL7jHl3yfhfDIUGk81vFD8vhbthoSph+EKphl+Msa/r3Rrodq0qZ9NOLDTel7rnoe64uHj7zReZU8skBp8Kr1CHpyLf7ck1iN3Ci2jF3BHyNGf604+AS4mSucdWn2qTmnsYxqpcuwY12jpR/zMNkTfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671318; c=relaxed/simple;
	bh=NZradPtTQgiorCoRL5b8AEiP0ukiBDGBBYb0phx50k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8uxQGoRjooxk/y+0xcp123cKGGwTPnRIxnYQGsjyi1Id3cnUY+7dNVc5CXgW6b54sY7GYPjCUCuLSqDEIzXO7VdY5ZHh8QjeI76YVSAPSIq6qTw/UhgCjRDTW1DpX8xvm9E3V+7Bnyh4Lb949LL2889kccz/RZ+ihKYiGDj2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0h/TcEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F0C4CEC2;
	Wed, 18 Sep 2024 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726671317;
	bh=NZradPtTQgiorCoRL5b8AEiP0ukiBDGBBYb0phx50k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0h/TcEsbiRR6fgkbWIxS8nIRprbq6VKUsK+6fQkQsUTbIyoApUT5du1QtsduGHvK
	 kMV0gNqfAxjkdsJAi4pIJnczFHfm4yecMPGpqR/dPomtTwGpVcVn9pErq3BQoZUrv0
	 hN7F+8h9o4cxJFYUE/xfRNhIsyCmYWWrgmKUAF+X/K00R/lyzD3L3jVXkm+S2E7Qpt
	 MxevvIBY5HlJnALtAvkDgrlQ5zEujBV4uErwhdE8KQCyW25Cbn3REt+CpL7qkT5tHO
	 OLImN/ucVbnpYLoX3WUvblTeNn4F8eI8xu69+7k1yUzJSLpVOxzqz6Dc3C1pLqHHXV
	 PsSu2UERXDTuQ==
Date: Wed, 18 Sep 2024 09:55:16 -0500
From: Rob Herring <robh@kernel.org>
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, yoshihiro.toyama@sony.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] driver: core: add probe control driver
Message-ID: <20240918145516.GA1560032-robh@kernel.org>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>
 <20240912204634.GA738361-robh@kernel.org>
 <ZulEFlDoRz4USTB8@NAB-HP-ProDesk-600sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulEFlDoRz4USTB8@NAB-HP-ProDesk-600sony.com>

On Tue, Sep 17, 2024 at 02:25:50PM +0530, Nayeemahmed Badebade wrote:
> Hi Rob,
> 
> Thank you for taking the time to check our patch and provide
> valuable feedback. We appreciate your comments/suggestions.
> 
> Please find our reply to your comments.
> 
> On Thu, Sep 12, 2024 at 03:46:34PM -0500, Rob Herring wrote:
> > On Wed, Sep 11, 2024 at 07:53:19PM +0530, Nayeemahmed Badebade wrote:
> > > Probe control driver framework allows deferring the probes of a group of
> > > devices to an arbitrary time, giving the user control to trigger the probes
> > > after boot. This is useful for deferring probes from builtin drivers that
> > > are not required during boot and probe when user wants after boot.
> > 
> > This seems like the wrong way around to me. Why not define what you want 
> > to probe first or some priority order? I could see use for kernel to 
> > probe whatever is the console device first. Or the rootfs device... You 
> > don't need anything added to DT for those.
> > 
> > Of course, there's the issue that Linux probes are triggered bottom-up 
> > rather than top-down.
> > 
> 
> Our intention is to only postpone some driver probes not required during
> boot, similar to https://elinux.org/Deferred_Initcalls. But instead of
> delaying initcall execution(which requires initmem to be kept and not
> freed during boot) we are trying to delay driver probes as this is much
> simpler.
> 
> > 
> > > This is achieved by adding a dummy device aka probe control device node
> > > as provider to a group of devices(consumer nodes) in platform's device
> > > tree. Consumers are the devices we want to probe after boot.
> > 
> > There's the obvious question of then why not make those devices modules 
> > instead of built-in?
> > 
> 
> Yes we can use modules for this, but there are drivers that cannot be
> built as modules and this framework is specifically for such scenario.
> Example: drivers/pci/controller/dwc/pci-imx6.c

Then fix the driver to work as a module. Or to use async probe which is 
not the default and is opt-in per driver.

> 
> > > 
> > > To establish control over consumer device probes, each consumer device node
> > > need to refer the probe control provider node by the phandle.
> > > 'probe-control-supply' property is used for this.
> > > 
> > > Example:
> > >     // The node below defines a probe control device/provider node
> > >     prb_ctrl_dev_0: prb_ctrl_dev_0 {
> > >         compatible = "linux,probe-control";
> > >     };
> > > 
> > >     // The node below is the consumer device node that refers to provider
> > >     // node by its phandle and a result will not be probed until provider
> > >     // node is probed.
> > >     pcie@1ffc000 {
> > >         reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
> > >         #address-cells = <3>;
> > >         #size-cells = <2>;
> > >         device_type = "pci";
> > >         ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
> > >                  <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> > > 
> > >         probe-control-supply = <&prb_ctrl_dev_0>;
> > >     };
> > 
> > Sorry, but this isn't going to happen in DT.
> > 
> 
> You mean we cannot add custom properties like this to an existing
> device node in DT?

Sure, you can add properties. It happens all the time. This is too tied 
to some OS implementation/behavior and therefore is not appropriate for 
DT.

Rob

