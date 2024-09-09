Return-Path: <linux-kernel+bounces-321071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B997140E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D7FB223E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190811B3B08;
	Mon,  9 Sep 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jRuMaP3k"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33C2B9B7;
	Mon,  9 Sep 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874989; cv=none; b=ImWq2EBb5kN7wyg4xwjHMizI3H74eeaLkUB499yevxJHEMaglTkQ22ilPAJpENeeISaJ0wJWIbDR0wQQl2CRDf6E/z4MrUhpFPdKBEunVulNZVyk3mJzIGddf3aJBWmVSvQtlZvaSbGdJQMu4D1ueI66QEyHSAeHb1CibUFIn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874989; c=relaxed/simple;
	bh=oaQTAchEaBkSQcwrLccybjUtspKB7+exoP4r1K4V8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u1bRmRgpEVanbU/3SLcbcZhAj0HRd+y3NIi52FOcaXudT5FGouDmt4IlRKaDvPif2RKpPSaUxw404FEaszAyvG87chON6Jd0dyGtScqdwYODCBCXyPfSBDmrNrq2JkqTiAex78tzwhOMHiYP++5rQb73cmqhUdYqhcFE38kzXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jRuMaP3k; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725874946; x=1726479746; i=markus.elfring@web.de;
	bh=EBlqzeibcHmLE8jmEMvY/kGvwXFkAdrNBvVf/DUWlqQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jRuMaP3kv/79914X8WkyFcRufIcKEX1mn6+C3ACulpE1FKCVk4WN2pliQPxLddu5
	 2iOcXpyeEShRv5pJnxYaV5bQF73LcEBCQRIQhgFcEjrNzPjIG54dqi2N1Xoomm/AF
	 RAvJHyXe3dbJOnt7OjtZnErFGqo1X5Rrx91P1SHFt5Yz4XQoHgdavxivTw4Wzbc0Q
	 BUC3P4OHjZ4dXpTpSC1zJwpgeHsv4qNBUMWscFh9iTAiUmCZv8fkKrBUCYY7/sKom
	 13beFEvK/fSEBlsHH8kyANynfLlsOaA2wX/nYZMmzppU1N9g/maHX1cyfw7+YQb19
	 WlxX4ZOzuDZHSIzLVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1sl7o90LFL-00EbI9; Mon, 09
 Sep 2024 11:42:26 +0200
Message-ID: <d4136720-e6c8-490b-933a-4a884412b38a@web.de>
Date: Mon, 9 Sep 2024 11:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Move a variable assignment behind a null
 pointer check in amdgpu_ras_interrupt_dispatch()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
 <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Language: en-GB
In-Reply-To: <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FinRSsoYLcUBzW5CselKtDxWi72MFZcC3KilliEKBsQUeKXYei
 FR2I8NrqAgdIr7ze6KALJPaM7wknBcUXSmvlGyO7sm9JokMjRgJonKx2kUM2LDr2R2qlBew
 oHpIeeJnmJltdTUQ2q2AREeQHxSuBS/F94J2yTpY+UIAZtqw2TB5gH2spYfpgruDPCjvV+f
 dPM9jIAK7/z0nl5PCkokg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4mNfO0uCz2s=;QgAKWGK+oCVd1C58nJsisjfUumH
 UMZmClwq9WwbmEwKs0+o3InvaH49mHbVoA43aHpnciXuMv++wM97ehl85Nab5/LXN0js53AiO
 EzYUt9sYSBwxlWlR+9nFnwyG/TDN73Kv8BkgsREn3EA7hFIbppbXE+zmt+MabpUhiIK66iJ03
 aXjpemLGO7cZhg5mcC2VGg1tf/bs2hdO0PmiGFxOATsywO80kwExz8zHnPHQAZrsvG0i7a+sA
 xSjvaCOz5t84lyOuaL7csvkuQ7lp2PghHkcDb0ZfpBlN/J1zmj+62HIPRyWS7HwGWYFJcZFpg
 k+FAOoQ7JazBLKMLigp+yG2X6dO7PVjV4uGwAwkWNCvrrnGtNfHQQGjg0bD+resJXlx2Voqjv
 OXRlDX5OPmmPXiDJrqk/sLY8LVVTphwEXblDdXb9RqoyRlmYxusqGpcF+SUiPpAOIAe5xGo8+
 5TCdEqgocUXf2JbtOgJ9ayZ8JrLKFbYe6TPdJpyOrI7nyxTG6HKgi9dE/Gnw4KG8/4kWZPy6k
 Pw+99s3sXF0SR0OxlIP+Fkl4DRslS1Vui5yj4jzEwiZaVoNp/jPG4SRBkdzWycNAlIPr8h7pB
 AiUokGue70Z16SqzBH+ZJNWb7CwJu9whs/ZITLd1cShfdDaXav+gEVWBa4EtRNMprGrKZsQwO
 oGpFqHnJSf0ZYOP+xNVgjLETz0/LvRK5H9LcsqiXRaB0K7sx1IH6hgEixESofMowET5qtP8BN
 DnvYQwP227HLP4OM7L50krSK+sVZ0p2IGxOMUUtgTaUvVJY2vP7dORRcd8kx3dyEcCov491na
 5yIA4CEHwoVpxpFHGIbbbRMA==

> Date: Tue, 11 Apr 2023 10:52:48 +0200
>
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Camdgpu_ras_interrupt_dispatch=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cdata=E2=80=9D behind the null pointer check.
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: c030f2e4166c3f5597c7e7a70bcd9ab383695de4 ("drm/amdgpu: add amdgpu=
_ras.c to support ras (v2)")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.c
> index 4069bce9479f..a920c7888d07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1730,11 +1730,12 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_=
device *adev,
>  		struct ras_dispatch_if *info)
>  {
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
> -	struct ras_ih_data *data =3D &obj->ih_data;
> +	struct ras_ih_data *data;
>
>  	if (!obj)
>  		return -EINVAL;
>
> +	data =3D &obj->ih_data;
>  	if (data->inuse =3D=3D 0)
>  		return 0;
>

I would like to point out that another software adjustment got the desired
development attention (on 2024-05-11).

See also:
Commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ("drm/amdgpu:
Fix the null pointer dereference to ras_manager")

Regards,
Markus

