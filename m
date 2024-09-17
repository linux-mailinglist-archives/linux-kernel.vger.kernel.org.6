Return-Path: <linux-kernel+bounces-331837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845197B1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F54C1C22B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071FD19ABAE;
	Tue, 17 Sep 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ri7YYUgq"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535019AA43;
	Tue, 17 Sep 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585282; cv=none; b=kTrqeKBmSy2/uEVEuTPilKtGbAIcBqZu56OJxpgeBzF/AmisDoqODcm3ZnJdFb5mOdtHaHl+o1+q1XQ8InyvoUxm+C0x3VMxInLzKSM6BXWd2BIT7VY4QeS6PAgUCMxftiDHZDbAXhJXpzAGq5iJuqPxl9YdtIZ7HCiTsKyETSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585282; c=relaxed/simple;
	bh=EgWq3EuN/KO4hcBdjCN9j4NPsuaXNQWAhOdIsb7vtDg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Op42LBoNWqhU/Vp9Id4udJ9h9vRLyJy3yf6C/Ht2h2w4SgDGXUPRWqamMzMyUewG0eONa3gbYASP9olJ7xnlyz+gB6cZ61eHyxkjpRfyMPUuEdBNUfXPu4kkEW2uzWNUsd/691mhy30q5ta42c2ftFUzhJGNfcqnyD0xAAHfe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ri7YYUgq; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726585238; x=1727190038; i=markus.elfring@web.de;
	bh=4/S2yC/kdYw42oxDARzjfzTaoEFcZAO+vlfQhsMk6Ms=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ri7YYUgqsDy/Pxbt7RfWiVeJblQPn9mM1RCtYofMTtReuTTIyVe//X7TQ+vtfUjC
	 b6OM8CMwW5TteWquaDMi/nSNxpaN0ixacL0bNAcEgqs+Wek2lSWYjVbvZ61mSaBjI
	 wsAZRDDwUbiRWcdO09W9xrwLuNJtMCQ8iXYFPkEfoAKrP3P/PgrZQj2a7D2TE1bj0
	 Q9mBH4MZi2BbKDy0OHLwMlgavOyYnedI79/8xYVzvVwwrOMPJSSw32KtgrHur+LUN
	 9V69BXp+0ACRTWwOD90pEGu1nKYXENVyplONv6cjPtoLnE15U0PemPhJzMAo2BKUW
	 w4pwclkRufl/3pNoGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1sTHYJ0hqv-00JLtP; Tue, 17
 Sep 2024 17:00:38 +0200
Message-ID: <492f8027-f657-4def-b677-34d3f47d8de4@web.de>
Date: Tue, 17 Sep 2024 17:00:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/bridge: imx: Use of_node_put(remote) call only once in
 imx8qxp_pc_bridge_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JWmSeszK/KH8KKtj8pgGujoStJ/gM3R+Nmlpm1mQ+2BqBo8/aIB
 fRupnSYZy3H34rmR3qpou9g6WXH1i3DH0FG6zc5wmM3XB3HlHA67eTtIlA84zB2VVsMnPS2
 wgW33mr7QxI7DVNaRQHJjJOxhSnxBuFee59Jmop/KFNAbzxU1Bvc2pcRVNlaE36JU/bHkXI
 SpmbFuvkRiFTLYQENAXJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s0vvRLopAFs=;j/jjZEvtcq7ivnsKI1xtfRQ5n49
 Ff3rXD0idMx+PofLBerS296Jhk3ExBBEuEJxxPTpeXFXhgegVJyxfgHwCz8ahJhF07DdE0uiP
 8/9oKZnAPkV+xsjMcbQgNfhHXkXm2g6JTh4vaewKuYvqtdbQ8XvjsdkDXmcVS6pAtBwSMK3on
 /FN4bOdkpiSEvjRbWy4GwaNemGTzH36I5l56fQ3KhfAXafrJBkcruAsXd7H3jJKmTu1FCliFt
 fuAJy6GJDS4cn77wsQ3menWHwJmYigkTSuNmOpPvVtatxW8QlN6au8ycO29VscGpRtDC5JKED
 IcjZL1G7MhpCS07f1qbTS0njZ4RPtjABNqJEKeIOhVXFRedMUfYzEovMKuRkGWBC+aQtk5j3m
 S4vdsPYgZaE9PNU+xstHBl5iuz7Q8IiAVv9okycDMgHtog52OkCmmQ6zMR01I60cxkvMvuMTJ
 EH8MwTENrOpKOxJVRhR327XHutF7aWDQvHt7CIw6ZoNmFq0mX5KV0eSWD3I8JnI1PRa4eRZD6
 smDqs1HredAKgPNvxAiA0LFGFIaIkNXJAGqaJNwW2bl8QMxhamS5cUhNKoPG9q/9/QvUh5kJ9
 pXzoDBDydrrA2eWHo/o1z80URAAoS98mYhpCasSpK9yx1kF162AUTiCKVbY/QIBvZONeN8Z10
 5Xo5q14BUSAGBjuaaxicxLm+V0J0PJkbV7Tb6TFSeGf6AxPwFU1qsQQxhNPCAKERNpG2LDFGF
 ntvLWKtXhYOt4Gb2k87/PLeQvq+87lqQoSor0lTwK4ky2Y8UL4I6YcFc+a0+T21IweYhXHJWQ
 OTE8VKf3VWWqsHadvQPgJBfg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 16:40:18 +0200

A of_node_put(remote) call was immediately used after a null pointer check
for the data structure member =E2=80=9Cnext_bridge=E2=80=9D in this
function implementation.
Thus use such a function call only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c b/drivers=
/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
index e6dbbdc87ce2..0064d37ad8f6 100644
=2D-- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
@@ -321,8 +321,8 @@ static int imx8qxp_pc_bridge_probe(struct platform_dev=
ice *pdev)
 		}

 		ch->next_bridge =3D of_drm_find_bridge(remote);
+		of_node_put(remote);
 		if (!ch->next_bridge) {
-			of_node_put(remote);
 			ret =3D -EPROBE_DEFER;
 			DRM_DEV_DEBUG_DRIVER(dev,
 					     "channel%u failed to find next bridge: %d\n",
@@ -330,8 +330,6 @@ static int imx8qxp_pc_bridge_probe(struct platform_dev=
ice *pdev)
 			goto free_child;
 		}

-		of_node_put(remote);
-
 		ch->bridge.driver_private =3D ch;
 		ch->bridge.funcs =3D &imx8qxp_pc_bridge_funcs;
 		ch->bridge.of_node =3D child;
=2D-
2.46.0


