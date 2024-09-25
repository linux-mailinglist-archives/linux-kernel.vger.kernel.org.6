Return-Path: <linux-kernel+bounces-339470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CB98659F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57043284A96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BF77117;
	Wed, 25 Sep 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GZTtTwK0"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AA28F0;
	Wed, 25 Sep 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285491; cv=none; b=YlXf1p9hRZ5VcgjAA7bhettWCBcMjKfWXIj3HHFYEUbpTGYUUiRI2S28yZoNJZJmCv+vnc+vN3IpW94LFpMOukzuoAKx/rD3w68Sde6IYo+UGDbvYYqhTOqgT2lGkf3wtKSK3mpqU+LUYBCTqIg3YCN+aUj1WhMLENxRVqu4J+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285491; c=relaxed/simple;
	bh=rGQkSpdq0qrZpkr5gjjKCECjESAYk4AF9OzJ9Z8h/hA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Bd1ZlBhz5AFhnQ8FhPskbLrGtLUhOcAbz1uUF98Lv7EK2fcsIFxWi87P9/ivoL2K+QlflO0/Q/tNtvl3B8AuOKKq+C2Pdqpgph2b2z6Mg6GjfPgT36w43fFX5cw9KzNEERMano6/Gs4dEB4Md4yQkliUZGUVndjy4mxlZndnJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GZTtTwK0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727285471; x=1727890271; i=markus.elfring@web.de;
	bh=207BIIINoQhtIpwZzzJgEApvnp6eKuNSLHH5ebki+cE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GZTtTwK08IUdhz2CPXB2HZeSRtuQFvewf3KxHC38oi8tOxwBUEQNGUazEU6Gb0K4
	 YfuzloxRusv4XcD3Z7ouMKrJM5eyr69n3HkCs67EoXEJZp37noZRrJ/Slszoa6Tlq
	 SErRh/LCVrvNH6BnHjvB93TY+6dXT0YMP0VB6Jryk0sVk9LEgFLNixYIOyOtw1Wi1
	 2mqRdkKpROR/PipWTrN15f8T0r/z+HuK2hOWSOSLNIlb6zdyE0gIN4P0ThIAHhH+u
	 8JPSVOdOTdHSeqZvFcEDwfM97YLCVB/QkZgty88qgGnrbfiSlC9bpVZVRGKWBYWE8
	 rN/J3Qr2ps/qjnvhDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1sOyPn3re5-00QTQ5; Wed, 25
 Sep 2024 19:31:10 +0200
Message-ID: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
Date: Wed, 25 Sep 2024 19:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, Ajay Gupta <ajayg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haotien Hsu <haotienh@nvidia.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Utkarsh Patel <utkarsh.h.patel@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Wolfram Sang <wsa@the-dreams.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] usb: typec: ucsi: ccg: Adjustments for common code in two
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TFAqIEFqOpdD0fBdHiffephnUl82Q8HRfVswmzf7M217X0UULud
 2HzryejYHDe/OGLyl/c221b7ZktCfbKUTckYsjgLtJw/79xXnISh+1Hh25ejQvn83Kvw0qG
 PfXKad+z8tNLE4KL37OGgfR6/hbx/FS2jo8kprMS9P2CEZ37bPrdMSuC783dYSI/iRnzqor
 KRK2T5Yog5hzx0318allg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pKmsBhDT8VY=;6gyJXxnvADJxpgd9bY90hCU8lEi
 5oTzzPxn3lPBy8HIPpIjkkgPvMsNzhqUIyG3dadc4xSEgLW6oevIpzYtRoPwJouOXrIcCN0Wo
 qAgrZj2OMUA5snPxEpT42z7vY/dhlbcQBOk5gsrxrc9CbAO9SZMIdi4YQFTfJUk2GDCvuWDO/
 L3VcBFm/q03oALpqdtENbKVZQsIN7pfPRS157VnosBQT9lc83yQmHa0unREEJF7qrA0IZHl1w
 MHSEs8r+yDel6862QAh7XL9YOtKSq8M1JMecRDSyJDuVlF9ly9OdWtatZev/oKUJEM9rYiYJv
 bWWAOS4IHGOudF9Pk8tAyC8xQ602MuYhvuQTW6rtxvAE70kFCMnINUSuULXwARytUfUNyphkx
 lFW1vCMZwxvez307OoIIaf45XLVgWCy6w3LhFEaeLI6CbgezWhWwZndTmu5nnxLvfEOqvnYmY
 aOfYce8ZOnOHr5doTSGkMklykxuZo/tuAbEB+G/8Dmq+Bw6P14z8H7KHzK3Ir2H6ycuIRXg85
 FMyq/+L49yLpeCtJH8owJKVshbbDKyXIiIzPEanVe87xjUSwJWqOEBeyElj+IoTblSf6DXP3I
 dFsuRD7opvLolNaFHerpLa7ar3n/GGNRXSw/g0VPt/zaAfUYTfiCi5yUO85lSdHgdnVn+ATAD
 FEOGTcuvyg1VDBTgYfjPxVWGSkDSLvZVq+yJPTEyhKI3IbNVx9SaCNCZgyXvykFZYFBODKbzM
 VSEWioxFVxiAvgWC9sU+swhNVmmjdM0JhjABCuYO1NabmdPp9KTaVX2WTpfMrnJiC8gBJmRxG
 atwfIMmsY80f9+oRX1m5i6OA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 19:19:01 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common code in ccg_write()
  Use common code in ccg_read()

 drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

=2D-
2.46.1


