Return-Path: <linux-kernel+bounces-362744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0099B8E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4071C20C34
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDD13AD2A;
	Sun, 13 Oct 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ufsDYMRk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CB12CD88;
	Sun, 13 Oct 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728810547; cv=none; b=AAv+xcO/jI9KjlyVMUuwD1rRb4h7LEbLqOJ2xKpKHplHJfPkmLp+wCSIQPc9mWqvHm49L5eBSWRbjJTqDsygd97DcY5KLPlBEt18YD85odMa7LQ4oG/LkIVTjgqqYanPycPuG83rdS3QGP/YDkBmxzEZVVNtV8GvR+cVJCcgIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728810547; c=relaxed/simple;
	bh=bk1Cmpp8hfSOZ8cDEqEfiHXDRPHWrqf+C5g/tx1Cc+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCt+9CHisMuYKDQNlF7UaL7GRiQarA/jdH6oKTfhkaC2QaOvkqV6K94kof51HeqQ9fHEzTwCzbCM5gMCav1Isgtpk3EFeUfQgM+mO1flJ6IaBLEYkxZE0rAltDuwPaMahBUBZAr3yox/4oUrsk0bI/vW5L3tkHlIhPF8pQqEd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ufsDYMRk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728810532; x=1729415332; i=wahrenst@gmx.net;
	bh=UsAIdWe5potvvua1FVV0w8R2E6NW4K544p9dIWK0Ggc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ufsDYMRkcHPiORHNiZ97uStt4t4voQoks4nci7YgOA9zry7VpRTVgx+f8hWMGtdb
	 OIf8yF+KflG6qUaQVZM6mLGARFrEDv+W0Ul0UZDBA/CYq8w+DaiWbmoaF+yUKddax
	 jxOh4tSZNsejXLLpImDdEN11EWKqsdkN0er7xD0Z3UdzwuevrTsU2cNb5G13Rn4K8
	 cM01To1+zXBOMn4r8Klw3JfLIshnBdKq7V29gFMYqt5iSVfiDxH9CymDfr9nFdqun
	 GIY/rFxi4ET4m+mfB1zJmNd3SrpjZOAax0TqXmyUDh6GkqArehGHOuOR9NLJ5Req+
	 ZTMb73fH4q/Lk+3cZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1tdvuc2ijG-00aKr6; Sun, 13
 Oct 2024 11:08:52 +0200
Message-ID: <43abc7cd-89ca-4129-8f0b-f46c26e43510@gmx.net>
Date: Sun, 13 Oct 2024 11:08:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] staging: vchiq_arm: Drop blank lines
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
 <20241013084529.377488-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241013084529.377488-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pK1zUEGVKR7Z1EZLbRnzRHlXym1WTMruNtQCWtnHGQT7DE8uElW
 e42eMnfChgCGKwO74vheivFfj35lt585vI/b4iadJwU06dwCPCbWlGNbEnYbzsy6x148Akx
 iNa8Vt832MtrSCg2c6YHEWhAdubSIuARmTlQ65yhmN2iClnEuSMZxpAuzm//qwgFnEhsRmp
 N85GLH3qHPTY/WhmbxWFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mQ7Bjz7PYuw=;5WNqnyOkuI5Eu2XYGNfeoYvZLQw
 BipwRxyxdz9L6h8LXASjABRnidWhnuH/gkWDuMqflxbxTX442pAOOfnNl6THDAVoWOvp5lFta
 pLvsyEa6j2F9C1AeMekoys0fKDx1MckuOSJuuWeCUMwBQv0LNSrAzwyAAn6+ZWzP6HdEKswAi
 BUJWcGiHr57Ky7bmU8yXSNcR1QRYstGp2FSv7SodiaFrQLmSlaYL5CTPELjVxi2vI06rfbMG+
 eNDo0KtfMgEsGjifXWQLBZo6Fp+6RX03woHFbk/c4K1EiIbHJ+pd5ZBM5xAqKRE4gX1cpptwF
 TN4wPeNeIzma8A2XG/jhz1QefVHNXnzVYEksCQgxNdHvZDUP/uuvCWSwtyPMaS3ybc/Ew6s+u
 bFMATC1HmSoVdGMWOBTpriGUhwBAIFSOsHr66yYEvdgp7YRl4vn6XbuUzADPLRBfFfu7BZQOe
 1I6uAN3g30fyPcO1N4xn6U5pM1NnaxrRyaXPRKkh6YSHIND1TyqLGEqAyrUpN62Ep8Ex64TtY
 3VKkviobElSHzVO8ggvGroWSlm2oZb2HJ5Eg3akZH3k9E/U4FBd5+B6xjOuHIVyM3oUZhg71K
 fJNz8B+eMGSC2JNt+Hh9LzuBzXNvr20ZI8K00sE+veCdSN3wlAMx+QNFMhraLWy1Lq43AUW/v
 65rhMAt5ytJX0l1o7VODuSCPI4c3cZRP8suXcVC/p7+OL4d+nNk4pbOopB0ukSyng764IMM0j
 MVu1sRKpDHF96oeGElUw9bmGMeDAH5GHfn5/LLd2MOn22fPfgjbE1A6UZraS0Xk89AJq4/in0
 rwX51qMTfib/C9KIvG7+Fp/w==

Hi Umang,

Am 13.10.24 um 10:45 schrieb Umang Jain:
> Drop unnecessary blank lines from vchiq_arm.c.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Danilo was a little bit faster [1], so I think you shouldn't care about
this.

Regards

[1] -
https://lore.kernel.org/linux-staging/20241012233931.30720-1-dpereira@lkca=
mp.dev/T/#u
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 27ceaac8f6cc..e780ed714a14 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -309,9 +309,6 @@ static struct vchiq_arm_state *vchiq_platform_get_ar=
m_state(struct vchiq_state *
>   	return (struct vchiq_arm_state *)state->platform_state;
>   }
>
> -
> -
> -
>   void vchiq_dump_platform_state(struct seq_file *f)
>   {
>   	seq_puts(f, "  Platform: 2835 (VC master)\n");


