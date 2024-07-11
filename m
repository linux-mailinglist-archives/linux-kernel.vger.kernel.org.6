Return-Path: <linux-kernel+bounces-248659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092092E04F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480E61F22821
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1F12E1F9;
	Thu, 11 Jul 2024 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Qf6UdGtV"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79846374CB;
	Thu, 11 Jul 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680582; cv=none; b=YKhXaXjE945NSTrmeBjZLQ4FS6+liguM93PY9rZt82ykk/oDTFuJ5opkgC9ZUX3IuR8Zxp7P52UJYK3M6i3l9Ce53zrY/E3+JlJCKYOLGtqL6RwilZkpGBJyI2AXy/lTwgOeT81EJs2JCE3XsU5DT0GvQsionRQar6Jnerl4lVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680582; c=relaxed/simple;
	bh=6qI8fLIJiGf17J5Ni96D/YTFzWMMohhjRTncnDj8gIg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LT0IVSSrGMMQVFMlMNRd1T8LSOT/dx31v4iqhit20OEpVXRe5rk/aehRkrFtsnaJwzWnqvV3aswCEFNjv5wisTUlIoSkFtUywiTnpMQ3vrVHXKc2sfuAkTcCFQP0kXEbtkPSeHFRtGyHH8geZCVbqDSZE38Ooqj2rmdHAJIJ6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Qf6UdGtV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720680523; x=1721285323; i=markus.elfring@web.de;
	bh=6qI8fLIJiGf17J5Ni96D/YTFzWMMohhjRTncnDj8gIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qf6UdGtVg0C+3CVRbryVw/ff4dGeXSVSTquRkYNDn/jDjj1ReKAhus+X/6P80WH/
	 msiR+5OjWeqY+rtZMqAFwoBgnKv+IGyOQTCx69kAV2gaqX2WJ/QRWFzBOMCw+TZlO
	 iV8aOLR2YDWwYSrJ7SLsVwzCXGn8m7rzXrmBBn3sQeVj0K1MCrrj5LcOWKjokTKFQ
	 rbr8a2bOCXA5XuhBalFPkH4hALZSZZqhqrStomMxG3cJ1wi6WCnSSXWn1EjC42HiU
	 Mi8Qkj/ZGdxokChxM7/c1QB9zbwzrXxSHOMgVSOw2nHQ5AKES36vwG734WaKJ+S/6
	 ujlWJ/d/+YuN6umoag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1sDj8T3pXX-00rMnK; Thu, 11
 Jul 2024 08:48:43 +0200
Message-ID: <74b43faa-f212-4542-b7e2-68d5eb9ce474@web.de>
Date: Thu, 11 Jul 2024 08:48:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: tech-board@groups.linuxfoundation.org, LKML
 <linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Chen Jiahao <chenjiahao16@huawei.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Guchun Chen <guchun.chen@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Shuah Khan <shuah@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Xinhui Pan <Xinhui.Pan@amd.com>
References: <20240711024531.1604757-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/amdgpu: fix a possible null pointer dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240711024531.1604757-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SQMLuje8Gr1yokQNLO4dDAgbd+AIGjrCDl1NTgAreYMe3ccfHrM
 qHW7nk1tIK3Qh3sJg0yZ1UBiSf+em5kL7oH1eIuO/bKFYNuOy9t2z/YIg6SA8ozi1gV/ibU
 elAPMwnfIeGc4ta0+RTeysexxtXFQtcrQL1v0aH43/mpFGVjgm3nALJUMURbreMljVqOF0Z
 +aOxRAbBw4/DqyjagFnow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F35aPUitlI8=;iUxxLvJdovw+7SO0os6kpsTQkXg
 AevsvLV/3wAetvXBvxMzDMLKJ81X4uKxpOXUBTzCXnbeKnqMmZ9V/Itdlj6DgpPiqZfLITzLI
 gE0IaYZzN13JFQIQBGFf1jBQgXPTkFLAAjl3woxxyrL8A9COvOJ8GooNsisumF9Fx9ygLQxPc
 04lERQA2dXUCjmvWZ9+w+0lW3AbFEXjEsPQEEdCh1kjliIqTPue5RVzb6nP1uSsLNWPh5iMJv
 MlFPTRa/8ndIGpktU7pORraE1KHGNXLdxzvCYbBNKjllbE+/V6w0uHKShBb0JyyObQea8pNi+
 9YNi/PbP92NRkhlBbpmTA3Xbiu40GmRVvggNkVKiSRK0Us1yE+s9A3kp89JtDMbCC0PkNvom5
 bEx2yHphgAnm2X2dw6QXw4zYVxaXCfjjyHUEfhYmgEl7jctnpDYFehDMSvts1zKtdwtc4hfbi
 n/hPVpbSsUVQHQhWAMh3tTjBAGZbHpcnHVQFijlQWZuWPM/xX1E2BjMKB45rqSH+vI/pR/9Wv
 Oak57OurljQbWCMFup4rKX0r7BD8yFf2ay+vNjRBsvz94tAETcWnh2xOCN1GZiEivzCKwKCvY
 aY1VFFS2U0aeycECtCAt/UHQZoRoC+aTaf036FTiRAULa+HYi4gLgnk6LIzRHPmLeQYSh6SAy
 fmitSZaft1XyvWgdGjGNbxFPlfRNZkHmQvtx6hiG2kpDhypZntw1ZKXMs9s7MuVmUL+jdE7ww
 zDkkKpPV3eOGONJD7zcpoxWb8nIASLEKFqLQgY83dZwboiPyccJMkQIYo61nY17QlkWZRFXIQ
 1r+GNaPXAVQZ8DC9EGEmngpg==

> In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode=
()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_cvt_mode(). Add a check to avoid npd.
>
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Are you going to adhere to known research and development processes?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv6.10-rc7#n5

Regards,
Markus

