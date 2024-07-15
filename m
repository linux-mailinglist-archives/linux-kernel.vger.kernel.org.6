Return-Path: <linux-kernel+bounces-252473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFF931385
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E99EB24176
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991F18A944;
	Mon, 15 Jul 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LcPj6Qny"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88215187868;
	Mon, 15 Jul 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044526; cv=none; b=ZOQnFXNXovL3Y3ZARduuLWYlJ0gSy2Nd7S7yVOiyCSKQRfDsyH35RJBA/Aw1pqH21nLrXDhudOb/WzZgbe/Hu5IiQmJYRBWUyJcVGVqIZ/s4m2lEKwSkkVl2ZGgDQf5eSvp0VIVy+v8L2sMQW5bNqVrJ6pIFQulTmUhJzKsh1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044526; c=relaxed/simple;
	bh=RrHXwtJA8vk2WaO7Dao7PE8d5VKXw+HfVBwPX30khoo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=om7hWgfLq+6Cezci+dT0x6vtukEsDzw0Eyhsls1mg8QKHyKgDgUCcIL8ChIlBvux/0MwrDycegdYXgHUOlRKHUQUr8r3VYb5eYGarTNQqk5KotZ8x10mBJniCxbAKDYDQjRWdijM7VGhAWSGJ21j58P33c34KOPLFBAUIwKfuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LcPj6Qny; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721044521; x=1721649321; i=markus.elfring@web.de;
	bh=YrYnfXpy81C1jpVdx1iEDBRM93/KVFVJhrGxbIs42Zo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LcPj6QnypY+VsekT+acYASqFKNLqImYS7DRHjBQp+n1/SfglgVldlH4/HOiOBTpA
	 3qhRXeYA24kKuTfQXo8g55Mred03SGg0lOdu4JyF9I/S9CO8aBkqTO+xUR7jSHMhh
	 f+A6WcUxbAhQdyKJnQcDYDS/NqxxgOTJuAie541juAvksSXQxVBaG6F+/TQ3I6OHP
	 reK/ugu3iOABJIGyp/ANx4XoNEzXGoD3TlFH7G+PL/XmTquaXv2KIZbiNgvSNeVF3
	 jxJ2MfJtFc/cxtp0Q/WNbQqve4l6x5T/NujHIPrvHna37dXwtcJfztbedqOGS9xf5
	 /V9lcAAUsA7LCHUNLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTLO-1s7Y7N2tOq-00r5Y2; Mon, 15
 Jul 2024 13:48:25 +0200
Message-ID: <cb21950b-286b-4630-9052-cff9e7e56337@web.de>
Date: Mon, 15 Jul 2024 13:48:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/nouveau/debugfs: Simplify character output in
 nouveau_debugfs_vbios_image()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:71gomZOBeHsXTuuGCpKsfKlHuOH458fHULk6qYyu8eYyRHEy6wg
 vxu79FguCXSArnOkasdaTOv+hNaMNrALYc4QlU5uT+/sl7qPLC4gHFGZkGt7LB9/4vc1+EQ
 OGojZV0bf1SSPdsA+bzDjf0TCKn7tY9FpoBuDypjHKZpzOwR6qWxHEdWZrisg06jk0Ywm4F
 kGsFCja0s75FSjAvjjJxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4xIQXqzDzD4=;5jWXeTpY5ew0dytSbThixv/me/J
 yKB+df1EI/IVm6ITgJBgqofOAF2ZlkEMWQTZqxmIl7V6svWyXRi6fdrjjy952RV+31k8bRa0V
 w7byy1grRF+e1SUhjVZnRgoVkqt0kYuvq1ILbVs0LsG2emGq79Oy6ESKBtkyO3w3NY1UdSygD
 rqjeH1U2yHKkJ1+FsYtDbbL7Xujbf+NvwXuz0RYDZm57NZNKXu4SPMdQr0GomziCQ8XltMrwy
 S7UjShyqBK1ZcoDzWv898eG/CsgXmX6CkV3xXfyVV256yJqaCVYeb87w3b+MfNUaYal+ZbvtE
 cgyizjuie8Fs0faiZWrXrk0gMN+pCji3lTk7EhS+l3pagZmPHLHnAQhDpuCXbwgTF8vpMUVJx
 /MLaBJkKLLx5MqQjVx/oTJO3iSySZxAHzTKGrWcnOkgBHsZNcp4oKf1rC1NWzrbyQkGVKYPCw
 2PVjvSoFLehPmWadsI0K3d3oMLLuV9UTLrlugN3jtN7mWSglpUv2t1aqaSKgqfKiqM1HUQF2M
 RG1VfWYpLrongS4tIJ5KoCblm2QL0Uw2N43uxCap8DUjo92DisP60xSU/vcU+QaRNGcvUkI4a
 pmShL/0DUn5IVE54o+3MkwhfA28sEbv/Db53O2MeMLOElx6zf0YLAy6vtuWrZvyccZFcu/hfZ
 GM4V0Vf2xdao2+0LvUbHNYcvaQhqIG1tWaJnIjS0Z+Qz+A9y/y3b7z8xXccniaUVRaV9j0xdT
 K2qFK2ic9xovAQimaGwLzSpTyd8KxtOYbdVtVRgOYWJpgQpnOQ41E2A/k0sgYxjFJmABVRc1d
 flSb5ReT85kPVBePb/QZOxjQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jul 2024 13:36:54 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one sel=
ected call.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/n=
ouveau/nouveau_debugfs.c
index e83db051e851..931b62097366 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -42,7 +42,7 @@ nouveau_debugfs_vbios_image(struct seq_file *m, void *da=
ta)
 	int i;

 	for (i =3D 0; i < drm->vbios.length; i++)
-		seq_printf(m, "%c", drm->vbios.data[i]);
+		seq_putc(m, drm->vbios.data[i]);
 	return 0;
 }

=2D-
2.45.2


