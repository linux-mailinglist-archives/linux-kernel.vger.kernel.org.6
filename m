Return-Path: <linux-kernel+bounces-330366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC5979D31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3321F23593
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861C14600C;
	Mon, 16 Sep 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y29PE2Ey"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926D38DC7;
	Mon, 16 Sep 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476525; cv=none; b=t0isVNUSksJiIc+d8IiUV4PbLDs9AkQRu+MM8gQxYRJrChUlutL/gSRw7ofI16Tid47QfgrHZSY3ku+UrDRWyVtVFeJcX8VxsFIk+PYiR8ldTdf5c9owDjsS5XQHBJQ9KnZsiB3YM6Kkt2+hnuReQjeRsTwc6A/lPnbExdJB+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476525; c=relaxed/simple;
	bh=J8UOI948OnWKs+xB+/aTA/QkwoSDFz2PUm4e+MA95+8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lPmruHU74VymdRJm+7uReMN6quFyJrvbOy4paR6umedsIMq6RVCHOE+wyjxojHm73V8drTWngDeDl4h766IwjwsNWt4AVcak1WXsApQYIf7mCTtb7h0ahmcGEjkEtKlWKIYAT9vodzt3mtBgVvvDR5fdRKZFnca/JcW8/9i7J94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Y29PE2Ey; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726476501; x=1727081301; i=markus.elfring@web.de;
	bh=Ab2q8+aP9Waj4HBePxRO2QM9D8hRDpA/gAZWi0kJcZs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y29PE2EyGcEdwpfkBO2kxl6hAr9YTu2Ol6HnU8A6v6qma9xVO/8oV1PQYoLKEOWz
	 4Uj+U6ZzF/2hppw/IOgHam4SUjGb2YXLP5Ms4oa7dtLA6pV0l+u7x7H0KjBRLxoNo
	 jHXDvbNwPiA1iBi7NtwXl4w2HRiGVXg06m2Dfg+vOfLBP5Du/pdZ1KecG9Dq1F4DR
	 a7W9MblL2mc+ESAzJ2LI+SqlXEwLil7pKbLaM0X0vUbXSKZU4pf0arzYYqjwWZseN
	 Aoj42SQ3cGzdmYu+ZNcZfnKNkH8VofX8xZ0n9msQn0q1vIAbOVC3uYDQVWGbqfcDe
	 +K8mifZq8ZWezp0f+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1swA51028Y-009uIL; Mon, 16
 Sep 2024 10:48:21 +0200
Message-ID: <d3b37bcd-2d62-4a1c-b4a9-d47be271cdc6@web.de>
Date: Mon, 16 Sep 2024 10:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] ASoC: tas5805m: Use scope-based resource management in
 tas5805m_i2c_probe()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-sound@vger.kernel.org, Daniel Beer <daniel.beer@igorinstitute.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Content-Language: en-GB
In-Reply-To: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L6Nm2Bprgo6+Yuv52zM3x6fUbQwtIzeKwHMbTHtwYjFlASRENcY
 YKWIo0XBuxKo8Df9xwmxOiyO5IWEd60WKVv3IFPlng8fSTPxEzH1qhADfNruIylwUPOcl9I
 Ld2uruGAiuExayFvQsNPwXRFtykhmVSvFh4BIoGPZveY7if7vBgTBudBzeQP2MVwdHg2JaD
 0n+hH6KA02WoYabh6sjsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dD+/aa3tqcY=;FhUY5rbxoKQk5olwezu74i1vYq7
 lR85TcOFwU4ewjXv+kMq/PB7hR55/7lzf8u6lnsSQkdqaDKJtHwzX5O0fwXD/S1fNdroR/24d
 l9rC5+A85qYhVrxFZ39Gch5puOm6NBptVnA2oaUsPMfdIal5PYqxVJZvjxtYxV5O2Yub+c+HM
 tQq4w7sXvl92moe1k7jK/rteBe5SPiMP03Lbk5ayzRbDzyzU5lPHFxof0OZQ2P6YURD9R8mN8
 b0x5CPF84QxAInUoURHC686OAi/iswHCifec99WM/j1rD8gj6vIWkZwQ2HwmpsOSZIDO+6xvF
 tDITfQj5cOzNvN7xvpG42PPu7OXzKexUg2Mbb6DzdmkM38dh9CdqZmg3iUirSV1/AaIkDFpe+
 DHWioQe2WdUDewN4Y/ZkyU9H+wJY3VPpkU43RjW4/hGpdoy0Xx9jQ7WNGcnwueQx9KBYAhE0d
 MG9fzetDYcfXXcN/iON2xCsWH81Tfp1Lc87DlXW+tTVdoMfZcYJ2aX4PYECpRhsCdMeN8U1oz
 se3xY+Hhyt/kTN2+fGEHGPsLYXDaT/d/DPhJ/IDEPd6vnu396OaybPmLzOj3v74GMcpZxNIUY
 drRZED5VYyzxPFFaGYlLUlz62ySs/1DgSTocLCaUOM+5p/sJA41p5yYGp2sMYVdgZLvwAc5E7
 yufuPhfwZ95sjyeGQ6b6sMuL1JXhNGnyJSPJN2lN3qzr/kvcRMK4mHmEuC/1IRClffa+zfYHM
 +TT0yTPsexrsT1xwPteyfX50NfIzhVzeDaQH4arMiiV9UHholCWHq1VnHFerc8RDfKq8t22IQ
 Faxfx3dDWEvMN1u/z9YPa77g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Sep 2024 10:11:59 +0200

Scope-based resource management became supported also for another
programming interface by contributions of Dmitry Torokhov on 2024-01-17.
See also the commit 8dde8fa0cc3edce73c050b9882d06c1a575f6402
("firmware_loader: introduce __free() cleanup hanler").

* Thus use the attribute =E2=80=9C__free(firmware)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cfw=E2=80=9D.

* Omit explicit release_firmware() calls accordingly.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/codecs/tas5805m.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
index 3b53eba38a0b..f37eec960364 100644
=2D-- a/sound/soc/codecs/tas5805m.c
+++ b/sound/soc/codecs/tas5805m.c
@@ -464,7 +464,6 @@ static int tas5805m_i2c_probe(struct i2c_client *i2c)
 	struct tas5805m_priv *tas5805m;
 	char filename[128];
 	const char *config_name;
-	const struct firmware *fw;
 	int ret;

 	regmap =3D devm_regmap_init_i2c(i2c, &tas5805m_regmap);
@@ -509,24 +508,24 @@ static int tas5805m_i2c_probe(struct i2c_client *i2c=
)

 	snprintf(filename, sizeof(filename), "tas5805m_dsp_%s.bin",
 		 config_name);
-	ret =3D request_firmware(&fw, filename, dev);
-	if (ret)
-		return ret;

-	if ((fw->size < 2) || (fw->size & 1)) {
-		dev_err(dev, "firmware is invalid\n");
-		release_firmware(fw);
-		return -EINVAL;
-	}
+	{
+		struct firmware const *fw __free(firmware) =3D NULL;

-	tas5805m->dsp_cfg_len =3D fw->size;
-	tas5805m->dsp_cfg_data =3D devm_kmemdup(dev, fw->data, fw->size, GFP_KER=
NEL);
-	if (!tas5805m->dsp_cfg_data) {
-		release_firmware(fw);
-		return -ENOMEM;
-	}
+		ret =3D request_firmware(&fw, filename, dev);
+		if (ret)
+			return ret;
+
+		if ((fw->size < 2) || (fw->size & 1)) {
+			dev_err(dev, "firmware is invalid\n");
+			return -EINVAL;
+		}

-	release_firmware(fw);
+		tas5805m->dsp_cfg_len =3D fw->size;
+		tas5805m->dsp_cfg_data =3D devm_kmemdup(dev, fw->data, fw->size, GFP_KE=
RNEL);
+		if (!tas5805m->dsp_cfg_data)
+			return -ENOMEM;
+	}

 	/* Do the first part of the power-on here, while we can expect
 	 * the I2S interface to be quiet. We must raise PDN# and then
=2D-
2.46.0


