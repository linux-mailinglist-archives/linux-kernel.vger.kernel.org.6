Return-Path: <linux-kernel+bounces-339475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCB9865AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5A31F25316
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD68288F;
	Wed, 25 Sep 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="xCZF/620"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501851D5AC0;
	Wed, 25 Sep 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285643; cv=none; b=bgg/tE5I4BGKS1pwHz2sllghNWXnmb296XGw2ct/0Yvj6IgCnw7KfdISVkt0kOwlPRPfQKfnxuX7A9uxYTlzWT2ZVtqEHIJPptbhc6XtfAdtTswNY1WAGKgqu3tGcL9bSaw7fkPicgK3vbWkw8d6DukdF1ZwUCLXnV0rcqb4qBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285643; c=relaxed/simple;
	bh=4/NEIAsBtB7blCG4wuSJkRPHzgJJT3t+tm/XzE92nXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lsi+x/TsOy294pdz7rmgZqydVeW4ejwpS9ALNO4lXjq2ZQo+TfO4tlKI1G/742DFQlb/oTz3tTy0FeO2v1Wx0mN8Nx+6fO13jhSoocNdTuAR8bjxDUOW95+qv0YDrqauZCEitisZkOsPo5RAmYYIEexcSTYJPslChWFd5XkrMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=xCZF/620; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727285629; x=1727890429; i=markus.elfring@web.de;
	bh=Ncba3K1JtxujF8pca90omffguLowNeWnysl8nMmFl3c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xCZF/620fc4fEot+ULALOvhqAkDQZSJTP7uknZnnq7J68A0xsRm0fW6if9SC0apW
	 V3aoi870KiaPuJg9dAS+8MJVQ+RGUF4RvWy75xNYj4iInPKNuy6nPaCTFnPXjf6ZA
	 5SikgAlBzr02scTMQLM/eGkERQsiQKcHXE9JMqQD3yihDp6HBDkHJjhP4lvdmcGuQ
	 WmRCW4fZL2hrKpeXcCSA2KyQGVHIsW1funj1T1Bb/TIjnZ9jmE77Vlo6VBWl547ZG
	 Jwdyge7AckuIsywPjcIY4IpDpGes6Iamohia4ZlMYXqdY/HDHZSJmOOgdro5MB67B
	 A4YU1/AS5bR8zQMDAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1rvOFc0j0v-012ma3; Wed, 25
 Sep 2024 19:33:49 +0200
Message-ID: <a4087943-ee25-4e05-80c4-02a77196848b@web.de>
Date: Wed, 25 Sep 2024 19:33:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] usb: typec: ucsi: ccg: Use common code in ccg_read()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-usb@vger.kernel.org, Ajay Gupta <ajayg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haotien Hsu <haotienh@nvidia.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Utkarsh Patel <utkarsh.h.patel@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
Content-Language: en-GB
In-Reply-To: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsNe3ae79w4xuRU/j0Q+YcQzcKuXPrio8gkoBUw9g0TxFTtZ6Lb
 rZoT2n2dS1CHwTok3vGHwiPETf1xplcXlfwSG4bYSYMHj0lgBowKWMKB3Iuu2QcnTDbomAG
 7o2nFC6fHxRMgTqYnpjKoU22hFm1DCsJMF79vVqI7Pf2mOoc7gRgSc3/uT6xkssxLbTNdwk
 EXYN0ES3O2n4ye65YID3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LLjNEI7QT00=;SyukQnnyxKKbHKL5rqOs3YFLnLN
 vYuobNYilTJr95eChQ32Oyz1D7CtDGSZOZ2Oc87msTlM9vywRIMmuhSwSXKrR6nhHC0XTOGf0
 IJ5aeF/zC8nDGosILKxZFnR8dqUSRVXikJ8kL8GujNKcMnrLmkWirbsFkKqYFcuVtyIJYKMdD
 IF+RiC7bsZvdsOKJfuCmW7gWi2o82Qtp70yOE7kEtRTS+Cx9hNXDdgNUponoGPld1tgn+oNDh
 3Naeb5TifBSVtm5FFr6nLPeBoeYcqEEZrWXTKDNMllN6uPnlmmefr/gxFvjLSjixJEGTOMYrf
 mE2hAVtLsDia/m21IhuCx19jdQVFeGeAorx+6G4V2Y69J4YefeXYWuG5p/De+ZV+0SLWEtyhO
 fuye036+oOn2TM/11hV29yz73lJ7SjXT0jBhmnHUjgRzzK3EpQk7VXZ9JP4cSK5+ssuWYaNkW
 zLPB/UH+ILf4xSV7l743pTXQn+91MYrbH/lT01/ZKLE20OyRAVOTp+dd+HOHH89TxqEebQ4HA
 HSIB38ETeAzBboNO4AwdmKkLTU7dzQpwhVwcGEQADc1c/zzlYo3jrau0xHoPTJjYivsTxUGlM
 S2yM5r17ai6dm8BSK13N1KnJQbZ/IwB+wN2cP5DZDA7cjTD/4cBZohGCDcA5eyDe+yHjA/44Z
 6zMRbeonGpcbB1aY4jO/Tqdli6sU60gS/p9qfdA7oMhT2lMETWbtqBvf3CLymq+PN3iScaVWa
 1mASUeORGph3CTnEkWbqpaftmqAk7e8CzBIvMHYOulr0d7UYWRgPPp0AqYA+tXkLzyXCMW02j
 PFyKoVk10sA9QwAVKv2wgktA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 19:08:07 +0200

Add a label so that two statements can be better reused at the end of
this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/typec/ucsi/ucsi_ccg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/uc=
si_ccg.c
index ed075a403d87..e3850c42583e 100644
=2D-- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -269,15 +269,16 @@ static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8=
 *data, u32 len)
 		status =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 		if (status < 0) {
 			dev_err(uc->dev, "i2c_transfer failed %d\n", status);
-			pm_runtime_put_sync(uc->dev);
-			return status;
+			goto put_sync;
 		}
 		rab +=3D rlen;
 		rem_len -=3D rlen;
 	}

+	status =3D 0;
+put_sync:
 	pm_runtime_put_sync(uc->dev);
-	return 0;
+	return status;
 }

 static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 le=
n)
=2D-
2.46.1


