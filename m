Return-Path: <linux-kernel+bounces-293643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D384D95824C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD71C20F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FA18A6C6;
	Tue, 20 Aug 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IC1y372E"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B418E372
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146365; cv=none; b=nOQ0wGFBIxJI6QHIuGBh0jbnMxRVaajK3uHyBVbfj1YtUphMkdRAthEef94CpbTeXmkqkYD8j5QCDdD0UW26/8W5kX9p1kaOEdws1HJSE4jvWFt67ARr2wkEdQ3VLR8kcQzdDoxdzP/0G0veY7wv3mH3G7DaVt5zdOIpUboq93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146365; c=relaxed/simple;
	bh=rzkHiZykSnYlcJNzJOMsXGqF2UVmOq5EHFa+GXcLF0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm3AtOVUE2AT3ZC6gtxAtVFJthNiTwZ6dlJZuPTvZYUc/hcZuzgDkfWLFdhmha4Mv+06wlzlx80NGcMfy2sIVDh3Dvn+k6Y7Qi/AamKCubNWqqD45hk6rAgQmY7fEnMMvzdFW4Upw6J9iqUvUQDP9e3Sl29z0htAos6/EJIfBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IC1y372E; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AB32FF802;
	Tue, 20 Aug 2024 09:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724146355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbceFSIpRzltmfoZ2MI0Jte5v6rIwCWOaAkplu8Qpsw=;
	b=IC1y372ElMZsj+B8pMB4Noi4Bjz3WKvFzzdLd1Y5DzFAGx63Pt4N0rLqRcj1rcPwNBZIM5
	CZCS0oXNbrId/oRAMmdHxD3teZNceDGf1yPFXXUKX+W2dblL/15JLJT3eBTOUyPsXeVaGv
	xB4mEN7PefugOkUzIKG7Tqm7UTul8W0E9y6ySujDNsWWggZiL5CTAHm7+Zx8hjIAYTw0p8
	ZFNW7k4chYkIvFPfBuBy7Lp4g2qn1jh8ZTlqUkvn2bn7ZDkgWBYJSJmjGepeEXztkc75S1
	dHRVPdEcxB+oaYN0gI2IbEGpRwHNu3lxF4Qt17Td1P5VKbk+xGL5OmRrnObFFQ==
Message-ID: <7e8c6991-25f8-4df5-8510-b938e2f4e098@bootlin.com>
Date: Tue, 20 Aug 2024 11:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add resume support for the mux mmio driver
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 6/13/24 15:07, Thomas Richard wrote:
> The patches of this series were originally in the series "Add suspend to
> ram support for PCIe on J7200" [1].
> There is no changes compared to the patches in the series [1].
> 
> These patches add resume support for the mmio driver.
> The first patch adds a new function mux_chip_resume() in the mux subsystem.
> The second patch adds the resume support for the mmio driver using this new
> function.
> 
> [1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v6-0-4656ef6e6d66@bootlin.com/

Hello !!

Gentle ping.

This series has no remaining comment to address.
Is there any chance to get this series merged ?

Best Regards,

Thomas

> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Thomas Richard (1):
>       mux: add mux_chip_resume() function
> 
> Théo Lebrun (1):
>       mux: mmio: add resume support
> 
>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>  drivers/mux/mmio.c         | 12 ++++++++++++
>  include/linux/mux/driver.h |  1 +
>  3 files changed, 42 insertions(+)
> ---
> base-commit: 8e7767d07e04b89999d5adefb190f4d5e566d8d4
> change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a
> 
> Best regards,



