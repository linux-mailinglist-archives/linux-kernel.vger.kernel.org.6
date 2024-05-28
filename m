Return-Path: <linux-kernel+bounces-192703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A88D20EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E3328951C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC5171E5C;
	Tue, 28 May 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si2wh7RR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357716EBE2;
	Tue, 28 May 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911890; cv=none; b=X+wUDMLb9NymVyBw9muuOovm9435Wwkm/92Kb259brcqjzN7bWNC3cStHdvBlf2BO1JLSG0Q04qLcWjU2T/pGQvmFh7Ree7ErsR2xCllHdlpjfZI+o2cOJV8oCjgTkBens7etAfF+zOvYGIsxKV3K9hr2k6FrqRmG1zJog4m9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911890; c=relaxed/simple;
	bh=c5lGEXQwzulh39BNNvVK3ComcUQeEWk6Pg0H6NWEfbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppoe03qIJlkCJKYymswiKMIYuiEro2iN56zHPdD5wXNgqJWK0DGPTTFlOvOzkips1Xbhpqnyimut00F/W8vQ7AogKURsQ1do2Fy6pZ69CezNM3PtB/omGLXsSqPxnfeSsaZZkDm3jGH/+aEOOYIq7doe+z91BGMa69oYoUNJWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si2wh7RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76209C3277B;
	Tue, 28 May 2024 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716911889;
	bh=c5lGEXQwzulh39BNNvVK3ComcUQeEWk6Pg0H6NWEfbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=si2wh7RRadbQhWij7/FlclQAb1uil6gL8wD06Q08zbUhVkIq5tv/8K0cPHIkXVV27
	 +nzaKAAKApwgOKNnIqsruYCGEx2VC6rKeobQXp+RWqLYzINbTSOR0NO14GkxTvLKLO
	 L31lR8XlyC1mU3wLB7vJj0xBNokXvUvJQmLr9xrTcGe9oeDMroRnD7aZrza/pDVtph
	 fX9URt5gU5Aov0kRfrcbQgQAb5hL65AVkSqJ4m/M3VnqKV2HJzJMr0kqODE6PQId04
	 z282TuXRvFX1/Wchj+O8fCVTJEBjzMf3h38/U/fxYf8LsiYDByZiIT09A/+tt94Pyy
	 P4BsQUcQyqSFw==
Date: Tue, 28 May 2024 10:58:08 -0500
From: Rob Herring <robh@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
Message-ID: <20240528155808.GA695520-robh@kernel.org>
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>
 <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
 <20240524-cavalier-outthink-51805f49c8fb@spud>
 <8007abef-38bb-4d7d-a453-00bb5e6bede5@linaro.org>
 <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU3Rh6f-HrFbBLxNXVP1PwsGh8OyGmmGJBv6+GRwZaTXgw@mail.gmail.com>

On Sat, May 25, 2024 at 12:58:18PM -0700, Tim Harvey wrote:
> On Sat, May 25, 2024 at 11:34 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 24/05/2024 20:40, Conor Dooley wrote:
> > > On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> > >> On Thu, May 23, 2024 at 7:47 AM Conor Dooley <conor@kernel.org> wrote:
> > >>>
> > >>> On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
> > >>>> On 22/05/2024 23:50, Tim Harvey wrote:
> > >>>>> The GW7905 was renamed to GW7500 before production release.
> > >>>>>
> > >>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > >>>>> ---
> > >>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > >>>>> index 0027201e19f8..d8bc295079e3 100644
> > >>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > >>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > >>>>> @@ -920,8 +920,8 @@ properties:
> > >>>>>                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> > >>>>>                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > >>>>>                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> > >>>>> +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
> > >>>>
> > >>>> That's not even equivalent. You 7500 != 75xx.
> > >>>>
> > >>>
> > >>>>>                - gateworks,imx8mm-gw7904
> > >>>>> -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
> > >>>>
> > >>>> Compatibles do not change. It's just a string. Fixed string.
> > >>>
> > >>> I think there's justification here for removing it, per the commit
> > >>> message, the rename happened before the device was available to
> > >>> customers.
> > >>> Additionally, I think we can give people that upstream things before they're
> > >>> publicly available a bit of slack, otherwise we're just discouraging
> > >>> people from upstreaming early.
> > >>
> > >> Hi Conor,
> > >>
> > >> Thanks for understanding - that's exactly what happened. I'm in the
> > >> habit of submitting patches early and often and it's no fun when
> > >> something like a silly product name gets changed and breaks all the
> > >> hard work.
> > >>
> > >> The board model number is stored in an EEPROM at manufacturing time
> > >> and that EEPROM model is used to build a dt name. So instead of GW7905
> > >> which would be a one-off custom design it was decided to change the
> > >> product to a GW75xx. The difference between GW7500 and GW75xx is
> > >> because we subload components on boards between GW7500/GW7501/GW7502
> > >> etc but the dt is the same.
> > >>
> > >> If there is resistance to a patch that renames it then I guess I'll
> > >> have to submit a patch that removes the obsolete board, then adds back
> > >> the same board under a different name. Shall I do that?
> > >
> > > I think this patch is fine - other than the inconsistency that Krzysztof
> > > pointed out between the "renamed to gw7500" and the "gw75xx" in the new
> > > compatible.
> >
> > I am not a fan of renaming compatibles because of marketing change,
> > because compatible does not have to reflect the marketing name, but
> > there was already precedent from Qualcomm which I did not nak, so fine
> > here as well. Double wildcard 75xx is however a bit worrying.
> >
> 
> Hi Krzysztof,
> 
> Thanks for understanding. The double-wildcard is again a marketing
> tool. All GW75** use the same device-tree by design. The boot firmware
> that chooses the device-tree understands this and for a GW7521 for
> example would look for gw7521 first, gw752x next, gw75xx last.

You haven't documented the other 2 though.

How do "all GW75** use the same device-tree", but then there are 3 
possible DTs for just 1 board?

Selecting a DT is not a unique problem. We don't need unique 
solutions. There's the QCom board-id proposal[1] and OS provided DT[2] 
which are addressing similar issues.

Rob

[1] https://lore.kernel.org/all/20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com/
[2] https://lists.linaro.org/archives/list/boot-architecture@lists.linaro.org/thread/DZCZSOCRH5BN7YOXEL2OQKSDIY7DCW2M/

