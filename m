Return-Path: <linux-kernel+bounces-400798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3C9C127F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FC2885FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6BD1EF923;
	Thu,  7 Nov 2024 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="YDcb/89f"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB2322E;
	Thu,  7 Nov 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022419; cv=none; b=XzKYm5TUIyhjINISJa738qR9cBVOXQ3lqnxvtHXw/h2ZrcMmM9ukDBW8bTg6AwsfwMAvHIIcOdAf60cAq9QHy/PzCdwFpYvfAQ51diHx+gclNu1Sjpc/HoVIsDFscJ3xMuHrR/XspnxX3jYLp2jZ+pBcmoIKXoXW6pKIENc3Qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022419; c=relaxed/simple;
	bh=IkJAGvDQkZovXD1x3n8hplojH9ac0PufnJnE8gv8k9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAeUWC0rZx+iUriqyQyhVBWcGrXq9Ui8Pjo0fdDifJHcCxe2vrN3bj2I9HoK3BUSJ5EjoCVM26zA5Xq0jHeaLNNIh+mOJg+uq09eBfEJUdSB4ozMsJeuL99OGaI78HqTKXttXFF8DCogsHcKkna8uz2AiutGUYhfw6nYRRC4Kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=YDcb/89f; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1731022065; bh=IkJAGvDQkZovXD1x3n8hplojH9ac0PufnJnE8gv8k9c=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=YDcb/89fw1nXBP4aHT2wQl02i2QGXRsHIFvmr5knquIfn4RQXgS3a8ii279dvM+Ff
	 HE+h7PO/048ET1Oeissg2gXHTpMxyzSHsU56+PG3+M/d8ZdJ6VB6yuEVBs6hv1QaI6
	 xFsiJ1DMm6dS5fRgoYaDJYQ6/XdKe8bGZcFwh/g8=
Date: Fri, 8 Nov 2024 00:27:45 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: orangepi-5-plus: Enable USB 3.0
 ports
Message-ID: <fzrnp55hcmszqcdc6m6qacfv4rka5tlvp3kpll5i6d6fjm2mc5@d6yo5c25gv6i>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Chen-Yu Tsai <wens@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20241025175415.887368-1-wens@kernel.org>
 <pe2ornjaqn24i7e3x64rfdtqbp2c347mc5okgj5y6bfvkwnv6z@jux5yei3vxxa>
 <CAGb2v66WNDVDVqncPNjep3Usqwj2txuXVMxK_Uy0fSgbMFbX_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66WNDVDVqncPNjep3Usqwj2txuXVMxK_Uy0fSgbMFbX_Q@mail.gmail.com>

Hi,

On Fri, Nov 08, 2024 at 12:16:57AM GMT, Chen-Yu Tsai wrote:
> On Mon, Oct 28, 2024 at 6:47 AM Ondřej Jirman <megi@xff.cz> wrote:
> >
> > > +
> > > +             usb_con: connector {
> > > +                     compatible = "usb-c-connector";
> > > +                     label = "USB-C";
> > > +                     data-role = "dual";
> > > +                     op-sink-microwatt = <1000000>;
> > > +                     power-role = "dual";
> > > +                     sink-pdos =
> > > +                             <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> >
> > The board can't sink power from this port. It's a source only port. So sink-pdos
> > can be lower, so that if you plug this into type-c hub as a peripheral, the hub
> > doesn't need to reserve 5W for this port.
> >
> > op-sink-microwat can also be lower. The port will not sink any power when
> > connected to 5V VBUS externally.
> >
> > Otherwise you can probably keep power-role = "dual";
> 
> I guess it should just be power-role = "source";
> And then drop all the sink related properties.

Probably not. The board is not powered from that port, but I should still be able
to plug it via that port to a PC, and in that case it should not act as power
source (vbus should be disabled), because PC's port will provide power. (say
via USB-A <-> USB-C cable connected to PC's USB host port)

It should still be capable of being in power sink mode on that port, but it will
just not physically sink anything. Just the board's vbus will be disabled.

We should just describe that in sink mode it will not sink much of anything.

> > > +                     source-pdos =
> > > +                             <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> >
> > This port can't source 3A. U22 (SY6280AAC) is configured via Rset for 1.44A
> > limit. So let's say 1.5A.
> 
> Probably 1.4A to be safe?

Ok.

> > > +&u2phy1 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&u2phy1_otg {
> >
> > Needs:
> >         phy-supply = <&vcc5v0_host>;
> 
> You probably mean vcc5v0_sys?

Sorry, ignore this request completely. I was mis-looking at quartzpro DTS, when
reviewing this part of the patch.

Thank you,
	o.

