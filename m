Return-Path: <linux-kernel+bounces-175400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A88C1EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC951F217EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651E15ECEF;
	Fri, 10 May 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nuQUwfNq"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865515ECEC;
	Fri, 10 May 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326329; cv=none; b=QYvtOMmNbTY3p+/ggu+//JZXRnWxww+FNu9+Fe32UEZOcncI1OEzJb+Ie3IiDaMltocrFu/LXEmE1JQ2ZLDCFmKQyyBAaMR85yO1B2qGFEtJxc2+U37AonEPhea6dp6NsWfuQSdxHnvIxQM+wuP4nDjt03eAuRiXTvQp6FH+zr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326329; c=relaxed/simple;
	bh=Fckdb3Fian35DrO+vC9ujlpyzWqeeX/x7xTu4QrzFlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbmYlYIq26JPvYa4PIlrZAm13oVApYn/It3IK3rvk73gY9TP+9SUvjm7aEWLupVfbJ1WtEu7G4ozYQPFKENpKUMKw8QeJ8isfrC3hUIuDGvx8elmmz7hKCywEwUE+u7MFmrrZTqwDiStRXNMxRIXH5f4ikmODBxd5P9x4m1YT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nuQUwfNq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2D6320008;
	Fri, 10 May 2024 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715326319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gy0lQX70PJvtSy4wE21NBe3LM5+X5IH8D2WT9ewXI5o=;
	b=nuQUwfNqdtjSjH9txQZFKddvqweW0O0bXvsoAWLS3Gjl4smDIbDR3+Mmx56Pol2mkPjVKc
	Q5+gZgEuNw6Vu1mThyKSTu4fuISqNrA7oQGaM9dX23bQ2Edr0F/Zd5r35Xm3VUKKy1wMaA
	ZO+mEd89ImY+2pJOiqHVQo+fCvnAyIPrDVXJ28LZX3WTFz2Zg+HP3MspHMVJLJ4w9mWeAD
	YzhcWmocPrA275DAB2iq+0X0zIxav0W2wMoVGBXN9LfdG5V8aiYOLmwVp9lQfnleUPnK0e
	ij5NxkL8Q6m1jF/rrIhtX6RbYvJODmwsZDCQymmrXBcUQlbuRym3g5bXxC91tQ==
Date: Fri, 10 May 2024 09:31:56 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Doug Anderson <dianders@chromium.org>, Chen-Yu
 Tsai <wenst@chromium.org>, Matt Coster <Matt.Coster@imgtec.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: Hotplug hardware with (un)loadable DT overlays - unconference
 meeting notes
Message-ID: <20240510093156.13bfcd34@booty>
In-Reply-To: <20240426115141.201f257a@booty>
References: <20240426115141.201f257a@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

On Fri, 26 Apr 2024 11:51:41 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

[...]

> We described 2 use cases we are working on at Bootlin.
> 
> One use case is for the LAN966x, a classic SoC that can be however be
> started in "endpoint mode", i.e. with the CPU cores deactivated and a
> PCI endpoint that allows an external CPU to access all the peripherals
> over PCIe. In practice the whole SoC would be used as a peripheral chip
> providing lots of devices for another SoC where the OS runs. This use
> case has been described by Rob Herring and Lizhi Hou at LPC 2023 [4][5].
> 
> The other use case, which was discussed in more detail, is for an
> industrial product under development by a Bootlin customer, which is a
> regular, self-standing embedded Linux system with a connector allowing
> to connect an add-on with additional peripherals. The add-on
> peripherals are on I2C, MIPI DSI and potentially other non-discoverable
> busses (there are also peripherals on natively hot-pluggable busses
> such as USB and Ethernet, but by their nature they don't need special
> work).
> 
> For both use cases (and perhaps others we are unaware of) runtime
> loading/unloading DT overlays appears as the most fitting technique.
> Except it is not yet ready for real usage.
> 
> For it to work, we highlighted 3 main areas in need of work in the
> Linux kernel:
> 
>  1. how to describe the connector and the add-ons in device tree
>     (bindings etc) -- only relevant for the 2nd use case
>  2. implementation of DT overlays for adding/removing the add-on
>     peripherals
>  3. fixing issues with various subsystems and drivers that don't react
>     well on device removal

Quick update: I just sent a series with a proposal covering items 1 and
2:

https://lore.kernel.org/all/20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

