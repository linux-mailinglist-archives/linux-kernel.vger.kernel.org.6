Return-Path: <linux-kernel+bounces-201329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19358FBD11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AFEB213CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC814C58E;
	Tue,  4 Jun 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rYzgXPGN"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3B1350FD;
	Tue,  4 Jun 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531601; cv=none; b=Mxk2v4biQfCHKujK7FI1zj5qfxtkexUfy8K+d81ovlArP1iAqk73l8paGZkHrxQX6Vr+ub1riMtLghXCba/paSp4wqvayTe1J13+/4bYFBmtJcQi597xNB3ixobGx+Mxk8/KdrGwG/9IgqTzTB/8td5uN1EmPU09nYI/Q56E6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531601; c=relaxed/simple;
	bh=UyYvcyDzvOULQA5s2EXEzktbfL5xmUY+eN5IYMYeDPE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EbKgkb7EUpxQele3blrndPnf2wLV2wFcADtDu/FTXRjf1CMAugF69fqM3mUAYUKbMqlRE1Ljj6c/RJEbDpZrVtBo7XeYwvI5Pli7oAhaxmA4PTaN92KGGyE8Dfzud+OJ9C667C6/OqHGJp237y9E/ZY2kQPLkiBtF0uCuu37nSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rYzgXPGN; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717531581; x=1718136381; i=markus.elfring@web.de;
	bh=uhHW9GGQMJyeKuzBVKGCIeAGb0QutdaJfivNQuDOQqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rYzgXPGNju40m3dtl+VNlpzgxfCNptFUl4EL+/gtnyN5uUp28+yWnmOlPyGEFmgO
	 kNlK8f6hqLSfIE+M1WVlUHPpktTDywxRrpbxHHxfN1nci0xBvgRijfzN6KiMdYFt9
	 mmNcCwoYuteM61RJ3ao9PBmdH4PbpRMKPJsaZbJE+l4KOzTZupzd4Tt0mHp+Nj0Lc
	 pYI+mSGvvHLkrLcNiqIehL7Co/DFoBF+RU8R8yEIlgLlQ9AHB30Jvc88rrFLSSF6r
	 Ea/uwy/6uvOOSW9gwfUN2+ZYSX1LbNVeqa0Ej99m8X/BAqUXWzgXPaEOPZ53zgjuH
	 j21sBwlox4ZXBJfQPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1sTEak1TQJ-00u3fa; Tue, 04
 Jun 2024 22:06:21 +0200
Message-ID: <532aa50e-b8e5-4e8e-a2bd-a05fd81274dc@web.de>
Date: Tue, 4 Jun 2024 22:06:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Stanley Chang <stanley_chang@realtek.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] extcon: realtek: Use scope-based resource management in
 extcon_rtk_type_c_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0bU/ob+7kOatF+Jz8t5uLaM4o08nrxHMvPvk17RGGz5HLVViqNf
 qfYph/J4pM7wUvoDWFDckjjDi7jyfZQGyF6wPNDWq/tpstxR6SPkGdaQyw4euoWWTily9pW
 G+kDuJVD5kxkQjvr61PUe1fH/0qiSPhp3pk8dhhKfruf4zlZtMsNRPUaRreugj7ZzxGzasH
 bBFVGpJN2omsakJnVmBGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G+pSpadvric=;2EdbEimaqR1zhnAl1Odt2yDHrIZ
 j2XPfbzrkmiVTG1OeuCx1a58gDVUOCVQDgt4HrCeckwzyUJItFRZr5RLKcgILgsXljwUNISWs
 G+HdNEoh1BSOq7MXaELkRfimlCsdGh3ijPMTYz+g/apY2j5xoJTwaztHvWET7w5pbmTdZvd6E
 SWfMIjf2LL3TuDb9SKBHKJe5XcvGNxZ9awzL/c+TAxP4xhNL2ubBa9R6/wlp3n6HDFvBfq/CX
 0pInHr5v5AdBe2GTVgrlaOKZK0uQYGsLGtlTklHq0CUB/HVa9g2oRGy39UXWBkDitznLbsrSZ
 AUKMCN/OKHirU61Tj+l7z4WhmM6vbnCXcOQQqUHoN9SGePYyftjx4NDger5+vsGaifqDrKsKO
 jEu79XqxIOWlvZ7KGJYjT6MOnoXNU/737tBd/j5hPtEqsk5GbeOTIb89XhPEbsgsmZH9PZzOg
 4KOQ3QtwP5OfEBSbNYSQnFezCYGg0wUNFz4Fm2Zk0vBfkyTptelpRoUxn9wdQEaZmLb/Vw4pe
 6J+aVk/0x9fenrmtBWnxxbhDly4h9ZwtnDkVfOdGqBRnqcZl3HcBHRcl2AtDa9BQ5+uSWfKu6
 I77mQAddGs9BXVoXNJMOAmy4QZao0Lt6Rj3EKhzfpMnAgYyOxlxZO1+lEtjKqW84mCsL6vxtJ
 Xo89EdpnbF4SnwM/ev7PMeIJzg7Or9PCRusN/VRtQ3Atai16K+dnNo4Coyb1cucXQIAhPJZmb
 YvNDZak7utenWSF+ifoDY7KAHw/UNvdVCcsOFwRYh9Pd0V7PN6HImgizXTcVO2C8Se86M0mtd
 GyqZf7GOqtoyOyznNWtN3K41G2vWCcNzFs72Eob1tFF0s=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Jun 2024 21:55:08 +0200

Scope-based resource management became supported also for another
programming interface by contributions of Jonathan Cameron on 2024-02-17.
See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").

* Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.

Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/extcon/extcon-rtk-type-c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rt=
k-type-c.c
index 19a01e663733..8a4b074fd745 100644
=2D-- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -18,6 +18,7 @@
 #include <linux/syscalls.h>
 #include <linux/suspend.h>
 #include <linux/debugfs.h>
+#include <linux/property.h>
 #include <linux/extcon.h>
 #include <linux/extcon-provider.h>
 #include <linux/sys_soc.h>
@@ -1237,7 +1238,6 @@ static int extcon_rtk_type_c_init(struct type_c_data=
 *type_c)

 	if (!type_c->port) {
 		struct typec_capability typec_cap =3D { };
-		struct fwnode_handle *fwnode;
 		const char *buf;
 		int ret;

@@ -1246,7 +1246,8 @@ static int extcon_rtk_type_c_init(struct type_c_data=
 *type_c)
 		typec_cap.driver_data =3D type_c;
 		typec_cap.ops =3D &type_c_port_ops;

-		fwnode =3D device_get_named_child_node(dev, "connector");
+		struct fwnode_handle *fwnode __free(fwnode_handle)
+					     =3D device_get_named_child_node(dev, "connector");
 		if (!fwnode)
 			return -EINVAL;

=2D-
2.45.1


