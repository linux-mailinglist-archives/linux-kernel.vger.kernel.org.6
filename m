Return-Path: <linux-kernel+bounces-256166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A5934A29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746141C2175B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEC7E0E8;
	Thu, 18 Jul 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XTBAEQjI"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AE3B784;
	Thu, 18 Jul 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292236; cv=none; b=VAf0tF8xgtgIildSWlU7lOKLcD/MOPInIgLsYsmewxFKZ3foX129c8KrIAXR249ggC0Bn5FPxmyHyy0fLrodmCPGW0g44z0T8fTVvwaeBYmNFh7HoF0axmdDFmwyeimv05VzpjWtMaxbpvVyoo5ZapDVCL5QMC4aJ84Tx0geK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292236; c=relaxed/simple;
	bh=t59HvvioUnAYN4TRwpXWrIUMqAPeRW5LGIJ3kW8HqgQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XV3leLR4U5qFHDXyqNxldJ9bSbbAppF9zpSqtvY5FJTDi1SCgJQAxRHRqiH8Dby9XFEyErDpoMtYGqJ8fW8ZytQBSUfn4frhGzPmL6WZfeEjkVJ2AeNM/HCIUO+FV/gf0f+3ZnxB+WfN3/EiZPnK3J+a4ZvclKhEE0TLqafrSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XTBAEQjI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721292231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKk8adyi9jKYJ3vFAHnVWE13YqvAw47sg8mkzonVaMk=;
	b=XTBAEQjIAr/Sm2A4jEnG0EecGJsQtbpQ71+5D9saa21Z31AlZzAuCCJB2UV93jw/+uf09E
	lDPD9O//Y2wtfeIcL7hsxVWsTxU2ZzvfK7ZbSH8u80DZvCnk7+lGC6VUb5tolqXY08I/AZ
	2Bqjlc0+wt6+pNVWN9rWx4LLHRjvd1gA/wbcoFfAwKoUxeKgkLU1d4Ti3Iyekvwslzkz1/
	6D+44dufeuQDm6SbfFpestveehQS/w9ROgX63HRgrec1bbQLe4/+wo9UMhBaJRPYldAOHJ
	o9t65FddTbvPbu9rItji07hs6ooM5kbuOrUBkPbCYURzvo+WWhU09JQk+Qc3Kg==
Date: Thu, 18 Jul 2024 10:43:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>, Collabora Kernel Mailing List
 <kernel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
In-Reply-To: <20240718-lapped-suffocate-0216bad82c68@wendy>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
 <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
 <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
 <e34f1a0a81de24437be7f582c719d3f128d44b51.camel@collabora.com>
 <20240718-lapped-suffocate-0216bad82c68@wendy>
Message-ID: <6ed3e6c6b74ddba1bca1a719dfdf3ac4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-18 10:34, Conor Dooley wrote:
> On Thu, Jul 18, 2024 at 09:31:45AM +0100, Christopher Obbard wrote:
>> Thanks for the review.
>> 
>> On Thu, 2024-07-18 at 06:36 +0200, Dragan Simic wrote:
>> > Hello Christopher,
>> >
>> > On 2024-07-17 18:46, Christopher Obbard wrote:
>> > > Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
>> > > with the MB-JD4-RK3328 & PX30 baseboard.
>> > >
>> > > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>> > > ---
>> > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>> > >  1 file changed, 6 insertions(+)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > index 1ef09fbfdfaf5..33ca8028bc151 100644
>> > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > @@ -148,6 +148,12 @@ properties:
>> > >            - const: engicam,px30-core
>> > >            - const: rockchip,px30
>> > >
>> > > +      - description: Firefly Core-PX30-JD4 with MB-JD4-PX30 baseboard
>> > > +        items:
>> > > +          - const: firefly,px30-mb-jd4
>> > > +          - const: firefly,px30-core-jd4
>> >
>> > Similarly to how I suggested the new dts(i) files to be named, [1]
>> > the model names should be named like this:
>> >
>> >            - const: firefly,px30-jd4-core
>> >            - const: firefly,px30-jd4-core-mb
>> 
>> I suppose the order should be the other way around to match other 
>> entries, e.g
>> firefly,px30-jd4-core-mb first?
> 
> Yes. Mainboard first, then som, then soc.

Ah yes, sorry, I somehow managed to get the order wrong.  Basically,
it goes from more specific to less specific.

