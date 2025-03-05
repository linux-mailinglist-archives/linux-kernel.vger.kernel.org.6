Return-Path: <linux-kernel+bounces-546067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27AA4F5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FBA168E18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B91A23B1;
	Wed,  5 Mar 2025 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CBDAyr6g"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCD19E7D1;
	Wed,  5 Mar 2025 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147605; cv=none; b=Jg3aPJYlgsBkbXMbbW/VvCD8VrufucNFR0tKYkbYPDmGFLmWcZmKeGAAfD1AI34aq675M/kN6YDTgSDLBPNP4Scrd1Z1qRZyL7sKqkFfmljQVuHcjm0rgDXACrMf6bn5IgCiCq94bFExTlggIVlntNc1GMIefGfQqC/C4C1fKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147605; c=relaxed/simple;
	bh=t//kC1ZuuWYzIIyvn7V+j9bMabJqtZZ6AFHBn97+huc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BDz/yr5rTlq3BUIEtijNX2TKKAjlgppjqSA82/Bx/qZfadKR7x6aGYrz+OHbWDgMxuikHFsMITlYUyx+iEx36vBax5qj8GSBJWfommETwXikddo2i0siXm3+/bFtYvCUaNaQqmXqBA/oEGd2W6qFHUZcVC5c2KzDrWeg5KCJMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CBDAyr6g; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741147601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDELCpQeeRsQjBq8mPwKYZFbE0oodQGK1z39/kbbFVc=;
	b=CBDAyr6gphxZstlSVsbNMId1zpTUhZp+pAWmgYDZI5aTdeZ+5+nb+TBqrBtQUrnRTU1GZb
	Si9rzNzGXCDlFD2IIB8gCrmBa9Nc2M0oIKh9vnT4w05EvX9lPTgrhpPOsEq3w5XvwHskT2
	QL282+8PZd6XrT0eT+hA0aCCcL5b1WNM7Gt/Uv5uLkpGedTMgV4WCyrpb2z9DgSIm6AEDo
	pz8reP1rIZJj47AjtbDQDxo/pGlHwaTqqcZZspE8HTRxdAvt38uDCTONarVUiCj9VLoQ2e
	ItwzTTEgIUEqZftGQ1ALfausu/4JWSVp95OuTAKXQ1LTQ7d9/w5eUNfvBHlIsQ==
Date: Wed, 05 Mar 2025 05:06:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, didi.debian@cknow.org, chris@z9.de
Subject: Re: [PATCH v2 0/2] Slightly improve hardware description of Pine64
 RockPro64
In-Reply-To: <2630232.Icojqenx9y@diego>
References: <cover.1740941097.git.dsimic@manjaro.org>
 <174104113599.8946.16805724674396090918.b4-ty@sntech.de>
 <757afa87255212dfa5abf4c0e31deb08@manjaro.org> <2630232.Icojqenx9y@diego>
Message-ID: <40aed1a2c3d4015881694e847beca683@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-03-04 22:52, Heiko Stübner wrote:
> Am Dienstag, 4. März 2025, 07:44:59 MEZ schrieb Dragan Simic:
>> On 2025-03-03 23:36, Heiko Stuebner wrote:
>> > On Sun, 02 Mar 2025 19:48:02 +0100, Dragan Simic wrote:
>> >> This is a small series that introduces small improvements to the way
>> >> Pine64 RockPro64 [1] single-board-computer is described in the DT
>> >> files.
>> >> This applies to both production-run revisions of the RockPro64.
>> >>
>> >> The introduced improvements boil down to eliminating some warnings
>> >> from
>> >> the kernel log, by adding a previously undefined regulator and by
>> >> adding
>> >> some previously missing references to the regulators.
>> >>
>> >> [...]
>> >
>> > Applied, thanks!
>> >
>> > [1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board
>> > dtsi
>> >       commit: bd1c959f37f384b477f51572331b0dc828bd009a
>> > [2/2] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64
>> > board dtsi
>> >       commit: 64ef4a4320e7aa3f0f267e01f170f52b90bf0b1b
>> >
>> > I've moved the pcie12v supply up one line.
>> > While in a mathematical sense it's true 12 > 3.3, we're sorting
>> > alphabetical, so it's 1?? < 3?? .
>> >
>> > And yes I sympathize with 3.3 < 12, but also have come to appreciate
>> > not
>> > having overly many special cases :-)
>> 
>> Great, thanks! :)
>> 
>> I'm fine with the alphabetical ordering, albeit with some caveats
>> described below, but the following part of the patch description
>> should also be removed, if possible, so the patch description fully
>> matches the introduced changes:
>> 
>>    Shuffle and reorder the "vpcie*-supply" properties a bit, so 
>> they're
>> sorted
>>    alphanumerically, which is a bit more logical and more useful than
>> having
>>    these properties listed in their strict alphabetical order.
> 
> I've amended the commit, dropping this block

Thanks!

>> I'm hoping you'll agree that specifying alphanumerical ordering
>> for the properties in the DTS coding style is the way to go, just
>> like it's already specified for the ordering of the nodes.  I'll
>> go ahead and submit an appropriate patch for the DT guidelines.
> 
> vpcie0v9-supply = <&vcca_0v9>;
> vpcie1v8-supply = <&vcca_1v8>;
> vpcie3v3-supply = <&vcc3v3_pcie>;
> vpcie12v-supply = <&vcc12v_dcin>;
> 
> In the end I don't care _that_ much, but personally I find that
> alphanumerical ordering harder to read ;-) .
> 
> Because in the example above, my mind now constantly shouts
> "why is vpcie1... after vpcie3... ..... ooooh right, it's 
> alpha-numerical"
> 
> But I can live with it I guess ;-) .
> As 3.3 is smaller than 12 afterall.

Oh, I know very well first-hand how alphanumerical ordering may
look and feel strange at first... :)

I used ls(1) without the "-v" option for many, many years, and the
things looked a bit strange after I decided to add "-v" to its set
of options at some point, but after a short period of getting used
to it, alphanumerical sorting became so logical and useful to me that
alphabetical ordering is actually now harder to read and is looking
a bit strange to me. :)

