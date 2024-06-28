Return-Path: <linux-kernel+bounces-234195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36C91C387
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A5E2819FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A41C9EC3;
	Fri, 28 Jun 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KcmU2isO"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6221158DDC;
	Fri, 28 Jun 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591266; cv=none; b=Jxi8h0spMi5wBw6bcgH6IEVH6cxRNeI5T2aer4Wfp6bRGkCfmk/w0/S2+lzDV2/Q3+oX3IbeICp0Ywe90lpvyFDQuOYKldKBXxOQ2y1OR5k7oAwXC8fC4AQNNjgkJctQ3AnOXAxu0yQoVERqUyHWKA3n0jJu2fZgdvfeUwT2pT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591266; c=relaxed/simple;
	bh=feF1lOyhnHeQGXNKtOQi+xZFfMBlR7bnlTEk0I8pZ7E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=fEkSHhR6pg7iJewd/RSRFFhJ4dkW6Vgutcbcm2fFftCImSAHKbihpG+7VkY4ckMkkUSyHnh9/DokfWEOUbSBb7gaeRYQDrcrJod0Y7CJCcLpsUubSiJ/CkPD5wjsLO0mGLVITSPnEjYJrF5ZxoB0TdAVYYxqLQdBlkGd4+YpThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KcmU2isO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719590913; x=1720195713; i=markus.elfring@web.de;
	bh=jMjENFh+f5y9wyjB5cxn4bcX9t6DsGiG5xIjoFHNnL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KcmU2isOzbZdqyyKmg87LJN7CYNLrBhng4oN6+Uq9FP6ivUE17oN7cD3XpH952my
	 12kn7y9w7KVj1dttLKnnhYUgSXTz5DBFnCRYqwSsDRkrSrBQrloK8AGQ9q+w6g4+R
	 /Zwx/tC6VtR09zxc3Z7M5iTUHkZJiNFiq0XqLbHDIJBbnhf2eZsFguDp6mj9KARsl
	 RufkUP7Qt8R+06043CHda2KdIbVGS6iPUSmQZXsYLlDNSEpcfpHc8nLCVZYg7yQo5
	 FniDToohr+aR5fBquVEiAQpHvhwDG6/0Q7sPg/e60VQntiujkRWVG50B+VNkA9FXG
	 RxaMjSh7z66T8NXiXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxsD-1rzoHe1nVP-00Uk7W; Fri, 28
 Jun 2024 18:08:33 +0200
Message-ID: <c05e397c-5ed1-49d9-92a0-826f21fe2469@web.de>
Date: Fri, 28 Jun 2024 18:08:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Prashant Malani <pmalani@chromium.org>, Wen Yang <wenyang@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: typec: Prevent memory leak in typec_register_port()
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Op0AhE/oYVUbpffMnqL1KB0klyIoNEWbyvj7Rl1SdHSSCKNv+eQ
 MFfe5GqAwDNji7jlyykH+eisfGcwrLVPEoaUGUsBinSgRrt+ehKY6D4lUQDOTvAYLoLIHCP
 GYGSenPeQFJVAAcpFkUw+59iK7YCNqpst77f+KcoE7VYg01gO+WZlqLnxAmoxxDkQpkjdeC
 bgw6iB5M75uZ6OXPva5Ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JrQC0Yt1hKA=;mPfok86m0LGA7E1Y/8tQE24en8v
 dXNDcbAtVLN/ETAB0d/cR1otpdFGqO+YRr4Pb98IRi0uPQ09CIlrFPhV9BVv6+u2moArd48/A
 7kblJFV/HtzxrfUc6bepLCoDQfeNFnBVon/iul1wJ+iWrndX2LFqwwXbroDPPOyS0Cbrx/2kL
 pa4PN9TsOCZAykjgBJdFpg8PCTfULDm35FFjAe8QwQyyKX428aUV0RB23mMNoBvmreLX6Ym8y
 oMOhGnDxX0zJnWjAoPdNDyVBIcMZl3NG4GVH/DjizGo8dLPmTzIJSzV3p1Tn2eXA59t7KRTer
 6NMH7VVca6/OdC+ZDlVtuAqc4IGJjAtm7VZQACOOfuMzAnKvrXydTZKd0JyzGiG2E1OkRdMMl
 iKjdEY5+84fZIwAwcSJOXgEUYbU/tC+mMJmT6iSkgJSTyfzEn0WB+KuKSAw2m4iHc/LciHUKY
 IIlntfBXBej3onWxp5O5evsj8dOgiosgK9TVclfHJGGp/yNyzKTRLspjAxyg90AExwvaRnz9R
 FGBumynauwl+zYDO6wSSIGvxtUdEZhtlVE8veMB8YdrU21+KoiEukt9bP6jscENzfnSI7+1TO
 RYmH/lqJUHQvNQ6TZA7biysx/rua+Fm+LrI9VO+gMn++vAAIX729x1LTC+s8Ty1y3+c7yS40A
 YAnUGOy7yyw1DfJq0piMC+qFvAXXtM8bfFCaS2ukdhtxkBG9wvrcbk7BU+jl3BY2FS1xVB9w8
 QAjN9WIvqVvkCdVs1gvBj8wXKRBtE7THCY1KlAW3D1DvhNiyWa12J1DzrCv7KGdZZrJ/1aO/O
 iua+Ry4DzFGfWAe2qy9LQfWcL6T3WZNO6qjThfpF2ioo0=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Jun 2024 17:46:19 +0200

Memory is allocated for the data structure =E2=80=9Ctypec_port=E2=80=9D at=
 the beginning
of this function implementation.
Unfortunately, it was not released in all subsequent error cases.

Thus apply scope-based resource management which became supported
for this programming interface by contributions of Peter Zijlstra
on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Use the attribute =E2=80=9C__free(kfree)=E2=80=9D accordingly.

* Reduce the scope for the local variable =E2=80=9Cport=E2=80=9D.

Cc: stable@vger.kernel.org
Fixes: f31a8702cd36 ("usb: typec: Add retimer handle to port")
Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and=
 partners")
Fixes: 5c388abefda0 ("usb: typec: fix use after free in typec_register_por=
t()")
Fixes: ad772c39b2fb ("usb: typec: Copy everything from struct typec_capabi=
lity during registration")
Fixes: cf6e06cddf29 ("usb: typec: Start using ERR_PTR")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

I guess that clarifications can become interesting also for backporting co=
ncerns
because of the proposed software transformation.


drivers/usb/typec/class.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9262fcd4144f..97c0afd41e35 100644
=2D-- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2372,19 +2372,16 @@ EXPORT_SYMBOL_GPL(typec_port_register_cable_ops);
 struct typec_port *typec_register_port(struct device *parent,
 				       const struct typec_capability *cap)
 {
-	struct typec_port *port;
 	int ret;
 	int id;

-	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
+	struct typec_port *port __free(kfree) =3D kzalloc(sizeof(*port), GFP_KER=
NEL);
 	if (!port)
 		return ERR_PTR(-ENOMEM);

 	id =3D ida_alloc(&typec_index_ida, GFP_KERNEL);
-	if (id < 0) {
-		kfree(port);
+	if (id < 0)
 		return ERR_PTR(id);
-	}

 	switch (cap->type) {
 	case TYPEC_PORT_SRC:
@@ -2483,7 +2480,7 @@ struct typec_port *typec_register_port(struct device=
 *parent,
 	if (ret)
 		dev_warn(&port->dev, "failed to create symlinks (%d)\n", ret);

-	return port;
+	return_ptr(port);
 }
 EXPORT_SYMBOL_GPL(typec_register_port);

=2D-
2.45.2


