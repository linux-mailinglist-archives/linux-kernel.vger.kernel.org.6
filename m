Return-Path: <linux-kernel+bounces-326205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDCB9764EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02871C23066
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD2191F6E;
	Thu, 12 Sep 2024 08:50:57 +0000 (UTC)
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160511A28D;
	Thu, 12 Sep 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131057; cv=none; b=VPIZMrlNordo7kjzFfLvsse68sI59p1pMh/3KOtXfw7vuTRGeqMD6UsakN0KO7//hNo2Z7sadt9gDaqxp6lEmGqUrOrezufDnAD8NiPRR5lcvhTMO4KA/EzSe+3K1ToFfMCJBv/g1+s4WhjN8xrlY0n4vhD2mZZUCWVXiJaB+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131057; c=relaxed/simple;
	bh=c8HyqOidXdqkjfP+IvUGSpv3WS5hePUxpBdEbOgNNXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oenRgkbw0u15pTdl4kUuiuHp5f6ZYJTr8l/FR+vfk1xQNSbrGyzQwCOOdTAfVmOjDyWlNGC/7l/vMHonz7ULyfDvNPij3n1cmHnP8wNvrgU8mpkw36ebiS1wwxoF3KsD7iq7ZKM/lwSV8fqThLGfdnBea7bcOqBbfnn+UdAUIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl; spf=pass smtp.mailfrom=stappers.nl; arc=none smtp.client-ip=141.105.120.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stappers.nl
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id 476252000E;
	Thu, 12 Sep 2024 08:50:45 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id AC09330417C; Thu, 12 Sep 2024 10:50:13 +0200 (CEST)
Date: Thu, 12 Sep 2024 10:50:12 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Ayush Singh <ayushdevel1325@gmail.com>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Message-ID: <ZuKrRJUwBrcV8ffq@gpm.stappers.nl>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
 <2024091151-unworldly-dance-9a80@gregkh>
 <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
 <419bf74e-74cb-46ca-95d0-03b3bab3948d@de.bosch.com>
 <2024091211-bladder-runner-2d75@gregkh>
 <8072c698-93b0-4d3a-a970-e276243f82c4@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8072c698-93b0-4d3a-a970-e276243f82c4@beagleboard.org>

On Thu, Sep 12, 2024 at 01:47:18PM +0530, Ayush Singh wrote:
> On 9/12/24 13:09, Greg Kroah-Hartman wrote:
> > On Thu, Sep 12, 2024 at 09:29:01AM +0200, Dirk Behme wrote:
> > > On 12.09.2024 09:16, Ayush Singh wrote:
> > > > On 9/12/24 01:34, Greg Kroah-Hartman wrote:
> > > > > On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
> > > > > > On 9/11/24 20:28, Greg Kroah-Hartman wrote:
> > > > > > > >     addon_boards/mikrobus/Makefile         |  1 +
> > > > > > > >     addon_boards/mikrobus/mikroe-1714.dtso | 28
> > > > > > > > ++++++++++++++++++++++++++++
> > > > > > > Odd top-level directory for the kernel, are you sure this is correct?
> > > > > > I am open to moving them to a more suitable location if we have one.
> > > > 
> > > > So here are the directories where dtso files currently go:
> > > > ❯ find . -type f -name "*.dtso" -printf "%h\n" | sort -u
> > > > 
> > > > 
> > > > Out of these, `drivers/of` and `drivers/of/unittest-data` contain
> > > > unittest dtso, so probably not the place.
> > > > 
> > > > And the `arch/arm` and `arch/arm64` are for arch specific stuff.
> > > > MikroBUS is supported in RISC-V boards as well (BeagleV-Ahead). So
> > > > probably not the correct location either.
> > > > 
> > > > Maybe something like `arch/common/addon_boards` would be better?
> > > Whats about
> > > 
> > > drivers/misc/mikrobus/mikrobus.rs
> > > drivers/misc/mikrobus/mikroe-1714.dtso
> > > drivers/misc/mikrobus/mikroe-5761-i2c.dtso
> > 
> > Exactly, put them where the drivers are, like clk and of does.
> > 
> > thanks,
> > greg k-h
> 
> 
> So I am writing a more thorough reply in the driver questions,

As I did read it,
is it not "driver questions" but about "location of new files"
and "bus versus device"


> but essentially, the driver is not actually required for using the
> overlay based approach for mikroBUS addon boards. Initially, the driver
> was not supposed to be included in the patch series at all. But I was
> not able to find a way to use a GPIO nexus node [0] without having a
> platform driver attached to the node.
> 
> In fact, if the GPIO nexus node is not required (like in the case of
> weather click), there is no need to even have a mikrobus-connector
> node in dt, let alone a driver.
> 
> So to answer why it probably should not go in the driver directory,
> the driver for the connector, actually does not register the mikrobus
> addon board. And if there is a way to have GPIO nexus node without
> having a platform driver attached to the node, then it should probably
> be removed.
> 
> The reason why the overlay based approach was suggested was because
> previous approaches could not do board stacking (having chain of
> mikrobus connector -> grove connector addon board -> grove board). So
> as you can see, it is beneficial to have grove board overlays compiled
> even in a board without any grove connectors because of stacking.

Please be explicite about file location.

And please elaborate on "bus" in mikrobus.


Make it possible that your audience gets a completere picture.


And for plan B: How important is this patch to the patch serie?


Groeten
Geert Stappers

[0]: https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.html#nexus-nodes-and-specifier-mapping
-- 
Silence is hard to parse

