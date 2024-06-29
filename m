Return-Path: <linux-kernel+bounces-234947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24E91CD34
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E191F2230C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B618005C;
	Sat, 29 Jun 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tshK4bQD"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C51879;
	Sat, 29 Jun 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668027; cv=none; b=FYaR8mfVLR+NtDqbMOh6YTiw4iwYoIWXyGSq9w7jX2uh0qSEOrgUnAi3ENVGxdKC9/57nsUIpXLtzCdl6heWzY/QkUly6KFm5omUzglm4I+eQxUYDYfsYjbry6fehlZLOPTTnY4izSmpFzqlSYUBgXqsQJJNoyPEq9sjegJWBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668027; c=relaxed/simple;
	bh=oo4jUmPrf9jedsT2pOZ0aqtdEjW9FoLur2248hOMMRs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RyOhAZBGhpptKxGXE2aW0w8EmyG2xaUMW5DPnOMZTq+pxqW1E5TzuRy1kzH3p0PecL7GDyUv7c7UPraKD41XCtDTSvC4Z9q7FkYnVxzP8xpW67XFKSeOkzhTnsD/V04+WEU0opJukpsdlpu3Dd8FqkJKTLqUulr4d37m8Fd4vJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tshK4bQD; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719668002; x=1720272802; i=markus.elfring@web.de;
	bh=Jup8QKQKJK0UGda0jM7cmsa/0c9sCTQpq+i/WNXMOao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tshK4bQD1QALZfsFVyW/4awZwh/ORsiSslDLjqc6RYbw8PdBec8b9zKQYUAMg6H/
	 alcSyanPfxneJCxKthGaTpCIiF237llxdjBuuqr/f3PDsE7F5sByCHknKQqoJiE+f
	 Mjbi1B8WGs7qLQH3vfei4xIsqjnWVNstOvJOOSsbZwsEiEIxjpdlaS4TtPyOU4kxM
	 p8L060cRGSloRd7nUDnEPYJ1hye3lNoD2BCe5uc2mAgjLU7+1QjUCKIlW+4Cob6Wu
	 ozn/zaYVyuXZySJf/V2RAkOZdoUMnis225uGrs5esMg2hwBwoI6hDR9P4V8kR/hCX
	 5s3SkiivsT7s2sciXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1sp9EM2hFc-00Llgd; Sat, 29
 Jun 2024 15:33:22 +0200
Message-ID: <a9623e7e-ce3a-434c-a904-39c6934c2ff5@web.de>
Date: Sat, 29 Jun 2024 15:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Benson Leung <bleung@chromium.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, Prashant Malani <pmalani@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/chrome: cros_ec_typec: Use common error handling
 code in cros_typec_init_ports()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8GEojlSlW/ZWYYZVwoHEsxx02W5R81RIHVkpu3Caty7Yd5qzQyE
 fsWuQFmUgY4yHRsLI7PvnUcm+PK4rRHnQTaQ/dDHe2ukv1JOOLBcoGcdEv3Vjg8ySwPzjCt
 t7pEt5TEb8/GtJxdjbjGPtzN0xiIcwPnMEOpkfrcw+HfTe/MV8yYZyVhrvHIYyExe0DcmQ2
 Ue13yqLbhF7XU1fsl3ldw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lzHNyPcj72Y=;EwPosG9IEVCYx49EBR8RezqvZCh
 KVGX77aZ3zF+tFbbgt8NAFYW0oTQUbwAyiJmgRgRG2s2y1w4PMmHF0JbsJBwGuf365huJVNPB
 7Wod+0wlwKT2CUnm+zBEEfK4ue9L3UEYk0TaUxMGmN6xzv2KaUxTJIaR29BPv/9dK3yCG6JLD
 rRSbT9mPBuaAh+C7pIKOWNcQMHNo25d1HJ76+6qAj3VfqovZdjteZg2yUuzcuUStAdejwp5ue
 YeTGhS68KKd7Di2KtK2KFMEeqd4IwOoWYAckUwza+GnKFjw3ox7ZRXkpTWBt0X3g+rVKHqnZG
 +PzReSZKxTl1hKCjdwm+bIrtEd1wR7FH7voq7+0936H4pfaUO3KghtkeEr1DxUKJTp2iq5I5H
 dZLhxZ3jyFdZ2QNd+ksyM9WCz1frqkDtl3kfJiXqvWwW818BnsW5JlvUiYqLCwOdiN8xNt3xS
 3oUXLLrGT3jEZlX/bjfmRB9LX3BCV9cNXpN7YHanKnPQHwQx2DemvNHOtxcUfbI4kWT52IlbS
 DUh8+owUdiiquZ7No6NH4JC57q4DRq7b7q9n5/KW4JNFK4GzLOeVQHd/uKii39knh446619Z3
 ltKZf1GLf45jujWFzvTZnqeJT2y54Gsr6+MFI2jh7ptOUP/yxlkQQGJatz2vd/OjzUsOh3U1i
 mNUnin7dyAFzOhBfs37hxdnIvN7eoy8w84wyIUZVPIfyGSNDpSiepjDmENeXLdoMcVMMo6DSK
 MBIBEdenZOwXwIqAoQaHKb86+fviWQjoBD3VXfYR3IjqtnuZ8W/Bn5Hgd1bQYoW7Whow+kTsO
 uouWaOEbCtL6/89mRO8akYtEADY9v3UTC7ogaugtHcUsI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 29 Jun 2024 15:17:44 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/chrome/cros_ec_typec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/ch=
rome/cros_ec_typec.c
index 4d305876ec08..aff744a0b38f 100644
=2D-- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -348,15 +348,13 @@ static int cros_typec_init_ports(struct cros_typec_d=
ata *typec)
 	port_prop =3D dev->of_node ? "reg" : "port-number";
 	device_for_each_child_node(dev, fwnode) {
 		if (fwnode_property_read_u32(fwnode, port_prop, &port_num)) {
-			ret =3D -EINVAL;
 			dev_err(dev, "No port-number for port, aborting.\n");
-			goto unregister_ports;
+			goto e_inval;
 		}

 		if (port_num >=3D typec->num_ports) {
 			dev_err(dev, "Invalid port number.\n");
-			ret =3D -EINVAL;
-			goto unregister_ports;
+			goto e_inval;
 		}

 		dev_dbg(dev, "Registering port %d\n", port_num);
@@ -408,6 +406,8 @@ static int cros_typec_init_ports(struct cros_typec_dat=
a *typec)

 	return 0;

+e_inval:
+	ret =3D -EINVAL;
 unregister_ports:
 	cros_unregister_ports(typec);
 	return ret;
=2D-
2.45.2


