Return-Path: <linux-kernel+bounces-202960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C28FD3A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA69285150
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8530190050;
	Wed,  5 Jun 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uS7stvm2"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20B2575A;
	Wed,  5 Jun 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607483; cv=none; b=P/PEcjj4DG2NNAyx7CjbhNcCUQ2Svv5xpuBVedxUWp9OLVDAmLkp/2P7nzEqNf0dFFOScnkTUMq22xM8QU1P32qMp/t/5zD8vyqE7wFyCsCva2UJe4lnt3xt2dMb48Ndo7xHWyuCdGOo6CT0O6OU2abYR9KNF02GQyI/Z9Sm1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607483; c=relaxed/simple;
	bh=fmb5TpMfeMLyPeR/4CXjm6GWO6a9KEDsuXW2IhRHv/s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Dqw1MEHDBKmZS/V7TonOi4fZoPSbLEpvepeKtxrF322CaarC3qyk+/AxHe0iFxTVgWtN9bRvSCY57moDBb1/Ls2m5V2260yl5FUuv6N6ZyhFqoVXUc0n73w7ik5YOnj9wCb3ncKyEe97DIySZUwIJ4u3TSLOBxFtNTy+wlrAuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uS7stvm2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717607469; x=1718212269; i=markus.elfring@web.de;
	bh=ygcT8PMT3gQgm193jaLXcPwMadyNYL0mF6kGlGdUQMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uS7stvm2zenctSskNf/nSuo80BiljGcr0jknaymv/2Ln6SxNZSOei4hlYreGGCSe
	 5BHbGKk+BmRt/DmTA5SSVQPBcdylOKCvbZojBXuXN/lEwqoqrSRwWbatoxq+SgtSk
	 0bFDnOBqK8jqp5qRhObp8lxRFbsAJb+kJdnaGBh+gpaFcESr9LOSii43s/A4CphGF
	 JjusQqskUifhdgxQG9J7aDx3xYFQQtQLtca0A7rdUfJHTueeFYbmEg4BX8hSY2w7Y
	 JVS5mhZLvHa0UQZANVH5QO7Gqpzru/7Bxaf2Z7rtUh7bm+6hcnBeJZ5hgqcgnb168
	 9ylqB/kzooKgVUV24A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1s5sAN3mBD-00VtoQ; Wed, 05
 Jun 2024 19:11:08 +0200
Message-ID: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
Date: Wed, 5 Jun 2024 19:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Xin Ji <xji@analogixsemi.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: typec: anx7411: Use scope-based resource management in
 anx7411_typec_port_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T5g7jB/ZHufzy80Ddm6DM8BWwJfKECH30n7VQH9LEIbgO1a+9Tr
 2jkjdU8SzUVXwO6xroramWor7k3LXHc+gog999peacSlldUOaF2xHkl1nY8VHVGVFx2tJNd
 e0E+Ij/zEI+gITRNmYExT6MJuifTNQKtELlB5EWOjNdcdxC8OIgd2pPAcfyjFsx5wuij//6
 ySqmeiSSW+zPQx08h1tbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iMcl/J7hc1E=;KWaKLrWhYWU96yjLsw2JIoSnNfO
 lUO85AdEGvxW6nL1/mVZZh6McWue/ZbmTiwZNpUmD8NOD/4QcfsGmTvAWvfbKDkUKXmPMNXDe
 0n5gsA8V3uEu8ch+IJ4aaL2eRyn9EksK51B+MShKBsixs4FcTQEhqXTc9K/um+ac7oZaIDF1+
 rJ70yFqU/r74WRG7ju15W3fMC6TISvt0dFpeGGbr2liL/Vyj7AE5FD/tyoA8SaYAX2osgS3lW
 vBQQ2SyyN4DHlNHLvQ9ZLb/JHn8g8pncJJGCmuu34lr4n/rVXdpaR0kR6w8+zRNv5zkfalWMj
 h/iGjYTh9yE4G/x22lTpsqIZolyX/F2DeWppoSisn+L0TXichTMxKqrf4ZO80xGllvqxusSmY
 NtNXNo+jR/XpUK9V8nrWB6gJOQcmEiPe7Ytkbno7wx3XMmk0nkdcrjXtT/CtrOYJImrJ2hPIF
 9EtKPhUcfohStxUgBvA0vdUdPD6+3qlGIlqWgKdbuBGiJOKsWX4QRSiX3xe9G2YlDPFhKO+iq
 pyDUbEB4JPYuo4ZlKsf0oAR6dOS1nllICKOy0SSi+EfbfT4D8BuoDy74chTdc43eUEiYwLhmP
 +EPII9woYDIve+IF35ud0tyLcjGu2IC8ZON7eZdu+Di4FVNyY31xONcwAiDonqs+44GtYGao2
 bcCAVw8UhUa27hW6fcw6m2kTqvRyrmI9wXOp3NnOwW/HYLoYYqMvEv5r+nLtMGJUWPh5FdAUq
 dKMUQxXkZGHLongA15N7CSl98720PyXCrNkUoqV8AKo4QA99TN3yWpwjzRbBjMgc6tPB4nNvD
 3+GmnrXgunTrKTLU/P8Yc8GYt57rMAlTwyx2XQpO0B9ng=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Jun 2024 18:56:19 +0200

Scope-based resource management became supported also for another
programming interface by contributions of Jonathan Cameron on 2024-02-17.
See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").

* Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support=
")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
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
2.45.1


