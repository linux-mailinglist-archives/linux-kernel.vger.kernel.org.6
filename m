Return-Path: <linux-kernel+bounces-233496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91E91B843
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1801F228A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFCA14262C;
	Fri, 28 Jun 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GvNIrfqu"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B013E3FD;
	Fri, 28 Jun 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559647; cv=none; b=I2FSN1F51a31kfb5JN+mxIjBEKN1+tS1ye7c5BOUgKtE0r8YdZSw6l/QeUNEd6U+HxwQAHqNTmKz1KitEmKgWR4OtSem3s+pthA0Lp7ZdttWQai5MlA+QvdPVZnsnX9kvUQ2U6soQUh9ud7+tH0bjbfolwDcxy9DLddQaPy5+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559647; c=relaxed/simple;
	bh=GzFaYYQU3q+oka/5f4J6D9YJgYGUys2RDo5EPNs7WLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtdDJhh25y7wWa5HjBwAJT3zjpu94msSwyWw0gvUFG4ZMR01lNjxG9t4IOeexW8L4yrVz0kAbuOk1uNUbdEpsylv2XsXWmpRb6L2awbGobJ7RinAWKluKDnCRCpl0J4KinubKZlhb6vUyyZiO10LZEcKm7WK+6+NSGaiaVSTRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GvNIrfqu; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719559620; x=1720164420; i=markus.elfring@web.de;
	bh=nl0CL9GDIaeTPnglvyjXELGMdmLp+0wQCRgVbrDa0Xc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GvNIrfquwx4IxnfzelRFzL06vT+ZrXCBp8ECAZhYWDDJke7/sN2mpOOyAAEQZy9f
	 G6ZgRL0v+nV7ll3aneE+TBVb0dwvJRptMY+Rnutx9kZXdPE0xDiKX+3wVsoiWmPhQ
	 pFRHgunBu6n35lX24q/5rZn3WphUz2ataWOd2Mrzs18t0AUns7w/OPGoNFH8Smify
	 om5wq6ZiEW2GK+h3ViMpwjy5cH0k6gtUMMbywXNbpGd19jBNkNGbftnRFwrsBIe9v
	 z2AMvGJrj3gq2fuSAL9tNhlKDhyD2X4JUhfDaMw+v9QiSOE1JUxPOwwfJDa5Dh3Mb
	 cU1vgnWKsiGKWGGzdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1sFyTW3WiA-009URR; Fri, 28
 Jun 2024 09:27:00 +0200
Message-ID: <0d2704d9-202c-457b-a83d-75a427966564@web.de>
Date: Fri, 28 Jun 2024 09:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2] usb: typec: anx7411: Use scope-based resource management in
 anx7411_typec_port_probe()
To: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Xin Ji <xji@analogixsemi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
References: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
 <20240606101757.0000331f@Huawei.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606101757.0000331f@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGRJMg3HVVWt+ehkSA2MzkeVAPv/Hn5WVwelrW7NtILx9T7WsC2
 zI86UvidMu9tiMK2rVoK6Ia0f7fDMn77Yw31x7afp97lDWE87HPembl1DydWP4PeiJ3UtdL
 z8bVAL8GaUICf7cfoCzglJ/ucWJv4WmSQcEcAga6yaw/TXCHPJ46UAWTIeeUvIGOvcs43Zk
 rctE3izcHnYeEMYymzniA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WMNp1tp+eX0=;7SG/gANxHI2ek2gitqo80qqvDDd
 GTmzPe8GerRu2Au6/GL13hP605zrf0Kyi8Qq2dyFs9QT+55WH8FJQiLvmSsbxyh/OaCLS3BOc
 3+QfP0YHl6o5iK3u4Zr6yxRMxA93aak6ALYs+HDd7iHoojzJAiWlnMoQ1AeREwgZkCVG8L6E6
 yH0sNpnFs3vseBKEbedZjt0/ut10xcfkpeL2rP68OvL15ujQtaik+a4ePACZ9aBzwhwMUF2jZ
 4ANraoppJG9YJsh4CP58S7R3pmcdfJ1W+wYqTeGYgPyt7oobGtXhAQpbiKDuBFP5p9PlbhJyh
 amIqGuEjoPDSYlNgm8hKWS2Iq+G+KEaAyMqzMRw4H0lhEHZxviGoxX1hE0LnEgvte/hI0L/hJ
 ktmE2PPtIvIrbBvwlKwQSur2TTgK9VNptS3xeB4Uc00vNrk5CqRnu+Gi9WLLDvfFfxpM5fHjE
 e1Jvi0LG9bISmh85oqs8h0MDyCxH0yQcIY13EL1xnpANLvAbCfqabQC8Ew/tHHvS4Fms5HPAL
 ZFLtP8ws/Kua3DCksaRLLjP9rvkBWugFyDAuN91/DfTdifUWoXQ5NPZHSnSMzaw5l/u5CNDTW
 QaneYLeceuxLYdGMTmr2rT7ylEJHZywlQ8KiMXuJc89NqY16800d0RAgMQqDv+ohBhR6fg8DR
 r+DMxFJGxjGjjK1VOxjEcDqK6EqMZshWsD5uXOFH/7GmG8M1qi4xrY4G995HVqLZYyhVB6bnc
 gHKO/iQxi/iJ26D7Le9Mzkkp6b9FUHbEHSS6xEZk97yu1d+DQfqhtBPFFZNgUbDV1aiQwpQtO
 LeM2aeDJLllpOxeTi79Ca8HT+7dqGGS2amrhtSLbyHDYI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Jun 2024 08:25:34 +0200

The API documentation for the function =E2=80=9Cdevice_get_named_child_nod=
e=E2=80=9D
contains the following information:
=E2=80=9C=E2=80=A6
The caller is responsible for calling fwnode_handle_put()
on the returned fwnode pointer.
=E2=80=A6=E2=80=9D

The mentioned requirement was not fulfilled so that a resource leak
will occur in some error cases after a device_get_named_child_node() call
succeeded in this function implementation.

Thus apply scope-based resource management which became supported also
for this programming interface by contributions of Jonathan Cameron
on 2024-02-17.
See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").

* Use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D accordingly.

* Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.

Cc: stable@vger.kernel.org
Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support=
")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* The change description was extended as requested by patch reviewers.

* The tag =E2=80=9CReviewed-by=E2=80=9D was added according to feedback by=
 Heikki Krogerus.

* A =E2=80=9Cstable tag=E2=80=9D was added.


V1:
Initial patch review
https://lore.kernel.org/r/889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de/
https://lkml.org/lkml/2024/6/5/1276



I guess that clarifications can become interesting also for backporting co=
ncerns
because of the proposed software transformation.



 drivers/usb/typec/anx7411.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index b12a07edc71b..9fb52f233a30 100644
=2D-- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -16,6 +16,7 @@
 #include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1142,11 +1143,11 @@ static int anx7411_typec_port_probe(struct anx7411=
_data *ctx,
 {
 	struct typec_capability *cap =3D &ctx->typec.caps;
 	struct typec_params *typecp =3D &ctx->typec;
-	struct fwnode_handle *fwnode;
 	const char *buf;
 	int ret, i;

-	fwnode =3D device_get_named_child_node(dev, "connector");
+	struct fwnode_handle *fwnode __free(fwnode_handle)
+				     =3D device_get_named_child_node(dev, "connector");
 	if (!fwnode)
 		return -EINVAL;

@@ -1237,7 +1238,7 @@ static int anx7411_typec_port_probe(struct anx7411_d=
ata *ctx,
 		typecp->caps_flags |=3D HAS_SINK_WATT;
 	}

-	cap->fwnode =3D fwnode;
+	cap->fwnode =3D no_free_ptr(fwnode);

 	ctx->typec.role_sw =3D usb_role_switch_get(dev);
 	if (IS_ERR(ctx->typec.role_sw)) {
=2D-
2.45.2



