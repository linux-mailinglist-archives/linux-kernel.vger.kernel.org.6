Return-Path: <linux-kernel+bounces-348984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8398EEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E748CB221E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F118306E;
	Thu,  3 Oct 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KWZzfa79"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508626AD4;
	Thu,  3 Oct 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957828; cv=none; b=A5v4JWYjUAeqc+1U5xue+0Hi2QTU6/0KUAOP6SXRkQXPxyU/rr2aYrcQ5F9OM3R1ubxC0+HufWj4eK6CpYb3UOrTntRl3ZBbGQRnjPnZ9KEgv02oS9SdEg72+rffO4QDp4KyW5zdP+DOP+N9/wBCqGhI4xF4s38Lq4+EnY6/Ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957828; c=relaxed/simple;
	bh=VHnPe5JjctwpcQPgOWdjDqYJq+XTnXQdChzTsAkuj3k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=clrLgVPwoOHtP4n1iuP1nqAa20MwIxBKL4z3960ZhLI17eQPDHuLCxJAJnsSi0A3CH+05mcL3DZ3dZFKcxlhMFRQCESbMqtEWIkfZWP6LFpuPH0e5sc5LQfBcDUkL34Fc0PN+zGj/QQfDYw88YOOX53P0sethGVnHe+mdZYdJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KWZzfa79; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727957813; x=1728562613; i=markus.elfring@web.de;
	bh=8I/IVOJ3HUxRhKc3coTrKl5H6hLLRD2Cqq329HCmAMs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KWZzfa79eoJusIj+SI02HZcVeTsQJT9lKNItBaG/W8Vi+sIU7ovmNWmrFYpT8EIr
	 cnS9DdnFlAnHueEKFhExQVQb2q5rCSQygyY6KRH5EXubAZ96RVfpn/v3ZLpih4tnj
	 M5cI3LwKpTFar9d87YBvstLNL8B/40Or4OBEKOdPhzXKxIDHYjdKUuMRpw9ohoJyj
	 DiEPCHixJFoihspZpsbMyH9oru0TAUPBhcm4hWqOffgd4yZxN+Z631eExsPaIPL+p
	 CmGhFGYHpEfFtJlfHWeCBAOgOak7uSzxM2TXgkBUf/XKzh4YKdkwQa7y4SmCeKh1+
	 TLXZeOkALx3MU22Zpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30ZN-1rtfqa21KX-017WxI; Thu, 03
 Oct 2024 14:16:53 +0200
Message-ID: <591377f6-1926-49df-a1cf-6b621244a710@web.de>
Date: Thu, 3 Oct 2024 14:16:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@gmail.com>, Edmund Dea <edmund.j.dea@intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/kmb: Use common error handling code in kmb_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uL7MhWR5SiXR/kMcs5RsR9sj6LDYN4Fz+J3FqEkdyXxpptsRV/k
 yEplJlOq2a87hAxfwzsdXCYks0r7GprGgrE8LKeN2ac00TT3K4Xb24JIWXGMGwxU+rO1kY8
 RktrRdwTIRReqCWfWTXIUv3m+rkgnfSWFBQ3eIqVZH9TT1JVI0WpT0M3C6DvIpnMrPjrgy9
 A8KUQeBFDKcolJpJ9i3ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KCtrGQQkKZY=;TF5WihV4S6I79F9YfEj54MYbYD8
 /RLaOqfTbpetzSRjLm8ka1Nc07LDwgTcIwpvBPO78qziCXUU0uU03lBRTq1ZGH00U1BHcQp03
 e+dErfyCqI8wi/FLK8LXkY6Mns12agpqnoe5umMwCCxpjqKnX11VUVed7ZfR6pLUrtj4le+kC
 qNzhdTe7T+RoXRTgIBwH9yQ5IJxpvEYpaiMHvufpmaVoStHvokb4NTwCBhT9j84x1iwoDkbk9
 rJU50rq0JADFt5o++4V4xRB4B/6SVig9uke6atfdbMKALanjxkULgk6fASIg5hCwqR341ah8t
 bbqO3iSz6mNBj9bLcOEhE1ePrn0VvpOE4JK6q20uSYD7gPGM5kPJEclbLJAjOTikPeRxf+Olj
 IZSzx2Vnwg5Azt+f34NBg+DtVKK8wc0VEtC4Zn9KTkhvkDbWZCHogplMxVp0Ik2hT8gQsnyMJ
 MSMESOE9PqPf3WhTzqrhniDtQ1LNNjdo06Fr6+z+fDwwOvUfjJ1QH/JrOBr+y+F6U0zDlTJOx
 jy0QHmEy2jXLu/9sLI0XLPyMnOul7SctuRLEb6y4K64kVuselECpu9ilJAhyo75MnIA1J6o7n
 lU0as8A+bgKiDRdLDgBhzTC3O+6+BD+eiZpyN7LxQ1CYMkEw1P/BIO711x5Ut31O+Uz6eyCUD
 3kwDiN7uKHDzt7MZbu+mPRu/CvZfFSou7ecEzaaoX0luGiE0cKjiaGi4qrAzZwn1912pKt/V6
 wmTEF7oOvevlYv1E7x35Jqe/kjUlc+eZkww/BWMoJfqr+gKMe/MGiC613JdqeYUgR42Qol+Ot
 Hwj3+60mYDVkHQGxTV0qnYcQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 3 Oct 2024 13:20:05 +0200

Add a label so that a bit of exception handling can be better reused
in a subsequent if branch of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/kmb/kmb_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 169b83987ce2..2680afa684a2 100644
=2D-- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -498,16 +498,16 @@ static int kmb_probe(struct platform_device *pdev)
 	}
 	dsi_node =3D of_graph_get_remote_port_parent(dsi_in);
 	if (!dsi_node) {
-		of_node_put(dsi_in);
 		DRM_ERROR("Failed to get dsi node from DT\n");
-		return -EINVAL;
+		goto err_put_dsi_in;
 	}

 	dsi_pdev =3D of_find_device_by_node(dsi_node);
 	if (!dsi_pdev) {
-		of_node_put(dsi_in);
 		of_node_put(dsi_node);
 		DRM_ERROR("Failed to get dsi platform device\n");
+err_put_dsi_in:
+		of_node_put(dsi_in);
 		return -EINVAL;
 	}

=2D-
2.46.1


