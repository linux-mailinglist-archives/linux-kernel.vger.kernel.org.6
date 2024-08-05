Return-Path: <linux-kernel+bounces-274410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF99477D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E71BB23ACC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938DE153824;
	Mon,  5 Aug 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cSCJWCq8"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913833CA;
	Mon,  5 Aug 2024 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848337; cv=none; b=p3dkw48b9nQDUNq7arzQ4cU3fihzHG73INZuqMq5+9x6MdhR8RkNwx9GGaAcBJe6WH2eY+cAyig/xofqKiNIE+N+ORF5T7ytNZu6ZutU1CwNzXLXKw4As709ZedMJZwSTyED+ucagoiOdCddLRnP8r51anuBYK3sSBEIo9WHlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848337; c=relaxed/simple;
	bh=7VEQ44pggV3OfhjjVh8YdtmW67p9HcZn+ewpvqkAW+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=CPV9M+lUY9wujBVkfdo5PCRcU9KdMwA4bmnKXKAcjBhFDjRUUfzYsnd5N8V++WO82VzTMPjPu0cR+PnKRqWF+VaKjn3noo/h1Ri3yKjcMhQ86bWc+/pQa474x9EwLA9GRyydV38M0FBo+GM7Y/IpoYHqtY1iMCznUX6IRDBh67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cSCJWCq8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2735760002;
	Mon,  5 Aug 2024 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722848327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hspDI21NExis9E21OLcVoQ7yINV4U0zlx252AwZl/ds=;
	b=cSCJWCq8tYxsmdlxVHyiNBZ+GW78Unsjq1KAV2o6qllCYFq1ZsIbJw/ll0QnOsnOdPeITg
	uwk+R5XRNl7PDCDM23eUe0t66sp44iMGQRhqPIiyLRKp7cFeDXYmP9efnkdUdf7UvAgI2m
	4JJ2Fl/bG31ROCDk299GVV5RLs2jZSH19DXxtSlxL50eBMjgVReuSnMtlZNTsIuua31Gsq
	nxwyVKGAxpwAWCDfQ1idQV4Gvu0gBM5SxXvv38KD+OLFjfGYyr1WWcbasxTA9JutLJAT41
	PjFMzraBLRaeNlL85UqtZngxq4G8OcFkvFBfJBiVKDC8vbKEhuJKLlEagr+nPA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Aug 2024 10:58:45 +0200
Message-Id: <D37UREKS0WIL.194M8MD5LEN2T@bootlin.com>
Cc: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 "Kevin Hilman" <khilman@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Conor Dooley" <conor.dooley@microchip.com>
To: "Roger Quadros" <rogerq@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Peter Chen" <peter.chen@kernel.org>, "Pawel Laszczak"
 <pawell@cadence.com>, "Mathias Nyman" <mathias.nyman@intel.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 00/12] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
X-Mailer: aerc 0.18.1-0-gaa8319bc591f
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <37760e53-4e0d-4275-8497-1b51dcf72d5a@kernel.org>
In-Reply-To: <37760e53-4e0d-4275-8497-1b51dcf72d5a@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Roger,

On Sat Aug 3, 2024 at 5:14 PM CEST, Roger Quadros wrote:
> On 26/07/2024 21:17, Th=C3=A9o Lebrun wrote:
> > Currently, system-wide suspend is broken on J7200 because of a
> > controller reset. The TI wrapper does not get re-initialised at resume
> > and the first register access from cdns core fails.
> >=20
> > We address that in a few ways:
> >  - In cdns3-ti, if a reset has occured at resume, we reconfigure the HW=
.
> >  - We pass the XHCI_RESET_ON_RESUME quirk, meaning the XHCI core expect=
s
> >    a resume.
>
> OK.
> >  - We add a xhci->lost_power flag.
>
> Why?
>
> >=20
> > The previous revision had one big issue: we had to know if
> > reset-on-resume was true, at probe-time. This is where the main
>
> Don't we already know this at probe-time? why not just rely on the existi=
ng
> XHCI_RESET_ON_RESUME qurik, than add a new mechanism?

Some TI platforms cannot tell, before going to suspend, if their USB
controller will reset. Suspend behavior is defined by (at least) two
features:

 - Power domains. See arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:

   usbss0: cdns-usb@4104000 {
      compatible =3D "ti,j7200-usb", "ti,j721e-usb";
      // ...
      power-domains =3D <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
      // ...
   };

   This `power-domains` property implies that even s2idle will reset
   the controller.

 - Deep suspend. The type of suspend defines what will happen to various
   controllers. Currently deep suspend is suspend-to-RAM, with the SoC
   being turned off.

   This might evolve over time with more complex rules: the chosen
   suspend behavior could depend on wakeup source and/or wakeup target
   latencies. That information might not be available to Linux, being
   decided upon by firmwares. We need to be able to resume successfully
   without being surprised by a reset.

I am sorry the precise usecase wasn't clear from the get-go.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


