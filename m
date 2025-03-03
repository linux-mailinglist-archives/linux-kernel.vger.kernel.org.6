Return-Path: <linux-kernel+bounces-542510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E947DA4CAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A5B3AA344
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6E2153EE;
	Mon,  3 Mar 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iHEXoSgx"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B7214A81;
	Mon,  3 Mar 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024172; cv=none; b=A2uOfbJ/W8oKN9HeipEXjLoCGWXchk1qjTvIhwbW0xoL28QSGSnumAzGLJOi9tmSxEremZRMfYDlXsInF6dIUtWbGLP5pKbscSWF6gMZcH7OHViyb84FR6mmucujAo/Lu+XH+jomRzwlQV74KWfDWutlrbqvRngNiYS+FTQCN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024172; c=relaxed/simple;
	bh=ZXOL04VJeY1u6TZL16xpqWJmzxBgEFTN6NZSF9bTD7M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vq752UzB4gZE3wuMVvA0LB6IMqRNjuD8alprcZm+J8S2Dus4DyYnu/1lEznId+F6JRICTxxbeyUfq2KSYKjjUXqhONVZ7IR68yoHfzKAX6STRAYbRJMNiavyzVAtdewNEoo96KLHnRMxX8czCA5dqKC2DRv3TlXTqF/vB4b2Lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iHEXoSgx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741024148; x=1741628948; i=markus.elfring@web.de;
	bh=BYfX7ahdAx14xenhiSbgtax3duc93F62obxPkYvV944=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iHEXoSgxSkWYaxNEftQfb60FZ3dHehjWa130JFI5+xqgwqsgzXDpHyjdUp6QHdMG
	 3mQqWWoHtLQ5FeA4e82ZxP5z6jL1/NCgCRdQFxlKPYLkrRQUfPv0WT7iMQJ3JtA9R
	 lCRRwf+/9avb+EPhM/vwj7OkAfwLIex6hW57sn1DPaSd5rOBTjv+7mVLBVPe4GuqU
	 nWg2eUttDZKyuyU0azchzYmbhkEOoTO12ftSzF0HRuWacyvmtwQbht3juOALsMYGy
	 Ax5chNSrQHR30CTC3GXbUiaPwrl1LJklUPGQT7U1oVUlecRZBaAqxSVdH/tsyVEU7
	 DIQR0UFvE/agd7KX1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1syhgU02a2-00vk09; Mon, 03
 Mar 2025 18:49:08 +0100
Message-ID: <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
Date: Mon, 3 Mar 2025 18:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
Content-Language: en-GB
In-Reply-To: <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/k+Xgzr03sFsIQP6/rLbeZ9jBhiTPWWxBW6gyeBMvI3JQbgT9I
 +Y4HgV3wwul18HU6cxSHtB8d2/74o/f4jJeELUakevzSrfaT/yrefYE+E69JzCmstH3zI9B
 yCXvBjH/00Ethv40lD4gvrb27rewWNHvaVZD8rEcm6QJqUD39A6qXWVCQM/2UAZMD6auaU/
 Bo+9LSx5ABwtoAYcX8jDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bCQY/gSiTXQ=;NrnBi0ajv0riYdZVXn2UBWmn5ea
 M82WcDJ4E/ee4P/thkOyeYYVcChOy6tBfYIORjnJ+WkomlUTPak3+AU3bO7h0jI2gOnXzd7Jj
 hPlcusnKwPXN3NwslXFcJQk7aTN3ZIO3tMIcD+7Ydmc2Y617hJRiRLivLSdgYMcXr71v8a56O
 GNKzkwshWPd8607X9m1vrI9zUmtICtFIgWyGbud4/YWSw+ZwizFiM15d4RYo89eIocHZUFKB8
 nw/JLJs23W169Enq1R/yGeK0deAJ6lcJP+UZ5fIrhkatEcUjQRBGXu8qp0FmsjJxK67begUje
 9Px9nW5cOCUeO+B+tueW+PfC37/ePfewRfRCYxe4KQa/KO4ipC1wVWVmHIckrQxD6gH8q/3Ly
 u5b90ixqgOjkFMn2Uvp8YvF7w2YNdVMtfJ1LWpOj5unkHuJKdCNi+w3eJtIlUc75jLPlXZ0hJ
 9vwcicSUF4surrmDbV+4e+FNaAnEDZgo/FNn0A+yQzMx6YsIfHGe1W+HSHAss7sBM9xwH6vbu
 c5qY9EU49WyD3Ay1Gim2CntSow4Yg7HVq7+rzx1uWqh0155zPT+k1AUxViQvnBzEcIUhaq57j
 WW2/lMMCsTCaihI7etFgBEF9WwNc/YhfpNh5gTIobXjcl3v+b3DGHS27/XdlgFkxg9o15XeWp
 VV+eklQzrVyTy4YqI6H/HJFY2Uuf1GAPdWP2U5AKDZDWya/LIvOwqpqbCCyLSiC/TcPTS8cQq
 1XK3mst42oeSXog9tCktRFDnHMkDPobERTTz6fgPluYhCla8OXueIieDuzURlE7NkR2r7hILF
 9Isayjln6IEF7+1DcF5l5amZuiTjCwg/o16396OfatSC7MVqKltQqNj88Zlbt34JvRXas0t/0
 JAsRi3RNHdb+xHNcootnMZILnt7giqutnUi6GEzFtQKN0NvFvheGisMozARhC0tYJWMEuqs0B
 EXtrOEEll2D8+WkP3onpQnO3oEZxPr/dx8ezhceq7HlXEhLGLl9rSgFEuRFZW05XmYd1GK8ur
 21wfdvxF4eQzOu+Eara2WDoRTb1ciZ9JlMZa0ZKKS0RuvEBcf0q+ufctkz3DoCdAgtLgbuq32
 1D49SwOCB+VfBsXjluLhg81hrb0s0inxWt4kFePmt9vP5180WtOVHyEC4KGiBgMjHzWSCu/qI
 ZTGAgL8li12HjjW3eAtwJSmKHESyr+3aLMTBagLkLbtZZblgEx1H4sL22NaC1nQKbc4TEwry1
 w5yxsVyW3uvlnnwP+ySuAIGbpdtMKVZY9zoWpp2D73gVpGQu2kF3HeJ8hsEfMGGJP7OFlrCuM
 go08a/YhtFNuWP3ULkCGZUdgNlVMD3ovNPG/ZH5lXfB9vNFV+vtxGNu1E2/rtmbYfXmfovCB5
 9ckjVMfYdTJKsdz58F8bBjEc2xdRsbyeVzBxu0I5TN1YtxrFFJa3JvMgbSR15LoCyAhbu2NM7
 hEuoQSnekcH7za5vUZ96XWIUMLZk=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Apr 2023 18:38:54 +0200

The label =E2=80=9Cout_prevalid=E2=80=9D was used to jump to another point=
er check
despite of the detail in the implementation of the function
=E2=80=9Cnouveau_gem_ioctl_pushbuf=E2=80=9D that it was determined already=
 in one case
that the corresponding variable contained an error pointer
because of a failed call of the function =E2=80=9Cu_memcpya=E2=80=9D.

Thus use an additional label.

This issue was detected by using the Coccinelle software.

Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a do=
uble-free")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouve=
au/nouveau_gem.c
index f77e44958037..d87e1cb2c933 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -814,7 +814,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 			reloc =3D u_memcpya(req->relocs, req->nr_relocs, sizeof(*reloc));
 			if (IS_ERR(reloc)) {
 				ret =3D PTR_ERR(reloc);
-				goto out_prevalid;
+				goto out_free_bo;
 			}

 			goto revalidate;
@@ -929,6 +929,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 out_prevalid:
 	if (!IS_ERR(reloc))
 		u_free(reloc);
+out_free_bo:
 	u_free(bo);
 	u_free(push);

=2D-
2.40.0



