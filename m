Return-Path: <linux-kernel+bounces-339473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEF9865A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9CC1F24A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5C7F7CA;
	Wed, 25 Sep 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Fq251lVT"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B712E71;
	Wed, 25 Sep 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285571; cv=none; b=jqbxOPgFLSh0dsnPxfC+711JdizcVXsV4pQ8yocTDlGrpO50zbwzRf42uTvdfUsIDTYi3+SQ73K7Mv7NpttvwKp95CxCMAtVTYQuOfKZMC7CWJbIHvfKxWAFts+aeutXwU1iYrZv3XZRH1EYZnlpyEugGadog72Ploy86tKXsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285571; c=relaxed/simple;
	bh=e740feuL2tObzG4lWI+nWxD4GvdBQTkreTYN1D1Sphc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qyfdsAiXJ0tUYZ4j/a7wWROdbdEC5UAtoIEEnL6KJpZT3ikHqRdMEacPIXu3NGfRsDEcMBQmU9rGtwmaMfQo+3fljv8wEwoP0RqIQh6ckONe67PElpiawH7XV843iaRwljSFE0DvdsN5hf3CJYj4j3s+dn5hw1ZrTVoRkmJkBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Fq251lVT; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727285554; x=1727890354; i=markus.elfring@web.de;
	bh=eFB3Ldx/KWMS5UjoX9kHPfNx7iFSTxjpoJqpFKbcd5M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fq251lVTbYzER3E+YygByzuy56H74TNfG2P369lFjmnap7LX719JBW+WayVNgugy
	 vwOkWQ4bYP9cG7mv72Z4QH813A4/jQP5bLIEULzY+kW9JewAph5qtUoDrB8Mt81AO
	 FzmmCy/PwIKzZtv78g+2ZJrthuBxBrv3ewZEI3rrEWpzg09yiRFvC9hP2ZZEuso+i
	 KrRtlXW8+sl0X+AjSDhY76Qx+tGZ0LVTV1y3c3yUBrs/vlGored6A/f3wkZsBeAVq
	 INq9I7we7SJMoizGW5z7W27kIfc8Pj7zCygsDxAAIl/XuKGOqpqHvcDWPrRObQtDe
	 J1XLgK1n3mWJHMQarQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1s6D5C1Mcm-00nAO9; Wed, 25
 Sep 2024 19:32:34 +0200
Message-ID: <983e8bde-513c-4053-b33e-06a1b10eef87@web.de>
Date: Wed, 25 Sep 2024 19:32:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] usb: typec: ucsi: ccg: Use common code in ccg_write()
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
X-Provags-ID: V03:K1:IS6aRcqyCh4ShCkWylyOYBJFLKIHIsPmw51lV+PVy2VffuHddwz
 9DfuAXkv/mZs+P5r168V1HOr5HgfWNyaqlh1c+wP1/geHJ35qPgfCG7VAoKYUettkZNDEPb
 rX1iMf/vc9nL4taL91b5GwJ8CB6j3TXU12kNUiwIhc4/jHqPThGozGjdGfr+939yeMmEVWb
 wy2/eCqrRmcoItRMQojpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eo/eXcNSpAs=;0Z8ZaXSpKKLNG4DTj6kFFrSzBPk
 d6Qq1wrRM2zCMQAWCwaX4fiT8mYiY+EYrO0Pj/4zLOfdDBoXsDJzA7eEVf724es49RyTho4+u
 NOQBrV0qvKYd469NrIQZTnDuddNm73Wa37kUQrAbfOlo/j/iTS90rsBsBRJMNCVfVCm+Ldsux
 thzzYN2tQoR1lvpgJEuxdO0/sRQ3822TlfZOfNa9TEjo3S0uYGDP7YoJAJaW2UGeyZ2iixT2r
 acWDTXsS1mwtCyQYj00fmcyDDJybQ6q+qpDVSsUw15UFcrK3XsGSbMAXAXiHgLMoPPOYLKbyT
 j6iuw7QQXiCAS/guV0YIJQ0tz0IXVE7+JVuLzDMllS+m6ZR9lFAzJyL3tc3OK1oc2sg2fjKhO
 G3cw6WTCxb+bSouc7LJt93Yj5R7dFguLNtcuF+n1CbstGNqy99gVb4WZxkc4cH61mnKuK3HH9
 l2bvsbsBx1NWn72xAx1Ux+rx/IPq/8gye5HnZSEcqalfR5Jgqbo3yXhvJkIKqKd8nfnkiWQM7
 2B3i1JDjJAF37yPmhxioMUb5b1Irk9UzzphqUr7tfvBCZlUoNct919KoZGnnlto0ex6VTZLvu
 0d7V8D8K1cAfw0DLY3w7T1j+76QWPd17TJMZYZlfliIZs6C1WnZ3jyeTb7E7zt1I6VURGck8/
 BCP14+fzflYjJRGhhb5stawpVSH4cOl+twtIhcowrbQhb60++6jmIOQBE0dLc918pPfCZrxA5
 rj9ef9sea869Xzkpdh+fLu2+qO/ZSJEwi4ztFu18ajlNbwRosTEtFI+fRwtiLjkFwgRh7pz73
 McMwiu2JxsADQU3ab3tjLPXg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 19:00:23 +0200

Add a label so that three statements can be better reused at the end of
this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/typec/ucsi/ucsi_ccg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/uc=
si_ccg.c
index b3ec799fc873..ed075a403d87 100644
=2D-- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -306,14 +306,14 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, c=
onst u8 *data, u32 len)
 	status =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 	if (status < 0) {
 		dev_err(uc->dev, "i2c_transfer failed %d\n", status);
-		pm_runtime_put_sync(uc->dev);
-		kfree(buf);
-		return status;
+		goto put_sync;
 	}

+	status =3D 0;
+put_sync:
 	pm_runtime_put_sync(uc->dev);
 	kfree(buf);
-	return 0;
+	return status;
 }

 static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
=2D-
2.46.1


