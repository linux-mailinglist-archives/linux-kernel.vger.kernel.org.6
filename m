Return-Path: <linux-kernel+bounces-175624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F798C22C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250E71F21AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A416D332;
	Fri, 10 May 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="fbp++X+o"
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBA135A63
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339213; cv=none; b=MBwzNBjBX/mMyOva0PFrDo8VIVOcoHsHc5hQrGh0o15O1rvsTNseF0DCXOxnlqV/+oI0uyAVYMD3AljKQ1pE2dawB/ZBnaugUHE7yC5rt3dlQUn0kVQTVXPgCD8kZp6KLfldmp6AjDqXPhudKojuXa9pHt4k/8vo4pqblBf2r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339213; c=relaxed/simple;
	bh=BH9sLo0LcajSeSGIaiRPV99KE+nEZ4OheC8n4KCWD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrYhhRVIVeQMMMFheiwsfCmy1vj23qMP0fbRacvS1XKdbJqgnv5/FHK2tlu5tvAiHC7C/8xjQXKlPj/p4N5kZUBtw8JDi++cMQXNWzCw3BuZAM4dAI2Hif2u/07lQyFmnIroV1U/s9AQuD4OQhada3y6BLssZAKP620Tfi/+Neo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=fbp++X+o; arc=none smtp.client-ip=62.149.156.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.26.65])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 5O2NsPhhm0ADe5O2Psfycw; Fri, 10 May 2024 13:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1715339021; bh=BH9sLo0LcajSeSGIaiRPV99KE+nEZ4OheC8n4KCWD+k=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=fbp++X+oLDW5C7+NqVSzS+XJfhsQi/teCs7aSLC8D3j6wbDVFzd8f6VWEFd9zlu2H
	 ORwyLc3RkZaoBkhCX7jVGSxK3xWMntkcyBvKlcUPYPX78rIS93yqYy6Rsrk+rNqJo3
	 jAKAhYbgrBQZPmRaL/wmruYjJjjGn4KMAVdn2x3ymutCq5OkR00vfTVp6xG4Je1yz7
	 NLHrkfTLYW8im87cP6iokT8jHHPSAOBlJNOLBHmeWl8lbHXHGa23Jf+TZBQG2zbkpz
	 o0lv0AbG2DcvkyjxkVHihJ/ApJDWatnfIQ/QWIMq7e9D9NTjVeMmsYDDSLCn5vjM4t
	 gUxVxElIR4eNg==
Date: Fri, 10 May 2024 13:03:39 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B
 warm reset property
Message-ID: <Zj3/C2NJmCmNpJL1@engicam>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org>
 <ZhjhCvVNezy9r7P4@engicam>
 <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org>
 <Zhq8ibYrZH05/AQt@engicam>
 <46fe43d0-28be-4acb-b0d4-dacd84fef8e5@kernel.org>
 <Zh0ImzJZrxw4Xia+@engicam>
 <ecde24c3-55ba-45cc-8af9-94504dc4dcb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecde24c3-55ba-45cc-8af9-94504dc4dcb9@kernel.org>
X-CMAE-Envelope: MS4xfJB/g+E6+AbcjQs0pxsFNysyl/3kxRZASA0xPH0ENp61IAGllwJRgg09NdRgmUm0e6dK748/n464eKGiwOIiPnbuq98uXflejoz7dOoTmCZ0vgJ2qlAX
 ISOxgUD5az6TQuZZlWLLCTJh4q4R1QADDgfCv7L8T7WXlmJQCk/5wTPddAF7mu42uH4VnqoU6VLyo5bG46umv3LQw/0FESXr2PaOfOsmCSaRDo05L9kBrcXF
 yOmLUgVAvn1ItFw0JN87IGB20C8evHcVnAvNL9uwANEfu9mSpiIKJk3NSu+ROKM2j5cSWlYFFEDrT700YtBGmQF9oHNgEUCY1tcSseXe9U1UDMQfJZOgM84q
 kv9ehfW4jGzLNWcWVmUgnm/yD2qPqe3fqqk6R1F3AAOhgYvELfw0p0C7JErDi+LO5lijoSzZgarHj4RMksPbcBwzE3lFae/ur17JBlgKQQkpd7+aO5A=

Dear Krzysztof,

Il Thu, May 02, 2024 at 09:54:29AM +0200, Krzysztof Kozlowski ha scritto:
> On 15/04/2024 12:59, Fabio Aiuto wrote:
> > Dear Krzysztof,
> > 
> > Il Sat, Apr 13, 2024 at 11:40:18PM +0200, Krzysztof Kozlowski ha scritto:
> >> On 13/04/2024 19:10, Fabio Aiuto wrote:
> >>> Dear Krzysztof,
> >>>
> >>> Il Sat, Apr 13, 2024 at 12:58:35PM +0200, Krzysztof Kozlowski ha scritto:
> >>>> On 12/04/2024 09:21, Fabio Aiuto wrote:
> >>>>> Dear Krzysztof,
> >>>>>
> >>>>> Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
> >>>>>> On 11/04/2024 18:58, Fabio Aiuto wrote:
> > <snip> 
> >> I don't understand what is the use case. You wrote runtime does not
> >> solve your use case. What is the use case?
> > 
> > We experimented problems on some boards with SD card, if a cold reset
> > is done when the card is powered back on it completely freezes, the way
> > devices behave when unpowered for such short intervals is design specific,
> > not an OS policy.
> > 
> 
> Then describe the actual hardware issue, not instruct OS how to behave.
> In the property name and description.

Unfortunately we don't know the details of the hardware issue at the moment.

kr,

fabio

> 
> Best regards,
> Krzysztof
> 

