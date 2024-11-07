Return-Path: <linux-kernel+bounces-400801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9D9C1285
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669E5282C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC831F472F;
	Thu,  7 Nov 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="c8md9D9T"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB153198E99;
	Thu,  7 Nov 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022658; cv=none; b=jtQDa3rLPAyXblFmQFnZXfiBS2r/h7r86hGse0bEO8a1FY8tlX813vzZ5XarPMnmVtd3No7ctdHgmAob6pVKDgVDxqS3U4m7C8S0aTXDm6ss6xbaJBKBTiznED7Pi7UnuIpEe1wM7nkQKslezcxvqVYFL9EwrRPlP9OFEYTVlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022658; c=relaxed/simple;
	bh=7EbOP3R/w0Zq7VNFS9UaWkkyPOuwSSzQVhn4SCDSBDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJVfxBsSoqEPSR8/x+bNzuuFL/vbj6v9X6IFPG0BCvUuWA7OeHHW84/v/jnzKp9uLH8jHoJSYGAKQWOGIgaU1bxKjWIX18ur+9T4WGxBz682YfZ7zyAwLfxmibo+ytquXEt3pCctedMo1NK46TEA2cgO/sdf3dTVeDdz9kxNl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=c8md9D9T; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022653;
	bh=sB9WbFBpbPjCLPWf25Q6cNTRTz1ZxYwqcOTV66sDiIk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c8md9D9T5JUduyHph29pPdPnY7w/3iZEYl8eeCd5EOJSX66dP9k9iydIqE0HXCPyi
	 DjiCfNC4o2EFaCMetlEvYuPLeFCV++2G7k45SA7oA7t9Ziy2ihmAMjySdj5aIrCq8O
	 m4UjPv7OEbc3uBm0jZJBzHyVwA5i0oqDcc7JxyK/lzoXZ4lxLn/BPqBP5QXMV56vOD
	 7VWPQKvP0QnqVCenDj6iZDILl4LN5Aza1KJz5Kw8K1/azoqvLt5GT+z5iu9sR8Jksv
	 slHkyrZedpDOAqfsH9kjnMjTedB/oAb0AsGNjTW98Q2/os6kSm5kOqZksbBGNoofEB
	 ccB2MndkxgVzA==
Received: from [192.168.68.112] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C37FB6B922;
	Fri,  8 Nov 2024 07:37:31 +0800 (AWST)
Message-ID: <1c8f39015eae7cc71fbfb9136af8a728d743a991.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Patrick
 Williams <patrick@stwcx.xyz>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Potin Lai <potin.lai@quantatw.com>, Cosmo
 Chou <cosmo.chou@quantatw.com>
Date: Fri, 08 Nov 2024 10:07:31 +1030
In-Reply-To: <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
References: 
	<20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
	 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
	 <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
	 <CAGfYmwVxwaZk-si1OkP4xeaODhAO74Hv43U=SpzOsGOBkTH8Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 19:22 +0800, Potin Lai wrote:
> On Thu, Nov 7, 2024 at 7:41=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> > > Update the GPIO linename of each PDB CPLD IO expander based on
> > > latest
> > > CPLD firmware.
> >=20
> > What version is the latest CPLD firmware? What was the previous
> > version
> > with the old pin assignments?
>=20
> Because the hardware changes from EVT to DVT, the CPLD firmware
> reallocated the IOEXP pin mapping in DVT version.
> I will add more description into the commit message in the next
> version.

If you have different revisions of the board, it would seem sensible to
have separate devicetrees, one for each, rather than constantly
evolving one devicetree? Tack on an `-evt`/`-dvt` suffix as required?
From there you can always have a suffix-less dts file that #includes
the most recent board revision. See some of the Aspeed EVB devicetrees
for an example.

>=20
> >=20
> > I'm also interested in some discussion of the coordination between
> > CPLD
> > firmware, the devicetree and the BMC userspace configuration. This
> > change feels pretty painful.
>=20
> I am not from the CPLD firmware team,

I don't see why you need to be? This is a cross-component concern, and
you need to make all the pieces of the puzzle line up.

>  I only know our CPLD team was
> redesigning the entire struct which causes the huge changes of IOEXP
> pins.
>=20
> This is probably a different topic, I am curious about is it possible
> to assign the linename in userspace?
> In OpenBMC, there are many services that depend on GPIO linename, it
> will be more flexible if I can assign the linename before service
> starts.

Not that I'm aware, and to determine otherwise I'd probably need to
read the implementation as much as you :)

However, separating the devicetrees would go a long way here if the
CPLD firmware is tied to the board revision...

Andrew

