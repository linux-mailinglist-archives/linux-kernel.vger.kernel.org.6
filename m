Return-Path: <linux-kernel+bounces-401794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF169C1F43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A2282FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C791F585D;
	Fri,  8 Nov 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RzWyT0Om"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BD1F131C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076208; cv=none; b=VVeQ22oXiJa+Kp1dm1hld7AwqA5hyDclyeFWZN9vJrpCq8O00tN+uFs3TEQXdi4mio0KPE/Y+IGQzi7uBKq7u5cW2+cCCi+gaQeg39pnlJjlIzp5T9ISDd5IM3J/VFxPrpSN5L0+f5SGvaymMC6VyYhA/HlSDa/vU9i7gz8kVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076208; c=relaxed/simple;
	bh=EHxMIwCa8qmiBoghL6iGAleT+fQz3+bqy3/1DcOd/pg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bJCjvr75kIMdaVR/BaH4JzDUiN07UH7UNH6Iyy8X3VEXUXHFQ6kzzhuV0d1Frrz5gt4DXQC2pIyqTwIaI9BS2hpgtFocIBDiUiNDhv81gRlhJ7Mvn0IEchGzosLng0Kxy4vAUtUTlHjf7QloRQXFNFsuqKuArP9YQ/qSDqZhpaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RzWyT0Om; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731076204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXU0zqzH64T+oZBcduwWmn4Upe7MVevQ2K4G2VK2A+s=;
	b=RzWyT0OmX20cYiDWD/utFaU9an5SMKNlc3LneUtjhWoQxRHjmNaPJpQJ5FqC6wpPgihgBk
	/XLPL8amsRINXZGDWOn8rhiiIivVkkG2z2bYteFr00U+8lTpoMrhwNyVitsk+Ix0l/jKRM
	NeBe9BsGknLAoDw6+bJy+ctIHXksGy2vhe3e+b53uZupo5ZIpmnns/hvcj61pkr7HUibtz
	kM+t3uAWNvRCBI8qKK0+4gPtWsT1K32UYpUv3BmszszMf4jfTGtlEaPIxcHwryV+yWOMxR
	Z7oXE2gbuIVh8X/QVy/blRlOT5/WL/qps4joY/eI4+AsRZ1lw0URJHpci0teKQ==
Date: Fri, 08 Nov 2024 15:30:03 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Perform trivial code cleanups
In-Reply-To: <22484879.EfDdHjke4D@diego>
References: <cover.1731073565.git.dsimic@manjaro.org>
 <10558711.nUPlyArG6x@diego> <047164cc6e88dcbc7701cb0e28d564db@manjaro.org>
 <22484879.EfDdHjke4D@diego>
Message-ID: <c27ab238825451f1c3a4722f39a19531@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-11-08 15:22, Heiko Stübner wrote:
> Am Freitag, 8. November 2024, 15:13:33 CET schrieb Dragan Simic:
>> On 2024-11-08 15:09, Heiko Stübner wrote:
>> > Am Freitag, 8. November 2024, 15:05:02 CET schrieb Dragan Simic:
>> >> On 2024-11-08 14:56, Heiko Stübner wrote:
>> >> > Am Freitag, 8. November 2024, 14:53:57 CET schrieb Dragan Simic:
>> >> >> Perform a few trivial code cleanups, to make one logged message a bit
>> >> >> more
>> >> >> consistent with the other logged messages by capitalizing its first
>> >> >> word, and
>> >> >> to avoid line wrapping by using the 100-column width better.
>> >> >>
>> >> >> No intended functional changes are introduced by these code cleanups.
>> >> >>
>> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> >> ---
>> >> >>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++--------
>> >> >>  1 file changed, 4 insertions(+), 8 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> >> >> b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> >> >> index 58a44af0e9ad..f451e70efbdd 100644
>> >> >> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> >> >> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> >> >> @@ -1379,7 +1379,7 @@ static int dw_mipi_dsi_rockchip_probe(struct
>> >> >> platform_device *pdev)
>> >> >>  	}
>> >> >>
>> >> >>  	if (!dsi->cdata) {
>> >> >> -		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
>> >> >> +		DRM_DEV_ERROR(dev, "No dsi-config for %s node\n", np->name);
>> >> >
>> >> > this is all probe-related, why not convert to dev_err_probe?
>> >> >
>> >> > As the doc states [0], DRM_DEV_ERROR is deprecated in favor of dev_err.
>> >> > So dev_err_probe would be the correct way to go?
>> >>
>> >> Thanks for your quick response!  Seeing that DRM_DEV_ERROR() is now
>> >> deprecated (which I originally missed, in all honesty) makes me very
>> >> happy. :)  I've never been a huge fan of the format of the messages
>> >> that DRM_DEV_ERROR() produces.
>> >>
>> >> However, perhaps it would be better to keep these patches as-is, as
>> >> some kind of an intermediate, limited-scope cleanup + bugfix combo,
>> >> and leave the complete DRM_DEV_ERROR() --> dev_err()/dev_err_probe()
>> >> conversion to separate patches.  I think it would be better to avoid
>> >> a partial conversion, and I'll be more than happy to put the complete
>> >> conversion on my TODO list. :)
>> >
>> > But your patch-2 really just open-codes, what dev_err_probe is meant
>> > to fix. So with going this way, you're sort of making things worse
>> > first,
>> > until that second step happens.
>> >
>> > Similarly, reflowing lines for things that get removed in a week do not
>> > serve a purpose - those line-breaks have been that way for years
>> > already.
>> 
>> Hmm, it makes sense when described that way.  I'll see to perform the
>> complete conversion in the next few days.
> 
> just a note, as written on IRC earlier, I am sitting on a dev_err_probe
> conversion for dw-dsi-rockchip.
> 
> I was waiting to see if more cleanups turned up, so didn't sent that 
> yet.
> 
> Don't want to steal your spotlight though, so not sure if I should send
> that or wait for your conversion ;-)

I see no reasons why should we duplicate some effort. :)  If you're
already nearing the file-level conversion to its completion, please
feel free to send it, and we can drop this series. :)

