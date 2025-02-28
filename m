Return-Path: <linux-kernel+bounces-538936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0FA49EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD851882D93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210B271818;
	Fri, 28 Feb 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="crjVsU99"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614EA254861;
	Fri, 28 Feb 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760624; cv=none; b=AilXdkTheQvVcdIZ7XyScRZODxBYL9dcla7ssLXq5oqKnf47dqJddoiV5jf5QvVfeg76u2cYGaVnLgw6k4Wlfr1ypK+BOBqeDnFsoxFBTsuNGvwvmhawD5A47ZNVg3MAXhmJXVM1vVzIiMMcrxMh+jdR0q54uPD55HkqN56Xu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760624; c=relaxed/simple;
	bh=UcdzUFgY64qhkR/FTBBvQ+8/NVzky6HoTCKp1K6d2DM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tAjx7PSkQDs1wfsFf4sqieaDAIHZgjiiYQah04VTw08YPEd+TJy1/giw93yoplw/GEi0U6Z6FjzeEZh6MoUWFD9MYobPEP3AvOFXq2ADunMJityYofuHXUCFgOsoyp5oK3wxoIhfTehQ8R9trh+SvQOhMFGGPjl1NNqBnnLvZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=crjVsU99; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740760611; x=1741365411; i=markus.elfring@web.de;
	bh=P3aAi1K30diMwcSyotdSLBi8iQUEl+hDB2tmHvN4WgM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=crjVsU99nW/CZBMET6nlxo5P5Ve71G2x3ctFqiGmxnvi7FsxwgfQXyv5sn6OWVsb
	 x4qIMcrgrPve+oNy2UrDX5r6tSg0n1lSWr+zn5uco0QIgDtF+27/LMp+dXSoSRyS2
	 5CMin+pvn3H63SnHPS1vPtrLOaEIURSr+hsFC5kieFfAA0rPDZpeH+tb67yq+02AJ
	 SLaehROwWbAceE2iVSDbnQ/l6015TwXCK9FmDiRiYd7eQsnK2PUIcHEMlfCfZN7uk
	 5MQQwEL21T+XVl81aMuZRHZZK8OcXMkSw42rTjlB9PBChlON+Ylqkpj/KEjiVzmt6
	 D946/tidGDGJjMRPYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1th5Lf3hO5-00Hx7y; Fri, 28
 Feb 2025 17:36:50 +0100
Message-ID: <225be170-472d-40c1-95ed-71b452740ae7@web.de>
Date: Fri, 28 Feb 2025 17:36:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/radeon: Simplify maximum determination in
 radeon_uvd_calc_upll_dividers()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pQnRLfx8v4G9J+knpTzjK8SoUNS8MlolvSv3lkROWsw5FtuoZvC
 jejqbXK5eiAEUA/Wy3nz448SRf7fWzTID2DWCqDZk4gpGPTOppr9sNw80VIGYfnyk/hBve/
 MNEtXyvm5MDb4NTUi0brMno2VkKUjZLkPkSn3SG1mbtIUZ6Zc5zQUgAJJVWUt6893KWyP0h
 fhxSENApa2wuLnjbLweRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IoqzqYMsVKE=;8IMPCWVo7UO+jbp8zxoV4K9CIxH
 WUT5+Lqmgwmg9nmcLw7B62FBoZSApUZoLbTAR08MqOnYrR8NIPjp9H3hVMDqGbXcF1aZWmfh4
 9DJRGCpInmZXDQmzmF0QLWtBhjeD7nZcwTabq/nthTdMszLW7jtGpixi9g+/UIradL1uPk+Un
 8CKHNaCau95MOeD2QdI31+1Xu4OopBONfv5QhYKzH4qRYuBxuIAdhKzAtrRmgS6uVIatXLvy1
 zFN0nJHP/Xf8ouS4JzlVspTzNCQjen8K7495sn52gU4Q8xdZ+35q+Qk8/8tFxvW0hB849yGHs
 nPyZd0yxVJl9X3u9gdxtXibEeVrth5sUHVCRspdBF9JVAwuafg+Tjm0/6afVMYgvZx3ifCir1
 i11NcSYwA1Do044NNc0slPpIenXy9SOClbe+MzyyhZhRJRURrsXs+cPbzilwO6g1z0y2mFroS
 g8RTkPjpNf0+bjVyjtZPNNrMzRQmdmxGtL4LAeMRGksCAW6z1DlglCcGLGGSrXC84QabDukpQ
 vLcbn/izySG8Em5eBzNFfD5eRctBnH5fjY0Rq1BJHpSO9kv9hUr2o/tvTR94rXGsC0qpdA0y0
 IXNMY7vDiW3TCoOFiSAaQiXVagS3lEyW9af+Vm5LtntRizcm/Bi0/r0U3yomEQpOrHTP1N82V
 Dwzdht/SZUWDz85cvDj9AbGj9UZAnMkuD0SPaJY4KlreyIqDM4Dgjd8g7OAKKNZ3Vex3oMpM5
 OTunsUnTg4uj7+QG5wlcPmn3AZQ4Ui5dpMWdUdCO9NYHoSi9+VCL60J4VoCqGWdP1/dV+H771
 a7+wyQSedToNCdNfc3/VuWxVdqcXEvxMKmvD3Y50JONzJyV7cdnZ3R4swNo4qA2bp/MMdixZC
 1xz2af6rOp4rtK/wUT5mfbk2Re1wpccXrZXl42RPI+T+S8o01DuUcZ4sqOfc2cwB8xQlzL2Fd
 +OxUKL0u1lap4P71NQ9Ff2MnMgLtCoT408b4/7nTl8KF0evcN3GZsn5T/N7WL9Dg8dvrUj7va
 vBEivYCkNtF23WB2PttWtQZMS0LwiDZ4DyyWdpGsGPg1tNRsvPBxoAb5L4zFJ93IQ2PcYMdsq
 rXrKccO9wGsLZI47/FUf0ClRHNfUpVJO5yRJ/G26YdvBXb2Dxg9aFnGA6bOrEOdN1VRWlfa/6
 QXg87qVTASNpsvb1iuSXUadOGUDMl0/rUumy6IWUTffs5ySH9FBAwMyx01meX2y2gcBQLE2GC
 LxpIO/8N5+ammdtWZLxtb1+xzFZ82eusr4uMbyOFatsQZbX//2IEWCJU/u85y4YCqrb/StABr
 NUGd5KblsU8y+nFupKcH72vo+HijS5+6PV5Mwc0lVH49vg2HHA006eDF7X0fxqqFkLG27+Y2a
 vnvANt8zRWDhTpU8NZO0aY2CyJCoS6Xhqg1r5qDMgmjS4bU0lzcdsPndYTV4ifzBIXZH2hY0b
 3x+GMY8rBnsiXlSRihqzpU2pUyUs=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 17:32:45 +0100

Replace nested max() calls by single max3() call in this
function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/=
radeon_uvd.c
index 058a1c8451b2..ded5747a58d1 100644
=2D-- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -961,7 +961,7 @@ int radeon_uvd_calc_upll_dividers(struct radeon_device=
 *rdev,
 	unsigned optimal_score =3D ~0;

 	/* loop through vco from low to high */
-	vco_min =3D max(max(vco_min, vclk), dclk);
+	vco_min =3D max3(vco_min, vclk, dclk);
 	for (vco_freq =3D vco_min; vco_freq <=3D vco_max; vco_freq +=3D 100) {

 		uint64_t fb_div =3D (uint64_t)vco_freq * fb_factor;
=2D-
2.48.1


