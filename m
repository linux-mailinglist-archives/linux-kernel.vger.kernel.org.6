Return-Path: <linux-kernel+bounces-279520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64394BE6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8104D2827D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02318CBF5;
	Thu,  8 Aug 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qi2pkW44"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E5188012;
	Thu,  8 Aug 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123058; cv=none; b=pXKVaRfG2muKT8/F2dQIb+oS1ao/5k9Ih6Mw33HsAekKF52lW7LArZicuA9rmBREda37qHZ21arq+pBAHefocYa+fY8D+GpZfi2va1cwkyN0p+kqjHBxWwjyoJqKNi1BzaBszWDFIaJvlnfYE9hX4Yt2y3C6FCzxfHYUwsxPZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123058; c=relaxed/simple;
	bh=tAkUM349MBB9ygWpP0YmVSM14pjf3ShEmbYr/yOgm4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oqD8CuhB6LJtjL3iHP7G/xuRhIS+YnfiJObCniYwKoVz5D2uoC4hOun0qJy7BDJx/UlUZkcFP3T0eROgrJyhXeMXbE/lW6eo180bvgRogqM839av2GC8HY9sqQvs/KDB58j5rT6gbvy2OLHCkOXY7yfhnuSkT6qE8YwENEnR/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qi2pkW44; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3A0F2418AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723123056; bh=C+/tNLsG2YZ2hXnH2YATaWHxkruINKGFqJVnuP6i+Js=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qi2pkW44noL9wwPrgrbLQoiXjSRg1BFOzIJt0h8L+3w9U+mXItfuTknhA2riWxtjL
	 L3JQkmlcDX197hL0QrRjvH7+pGAeJrTnsQDACqrpCjRwPdrLU8TrrkSMv0X/OwLk6U
	 ZtYjfpmtll+DCZ8Ws/WZ5hWrY+kF6CYVHCSUkVY3ycYXZMF4kHBlY+1i/KoW23Sryl
	 x+TcplP13rYr9HKtNBOFWONmS55oY1/VQm0ylSv2hkiFiIdlit8FPy+QqAwzKiu9Ji
	 IgPv7DBU8fDk4nFc/GIGeOtekhMZlss3zTbK2rELVf69W1n6UiGGnry9OBr+HYpfWu
	 wn7QfXVbncyWw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3A0F2418AF;
	Thu,  8 Aug 2024 13:17:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Guo Xuenan <guoxuenan@huawei.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, guoxuenan@huawei.com,
 guoxuenan@huaweicloud.com, jack.qiu@huawei.com, ganjie5@huawei.com
Subject: Re: [PATCH] Documentation: dontdiff: remove 'utf8data.h'
In-Reply-To: <20240808085707.3235019-1-guoxuenan@huawei.com>
References: <20240808085707.3235019-1-guoxuenan@huawei.com>
Date: Thu, 08 Aug 2024 07:17:35 -0600
Message-ID: <87sevfp30w.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guo Xuenan <guoxuenan@huawei.com> writes:

> From: ganjie <ganjie5@huawei.com>
>
> Commit 2b3d04787012 ("unicode: Add utf8-data module") changed the
> database file from 'utf8data.h' to 'utf8data.c' to build separate
> module, but it seems forgot to update Documentation/dontdiff. Remove
> 'utf8data.h' and add 'utf8data.c'.
>
> Signed-off-by: ganjie <ganjie5@huawei.com>
> ---
>  Documentation/dontdiff | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 3c399f132e2d..94b3492dc301 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -262,7 +262,7 @@ vsyscall_32.lds
>  wanxlfw.inc
>  uImage
>  unifdef
> -utf8data.h
> +utf8data.c
>  wakeup.bin
>  wakeup.elf
>  wakeup.lds

I'll apply this, but does anybody actually use the dontdiff file
anymore?  I think it's old and, if being used, actively harmful; for
example, it masks changes to "parse.c", an instance of which was added
to git in January.

Is there a reason to not just remove this file?

Thanks,

jon

