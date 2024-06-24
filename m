Return-Path: <linux-kernel+bounces-227750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F51915634
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2FC1C21DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFF19FA6C;
	Mon, 24 Jun 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xibedBFt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F119D081;
	Mon, 24 Jun 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252385; cv=none; b=XAnbYun+Bf4F+NP+IczlgFiB4JBhscpamkfLD1BXJwr/GaGYDTtpIQuEFWYUPs9CPl4Gi8Kcg+jvJ2JKBpmiNiD5fpp6NCSIDEKoF1xdMinPNBKaAbSSSmAHrM3nK3ixfozvx3zFQrnifxKoaFogbXbQYsodpnegbPVTxTF8v2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252385; c=relaxed/simple;
	bh=2xU3M2GqnP8ukgos/00S7G2Z2rMdQNuSueB24ZYjk00=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LnGQPJdvnrlXrR1u8BVuVIUz/XRtbswOu+dagLt4mVIj4d4wHXzEBPOo/96wUmikWGoQvHAbi5u5Q3zsmTXZgIUZWVpS5U1BGnR5kHJ/X37I/rJ1mwA+h5rgbVmFsxbPa2xr9EW3OrswiX+9/JphXA+T7H7F2F12skP6SXGYTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xibedBFt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719252380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCy+hRmCRW5AO/hvJe9xg4i+qzJBreY+fC5iGKmnDJg=;
	b=xibedBFtXNM7aHmHNwmzvGHYjglaqn2uCn+wqMVRdkGBAdys5HGPgIEY7PE87bovwoF/mQ
	Cea1tJOoVBGcoRGicxPSGgE847H46H1VVWC2nBL9t6wlhhllsal/w/xNqqfQC/iabRaC7l
	PKA0hAo/9AYLR6dfFS8Zg7VUs+zzlduScdLKgSCgiO39m93rH0Ao81sNNZpIF3IXqQJFZq
	sJziTxYaxVtkuFQRnjqQHXE+yoTO48BpHpROT4fRHYZSDN39aUTNShJxu+b+SWqRsdGaSM
	U3QoWBjnHjtHLNA3EfpHw2+YZHp21xXYg1Y679CXP5g85rQ0TPhwtJcNV/q3yw==
Date: Mon, 24 Jun 2024 20:06:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for
 RK3399Pro
In-Reply-To: <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
References: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
 <ba9d41461f5d56947d7851473637722b@manjaro.org>
 <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
Message-ID: <84e5719fad4d405bf188ee86d12bb251@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-06-24 19:59, Alexey Charkov wrote:
> On Mon, Jun 24, 2024 at 9:55 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Just checking, are there any comments on this patch?  Is there 
>> something
>> more I can do to have it accepted?
> 
> Heiko has already applied it quietly a couple of days ago [1], and
> also merged the v5 thermal and OPP code that I rebased on top of this
> patch of yours.

Yes, I saw that already, but this patch is a different one, it's about
deleting the redundant .dtsi for RK3399Pro. :)

Regarding your v5, I've had some health issues, so I unfortunately 
haven't
managed to review it and test in detail yet.  I'll do that as soon as 
possible,
and I'll come back with any comments I might have.

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=def88eb4d8365a4aa064d28405d03550a9d0a3be

