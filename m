Return-Path: <linux-kernel+bounces-234970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465ED91CDA3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB1E2833BD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3D824A0;
	Sat, 29 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U023f2iv"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E25660;
	Sat, 29 Jun 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719672047; cv=none; b=eopcBHJ6ihvKK5e5sdj2R2RqAW4+1W49kYM73ZuMiCAcOsy47MUTkV8o/a+17BHw22Sr7AebbLobjX8w5IucX95YuF7yugaPpMOThFAAvB+5HfYtJerrRhCaKbUSjVJTaLFq36LguWhLrwYuozwiABN8KAft+QK2dnrLsGRLM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719672047; c=relaxed/simple;
	bh=4BbzsoAcYjjslEn0KSNDVOtRhzU2MoWz1axFIMNUH+A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lmcjW6RjlofdkV2d6yfHz55XQdkHAoGfp3KKYUiW6hShWlQEpuSEmL8yclhD7wjLIfeA/Jhg5grXyWGknRmTd5eUVn01d9H5RoLiKUWAPfViTRG00CGn0QSr1VsuLgHGqMOhzsL1ZO557qX+MvccEGfn5ry8fHJCw5hH0JVhTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U023f2iv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719672024; x=1720276824; i=markus.elfring@web.de;
	bh=PaPR7WLBZJA1HrQa7Iavj/L9F3coe01A/6bOeloyPcI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U023f2ivaOADosPdQNx7ZFM8a5bMFWc2S+Nrvvz+a2PK0cqkI3NmdrxTKX89G0Zv
	 GSpRMhAaUSoatfz1wY3UcrvuQa9IpthzHxZM4OZyWDoGqGabNcNPlTmk+p7wCVRsb
	 hu12G+w+WumW3TalVjCkVMQV2wqEfEJ1G0h4NTMmIeLA5ayAJs3lBNVttf7vx8pf/
	 5nZV3/IEeMAM+pPiq+jiBn3UOl5iwKCzUyHWh4Lyd5dn/9jIFphJskynDP7lOhnug
	 QS1mOho8eOyiO1bD2phwy0PCVZjQlKPCYFRIG76UhPKjxNnEWSxiNPECqdr3of1+S
	 FR0nreGS+Ph/HtH40A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1sDqM812aa-0165Bv; Sat, 29
 Jun 2024 16:40:24 +0200
Message-ID: <5d97e724-928d-45aa-b526-ee9c0d71dfd5@web.de>
Date: Sat, 29 Jun 2024 16:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: typec: stusb160x: Use common code in stusb160x_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjXAvu5rOee3IFBmLF07cD2Wldccy5BMejPO8HHUoJI1MQVEM0T
 /US+0bD3lPhS7JIN0hw3xdXW83j9POdZQqKZNiNN4oU1Wv4hVa9HjNEMYzMU9xawJFXqHZi
 oTYOry/WZrI8+2wmiUGIXvGPk+g+aHD/93I65NDf/BQMqFIrOwnBjOMchCfdSBKuMaU1knl
 1freYno+s5UvLFfPriPhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vR2SkLRsqGY=;qK9Zj4+2CL+s1ELaJlKjU7yC4F6
 QceVF5bhFm00CspckrgTmtkMklRknQqKPSmGtDO6q6LXFvQ4uZcbsyOzx4TCKfg7Ka/TmJ6f0
 KNf4pw4gKXNoF55U5/X88jdpHC2GYMEh43sSij0GdflE0XGcCa28eJyCfQzxNyjk+4ceQrydn
 jzN52R6aYSy8EIDjaZ+EF0Voghub+coQU0Y9hnmgL6WgHkaxbzR4UD9fxBwCE39cbhkHN0GsN
 FEZ5rxKxF3Ex78sAsT36td5Ra4JdkmYMo15SKLdn4qE3kXuVaL+PJbzSengijncI3PXrlivbV
 I1QlJftvexNJtS8IexVkjm1ULhrroXtWd5rRAeyhHSYV/Ysh3IvQVdh8Tv/+PFiFb5OB38MsS
 /jgA63O94acPBB8EoRGnSsAyjiP4nu6cRQ91UJtvkYiRkn567KKaY3AZ5hC1gs5C0WfBAzKH0
 iujBHTiVvN+MX+5wxZ7GcbzKDdQS1Zwc9N2zpRmCjjj3NbYSNWs41cpoFuD7ElpPYrYgdlGlh
 ZoQYx/R+mPT2T8FPs/UxTvHeyNfC8OfqLvbPJwFbNlLLErccee1l0Pw7QrQR3qFzSLRYnLiB6
 KKVoRkJTeMHwDx1x4LHuhnvAfJscj9cirxBJIOecdogct0iIFtDJISpou5VGzmqqdX2yr8MWZ
 qxV16OrQZ4tmNq6TgwipqwRi9itMUnoa8rBb9lCyLJps9djxinRlHHaVR6eQlIP8CCCbZddKa
 3MAtgXQ4sjp6USWV9qf/6fZkC/23OBjQ/HEGbZfrBkrjJeAvaZyiTYTHiuI1Q0F3qaJXKYj0L
 EHHJ3ZaK6mpGWWf/dz2Bs2oOl5kjcvJyikmlEjV79emOo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 29 Jun 2024 16:18:23 +0200

Replace a function call and a return statement by a status code assignment
and a goto statement so that a bit of common code can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/typec/stusb160x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index f3140fc04c12..e610f19126b7 100644
=2D-- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -777,9 +777,8 @@ static int stusb160x_probe(struct i2c_client *client)
 		}
 	}

-	fwnode_handle_put(fwnode);
-
-	return 0;
+	ret =3D 0;
+	goto fwnode_put;

 role_sw_put:
 	if (chip->role_sw)
=2D-
2.45.2


