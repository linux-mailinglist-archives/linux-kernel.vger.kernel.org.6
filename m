Return-Path: <linux-kernel+bounces-244138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172BD929FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC801C20DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3C73514;
	Mon,  8 Jul 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="JVNBFJHq"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930A55E58
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432525; cv=none; b=MYgjPNBvWyQZitEQSrj25/g/6+pV/DjORxCdBtMYGzVlhZr5dECBkwUEzO6b+vlXRw0NBlnBL50+Sgdcp7pQTkRKnUNRhY9BWCTwb1kD6k6hoF3DlbauR+zs6qwTkbNpU9i/vKm/XVQXYBuL8jST1l7I0YeiE5BVH/qGU3pkTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432525; c=relaxed/simple;
	bh=FoVT9DBZpCn40Cz8gJcXqkUGL2o1nrwe4JCB5l5MMe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0bA0HFkeyCyIvgg7O2dAHuJCDgN77t+q/Vw8Xv78mqz4BRauBJI6t470eeXywSsuxqdfPMyNLfmlqkl0zIFzuPMhY/l47M7UfJrnmXJ7Y6dXrPoi9T5dYPD3/GVs26hOLfuP2tSU8mlKkBj5Co5YRzLNrTB9wtbYke4AMvGUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=JVNBFJHq; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dsimic@manjaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720432519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjnCm+A1AQKhSlebbiZ+51zEwllzLIagWOmtFkMnH/g=;
	b=JVNBFJHq3Pbn2ER6JmV40+gJ9qa21faOvfzSHBT7DVBzORDpyCmXzZKgWsVu4tYoyHEo9j
	Js2kxf/06JIXKTgaKAbDHjxZC1MiCWsF+pcFkVMzd1qtHZZEWY71chNKQC/SeKBNp0zPB7
	7kW3i80yULEbZlFZgsmJsxTcOrp0D4mMucVL9RJ3wk2Cl9jIDByyZv+pVURu7TMl+I1Ede
	fX+GEh/USyqlfCrkGjtl+9ZGckZublM5ottUQpijiBH8FHup2JgRNjwFTO59uh7k0Kzj1H
	KxotnPfFqX9s0ScuJJv8bx1DIzinmMMznIQIkcoAA8mRT32P8FyGnBlwo0oW7Q==
X-Envelope-To: heiko@sntech.de
X-Envelope-To: knaerzche@gmail.com
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
Date: Mon, 08 Jul 2024 11:55:07 +0200
Message-ID: <6192146.IJkX0fH94T@bagend>
Organization: Connecting Knowledge
In-Reply-To: <31a86ec073e1de9e0241845f8783cd6b@manjaro.org>
References:
 <20240704191919.38856-1-didi.debian@cknow.org>
 <31a86ec073e1de9e0241845f8783cd6b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1956357.2bgSXjE7Vb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1956357.2bgSXjE7Vb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Date: Mon, 08 Jul 2024 11:55:07 +0200
Message-ID: <6192146.IJkX0fH94T@bagend>
Organization: Connecting Knowledge
In-Reply-To: <31a86ec073e1de9e0241845f8783cd6b@manjaro.org>
MIME-Version: 1.0

Hi Dragan,

On Sunday, 7 July 2024 23:23:30 CEST Dragan Simic wrote:
> On 2024-07-04 21:18, Diederik de Haas wrote:
> > Pine64's Rock64 was missing the avdd supply properties on the hdmi
> > node,
> > 
> > causing the following warnings:
> >   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using
> > dummy regulator
> > 
> >   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using
> > dummy regulator
> > 
> > In the Rock64 Schematic document version 2.0 those supplies are marked
> > as DVIDEO_AVDD_1V0 and DVIDEO_AVDD_1V8 respectively, but in version 3.0
> > those are named HDMI_AVDD_1V0 and HDMI_AVDD_1V8, which is a bit
> > clearer.
> > In both versions those are connected to LDO3 and LDO1 respectively.
> > 
> > While the DeviceTree property is named 'avdd-0v9-supply' the
> > 
> > 'rockchip,dw-hdmi.yaml' binding document notes the following:
> >   A 0.9V supply that powers up the SoC internal circuitry. The actual
> >   pin name varies between the different SoCs and is usually
> >   HDMI_TX_AVDD_0V9 or sometimes HDMI_AVDD_1V0.
> > 
> > So the 'vdd_10' reference is not an error.
> > 
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> 
> Already verified the above-quoted statement from the .yaml binding
> in the RK3328 and RK3399 datasheets.  Thus, hoping that you agree
> with the first line:
> 
> Helped-by: Dragan Simic <dsimic@manjaro.org>

While you helped me in several areas (understanding 'things') and I think 
proper attribution is very important, in this case it would be incorrect IMO.
I was helped by Heiko's (big) hint in their counter-proposal (which does 
deserve a Helped-by tag), from that point on, it was all my own work.

After Heiko's counter-proposal I had found the regulator I needed to 
reference. I then resolved the DVIDEO vs HDMI remark by looking at v2 and v3 
of the Schematic document. Which left 1 thing to resolve ...

On Thursday, 4 July 2024 12:34:18 CEST Diederik de Haas wrote:
> I do wonder about 0.9V vs 1.0V, but I'll bug someone else about that ;-)

I did mean you with that, but in the end I did resolve it myself.
I found the 'note' in the binding document and when I then found "min: 0.9; 
typical: 1.0; max: 1.1" in para 3.2 (page 36) of the RK3328 Datasheet, I felt 
I had resolved that issue sufficiently as well and was confident enough to sent 
the patch out (without sending you a RFC patch first).

> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thanks :-)

> I'd also suggest that a brief comment is added to rk3328-rock64.dts,
> right above the "avdd-0v9-supply = <&vdd_10>;" line.  Perhaps something
> 
> like this:
> > +	/*
> > +	 * RK3328 requires 1.0 V on HDMI_AVDD_1V0, which is HDMI_AVDD_0V9
> > +	 * and requires 0.9 V on other Rockchip SoCs
> > +	 */

The binding doc mention this: "The actual pin name varies between the different 
SoCs and is *usually* HDMI_TX_AVDD_0V9" (emphasis mine)

So that comment would make stronger claims then is present in the binding 
document and also uses a different pin name. I also don't think it's useful to 
mention what other SoCs (or boards) use in the rk3328-rock64.dts.

While I fully agree that the apparent discrepancy should be documented, I 
choose to do that in the commit message and I don't see a value to repeat that 
in the dts file itself.
When I see something which looks 'odd', I'd then use `git blame` to find the 
commit which set that and then I'd see the commit message which explains it.

Cheers,
  Diederik

> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> > b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> > index 229fe9da9c2d..90fef766f3ae 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> > @@ -154,6 +154,8 @@ &gmac2io {
> > 
> >  };
> >  
> >  &hdmi {
> > 
> > +	avdd-0v9-supply = <&vdd_10>;
> > +	avdd-1v8-supply = <&vcc_18>;
> > 
> >  	status = "okay";
> >  
> >  };


--nextPart1956357.2bgSXjE7Vb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZou3ewAKCRDXblvOeH7b
bu/3AP9TQM1mQsEoqJqSom8M1e3rf8ToWgUhxPpYuMl55Ln75wEArqjMHD7tyD7c
pxrGaVKXX2ipEbZAKEdU6/IEucgV+wQ=
=9qS7
-----END PGP SIGNATURE-----

--nextPart1956357.2bgSXjE7Vb--




