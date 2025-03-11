Return-Path: <linux-kernel+bounces-555643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4BA5BAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D5A1896289
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABAE224B07;
	Tue, 11 Mar 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPTHEgBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8101E7C2B;
	Tue, 11 Mar 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681226; cv=none; b=Hpg04h+VN/kWjTsqkE91oe6Qcayh93DiZWGFDNy7YKJsYaN00owM2Jj5TnxEiaEYC+TnkLKtNogW7yZJUyrAf//ihOO6lQFRnX0GZ7STdm/1MGhEQp8of4407RaQUpzgesYBbhEaXOVntwsqn0bDzkGjZR+IcqeSwQRmMM/h19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681226; c=relaxed/simple;
	bh=gaGVYX0NNOaIcaCq6wPZv9fxpNdPOdTR8URu/LPwxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+TGFLUClvDa3XKL6Gbx1jOBWpGfGFPT35BwWY5IGV5UXkr77A9hOnuxMABSnQdmVidxii6pwYKd8FxFwhn2EpfIc2APxubtqb3FTBymeTrogPQ9egvKZS07dzwLT2qxfP4fuW/vZ6V/DW2DT1d66/rjCLPRir0ZeD5vUKvVfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPTHEgBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E64AC4CEEF;
	Tue, 11 Mar 2025 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741681225;
	bh=gaGVYX0NNOaIcaCq6wPZv9fxpNdPOdTR8URu/LPwxus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPTHEgBEaigvAitgVNeQ5F6kP2BP+sjQkfPwZ+DWbHyC//fBTuj280Ds7/H5uor4d
	 y+AMnjeIRniwEOdALym7aNeBUhyrdbQmVzbN8MNmVTUoHLIhbIS6YmBlcXQls2XubU
	 fUnx1tygHDYNSX5khc094R3JZV5FQnMhwrKjM/o9q5MOcn6wTTtJ9Pm2nBPJLqL7Kz
	 aIemnq76eJpcetTu9JAS0kVRZchzJUD129eGUBbLB/ETZt/QWF8hBqcMsSZ8ULNrbb
	 u9F6WaICJVWRvsg6kshqgK8BP7xEDURWa/kDsbNU2UAiI1zRzhVsV9n0SgNXoKcLNx
	 E3ZyD2tAqmEFg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1truqa-000000004FQ-16rC;
	Tue, 11 Mar 2025 09:20:20 +0100
Date: Tue, 11 Mar 2025 09:20:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <Z8_yRFZrb6WFp5Y2@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
 <2024100109-maker-ravine-7c65@gregkh>
 <20241028225702.tdtfqzhm335vvuv5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028225702.tdtfqzhm335vvuv5@pengutronix.de>

On Mon, Oct 28, 2024 at 11:57:02PM +0100, Marco Felsch wrote:

> On 24-10-01, Greg Kroah-Hartman wrote:
> > On Tue, Oct 01, 2024 at 09:24:53AM +0200, Marco Felsch wrote:

> > > gentle ping as this is series is two months old now.
> > 
> > And it was rejected as serdev does not support hotplug which of course,
> > usb-serial does.
> 
> I hoped to get some feedback on my answer [1]. Regarding hotplug
> support: serdev _requires_ some sort of firmware like OF (not sure if it
> does work with ACPI too). That said, if serdev finds no firmware a
> fallback is provided to the standard serial handling.

It's devices going away not being supported which is the main concern.
The serdev ttyport implementation does not implement hangup() which is
used for serial port tear down.

> The firmware could either be added directly by the platform OF file or
> via OF-overlays. By making use of overlays we could gain some kind of
> hotplug: Once a usb devices was detected and the driver has an
> overlay, the overlay gets applied and the probe continues, like we do it
> for PCIe devices now [2]. For devices which don't have a registered
> overlay the standard usb-serial setup is done by exposing the serial
> interface to the userspace.

Then it would also be nice to have a way to describe hotplugged devices
on the fly, and overlays could indeed be used for that. But that's a
separate story.

Johan

