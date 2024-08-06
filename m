Return-Path: <linux-kernel+bounces-276490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7299194947F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7928976F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92821BDDB;
	Tue,  6 Aug 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZJEKyufa"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F921182D2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957986; cv=none; b=L/h0x0jVKHRhw9BiLdixL0hE4dmLWhMV1akTmX3a8KZBBeaC5xkq6WPHbySQ0I+/yMIDvFMBmj/j2Ypy7PoTHy91mdxOvLlWC47IBSWKWeueGDUU/XxaI2zUBFZGPKra82yQ4C3GoaJAJ/xYVS/Dy7wGdZR01e09CNhP8htm8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957986; c=relaxed/simple;
	bh=mAaOVbyeS7EsHcTkUzN5M99HJ5btMRVCZC64rug2BVA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WwxY2asuDiHkhNfY3+wS8j/GNMB2lIDns+2pxy89Fb4OeUyd6HTABnf9brJbJfJqySmjpbi8JSXiKI0XyfFSSVguXeqwVNo8MBbmiZTJcMaXaEnfNUi1X03+dN42W2SNyZ5iW1MIOX2Is0tsXmcCU4LI2F6+bsplR8IsY7lJBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZJEKyufa; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722957973; x=1723562773; i=markus.elfring@web.de;
	bh=bLhzpkSHLPZnvLieT2mCYEBjfAyqjRQ+E91la7udnrc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZJEKyufaIyd3lCZ1PK8poBvTYORNVZ6DhjmtVQMd9nk0zDvUR8IgsN+uwFV6jmDc
	 fzwbjif0JKJsjYc4OOsnh0zOLY3KsR+VX9NfXqQrAXqZEGdCp44ZKPYWNznKn5MRr
	 r2nbRzCFgaN5Ud3pVNSp8i/NCd8+vrMWU1zfz6FPu7o3/r5IOWRnXPV00wDQcw3Gt
	 N3WpQ+bRxzx/SSf3zeWid+OqtsAoetVOnFdkJwQT9IvFFLPoYZqxIR/sxECkYnfQT
	 jNE/EJd84BPLlGX4ISGCbf3Tfd+aRFdQlHiDtq4HIZfNWcs5NEABYjghxubfb1qan
	 s0vwgpak2qcZ7oeUVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1rs3IL2wal-00mucq; Tue, 06
 Aug 2024 17:20:34 +0200
Message-ID: <e518ae77-57bf-44b2-a0c7-0891ec80d03a@web.de>
Date: Tue, 6 Aug 2024 17:20:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240806-omapdrm-misc-fixes-v1-3-15d31aea0831@ideasonboard.com>
Subject: Re: [PATCH 3/3] drm/omap: Fix locking in omap_gem_new_dmabuf()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240806-omapdrm-misc-fixes-v1-3-15d31aea0831@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbEVBCwDOame7wFPdZHP4x2lqMPfgWJ11pWsTF4wmBA0PxY6t1u
 gHR9GLAtnEKBHR9MTA7eI7XxQLbnBBJDIagxOQaLhLB6cwgEBZgbAL1I/VMqiOmmGaclWFE
 0x7R17NtPn7a6xAec3YM0aR3gcknd7ZqDuB/GaUtY8/WawiHELh2t4vWpEOhUhC7DSRDQqU
 N7Qz0+21zRdLHBhacTh+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t79seN48P60=;82ZOveXbbHJ1J3NbkUpr9DzoZrE
 9U9WQRAH642vgcUS/UsoF6f7hRGIbRVonflVJVYmZPyACeiAuPwEPPYFVPRiGNK4wY0/qq6p4
 Bum6SOZQZD+tAslsA7PQ5otqZW9TG/RWoK45WNO1DNTx/Yp7pFLilYxHg4JgmkU69D8+0oruS
 mCagT51J3qVVpr0UzdSmZyzUBuoW1lyel6MuedDlUwj7VTRgFtqnUYjRKAfrKFuzZaDcSQ6sr
 Yeb2rA1lDwssXaCuF1gZIyIcwIrl/tplVCV0kRWc/te9zYiiopqZPMpQ0qIpv52PGCdLBP2xn
 3PBA6fLpnvfsXag117N+47FQl5bzLeE+3P09Njbb2I9AvgVlFdcO8kFbL56kWyjJ6A+O3hcSL
 Q39sb6dC+9tpXWNlaLHiD2npRyTbpfXm+U7SKPAwQHER2ICW3nMtdB+6il1+u7GrltUh6lVTM
 oqgnB36ZIRYEUILGa0nkG7VDww+cn4CBT/DKbiVkeZ8cjmBqbShctyTI6ONU70Jue6ykuV3k/
 dzvFrkR1h62hWHqbj6QHwnkASf4yzdOZZZGDv4QZ3UC+fjd56TooHs0gTrYxSNJFrnPSJtHsO
 i4hXDOH8ZlEDmOK7kgzdkt2GodQiLqz2OokN2ZjDeX+Wsbhnezjot/hwFZPUbLhKYCVZ/kjYc
 6hxtBjgEWBXabZvAeFlGCeFI3L9aWqDd5HhT9IqKLcHbABebz4gibOEr2qC9ZybxdOIWATYmk
 aYAq+hQBXyfLsv77xVY7Iy7vmqu9IuhaEkj7ab//EKFA8OsjEUmBVYp8GdRReZyKQsC8g0A2o
 Vk1c63IOIT+eAx6e4FC5XoAQ==

=E2=80=A6
> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
=E2=80=A6
> @@ -1418,21 +1416,17 @@ struct drm_gem_object *omap_gem_new_dmabuf(struc=
t drm_device *dev, size_t size,
>  		pages =3D kcalloc(npages, sizeof(*pages), GFP_KERNEL);
>  		if (!pages) {
>  			omap_gem_free_object(obj);
> -			obj =3D ERR_PTR(-ENOMEM);
> -			goto done;
> +			return ERR_PTR(-ENOMEM);
>  		}
>
>  		omap_obj->pages =3D pages;
>  		ret =3D drm_prime_sg_to_page_array(sgt, pages, npages);
>  		if (ret) {
>  			omap_gem_free_object(obj);
> -			obj =3D ERR_PTR(-ENOMEM);
> -			goto done;
> +			return ERR_PTR(-ENOMEM);
>  		}
=E2=80=A6

I suggest to use another goto chain instead so that a bit of exception han=
dling
can be better reused at the end of this function implementation.

Regards,
Markus

