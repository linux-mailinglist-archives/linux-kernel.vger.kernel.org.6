Return-Path: <linux-kernel+bounces-220573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0BF90E3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804241F22513
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC976F315;
	Wed, 19 Jun 2024 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WTIOUwKR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DB6F2EF;
	Wed, 19 Jun 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780146; cv=none; b=eR3kuHKfRzkDvvjVgr6RN/Mj0Cs1ArZ9p67Q9dtJikA++ytsl6XywI0LugvjACDNPDQ5W+MmHLv+hkljy1I6LN1wZHSO/kBZZvgQ3zYYeh0tzmY4DZwK3fguuNq78J2XmDjA0B0/+9AEe/JPuVGVtzeZJ5oEhHmBi7WFj432IpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780146; c=relaxed/simple;
	bh=hgH4DDDvAA9kgOZ2n3TjfNXg8eHsBsoYv2LJciY4Ixw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ouJJbsuKZWTr9rxa1/hngkaOvo2C7TKzbFVTfjGmab5TKae/SFzvlFQUi3mYT76C4ryVxYHhbhjEuB5zz6Dv+jEj2VqCFzl7jzcdZ6Htb+2LyE/Nc83hsIOxlinUw4WQZKQzg0RdjzlrgSlmu0y3ISzswk8z0oBS++OPOI2mBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WTIOUwKR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2112C20127;
	Wed, 19 Jun 2024 14:55:35 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1718780136;
	bh=hgH4DDDvAA9kgOZ2n3TjfNXg8eHsBsoYv2LJciY4Ixw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WTIOUwKRVPebDE+XFoyICYbLin7nX/vvQXC3AKRpUd3b0uxE/GDSDvyMybgzRCTFA
	 XWz7D6Xw+kLwrrsq0WgD0pMPLdJHz4DTMP8bbs11PjVC+k7Sii4vPzRlPB0jWfF0S4
	 gVIs5drwwyCeUrJdGWsyE4eAGafdpf56kYUcLC/HBRRpCvCJg7MPf6Fap0yKMpyTeo
	 I0Ladfm5LUXJWleJl40TjU5ek/Jj2Iwh7yq0Bc4qmzaavWU7NekEBhz+VReWH10Dvw
	 AnuhpmvXCVf6T3oQXIMfPzcLqzRKGuNMoeSyEkej2v9OE2BvYVcO0EOz1TMcyMdNXa
	 Urz5aAipwmYnQ==
Message-ID: <bae054d217aa577838593244eda02b008e3749a5.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] i3c: i3c-hub: Add Renesas RG3MxxB12A1 I3C HUB driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Steven Niu <steven.niu.uj@renesas.com>, alexandre.belloni@bootlin.com, 
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org,  devicetree@vger.kernel.org
Cc: zbigniew.lukwinski@linux.intel.com
Date: Wed, 19 Jun 2024 14:55:35 +0800
In-Reply-To: <20240217131412.4145506-2-steven.niu.uj@renesas.com>
References: <20240217131412.4145506-1-steven.niu.uj@renesas.com>
	 <20240217131412.4145506-2-steven.niu.uj@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steven,

> RG3MxxB12A1 I3C HUB is smart device which provide multiple
> functionality:
> * Enabling voltage compatibility across I3C Controller and Target
> Device.
> * Enabling voltage compatibility across I3C Controller and Target
> devices.
> * Bus capacitance isolation.
> * Address conflict isolation.
> * I3C port expansion.
> * Two controllers in a single I3C bus.
> * I3C and SMBus device compatibility.
> * GPIO expansion.

Do you plan any more work on this driver? It would be great to have
this included upstream, but looks like there's a fairly large amount of
work required to get to that point, particularly in regards to using
existing kernel infrastructure to support the device functions.

Anything I can do to help there? Would a (further) review on this
series be useful?

Cheers,


Jeremy

