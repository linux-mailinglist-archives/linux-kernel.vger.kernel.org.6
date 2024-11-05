Return-Path: <linux-kernel+bounces-397269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894E9BD9A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBB2847D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C90216A18;
	Tue,  5 Nov 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="i2BNR8di"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70313C9DE;
	Tue,  5 Nov 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848878; cv=none; b=qG2jznM5fwxKmfQPvbMUDzcOFNx3zyd8AWGJhZ4dSJIeLLfzdNX3uoMzEvTVAU2nheO00vkny0bj3ltG2/XRbHsiIXRKXo0V8FzQAN1VPXNrl4F7TT6Jza79BJ0iHhNv6gcW7rQxmsFUEJx6YTnAfGZKH2Jy5MpgMWMihU6y7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848878; c=relaxed/simple;
	bh=9xVg8S5A3dEOoVAga7+s67CM1EOce2OgL3F1GFpjD6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQIumiZfyLc6GuJ9IbSMDgr9QlPvqMVMcgYZmgemD8UoOw3WrCoRxIVsUxtKJtRwpHKLofDjir7zCAyiZOquQ2tY/3+ZOgvyE2iTaMQnHjSqbru7b1qJaV46yDMI0l6MW6hvglt1tyknYhun1SidHD/eNEX8MN3oxRCD3CLEKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=i2BNR8di; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730848873;
	bh=9xVg8S5A3dEOoVAga7+s67CM1EOce2OgL3F1GFpjD6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i2BNR8diE+bStAGqu0zYAfibKHrcVQtX9N4pflhBAUSdqW9IEM2OcclPJ48QwPlVa
	 GJPIcEHQ2ASnJHrarkOPjgskPbban8Hn+uqI1IOaTF34Pfo5YCoVfWsf+M2n/6+Yxe
	 HUa69kNuNSNjMIUOTEmvYkCVcN5Q/9vBrNM23GmsBzlOUSO+nApi1KChXTFYz2UACw
	 gBWe1Ztlchpgua51i8VwZSFqf0nNaVWpteN1aCTfocGyuikG5JnjYkFT1p4m0xtrkb
	 nhmZHYnuBrC3msnJr5cCJa0Cba3PJcLzi6usLnTXHfmaZceCbF7l2wHkSgwbwqJjl1
	 fivt5GIneEFaA==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 52A0D6B407;
	Wed,  6 Nov 2024 07:21:11 +0800 (AWST)
Message-ID: <9e9bf461b2ef8993bb46206b3cdf40806a528856.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Naresh Solanki
	 <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jdelvare@suse.com,  sylv@sylv.io, linux-hwmon@vger.kernel.org, Joel Stanley
 <joel@jms.id.au>,  Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org
Date: Wed, 06 Nov 2024 09:51:10 +1030
In-Reply-To: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
	 <20241104092220.2268805-2-naresh.solanki@9elements.com>
	 <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
	 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
	 <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-05 at 07:47 -0800, Guenter Roeck wrote:
> On 11/4/24 20:10, Naresh Solanki wrote:
> [ ... ]
>=20
> > > =C2=A0From a spot check, the warnings seem legitimate. Did you send
> > > the right
> > > patches?
> > Just checked again. They are resolved. But I guess the dtbinding
> > patch
> > for the above warning are merged in hwmon-next branch & not in
> > dt/next
> >=20
>=20
> Did I apply some patches which should have been applied elsewhere ?
>=20
> If so, please let me know, and I'll drop them.

No need to drop anything for now: It was just that bindings for some
hwmon devices defined in hwmon-next are used in Naresh's devicetree
here.

Merging hwmon-next and applying his patches resolves my concerns.

Unless anyone feels otherwise, I expect we can can carry on
independently with the understanding it will be resolved in the same
way at the next rc1 (barring any other concerns with Naresh's patches).

Andrew


