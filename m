Return-Path: <linux-kernel+bounces-384479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92B9B2AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0958A1C21651
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E85192B75;
	Mon, 28 Oct 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pXnKg6S+"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED58191F90
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105227; cv=none; b=DXHcxcSDyVeIh3GB9gxE9jdwbaRjorQclyt920QAVhneY4+fP3frPMvONwGTjUbVOAtiKGabDLLE4nXJ3wBV/GLkHxIfye9qVNmPJw+R3fG2wJQQnktyIURTiMhNuqQRw74a7gPWmed+FWCwYBXw0COtho2o7CCXglRmYmnd/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105227; c=relaxed/simple;
	bh=HzmNwqyvaQGylD5zh5oJf8Tp8pQKS5JTam1dNZybiQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsKECw4D81TQDtD8ryWqK+o7Cf15aKJY61kvkrWtoyPn9tvvVOXHFmCzMkGpO4ghOPWhRlvZGogTeGiLSCJXKuaRZUR6HXX1M362YRurDif4TfaaCkw44s4OYd2ovWvI1qHINYOjbn435W0RtUE8aQWJREuJsGpDHDnsZI/8gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=pXnKg6S+; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0B5DA89083;
	Mon, 28 Oct 2024 09:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730105224;
	bh=sUrT3beV/PYpsOKB3HvIozG/twVT8gxRUR2MTWVXAvw=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=pXnKg6S+slJgnrNzePPQpBSKUXDiEFziSfZd+9ZYIHcTr/DH5yqDy7HmmUS33oLPN
	 p6LxxFFf8qem5pCwl2nEGj7a5ueaD/7lRnX39I/QRQzKhsr5TINBYjkuIdKRytuRNx
	 NYrRcUONrMLen5YlgPqPMaZjPJJGh/WcabR9gFb6bGdvAqMFBcPwrI1xReOggBzT2/
	 BHep8RjP2SHGahw51GQYvktwlRxdPUT9qmmDaspl38DSPlqzWcuop7ys6hIDF79VVK
	 hl2r+X1d/zWKDJZ866sfsroyhoR/cv/nvc7uksD84brV6TZVHUKxqAQJIxxDQWTTXX
	 qvr6cNCgGPJgw==
Message-ID: <6c531544-9c94-8ab0-6a35-3b8f8b790db1@denx.de>
Date: Mon, 28 Oct 2024 09:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] i2c: mxc_i2c: Convert to use livetree API for fdt
 access
Content-Language: en-US
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org
References: <20241023202855.1571188-1-tharvey@gateworks.com>
 <20241023202855.1571188-3-tharvey@gateworks.com>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241023202855.1571188-3-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tim,

On 23.10.24 22:28, Tim Harvey wrote:
> Convert to using livetree API functions.
> 
> Without this if livetree is enabled (OF_LIVE) the mxc-i2c
> driver will fail to support scl-gpios and sda-gpios for
> i2c bus recovery.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   drivers/i2c/mxc_i2c.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

