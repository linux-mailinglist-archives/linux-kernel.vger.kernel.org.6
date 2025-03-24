Return-Path: <linux-kernel+bounces-573645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6097A6DA21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61211894BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF01CD0C;
	Mon, 24 Mar 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dOZUti1m"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B11DFED;
	Mon, 24 Mar 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819444; cv=none; b=J9cPETlUKjWXox2CEcZplJTuC8kziPprrzdqpmm6/WE2wa7s1qqxWgW1jGCEHRZrGFh50SfIDQHqtGs5d5lW5BqyYOeqQXRRLEj3+u26rhfpn5pOue8i8N4qM0Ij4vNnwLS3KixGqWzxXLCZ8jCoHHCJUIRkOJz1gN7W+6uuKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819444; c=relaxed/simple;
	bh=fwimp8HseB9UwFHpwn7n1zBpMN61kwe5isolz4he/D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+Ogc2P7wrKIwIeyTAoukQxpBu0xfsUAhBgZfsS4tfQw6kIVxEmV0Ya+sMfPZMC7Gsy3jAI6lHeTKsc1MnOj615sxOpjUBjoU02JDCnxjbI8L4d6WFS+zvDaurGda3MF51NYDXT/+8yYJkikw+Q4WaY4ahKIw5MExJgXma/0Ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dOZUti1m; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742819426; x=1743424226; i=markus.elfring@web.de;
	bh=rEc55otJf7ICHqncJghVecmxsSzuMVTiFLZWCZNGMhU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dOZUti1mOauygq02eBbZVYKvluyQZkNV411tWE/zylGK3jVjNS3xBo2CgSMcaekE
	 lacXA0kOSvpPNJ9lBt/WqD40/Fair9hngzFZ111XUuFNdosvC+DJ8nhDtkDlOiRFX
	 FUl/kraIQ2VrojgN/euMb7emLq/Cvu80VKYiEEZWRKpTwju9bW/8WswvprT30r/CU
	 GJ5dIYqzOJRXz+WHP74K2a8Q4s3NNSoFIyH+HKcUjc4UcLOMck/8+I4RVyIHqszkU
	 ecfuk0QQqIoKzl7bpr+0DIJALw9w9iao0RvlaKwWEdpzP0Dwapxz9M0VwW8d1On8K
	 7OLObY2Cb8sdnm4UiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1tAcny3Y1b-00wEH6; Mon, 24
 Mar 2025 13:30:25 +0100
Message-ID: <40a0ddb2-a2dc-4637-a899-65b84065032b@web.de>
Date: Mon, 24 Mar 2025 13:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] mei: Improve exception handling in mei_cl_irq_read_msg()
To: kernel-janitors@vger.kernel.org,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYYaUm0Hjzq9rr1Prs6gbeOzoVeO8auNDeOvHd8eS/g88fO3NLT
 qlzYAcUnP+Hgyiql+tSUJwVAYj55QpbsYJ+YkMMV8nmAK3KGoUxaZe8hzWnLs4lcuONzfY3
 HVCzxlWFFU/YPOUXDhuv1YDkSEklurYIoX588pFhm6WoPFJtnLh9FEh4q32VpqNE2bS8nLY
 nbjKxNI5DbPhS1LVyP8Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ybipT1OztxQ=;1HSNSUDbDwk97whTFPLjzBeRR05
 TMm3V9CSwlbB/NQ04y1Ot/sTP1/bDKdeSDHfNh2lyw16Njdbl2b6WnZG/a9QPkfp0/nIkQf8S
 yQvMoiQG6GvO8W2pQ6f0/xqVdNV0mn+YErYFPtWfoyJwkF8MtcGur0AaAu9P4Xem4U7AgRt4/
 Ofv+rGMPKdSGuxRX4NzjmNVoakhJsgUX+Bn/HZ4CD7FyJN+HixJLOy/XKjis6QrTp5pp9mf3p
 7DOBaW4/7qPh/786ep94tpR6ooQuNe1KwYLBD+rJbeKtWU1XIoLwRDegTUV/ePEB5ScDlvGB2
 gm0gTYTVooJwsNQOZittHTPZViVqaups9123++7dzMAMkfzBO2UCkviJMj/6P+E51J+zVPCWl
 Xrim8o2feea/hiAvIOrmGthNT36bfe/PgAF5eCB+InXzOJrTUmOGUij3pAY4YUfPZANaytZY1
 N2m4grtdjcI368MzOW90PIGWRaT/q5Os7zXAdSS5PSN3HROApWaHyezaQCsX2yLWH1Qs16X7A
 5eg+UFvXAXSeUFKdSyR7tWw7fAtAfkDWRanyqF1dujbzD5zuDTwX78xUCpJApKMrHF+qEfoFQ
 +NpUBh6GbNDfLzF21O5+MoReycfzVeWNGNZD+P7s5LaZQ0P8UNS7np4Elq4e9otjdLpfdMRLJ
 3ViJev7ArNB1PyGUnHUD0K6W3GB8TjQKT+yIWuW9/s2xfSzlDQ9BFyYgN3JsQQLVK4PWfOGw6
 QvfblnKBEbzMykveAoBvS92PGDGRJTQQ8qn9mpQhAYGmjQ6Zv/jsPSQCaK/rvnFmKUBmfBy82
 PZ1IYVYjAU+7Q5rE4RKpOC/3h6zRBhps7D/i2Eh9GDQhHbkHdQmwDUE9seGnxKye3oeC6Kw1i
 NoOcNW1YNtxNyM6AAuEolGELyNQI3zNLKUbxi0oyuxs+LiBmGCV0yxc3DX9UBvUUQgBBf/H1I
 Hbt+SdPCLBMHIfJxenzfmICwwkWZ34Cj50QRvBqOgiUGc4/MeAm9i6waYc3M/6pxSxerPT/qz
 6htkPat1UD2im+ODB3zisBGUKW5TxKHwtdva9y1nJH1hDNXgwKSyPCrlRIEqsD6tt/w1SBBM7
 XCplEXHOzoT3EhmwPi1sETM8j4Vbl0cj/SmcoqOwujkY6hDbkkwUHAHjmjBzls1KVmtq1UHBG
 y+uppdySMXjTVubmqI1KX4FzVjYjxmZUnsOjMPY6m46anHvLm+U4Mu5qJzrsEJy2WzmmD60Mc
 /NCbE10b/a3ch4i7kKVnoVUr4uv+ZaKJRitObEapghTD7m7UKIir0h6zRJUGh4M9ykgUojEXB
 zg1/m4GJGo3AKmX0cc++OvoK5C7EBq3pxSkM7LSmLj3SFOmfxyM7Ob44IySaTRskLHKubwC3m
 Qe+MysPSJvMb4qNQdgb2qn3va1zskPIv2BErt4HvHjIM8cqXT+1NCXL6QkFEc4DVfIDKv9ME3
 7j03QZ0e0ovjHPFMWGlHkAIMI4WeZLkYsEnFaBeAu8ttmuBeiFoXPqVCDhu7l4lwFNKXfYg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Mar 2025 13:05:12 +0100

The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cmei_cl_irq_read_=
msg=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

* Thus use an additional label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V3:
The label selection was adjusted according to the naming preferences
of Alexander Usyskin.
https://lore.kernel.org/cocci/CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR=
11MB6366.namprd11.prod.outlook.com/

V2:
* The summary phrase was adjusted a bit.

* The Fixes tags were omitted.

* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250228=E2=80=9D.


 drivers/misc/mei/interrupt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b09b79fedaba..78a01b402ea4 100644
=2D-- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -116,11 +116,11 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	if (!cb) {
 		if (!mei_cl_is_fixed_address(cl)) {
 			cl_err(dev, cl, "pending read cb not found\n");
-			goto discard;
+			goto discard_nocb;
 		}
 		cb =3D mei_cl_alloc_cb(cl, mei_cl_mtu(cl), MEI_FOP_READ, cl->fp);
 		if (!cb)
-			goto discard;
+			goto discard_nocb;
 		list_add_tail(&cb->list, &cl->rd_pending);
 	}

@@ -236,8 +236,8 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	return 0;

 discard:
-	if (cb)
-		list_move_tail(&cb->list, cmpl_list);
+	list_move_tail(&cb->list, cmpl_list);
+discard_nocb:
 	mei_irq_discard_msg(dev, mei_hdr, length);
 	return 0;
 }
=2D-
2.49.0


