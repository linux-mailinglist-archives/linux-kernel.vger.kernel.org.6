Return-Path: <linux-kernel+bounces-342922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41DD9894D7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B80B23651
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004E155758;
	Sun, 29 Sep 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Csb5vJ1y"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3853D96D;
	Sun, 29 Sep 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606748; cv=none; b=m8H/v1Ricj7zT9bceO81lk/Um7vxU+kyekifb2GTs+4/IA2ND92SN5tl3pBRfFghF9AXr3jjD3L7/q8N4Cqn9SLIlVNdeuth/5sNmB5EuVhRBa5t6AwLOMl+cSbo/Xw4x8dF2k3mLA72N/Hc7QrwDxjWPJ7b0oWG/QLfKdpXbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606748; c=relaxed/simple;
	bh=oT1ANVqVZY6yidoI9iifW1Q4EWCH/e1GEFnjgmZjsaE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rGQ3Ykxagcz9q3qLaOYWiX4wdWhimoA90RFRs8gNRWkigj01rLhr3llkizx/bDFnMpp5vA42iXpwIfRf2hC7MSt3sbDa4U663aqkTc1j/ZTxvecbkPysxlzwgadWgXgwV+xQVKPDOINVTOJ5S/bR2AacZkFv+6ZwcrR56lyVx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Csb5vJ1y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727606728; x=1728211528; i=markus.elfring@web.de;
	bh=rJ6rDvlfFJ1ctzo4nqUW3IW0EJwgP8g7q/slxShq0es=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Csb5vJ1yg8qx5MAdSRIv74gYHuQhyeOMpWOLqJ6XwFy1F8Z3H/hj4vZXMXxLJzyJ
	 AN+v3f5i/wVJZcYabbTqHpycocB15RILRBIlCXN4q0O/KBgwzKo8EPGWJFypA1bwq
	 9qmNXro+6iNPq9cyQNMcX1XzNOfKefe+bujHhaGgUNR6y+P/JYf53yEoG1cBQil3O
	 facFVqdphGm6ZSBSn1Dg6Cjs1Ja/AU3TdyhNsgjFrxVqtjJwDdwp70U79YbdNj6Ap
	 6lvnQURQ7zDFQIsaqgZejOzh6zC2fF2jGHu10n0bru/gTxdBTQWGxqN3waLE1e+m7
	 iHS5g6SiFAwERsKdqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1s98Dt3j8c-00nhvY; Sun, 29
 Sep 2024 12:45:27 +0200
Message-ID: <b050730e-ac7d-401b-8210-82453d05b0e5@web.de>
Date: Sun, 29 Sep 2024 12:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
Subject: Re: [PATCH] reset: Further simplify locking with guard()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qByEn6/jtm2IiGM28XvLyFij2fSLYXnBdowk5hkhQuzXMCVF3Ul
 E6VdfOnu7R/87cgiSfH0PnHPjizyXRedKETivgodbSweNvuNEHQu1Wf4J5F/Dp3Laoe/HDe
 eB+kY0D1BfMBnWplAxhlWrVkKHfjGLBM0ruTe3aaVy7vzVL4Xxlret27AH8m9YZnONEmG4s
 lpheKnTH1Mm5iA9Q/4Shg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SuThyrY8vZM=;Ta9wdDyjbK+W5dWl6j7Ws/mqV2p
 uSPrqgpD+/Gk3taKmmnk7I2DUDUmEaqrZxiujomqeMjjEDzydQtv5LwkOgBUgq4oH84ApbGaX
 QpdEac1b3SEX9eyywRZy+j03T+tXoLhcuy+Ju15m2nbI+IFLkoE8aar3Mfm8DL1Ulu5duNUUg
 FlvrSdw2RkMbq47h3sroVjuitcdGFU3gYuBBXtcc4cVdnjtZexzHhjWAsrHvmCQJL5qNBqdYX
 Qb+MG3ugHS0Nal1AJpD97V+cAjtYiQtyUlm1tJaNUaYQjXu9Dwa4BqWMZFXe8KHFiiOFLH6e1
 XPlH39iylOCKhpRKCvHOeTWN2KG7SrA2TzuBJWfjXCdThWLmNVMobFJa72OrGkAxIa0b4xoWo
 exb7OsFM+F21/Hv3ExxZu9LgIQ2mOHSopkjwd970nU65OadmaqRTFFtkKJLd4l6gqN9j0rfXT
 0TCi6QqjG4hXmLXLbFXKTUx0ajz1WTJ+YJkkapGqscUfk5oP/52+YTe7TT+OwgP+qB1GBWOfS
 3jRx7ByMMatyBHZ/pVQlT1zwcfVAlYFTMcVC5LV2CvZiQHGczsYTwV2P39efBhi08yWLNlwBh
 35wTUriys0Hj7BG/8tsI9UtCQWuGDODlX4cOztd1y3SA0CRppvloEXVSky7SZO2kis61J5ouS
 x/dLJI9eCeWUvZSIEKgp5658ANQQjxckFh0yr5ka0Gz7THeWRVTrlpMMc1cgmDUwgNmmF4av3
 L3do1zVqJuLiZpzLFor8mV++GISnAZ4fDu8qketTmkyXWP4KUXVJKo9RTtW0w7X3nfXHnzUYl
 NQYbrKVp6OyzNtBueqp4FSog==

> Use guard(mutex) to automatically unlock mutexes when going out of
> scope. Simplify error paths by removing a goto and manual mutex
> unlocking in multiple places.
=E2=80=A6
> +++ b/drivers/reset/core.c
=E2=80=A6
@@ -1041,29 +1036,27 @@ __of_reset_control_get(struct device_node *node, c=
onst char *id, int index,
 		}
 	}

-	mutex_lock(&reset_list_mutex);
+	guard(mutex)(&reset_list_mutex);
 	rcdev =3D __reset_find_rcdev(&args, gpio_fallback);
=E2=80=A6
 	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acquired);

-out_unlock:
-	mutex_unlock(&reset_list_mutex);
 out_put:
 	of_node_put(args.np);
=E2=80=A6

Would you like to preserve the same lock scope (which ended before this fu=
nction call)?


@@ -1098,7 +1091,7 @@ __reset_control_get_from_lookup(struct device *dev, =
const char *con_id,
 	const char *dev_id =3D dev_name(dev);
 	struct reset_control *rstc =3D NULL;

-	mutex_lock(&reset_lookup_mutex);
+	guard(mutex)(&reset_lookup_mutex);

 	list_for_each_entry(lookup, &reset_lookup_list, list) {
=E2=80=A6
 			break;
 		}
 	}

-	mutex_unlock(&reset_lookup_mutex);
-
 	if (!rstc)
 		return optional ? NULL : ERR_PTR(-ENOENT);
=E2=80=A6

Would you really like to increase the lock scope here?

Regards,
Markus

