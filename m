Return-Path: <linux-kernel+bounces-234880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61F91CBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CC028372D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D673BBED;
	Sat, 29 Jun 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GJjFmMsL"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2DB645;
	Sat, 29 Jun 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654336; cv=none; b=QpXFdPpgJIflU+w1elQF0EdCnaQRY6tZm+VDsPHSINQ+83WAZCAxqLACmU5fyG4AVa/P5mMHcSJ0T2ZnaBUaljQPhIjjc6LqCd0OD1TmxgW8+caPnv0WRZhEJI7DIvhsAcx8WBl63LVKEsfymheg6GAK5E4OiHPDT0vLge5lWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654336; c=relaxed/simple;
	bh=8TQFG/i8JN4oqJJhe689hGGOUqLPoIbGuHdOuNO60Zw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z3msJbCnuCJ49mTSmkfyrxYwd4m9JJh4wEs3Jy/669o6k7sRBmfO8W7EvMAmU20BRq7irL3i/WSzgWaQcOhKW2scw4+BouM8ZzzZxEgwgJoZr7PLHgalBS9FTY1Xw+WuhSOH7O52/Q5fjbl803WChiilhEj4pSpjIVmQgKTrAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GJjFmMsL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719654297; x=1720259097; i=markus.elfring@web.de;
	bh=Dcrq5SwkkM/A/2nHVlTypW1FQ4OCJ0W5eKy45LQ0Q6k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GJjFmMsL6P1As2sUHx/gO+AWWmlXPwHhb2v9ijMRLTYG9X+J431roeW74aIfwKAQ
	 eYW2qbZU0X665+YV8qqzuswGt4cIwU7JEU6FWJv/DIc1XfYR0n0b4NI4D+93NRQWu
	 NFaItTPF939iYpNNqx6IaoaL/eZ8LTxRhXHIhlIWgXBdUh4BnLYBkok5EnqY1Kygp
	 Rar8l/4vtMSEXKB1/7KIuhDtZdnWNgA5utYAyvfcqXTNO84Uv9krsjURMy0m7ZfVX
	 pQVHQrYeX9NwNfCqoxo+bwih4eGKy3Jf4zfUbLBJa6VefuZAy8Wn1HKEss8LqZ6cW
	 U2RrJd0Vbt9ZMpUyEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1s4Rga311R-00UGLK; Sat, 29
 Jun 2024 11:44:57 +0200
Message-ID: <a2f9f5bc-5e22-4b03-9cd7-5dad16743ca3@web.de>
Date: Sat, 29 Jun 2024 11:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] extcon: realtek: Prevent resource leak in
 extcon_rtk_type_c_init()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Stanley Chang <stanley_chang@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <532aa50e-b8e5-4e8e-a2bd-a05fd81274dc@web.de>
Content-Language: en-GB
In-Reply-To: <532aa50e-b8e5-4e8e-a2bd-a05fd81274dc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:org6bioxA9jVxtD2+WvGOl2jIhT0ddpsalXACyJ2hx/bAKH8t/O
 fg1IKpgF4AoMOSd9JoCx3EOL6ALDBighyebwHl93LzQndXkgJLnVzJbP3j65zRXwUPI2QWb
 Re3dIDprJC3/ITaYPqPjGkbmYX11lHKHz+gVz9G7aRl10exgPAxDFogyV4yoGB/jLwLC017
 i2Cj0mr23bI/mmzfYx/Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4c7VnyfKfm0=;qmmaANJf7GO67mwScG1Uw7DhMPY
 ysMcYCsKENbqoTMz9ytimyvwwhB1J7ERShXWu6redMj6d8lWxUYSq7asQ+AJQKCda6FdxAhE3
 ia9Y7QOzw4Qj+T7vt5E18mVkfIyUuADNagRiYZepPRhvpyzeZ14YEJmDt8vgOdmGZZ93gewEg
 38ug9hjegFMW00z+TmscSfp8uA1RwncjGU9OBoayfaM410jtm7cC1Qinjr2cBp523d4fHpXoo
 +v9MKqu7Ar7HaYZqPNJPBMENK2X33+c0WdFqIxG2gT2hvHYcArMzwNFUz2UoHg1/j9ZK5TLAq
 LaxGIyJ8XClvT1Y3s+wTQ1ExEG8PjgqrocWa48Fh/iyPaHCefUfjFtGEXqY6sVfCIBb0E+2wT
 JwIPwcaRVotz2F+8Zv009DuhzsiGmd6JY1HZb8EpK21dJJk+ZXNy0V9SfG7wEse2cdWowb6dm
 YZnRwE8UBV/GDJq5jXo2VF8GzuXG40yio5HVZyGlSih9u+1Py8059fwI77vGDH3qMfAHN2vHl
 soIA/1y2i3+jcJUShyUoX5UFfCHuPRzwz1wZf/d6+2GUj4px2tgRrmdbCoQa7zmW+5mBQqflq
 EOZRNL1g+QUq7p14f4WDZHrz2Q0VxJz6iqEf6rQoewSBnDlq7o5UBiGvJkkddJHUF2zt3/Abn
 oxVEixxbQ74Qv2c6PfyKFSSxzjlMmPF0sVR2nGiKRPuaWK01FB4r38dAttmpV6IfLpn0J3t7Z
 obugHux++TLmCFn/9IIXEF4/vOJAvx1JzGRGr/hfuTVeFZsh15VemyZTdmeQCs8gthFaOM/V/
 5mCVuNquR3SWcV02s9x5D+2zEYMsmwNU+pgdkb8nCcHOU=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 29 Jun 2024 11:30:06 +0200

The API documentation for the function =E2=80=9Cdevice_get_named_child_nod=
e=E2=80=9D
contains the following information:
=E2=80=9C=E2=80=A6
The caller is responsible for calling fwnode_handle_put()
on the returned fwnode pointer.
=E2=80=A6=E2=80=9D

The mentioned requirement was not fulfilled so that a resource leak
will occur in error cases after a device_get_named_child_node() call
succeeded in this function implementation.

Thus apply scope-based resource management which became supported also
for this programming interface by contributions of Jonathan Cameron
on 2024-02-17.
See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").

* Use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D accordingly.

* Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.

Cc: stable@vger.kernel.org
Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* The change description was extended.

* The summary phrase was adjusted.

* A =E2=80=9Cstable tag=E2=80=9D was added.


I guess that clarifications can become interesting also for backporting co=
ncerns
because of the proposed software transformation.



 drivers/extcon/extcon-rtk-type-c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rt=
k-type-c.c
index 19a01e663733..8a4b074fd745 100644
=2D-- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -18,6 +18,7 @@
 #include <linux/syscalls.h>
 #include <linux/suspend.h>
 #include <linux/debugfs.h>
+#include <linux/property.h>
 #include <linux/extcon.h>
 #include <linux/extcon-provider.h>
 #include <linux/sys_soc.h>
@@ -1237,7 +1238,6 @@ static int extcon_rtk_type_c_init(struct type_c_data=
 *type_c)

 	if (!type_c->port) {
 		struct typec_capability typec_cap =3D { };
-		struct fwnode_handle *fwnode;
 		const char *buf;
 		int ret;

@@ -1246,7 +1246,8 @@ static int extcon_rtk_type_c_init(struct type_c_data=
 *type_c)
 		typec_cap.driver_data =3D type_c;
 		typec_cap.ops =3D &type_c_port_ops;

-		fwnode =3D device_get_named_child_node(dev, "connector");
+		struct fwnode_handle *fwnode __free(fwnode_handle)
+					     =3D device_get_named_child_node(dev, "connector");
 		if (!fwnode)
 			return -EINVAL;

=2D-
2.45.2


