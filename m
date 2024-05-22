Return-Path: <linux-kernel+bounces-186373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EE8CC35D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D121F21449
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24361864C;
	Wed, 22 May 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJqkDzM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7D208C4;
	Wed, 22 May 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388759; cv=none; b=GQ8dFM9DGXNycLt+V8+SgxJ2MInfWcsYrAzv8lrhgrPMzHmCB+DDX8AIWkpsdAA2fbI3RVgH1f/NyQ0q07KX6poBIeZnxiZ1rRwOAZvlj2FnEhGK0C/whzsUfdSuQR3s9p0H20xjOdvwn+PiD1x62H29YmDLEblu6mj5hUH3Ui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388759; c=relaxed/simple;
	bh=c/erdSkvqOmmngCUdhuBClCtrfqJRc+4eqfJLuT4Sk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiKnJC7IsyDAMBSDGAwRTb1gAvUDSje5a1rEjHmGQEQ6Pjaphccc/zKz54jW3VZtkoFtXWvMw2BjWjN9DzcXeCZaVctoVRFX1kzPShxHYmBOH+i0nm1wNT9O2pvyKAJ/YM9fXAGplLCg9TQl+V85XYGx5pBIlng05NuoGH8zE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJqkDzM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF7AC2BBFC;
	Wed, 22 May 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388758;
	bh=c/erdSkvqOmmngCUdhuBClCtrfqJRc+4eqfJLuT4Sk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJqkDzM3dqUk1UMrQrQ9/ayDZagxo8dOczR/f9OxHA2lUhGkSv48uy45xBuu2PDax
	 eiqdpu54y8xj0rqQPd51EHR4G7Kqhdf+yYLJsSLRGDJftQqdsitHyoeq7qFmQNdVDh
	 NyaliuaSBw6ZXFraFwkHCih5vwf6mumiFsFzgYh1rPdw6qBSCnGYyTjS0uD4QtFeC+
	 FrUwljlVS3iIRbyxd4BY+1m3OzWWy3DoGvAbSQSL7ZxSUH1/m8XpLaE81DVqNYYpRZ
	 pwi5bfLBMjgsawpTx54SGmwYukfYj59zXu/h6gvYb/7ccCt9sVEmAEmX8lEl7PR9Lj
	 x2rCxpFDCI73A==
Date: Wed, 22 May 2024 09:39:17 -0500
From: Rob Herring <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-fsi@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au
Subject: Re: [PATCH v5 5/9] dt-bindings: fsi: Document the FSI controller
 common properties
Message-ID: <20240522143917.GA3261343-robh@kernel.org>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-6-eajames@linux.ibm.com>
 <9200e46a-3cb5-4363-a560-ee3d88e05ced@kernel.org>
 <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
 <eb6e2b5b-f341-404b-9215-6e80f21a6842@kernel.org>
 <80713a00-9574-4ae0-8af7-3fe12affcfc1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80713a00-9574-4ae0-8af7-3fe12affcfc1@linux.ibm.com>

On Wed, May 15, 2024 at 10:02:46AM -0500, Eddie James wrote:
> 
> On 5/15/24 09:35, Krzysztof Kozlowski wrote:
> > On 15/05/2024 16:28, Eddie James wrote:
> > > On 5/15/24 09:18, Krzysztof Kozlowski wrote:
> > > > On 14/05/2024 21:54, Eddie James wrote:
> > > > > Since there are multiple FSI controllers documented, the common
> > > > > properties should be documented separately and then referenced
> > > > > from the specific controller documentation.
> > > > > 
> > > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > > ---
> > > > > Changes since v4:
> > > > >    - Add interrupt controller properties
> > > > >    - Add clock-frequency property to FSI controller and CFAM
> > > > >    - Add detail to chip-id property description
> > > > > 
> > > > >    .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
> > > > >    1 file changed, 66 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000..8620e4da6de77
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
> > > > > @@ -0,0 +1,66 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: FSI Controller Common Properties
> > > > > +
> > > > > +maintainers:
> > > > > +  - Eddie James <eajames@linux.ibm.com>
> > > > > +
> > > > > +description:
> > > > > +  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
> > > > > +  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
> > > > > +  various engines such as I2C controllers, SPI controllers, etc.
> > > > > +
> > > > > +properties:
> > > > > +  "#address-cells":
> > > > > +    const: 2
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    const: 0
> > > > > +
> > > > > +  '#interrupt-cells':
> > > > > +    const: 1
> > > > > +
> > > > > +  clock-frequency:
> > > > > +    minimum: 1
> > > > > +    maximum: 200000000
> > > > This is a deprecated property in general. Why did it appear? It does not
> > > > exist in current bindings and nothing in commit msg suggests changes in
> > > > the bindings themselves.
> > > 
> > > OK, is there some document that describes what properties are
> > > deprecated? Because it's used all over the place in the bindings. Anyway
> > dtschema: dtschema/schemas/clock/clock.yaml
> > 
> > buses anyway should use bus-frequency but it is also legacy one.
> > 
> > > I need this property, I can rename it if you like. I can also update the
> > Why do you need it? Why clocks cannot be chosen by drivers and initial
> > state selected by assigned-clock-rates?
> 
> 
> Well, I could use assigned-clock-rates, though it seems like I'd then have
> to implement the clock provider framework for both the FSI controller driver
> and the CFAM driver, which is a lot of extra work. FSI controller isn't
> really a clock provider, it's a bus like i2c (which uses clock-frequency),
> so it doesn't quite fit in my opinion...

'clock-frequency' was used for I2C, but it really should have been 
'bus-frequency' as it is frequency of the bus rather than input 
frequency to the controller. So if this is bus frequency, use 
'bus-frequency'.

Rob

