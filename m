Return-Path: <linux-kernel+bounces-262760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A393CC55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11538282C93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5617E9;
	Fri, 26 Jul 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="fyyz4DvU"
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A0368;
	Fri, 26 Jul 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956820; cv=none; b=rIBRe0Iyi4WU/jz/kmDJwvzDsJOwEEyHAPy/5yDlF6KEOknx/mRCjR9X0Tl1B18nHluj1xB7z3OXMn+9TtHyuV4QgMYRNyP+PuwhnNsckixwbtB4uqL11irEDxASULpRNalNbj7QJaePMRwWyK/1D0A8m6Id+6rjJS/M9t+kE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956820; c=relaxed/simple;
	bh=idIovbAuS6+Pvrpma5p1RBuUUhbImAsLlX5UVbtW2j8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzhEZuqFj8ujVQ1R6R1TiZYr4YRgHtpwrlWnZB39+UVZkXkjkbIxv9KR82WDB0zJmob0XrjAHTh7wPCMUpf3Z2bPOotjFUUbe8MmQzqzNmxhCMizHIR4DaKLxm7nP2Ms7cZJ0KhZQrarQrtyLYz81q1r9zQ09k64cjRgA774fBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=fyyz4DvU; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 26 Jul 2024 03:15:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1721956508;
	bh=idIovbAuS6+Pvrpma5p1RBuUUhbImAsLlX5UVbtW2j8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=fyyz4DvUPrNDKM/efShMIDOw66spe/ub87mmH5LjwXB485+8R/cP8B8Ili7W5VhEX
	 7Hh6HCx4Efdlai501yZLqz0xbkVnBPqFCBM+Ln0++SWEgYNfCWEJc3foH6TD2LaRel
	 ++FJsIEwRZqYMP8alBMciMkWikWbmiBif37lJu1Zzuh5ruby4U31tSNCoyleDBwddH
	 4XtoTJC1IZvi5ftjkgWhljIQnj18KpBzYqSXtWaWZbNZZenY5oweQHLiyPLeq51N4s
	 PssT4JaA79+BBwWQxwolE/pvMej+wmJMP4QZoGUIl9OzZvBvY+wDTbsg4prva+1dsb
	 ZEnOBMh46uBQg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
Message-ID: <20240726011507.GA3587@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725142731.678993846@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.

Hi Greg

6.9.12-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

