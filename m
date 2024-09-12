Return-Path: <linux-kernel+bounces-326791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB1976CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D4C1F25DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB061AD27A;
	Thu, 12 Sep 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="V+lSdM29"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD481B12FF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153469; cv=none; b=TCdhpWDOEnw3l509g+QPmC18/cAXaUK4h7qQlXf6DTeQnb/b9A31TiAQnDXRD4Bnlt+sWPjkbppACuNzbv6StZm3A/UgURtbwnVAn+cuY2yqd1KPoLQ9SPRmLOsF0c3qMkJVK0MQrJs9Gz4VSegJRc8Zl3rQT/mEr0kJh9w6c3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153469; c=relaxed/simple;
	bh=COHs87GVxy5Lw05efQyeO4Rt+U9sNmcRpFGBuku0KwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mTPPSfHYi5QiLJeB6WyFDdIFSGqo6hS+zpn9ck602CwjWm+HqE8aCGKlxYj4h3/bNHTzo9Yeum0ew98qVlWP+EZMxYRf4ZhGTpgJjm74ynEMzrx6TeM0/87IZdD4pio7vFtl3xXRcRhCjpVHSEt7NT2yPcIbLUe4caXYFORE4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=V+lSdM29; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4X4LLq5xMLzDqpj;
	Thu, 12 Sep 2024 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1726153460; bh=COHs87GVxy5Lw05efQyeO4Rt+U9sNmcRpFGBuku0KwM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=V+lSdM29xRXmS++zuqjAtIU6xS/exkwjEu1Mmvt6W/iNkRUL+N40WvVRlq2QLGg+D
	 Q7JznIzH5Yuo0tXvEfJ80Zgq0ebcSeYF51LnU5BnhtSzC83kHFc0ifK/ICxbAkpRha
	 yOSWE6xBQZbKf4CQhCPI5EWRJoch0CpOnbAYissk=
X-Riseup-User-ID: DCD0941570C4622093E0E8E6210C22C8A04D7AE62FD600F173C3BD9F25EB9400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4X4LLX3b67zJsSh;
	Thu, 12 Sep 2024 15:04:04 +0000 (UTC)
Message-ID: <386b3df4-dade-4ad0-b17a-3582b917b640@riseup.net>
Date: Thu, 12 Sep 2024 12:04:01 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
To: Maxime Ripard <mripard@kernel.org>, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, sean@poorly.run, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, seanpaul@google.com
References: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
 <68da3932-10ab-4001-a978-f0f54034a64d@riseup.net>
 <ZuGJyfhkQe93jKlz@louis-chauvet-laptop>
 <20240911-functional-finch-of-competition-ad54e9@houat>
Content-Language: en-US
From: Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20240911-functional-finch-of-competition-ad54e9@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 10:01, Maxime Ripard wrote:
> On Wed, Sep 11, 2024 at 02:15:05PM GMT, Louis Chauvet wrote:
>> Le 10/09/24 - 15:57, Maira Canal a écrit :
>>> On 9/10/24 12:10, Louis Chauvet wrote:
>>>> I've been actively working on VKMS to provide new features and
>>>> participated in reviews and testing. To help Maìra with her work, add
>>>> myself as co-maintainer of VKMS.
>>>>
>>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>>
>>> Acked-by: Maíra Canal <mairacanal@riseup.net>
>>>
>>> Please, check the procedures to apply for commit rights in drm-misc and
>>> apply it. This way you will be able to commit your patches.
>>
>> Thanks for your support!
>>
>> I just checked the rules to become a commiter, and it requires at least 10
>> non-trivial patches, so I can't apply right now.
> 
> As far as I'm concerned, being a maintainer of a driver in drm-misc
> gives you automatically that right :)

+1

Best Regards,
- Maíra

> 
> Maxime

