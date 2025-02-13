Return-Path: <linux-kernel+bounces-512365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D833A3381A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA133A6E40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590020897A;
	Thu, 13 Feb 2025 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVo+psVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D831207E07;
	Thu, 13 Feb 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428958; cv=none; b=u8r1k8zsi+erM/7w2jYUIKa/lnTCY2iwmDrP43No15bMLbbhVWPALKLlaSFP0i7LqkpwrRec+QIbtxEogve9mUfSCDW8MvAUvJsnO2+rGu1mNxK8sc1CtkUAoKp/oIsmOw7sfVoODt19QO0EYPaCnYVo191HoBzy8ihcGtPAA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428958; c=relaxed/simple;
	bh=wSfzicfqZaGMaX/zy9i0qtnv9BY7+9lOnhH4GUr4yd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COYL+hCFPZfAiGlan3dur8s41FAh5aqAfzBYPNhidiHF0jtZPcJ9fvdeqzDNUUhncUhyjpX9aZI68daGzLfaZ4iS9OPo+8cGWf9Pb39OlG68h+4Ix+z36BVMFNSZITlK0C/+Gkrkl2fzN11CCk0y/Jk3AuLGG3yOKgKRpxChyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVo+psVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C83C4CED1;
	Thu, 13 Feb 2025 06:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739428957;
	bh=wSfzicfqZaGMaX/zy9i0qtnv9BY7+9lOnhH4GUr4yd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVo+psVlvUiOKBdW+Xk5NAoqefLAKu66zX8SaYpPRQh3zYFySTDP7EZ2VClOWYjC/
	 l1HURmC/RB4sV2xe5GNZ7blayI+eV61hKG3RVR1LbxOqL9xNZwCG7UinYY00V+fGdt
	 Qf37RwM651Va+5kdCOHt3SjFLyWYYSDLL8b1nWkaMkf6tnn/0vUo27iCiyJYg5XuU4
	 gg86fy7Oay9QR2RHT14pMoJYq7bESMGtvWeVQTPkI+Xt55FiB/WcztsOfRMnRi1WCv
	 X9fX0J8NKvCO6SfKuLxV2X8WKxUNcrrOBlcHr2KyEs9RCUHAZDUnI7aK+OEnvm/zDX
	 ClJQYN1dp396A==
Date: Thu, 13 Feb 2025 14:42:28 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Hector Martin <marcan@marcan.st>
Cc: devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-usb@vger.kernel.org, linux-embedded@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: Unified Type C PHYs and top-level port management
Message-ID: <20250213064228.GA181829@nchen-desktop>
References: <fda8b831-1ffc-4087-8e7b-d97779b3ecc5@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda8b831-1ffc-4087-8e7b-d97779b3ecc5@marcan.st>

On 25-01-14 21:32:11, Hector Martin wrote:
> Hi all,
> 
> We're implementing Type C port support for Apple systems and we're
> running into impedance mismatches with the existing Linux subsystems. I
> want to throw a quick overview of the problem here and see if we can
> come up with solutions.
> 
> The short version is that Linux has a pile of (sub)subsystems that deal
> with multiple aspects of coordinating Type C port behavior:
> 
> - USB role switch
> - USB host
> - USB gadget
> - Type C mux
> - Type C PD
> - DRM/etc for DisplayPort
> - USB4/Thunderbolt (not even going there yet)
> - Individual PHYs for everything
> 
> This evolved from, and is largely designed for, systems built from
> discrete components (separate USB3 controller, DP controller, external
> mux, PD stuff, etc.)
> 
> What we actually on Apple systems is:
> 
> - An external I2C USB-PD controller that handles the entire PD protocol
> and negotiation autonomously. We don't even get to pick the altmode, it
> does all the policy on its own and there is no override (we looked).
> - USB3/4/DP retimer and eUSB2 level shifter chips (not muxes) that are
> managed by the external USB-PD controller over I2C, invisible to Linux.
> - A single, unified, shared PHY (atcphy) that handles *everything*:
> USB2, USB3, DP, USB4/TBT, depending on configuration. It presents
> discrete interfaces to the DP, TBT, and USB controllers behind it.
> - A dwc3 controller per unified PHY, with host and device modes. Its
> USB3 PIPE interface can be switched (via registers in the PHY side, not
> the dwc3 side) between a dummy PHY, the USB3 PHY, or a virtual PHY that
> does USB4 tunneling.
> - A set of display controllers that are separate from the ports/PHYs
> - A DisplayPort router that can pair a display controller with a given
> unified PHY's physical DisplayPort interface, or one of two tunnels over
> TBT/USB4. The display controllers are n:m matched to the ports, they are
> not 1:1 (there may be fewer display controllers than ports).
> - The whole TBT/USB4 PCIe stuff which winds up in a PCIe root port
> controller per port/PHY (not going to consider this for now, leaving
> that for later).
> 
> The current approach we have is a mess. The tipd driver (which manages
> the PD controller) directly does the role switching and mux calls. The
> role switching triggers dwc3 to asynchronously switch modes. Meanwhile
> the mux calls end up at our PHY driver which tries to reconfigure
> everything for the given lane mode. But since PHY configuration also has
> to negotiate with dwc3, it also acts as a PHY for that (two, actually,
> USB2 and USB3). However, the callbacks from dwc3 are all over the place,
> and we end up having to do things like handle USB3 configuration from
> the USB2 PHY callbacks because that happens to be the correct timing to
> make it work. Meanwhile DRM/DisplayPort is its own thing that is mostly
> asynchronous to everything else, only reacting to HPD, and we haven't
> even gotten to the dynamic assignment of display controllers to ports
> yet (that's a story for another day).
> 
> To give an example of one of the quirks: Thanks to the USB-IF's
> amazingly braindead stateful and non-self-synchronizing eUSB2 protocol,
> we need to fully reset the dwc3 controller every time there is a hotplug
> event on the port from the PD controller. Otherwise USB2 breaks, since
> the PD controller will reset the eUSB2 level shifter on unplug and dwc3
> and the paired eUSB2 PHY can't recover from that without a full reset.
> 
> A further complication is we do not have documentation for any of this.
> The PHY setup is all reverse engineered. That means all we can do is
> replicate the same register operations that macOS does, and then we have
> to *guess* how to fit it into Linux, and what can be moved around or
> reordered or not. There is no way to know if any given Linux
> implementation is correct and reliably configures the PHY, other than
> trial and error, unless we can exactly replicate what macOS does (which
> is infeasible in Linux today because the cross-driver sync points aren't
> in the same places, e.g. dwc3 and its phy callbacks do not match the
> interleaving of PHY register writes and dwc3 register writes in macOS).
> 
> This is never going to be reliable, robust, or maintainable with the
> current approach. Even just getting it to work at all is a frustrating
> mess, where fixing one thing breaks another (e.g. if the dwc3 role
> switch happens first, that runs in a workqueue, and ends up racing with
> phy reconfig. We found out our current code was working by accident due
> to some msleep() calls in dwc3. And of course, hotplug is all kinds of
> racy and broken.). The sequencing requirements make this whole approach
> using different subsystems for different things without central
> coordination a nightmare, especially with hotplug involved and devices
> that like to switch their altmode negotiation rapidly on connect cycles.
> It all ends up depending of subtle implementation details of each part,
> and if anything changes, everything breaks.
> 
> What we really want is a top-level, vendor-specific coordinator that
> *synchronously* (in a single logical thread) handles all
> hotplug/modeswitch operations for a single port, driving state
> transitions for all the other drivers. I.e. something that can:
> 
> - Receive a data role/status change from tipd (this includes *all* port
> mode including data role, altmode config, etc.). This can be
> asynchronous/queued relative to tipd, but all config changes must be
> processed in sequence as a single queue.

Just some ideas and see if it could improve things for you.

If your PD driver reports some intermediate states, try not to handle
them all, it could avoid de-init some operations which has done at the
previous states. And for all PD events, queued them at ordered work
queue with some delay.

> - Deconfigure the previous mode for consumers, e.g. shutting
> down/resetting dwc3 if required, unsetting HPD for the DisplayPort side
> so it knows to shut that side down, etc.
> - Change the unified PHY configuration for the new mode (this may
> require knowledge of everything about the port state including data
> role, not just altmode/mux state)
> - Start up the consumers again
> - React to PHY callbacks from the consumers to further drive PHY state
> changes (some things need to happen in a specific sequence or at request
> from dwc3 or the display controller firmware, and we may have to add
> extra callbacks for some points somehow, which doesn't fit well with the
> current PHY subsystem which is more rigid about operations...)
> 
> Right now, I don't see any way this would fit into the existing
> subsystems well. The closest thing I can come up with, and what I will
> do to get by at least for the time being, is to:
> 
> - Get rid of the asynchronous dwc3 role switching, making it synchronous
> (optionally if needed to not break other users)

It is a good try, it could let the PHY lane switch later than controller role
switch, besides, you need to let your DP HPD handling after PHY switch
to DP mode.

Peter

> - Add a queue to tipd so it can handle state changes asynchronously from
> the actual PD protocol (and without blocking i2c bus interrupt handling
> so other ports can operate in parallel), but all state changes are
> handled sequentially without any overlap, and the ordering is carefully
> controlled (Connect: mux call first, then USB role switch, then
> DisplayPort HPD. Disconnect: DisplayPort HPD, then USB role switch, then
> mux call. There may be other complex cases for mode changes while
> already connected, this won't be fun.).
> - Put most of the PHY policy in the atcphy driver (which is all of a
> reset driver for dwc3, mux driver, and all the phys). This includes ugly
> things like deferring state changes while dwc3 is active in some cases.
> - On the DP/display side, we haven't implemented this yet, but in the
> future the single "apple,display-subsystem" driver (which actually
> provides the top-level DRM device for all the underlying discrete
> display controllers, and is already its own virtual device in the DT)
> will present virtual ports for the different PHYs, and handle the
> muxing/assignment between them and the display controllers on its side
> (there is potentially complex policy here too, since not all display
> controllers are equal and there may be a need to reassign a display for
> a lower-spec screen to a lower-spec display controller to free up a
> higher-spec controller for a higher-spec screen, but we need a
> controller assigned to a port to even read EDID to figure that out, so
> it's going to be messy).
> 
> But I'm not happy at all with the weird, load-bearing intermingling of
> tipd/atcphy/dwc3 there. There's bound to be places where the
> abstractions leak and we end up with more and more horrible workarounds,
> or layering violations.
> 
> A further question is how all this should be represented in the device
> tree. That might drive the software architecture to a point, or vice versa.
> 
> Any ideas?
> 
> Some further reading here:
> https://social.treehouse.systems/@marcan/113821266231103150
> 
> - Hector
> 
> 

