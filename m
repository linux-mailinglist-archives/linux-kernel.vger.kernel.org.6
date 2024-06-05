Return-Path: <linux-kernel+bounces-203184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F98FD791
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A10B1C22735
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7215EFDB;
	Wed,  5 Jun 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XBWdSVki"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93313D262;
	Wed,  5 Jun 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619679; cv=none; b=bMjHrFuiNQwXxyxukTAha0fTEIWtesg58BofBDrHJBXsh/S6gXpq/WyPJELX/Zg0DXDcPwTG3k1417aNd0J4D/9BoOnAtot88sSxBm9SNi6bWHXVj8yYBmzqqUgTC2f0wrxtbx7vA/jRlX+f17+U26ybjRi9esUHBma8q2qt/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619679; c=relaxed/simple;
	bh=uKobMdssiBNVRXYbdWAN28ycziehwxzkQTvSknhr/oQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Fllq04NI5YQlxYO8H4QwbNc+3FZwLCt3UZZFI2NfGwChwf0/DBW5gP5R1oW2Upxk31Plds1L3LUCsswNgeKnlqwEZEVT//hMWA5EffjX0oXzv+dWHLnj23zMmgra1BmhCrONy/XQNYrRI7xbcfoMY9GdzVLsHggRm0xm/MIcxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XBWdSVki; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717619674; x=1718224474; i=markus.elfring@web.de;
	bh=K4LgTxaCEsSwrK2DaS4xTbm0mo17tA8sa1rtdFZaZSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XBWdSVkiAoYN9XG88XnQ0//cxLVvH4hNEIOSI7Y2jlOhIXWYLxA0U52cFzsm4R5U
	 wqlymDVQIyFbxMbXMrrye3/kgkR+/hqCJOY5TGn2jwpX1p9bOXf9ZQeTfSRSF8maI
	 9QEITUqVaN8LZvYr/oVeKtdmqMRkWMPdzuWZ4o7c1qakpHL3kEdFrRkRKcm9wEwrh
	 vL++17BU5PFf9hMvYta16wctaY0OhZn4XiI0atfPWiS70hZ5qt5mm0gZdZS1hKKO3
	 gaVnan8DrRAYcECB9JP06jpMV2TDrfooWMcO5/h/u643gMLznHlgxPRoB7yTmA0tR
	 /9I6fzDNyppxCc+w/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3US-1sWLTa1tWi-011U9e; Wed, 05
 Jun 2024 22:20:14 +0200
Message-ID: <f2912116-93f2-437d-bb15-9b7d41ccda19@web.de>
Date: Wed, 5 Jun 2024 22:20:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, kernel-janitors@vger.kernel.org,
 David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ASoC: cs35l56: Use scope-based resource management in
 cs35l56_try_get_broken_sdca_spkid_gpio()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iiMvF75SG/hLXKOCRnOGm3xQbDMpR7dtnFbnQ9Xj6PHqB2eQQvy
 /VTBEhRwXj4Ql8Bkp1zH6MhJTVhN8IKwREbf2wYTCoxGKpxCn5tHQWeJC0UxJW0APqbyUWh
 74QaReiEVNE0OBgn8QtlmCnnsmk9+/9OLLMayfGcwdUNLjI9YCVriOzULAXL8NwQAIKWmh/
 3WoJ8iSyJ4ormopJEgkrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ur7g/hgP2Do=;E1jXlsG/dQA7JfHKHDxENaK1I+p
 MTbsn7g8AHoArGwlMIqI/VI2sMCq+T3V4NxwfFrXQZkx3SQJlkHnKlFqpmv69QmDFDWTiZ1f2
 WO3uQn0D5yVbZrZH7AD+ynEeCT43IKRAuD/J/fF8gywrQqMldSSdw1YaAwIYXA11F5SPG+RNN
 qPcQM2odmviSzjazAfUvGkW48jUdQ+CEHHE+m4Y3gl/a9egVoHvdOpbHWX9tuMeNj1K/8Mh98
 cOcr4u2HUGiyuYkHYv/fBY4hMesyUkilvuA41iK5DhDQBYSi+TYrUR5/Ha5fGLkUUjOV52yal
 woBOOZPAK+eg9503Z7DWMdD5r7xqz7xpr4gAWSSsfnuH3SsqaJxmr3ZpAshQCyJhQweKA6eOo
 GwpUCYroSbMaRE7+jbUcRQwRKwb2R0K3wLczRIyZmZgr0wHb54dvi2xMeadufNj1pfu7IApA+
 jQ/mTrVJegf7/QUGXFcnMliZDgybTdtKPyVTuL0IQQCfMwZDnvASDVXqwtcRqM79DPVRX0wbe
 8KYxaK45CPQ0DLQV5ByqVlPImNX7sJ7L5HAOCQydzVXJmUC7ddrfV52Z3YfX+HXdC2Ti7mnP8
 Yo/gPrZCZChHteC7zHm2KOmU4RVmqMk0WJcj8tuYYYd76lLQi68rbGeDcs6/WV89O49oKMELu
 TxkejgfXld9wLshMMJAaNqWTyQlPbyFnpfPnFB8AwGlAk9IgmuZ+kqQ0HRopxpaQ2uhkMq7lC
 OOh7iG6jk7oxDhjhxJs1byjemMc8QkLHG/2ER+iCjVwkwJNWgiDMHpzNhYaAXojG0U0e/QmXM
 /+s+HWpIZW5rwIXb3r4qTmoHZzS+8omK56lh8Xd/bS7MY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Jun 2024 22:02:09 +0200

Scope-based resource management became supported also for another
programming interface by contributions of Jonathan Cameron on 2024-02-17.
See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").

* Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Caf01_fwnode=E2=80=9D.

* Omit explicit fwnode_handle_put() calls accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

See also the commit fbd741f0993203d07b2b6562d68d1e5e4745b59b ("ASoC: cs35l=
56:
fix usages of device_get_named_child_node()").


 sound/soc/codecs/cs35l56.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 758dfdf9d3ea..db41fc42dcac 100644
=2D-- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1345,13 +1345,13 @@ static void cs35l56_acpi_dev_release_driver_gpios(=
void *adev)

 static int cs35l56_try_get_broken_sdca_spkid_gpio(struct cs35l56_private =
*cs35l56)
 {
-	struct fwnode_handle *af01_fwnode;
 	const union acpi_object *obj;
 	struct gpio_desc *desc;
 	int ret;

 	/* Find the SDCA node containing the GpioIo */
-	af01_fwnode =3D device_get_named_child_node(cs35l56->base.dev, "AF01");
+	struct fwnode_handle *af01_fwnode __free(fwnode_handle)
+					  =3D device_get_named_child_node(cs35l56->base.dev, "AF01");
 	if (!af01_fwnode) {
 		dev_dbg(cs35l56->base.dev, "No AF01 node\n");
 		return -ENOENT;
@@ -1361,7 +1361,6 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(st=
ruct cs35l56_private *cs35l5
 				    "spk-id-gpios", ACPI_TYPE_PACKAGE, &obj);
 	if (ret) {
 		dev_dbg(cs35l56->base.dev, "Could not get spk-id-gpios package: %d\n", =
ret);
-		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}

@@ -1369,7 +1368,6 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(st=
ruct cs35l56_private *cs35l5
 	if (obj->package.count !=3D 4) {
 		dev_warn(cs35l56->base.dev, "Unexpected spk-id element count %d\n",
 			 obj->package.count);
-		fwnode_handle_put(af01_fwnode);
 		return -ENOENT;
 	}

@@ -1383,26 +1381,21 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(=
struct cs35l56_private *cs35l5
 		 * ACPI_COMPANION().
 		 */
 		ret =3D acpi_dev_add_driver_gpios(adev, cs35l56_af01_spkid_gpios_mappin=
g);
-		if (ret) {
-			fwnode_handle_put(af01_fwnode);
+		if (ret)
 			return dev_err_probe(cs35l56->base.dev, ret,
 					     "Failed to add gpio mapping to AF01\n");
-		}

 		ret =3D devm_add_action_or_reset(cs35l56->base.dev,
 					       cs35l56_acpi_dev_release_driver_gpios,
 					       adev);
-		if (ret) {
-			fwnode_handle_put(af01_fwnode);
+		if (ret)
 			return ret;
-		}

 		dev_dbg(cs35l56->base.dev, "Added spk-id-gpios mapping to AF01\n");
 	}

 	desc =3D fwnode_gpiod_get_index(af01_fwnode, "spk-id", 0, GPIOD_IN, NULL=
);
 	if (IS_ERR(desc)) {
-		fwnode_handle_put(af01_fwnode);
 		ret =3D PTR_ERR(desc);
 		return dev_err_probe(cs35l56->base.dev, ret, "Get GPIO from AF01 failed=
\n");
 	}
@@ -1411,13 +1404,10 @@ static int cs35l56_try_get_broken_sdca_spkid_gpio(=
struct cs35l56_private *cs35l5
 	gpiod_put(desc);

 	if (ret < 0) {
-		fwnode_handle_put(af01_fwnode);
 		dev_err_probe(cs35l56->base.dev, ret, "Error reading spk-id GPIO\n");
 		return ret;
 	}

-	fwnode_handle_put(af01_fwnode);
-
 	dev_info(cs35l56->base.dev, "Got spk-id from AF01\n");

 	return ret;
=2D-
2.45.1


